function serviceEstimates=serviceEstimation(traces_name)
    % Regression-based service demand estimation.
    serviceEstimates=struct();
    [funNames,traces]=extractInformation(traces_name);
    numberFuns=numel(funNames);
 
    for i=1:numberFuns
        data=tracesByFunction(funNames{i},traces);
        times=arrivalDepartureResponse(data);
        queue=queueLength(times);
        estimate=demand(queue,times,20,funNames(i));
        serviceEstimates.(funNames{i})=estimate;
    end
    
    
end

