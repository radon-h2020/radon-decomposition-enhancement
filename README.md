| Items    |     Contents  |
|----------|---------------|
| Description |  The goal of the Radon-Decomposition-Enhancement tool is to provide resource demand estimations for AWS Lambda Functions, using external monitoring data captured with AWS X-Ray. |
| License |       |
| Mainteners | Giuliano Casale @gcasale, Jose Perusquia @JosePerusquia, and Runan Wang @runanwang07 |
| Demo    | Link: https://www.youtube.com/watch?v=vmnjp_nDqXU&list=PLJ3re6Ar-kEV5WAxbTiJJsBBzPp8-Bzs_&index=6 |
    

# Radon-Decomposition-Enhancement


The radon-decomposition-enhancement repository, contains the required functions to perform service demand estimation for AWS Lambda Functions. 


# Functionality
The enhancement feature is integrated into RADON’S decomposition tool to obtain resource demand estimation based on monitoring data. The current estimation procedure supports a regression-based model on the mean response time as a linear function of the mean queue length at arrival.

The main procedure of the accuracy enhancement for RADON’S decomposition tool is as follows. 
- First, users need to monitor the deployed Lambda functions and obtain the distributed traces with AWS X-Ray. 
- The enhancement feature takes the log file and the original tosca model file containing the specifications of the pipeline as inputs.
- The full demand estimation is broken down into the following procedures.
  - Parse the required timestamps and metadata of all the functions called in the log file.
  - Receive the parsed traces and split them according to the different AWS Lambda functions.
  - Extract the arrival, the departure, the response time (including queueing time) and the queue length for each trace.
  - Estimate the service demand with a regression-based model.
- After obtaining the estimated demand, the original tosca model will be updated with the estimated values.
![enhancement](https://user-images.githubusercontent.com/74663621/132330868-3ea66570-329c-480c-a0aa-0e67224b96a6.png)

# Documentation
The extended description of the enhancement can be found in the D2.3 and D6.5, where we present the monitoring customisation and accuracy enhancement. A video presentation and a live demo for the enhancement feature are available at [RADON Webinar 5](https://www.youtube.com/watch?v=vmnjp_nDqXU&list=PLJ3re6Ar-kEV5WAxbTiJJsBBzPp8-Bzs_&index=6). 
