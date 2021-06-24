function table_times = arrivalDepartureResponse(struct)
    % Function that returns table containing the arrival, departure and
    % response times, sorted with respect the arrival times.
    
    n=length(struct);
    fun_name=strings(n,1);
    arrival=cell(n,1);
    departure=cell(n,1);
    response=zeros(n,1);
    
    for i = 1:n
        aux=struct(i).info;
        fun_name(i)=aux.fun_name;
        arrival{i}=aux.arrival;
        departure{i}=aux.departure;
        response(i)=aux.response;
    end
    
    % Transform them into tables
    fun_name=array2table(fun_name);
    arrival=cell2table(arrival);
    departure=cell2table(departure);
    response=array2table(response);
    
    % Create table
    table_times=[fun_name arrival departure response];
    
    % Sort table with respect to arrival times
    table_times=sortrows(table_times,2);

end

