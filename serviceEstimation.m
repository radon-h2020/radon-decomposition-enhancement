function serviceEstimates=serviceEstimation(traces_name)
    % Regression-based service demand estimation.
    serviceEstimates=struct();
    [funNames,traces]=extract_inf(traces_name);
    numberFuns=numel(funNames);
 
    for i=1:numberFuns
        data=traces_by_function(funNames{i},traces);
        times=arrival_departure_response(data);
        queue=queue_length(times);
        estimate=demand_est(queue,times,20,funNames(i));
        serviceEstimates.(funNames{i})=estimate;
    end
    
    
end

