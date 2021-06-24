function structure = tracesByFunction(fun_name,traces)
% For a specific function we return the respective traces.
    
    no_files=length(traces);
    indices=[];
    
    for i=1:no_files
        if traces(i).info.fun_name==fun_name
            indices=[indices,i];
        end
    end
    
    structure=traces(indices);
    
end

