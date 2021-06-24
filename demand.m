function estimate = demand(Queue,Response,no_obs)
    % Function that performs a regression-based demand estimation using
    % the mean queue length and the mean response times by dividing the
    % observation interval [0,T] into no_obs equidistant windows. 
    
    t0=Queue.Time(1);
    t0=dateshift(t0,'start','minute','current');
    tn=Queue.Time(end);
    tn=dateshift(tn,'start','minute','next');

    delta=milliseconds(tn-t0)/no_obs;

    time_partition=t0:milliseconds(delta):tn;

    avg_resp=zeros(1,length(time_partition)-1);
    avg_queue=zeros(1,length(time_partition)-1);

    queue_at_arr=Queue.Queue(Queue.Arr_or_Dep==1);

    for i=1:length(time_partition)-1
        avg_resp(i)=mean(Response.response(Response.arrival<=time_partition(i+1) & Response.arrival>time_partition(i)));
        avg_queue(i)=mean(queue_at_arr(Response.arrival<=time_partition(i+1) & Response.arrival>time_partition(i)));
    end
    
    model=fitlm(avg_queue,avg_resp,'Intercept',false);

    estimate=model.Coefficients;
    estimate=estimate.Estimate;

end

