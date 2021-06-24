function [function_names,aws_traces] = extractInformation(path_file)
    % From a text file containing a set of traces we create a directory with
    % individual traces for us to extract the information required to
    % perform demand service estimation on each of the functions involved.
    
    fid=fopen(path_file);
    g = textscan(fid,'%s','delimiter','\n');
    fclose(fid);

    breaks=[];  % Indices where each new trace starts
    for i=1:length(g{1})
        if contains(g{1}{i},'False')
            breaks=[breaks,i]; 
        end
    end
    breaks=[breaks,length(g{1})+1];
    
    function_names={};
    
    no_files=length(breaks)-1;                % Number of files in the directory.
    aws_traces(no_files)=struct();
    
    for i=1:no_files
        h=g{1}(breaks(i):breaks(i+1)-1);
        no_lines=length(h);
        
        for j=1:no_lines                % Search for the functions' segment record
            if contains(h{j},'AWS::Lambda::Function')
               fun_segment=h{j}; 
            elseif contains(h{j},'AWS::Lambda')
               lambda_seg=h{j};
            end
        end
        
        lambda_seg=erase(lambda_seg,'"');
    
        start_inf=strfind(lambda_seg,'{');     % The index where the information starts
        start_inf=start_inf(1)+1;
    
        fin_inf=strfind(lambda_seg,'}')-1;     % The index where it finishes
        fin_inf=fin_inf(end);
    
        inf=lambda_seg(start_inf:fin_inf);     % The metadata of the function
    
        aux=strfind(inf,',subsegments')-1;
        general_inf=inf(1:aux(1));
    
        meta=split(general_inf,',');
    
        trace_features=struct();
    
        % Name of the function
        name=meta{contains(meta,'name')}(6:end);
        trace_features.fun_name=name;
        
        if sum(ismember(function_names,name))==0
            function_names{end+1}=name; 
        end
    
        % Arrival time including queueing
        subsegments=inf(1,strfind(inf,'subsegments:')+13:end-1);
        subsegments=split(subsegments,'},{');
    
        dwell=subsegments(contains(subsegments,'Dwell'));
        dwell=split(dwell,',');
    
        start=dwell{contains(dwell,'start_time')}(12:end);
        start=str2double(start);
        start=datetime(start,'ConvertFrom','posixtime','Format','dd-MM-yyyy HH:mm:ss.SSS');

        trace_features.arrival=start;
    
        % We use the function's segment to extract the departure time
        fun_segment=erase(fun_segment,'"');   
    
        start_inf=strfind(fun_segment,'{');     % The index where the information starts
        start_inf=start_inf(1)+1;
    
        fin_inf=strfind(fun_segment,'}')-1;       % The index where it finishes
        fin_inf=fin_inf(end);
    
        information=fun_segment(start_inf:fin_inf); % The metadata of the function
    
        aux=strfind(information,',subsegments')-1;
        general_inf=information(1:aux(1));
    
        meta=split(general_inf,',');
    
        % Departure time
        dep=meta{contains(meta,'end_time')}(10:end);
        dep=str2double(dep);
        dep=datetime(dep,'ConvertFrom','posixtime','Format','dd-MM-yyyy HH:mm:ss.SSS');
    
        trace_features.departure=dep;
    
        % Response
        service=seconds(dep-start);
        trace_features.response=service;
    
        aws_traces(i).info=trace_features;
        
    end
    
end

