# radon-decomposition-enhancement

The radon-decomposition-enhancement repository, contains the required functions to perform service demand estimation for AWS Lambda Functions. Currently, the proposed estimation procedure only supports a regression-based model on the mean response time as a linear function of the mean queue length at arrival. However, future support for other approaches is IN consideration.

The estimation procedure requires as an input a single text file containing the AWS Lambda function's distributed traces obtained through AWS X-Ray. The full demand estimation is broken down into the following procedures.

The extractInformation.m file contains the parsing method for efficiently capturing the required timestamps and metadata of all the functions called. 

The tracesByFunction.m file receives the parsed traces and splits them according to the different AWS Lambda functions contained in the files.

The arrivalDepartureResponse.m file provides the method for efficiently extracting the arrival, the departure and the response time (including queueing time) for each trace. It returns a table sorted with respect the arrival time.

The queueLength.m file receives a sorted table of arrival, departure and response times and it creates the queue length at arrival. 

The demand.m file provides the method for the regression-based demand estimation model. The observation interval [0,T] is split into n equidistant subintervals from which we obtain the mean queue length and mean response time used for the regression.

Finally, the serviceEstimation.m wraps up all the above procedures returning a struct with a field for each function found in the traces and the service demand estimate as values. 
