function table_Queue = queueLength(table_times)
    % Function that returns a table with the queueing process.
    
    n=height(table_times);
    fun_name=[table_times.fun_name;table_times.fun_name];
    Queue_aux=[ones(1,n),-1*ones(1,n)];
    event_times=[table_times.arrival;table_times.departure];
    [event_sort,K]=sort(event_times);
    Queue_aux=Queue_aux(K);
    fun_name=fun_name(K);
    Queue=cumsum(Queue_aux);
    table_Queue=table(fun_name,event_sort,transpose(Queue),transpose(Queue_aux),'VariableNames',{'fun_name','Time','Queue','Arr_or_Dep'});

end

