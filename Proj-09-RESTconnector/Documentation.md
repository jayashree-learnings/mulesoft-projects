### Api led Connectivity-REST connector

Api led connectivity is a highly recommended practice to reuse the assets enhancing quick delivery of requirements. In this project, the calculator api developed in one of the earlier projects is used as a REST connector. 

1)adding REST connector in the project  - In the pallete of anypoint studio, in  search in exchange, the latest version of calculator api added to the module. It has four operations corresponding to the four resources specified in the api design as shown
##### ![0a-restConnectorAdded](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-09/0a-restConnectorAddedToModule.PNG)  

2)Utilizing REST connector - The raml specification of the calculator api has client-id-required specified as a trait and client-id-enforcement policy applied on the proxy url. Hence the correct credentials need to be given while configuring the REST connector. The host is the proxy url of the the calculator api. The various configurations are shown
##### ![1a-conf](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-09/1a-conf.PNG) 
##### ![1b-conf](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-09/1b-conf.PNG)  

The properties are defined in yaml file located in src/main/resources as shown and it is specified in global element
##### ![1c-conf](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-09/1c-conf.PNG) 

The request is sent to all the operations parallely using scatter gather. Each operation is wrapped in try block and error handled. Final desired  result is obtained using appropriate transform message. The main flow is shown below
##### ![2a-0-mainFlow](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-09/2a-0-mainflow.png)  

extracting the desired details from the final result of scatter gather
##### ![2a-1-transformMsgInmainFlow](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-09/2a-1-transformMsgOfMainFlow.png)

The main files are split into 4 mule configuration files  
   -  implementation. xml - The file consists of only  the main flows and private flows for the backend logic as shown. 
   ##### ![2a-implementation](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-09/2a-implemnt.PNG)  

   - errorHandling.xml - has only the error related configurations as shown
   ##### ![2b-errorHandling](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-09/2b-err.PNG)  

   - globalConfigurations - only the configuration elements like HTTP listener,  rest connector configuration and also the configuration properties file.
   ##### ![2c-globalConfig](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-09/2c-globalConf.PNG)  


3)testing - The application is tested using postman and the results are as shown.

result of all the 4 operations on given two numbers
##### ![finalResult-a](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-09/FinalResultAllCorrect-a.PNG)

when num2 is zero
##### ![finalResult-b](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-09/FinalResultAllCorrectDivisionbyZero-b.PNG)  


