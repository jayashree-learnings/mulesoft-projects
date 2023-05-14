### Description-Integrate External Api

The requirement is to integrate two external apis in the project. One api is the genderize api(https://api.genderize.io) which predicts the gender based on a given name. The second api is the nationalize api (https://api.nationalize.io)which predicts the nationality of the given name with probability. 

The user sends a name as the query parameter in the http request. This is stored as a variable called name using set variable component. The scatter gather component is used to request two apis simultaneously. Each route of the scatter gather is wrapped in try block(on error continue) so that even if one request fails, the other request is sent properly.  

The main flows are as shown
##### ![mainFlow](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-03/00-mainFlow.png)

The various steps are  

setting the variable
##### ![setVar](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-03/a-setVar.PNG)

configuring the http request for genderize api
##### ![api1](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-03/b1-configgenderizeApi.PNG)


configuring the http request for nationalize api
##### ![api2](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-03/b2-confignationalizeApi.PNG)

transform message to extract useful information from the scatter gather route 
##### ![transformMsg](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-03/c-extractUsefulInfo.PNG)


- File organization in the project is as follows
   - 3 main mule configuration files in the src/main/mule
      - the main implementation file  consisting of the  flows only
      - errorHandling.xml - has only the error related configurations
      - globalConfigurations - only the configuration elements like HTTP listener.
   
   main implementation file with main flows only
   ##### ![mainImplementationFile](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-03/FileOrg-01-implmt.PNG)

   global configuration settings only
   ##### ![globalConfigSettings](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-03/FileOrg-02-globalConfig.PNG)

   error handling file
   ##### ![errorHandlingFile](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-03/FileOrg-03-errorHandling.PNG)


- Main functionalities used 
   
   - set variable - the name is sent as a query parameter in the http request. It is stored as variable name so that it can be later accesses as vars.name
   - scatter gather - used to call the api flows in parallel rather than sequentially. 
   - http request - used to request the two apis by giving the url properly. Each request is wrapped in try statement so that even if one api call fails, the other one proceeds.
   - transform message - the scatter gather returns an object of mule events from all the routes of which we are mainly interested in the payload of each event.  
   - logger  - to print to the console appropriate messages.
       

### Result

When both apis are correctly configured, following result in seen in the postman
##### ![postman](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-03/result-bothHtpReqCorrect.PNG)

logging the message in the console 
##### ![log](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-03/result-logger.PNG)

when one url was wrongly given, the other api request still works fine
##### ![OneUrlIncorrect](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-03/result-WhenErrorInOneApiTheOtherstillWorks.PNG)

when both url were wrongly given, the following message is obtained because of the set payload in on error continue 
##### ![bothWrongUrls](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-03/result-incorrectAddressGiven.PNG)