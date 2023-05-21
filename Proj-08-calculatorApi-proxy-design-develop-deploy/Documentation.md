### Design-Develop-Deploy(proxy endpoint)

In this project, a basic calculator api which performs the four basic arithmetic operations is designed, developed, deployed and managed.
The 4 distinct api life cycle management phases used are  

1)design phase - The api design is designed in the any point platform design centre in RAML 1.0. The root file has 4 resources to perform the four operations.
- add  

- subtract    

- multiply  

- divide  

The user sends two numbers num1 and num2 in the body of the POST method in JSON. Also the client-id-required is specified as trait for all the resources.

The data types, examples and documentation files are defined separately and used in the root file. The designed api spec is published to the exchange and it is made public so that its available in the portal. The root file is shown below
##### ![d1a-designRaml](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-08/d1a-designRaml.PNG)

2)development phase - The published api is imported to any point studio and the back end implementation is completed. The api kit router validates the requests and send it to the correct resource implementation. It also handles all the validation errors like the data type of each field.

The main files are split into 4 mule configuration files  
   - interface.xml - has only the api-main flow, api-console flow and four private flows defined in the RAML. These four flows in turn uses flow reference to call the flows the corresponding flows defined  in the implementation.xml as shown.
   ##### ![d2a-interface](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-08/d2a-interface.PNG)  

   -  implementation. xml - The file consists of only  the main flows and private flows for the backend logic as shown. 
   ##### ![d2b-implementation](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-08/d2b-implementation.PNG)  

   - errorHandling.xml - has only the error related configurations as shown
   ##### ![d2c-errorHandling](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-08/d2c-errorHandling.PNG)  

   - globalConfigurations - only the configuration elements like HTTP listener,  api kit router configuration
   ##### ![d2d-globalConfig](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-08/d2d-globalConf.PNG)  


The backend implementation file has a all the four basic arithmatic operations handled in 4 flows as shown. Appropriate response is sent to the user.  

a)adding two numbers
##### ![flow-01a-add](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-08/flow-01a-add.PNG)  

b)subtracting  
##### ![flow-01b-subtract](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-08/flow-01b-subtract.PNG)   


c)multiplying
##### ![flow-01c-multiply](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-08/flow-01c-mul.PNG)  

d)dividing. If num2 is zero, the result is an appropriate message string.
##### ![flow-01d-divide](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-08/flow-01d-divisionTransformmsg.PNG)

The flow to store the incoming payload is used repeatedly as shown
##### ![flow-01e-variableSetting](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-08/flow-01e-varSet.PNG)  


3)deploy - The application after successfully testing in the local host was deployed to the cloud hub from the any point studio and tested again using postman as shown below.  

For the application running in local host and cloud hub, it throws error if client-id and client-secret are not included in the headers. Since client-id-enforcement policy is not added at this stage using api manager, its not mandatory to give the correct credentials of the client application.

testing on local host throws error without credentials in headers
##### ![d3-0a](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-08/d3-0a-localhostTestWONTWORKwithoutSomeString.PNG)  

application works on local host with credentials
##### ![d3-0b](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-08/d3-0b-localhostTestWORKwithSomeString.PNG)  

application works on cloudhub with credentials. This is the actual implementation url.
##### ![d3-1a](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-08/d3-1a-CHdeployUsual-SomeClientIdToBeGiven-NOtRTmnager.PNG)
 

4)manage - The deployed api is managed in api manger by creating a proxy url and defining the client-id-enforcement policy for that proxy url. To get client id and secret, a new application is created after requesting the access in the public portal as shown.  

Creating proxy endpoint in the api manager
##### ![platform-02a](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-08/platform02a-api-manager.PNG)

Applying client-id-enforcement in api manager
##### ![platform-02b](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-08/platform02b-api-manager-policyApplied.PNG)

In run time manager, both the actual implementation and proxy application can be seen. The users generally will access the proxy application without knowing about the back end implementation. The policies can be applied to this proxy application like how many requests the user can make to the proxy application, what ip address can access the proxy application etc. 
##### ![platform-01](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-08/platform01-RT-manageractual%20and%20proxy%20url.PNG)  

The general concept about end point configuration is like this
##### ![platform-04](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-08/platform04-api-manager-endpointDetail.PNG) 

The access is requested to the published api in the exchange using a registered client application and the credentials client-id and client-secret obtained. The client application is visible in exchange-public portal-my applications and the credentials can be seen.
##### ![platform-03](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-08/platform03-publicPortal-applicationwhichRequestedAccess-CanSeeCred.PNG)  

The various results of testing in postman are shown.
proxy url does not work when wrong incomplete credentials are given
##### ![d3-1b01](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-08/d3-1b01-proxyUrlAfterApplyingcclientIdpolicyGivingWrongCred.PNG) 

proxy url works when correct credentials are given
##### ![d3-1b02](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-08/d3-1b02-proxyUrlAfterApplyingcclientIdpolicyWorksWithcorrectCredOfRequestAccessTestAppl.PNG)  

proxy url works when correct credentials are given and when divide resource is called with zero as num2
##### ![d3-1b03](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-08/d3-1b03-proxyUrlAfterApplyingcclientIdpolicyWorksWithcorrectCredOfRequestAccessTestApplDividebyZero.PNG)











   




