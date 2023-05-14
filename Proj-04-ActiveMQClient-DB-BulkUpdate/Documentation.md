### Description-JMS active MQ-Bulk DB update

The requirement is to publish the selected records from muleEmployee table(sqlServer) to jms Active MQ client which has a web console. The on-new message of jms connector checks for new message and if found, is used to write the employee records as json file with the file name ("oldEmpDetails-" ++ now() as String {format: "YYYY-MMM-dd-HH-m-s"}  ++".json"). After writing the un-updated employee details to a file, a flow reference component is used to call the flow for bulk update. In bulk update operation, a csv file with the updated name and salary details of employees is used as an input and bulk update is performed after transforming the message properly. 

The main flows are as shown below
publishing to the jms queue
##### ![jmsPublish](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-04/00a-jmsPublishEmpDetails.png)

writing the un-modified payload as json file and calling bulk update sub flow
##### ![jmsOnNewMsg](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-04/00b-jmsConsumeAndUpdateEmpSalaryFlow.png)


reading the csv input file and modifying the data as bulk
##### ![bulkUpdateSubFlow](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-04/00c-BulkUpdateEmpDetails_subFlow.png)  

The different steps involved are as shown below.

The DB table before any updates has 5 records as shown.
##### ![actualDB](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-04/DBBeforeUpdate.PNG)

The selected records are published to the queue as shown
##### ![publishToQ](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-04/a-publishToQueue.PNG)

on New message checking for the new message
##### ![onNewMsg](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-04/b-onNewMsg.PNG)

Writing the original un-modified data as json
##### ![writeJson](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-04/c-writeEmpDetailsAsjson.PNG)

reading the input csv file 
##### ![readInputCSV](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-04/d01-readTheinputCSV.PNG)

updated content of the csv where empName and Salary are changed in all records
##### ![CSVcontent](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-04/d02-CSVFileUsedAsInputForBulUpdateSalAndName.PNG)

configuring of bulk update operation to  modify the employee name and salary as given in the input csv
##### ![bulkUpdate](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-04/d03-bulkUpdateOfempNameAndempSalary.PNG)

- File organization in the project is as follows
   - 3 main mule configuration files in the src/main/mule
      - the main implementation file  consisting of the  flows only
      - errorHandling.xml - has only the error related configurations
      - globalConfigurations - only the configuration elements like HTTP listener, jms configuration, Database configuration and configuration properties.  
   - ConfigProperties.yaml in the src/main/resources has the configuration properties defined for each configuration element which is then accessed using the syntax for example ${http.port} 

   main implementation file with main flows only
   ##### ![mainImplementationFile](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-04/fileOrg-01-implement.PNG)

   global configuration settings only
   ##### ![globalConfigSettings](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-04/fileOrg-02-globalConf.PNG)

   error handling file
   ##### ![errorHandlingFile](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-04/fileOrg-03-errorHandler.PNG)

   Configuration property values
   ##### ![createCustomObjectRecordInSF](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-04/fileOrg-04-ConfigProp.PNG)


- Main functionalities used 
   
   - select operation of DB connector- to select all records from muleEmployee table  
   - bulk update of DB connector - used to update the details in a bulk manner. Used when updates are miscellaneous in a random fashion.
   - transform message - for appropriate data conversions. 
   - logger  - to print to the console appropriate messages.
   - jms activeMQ client - jms activeMQ of appropriate version is installed on the local machine,with the webConsole available at  http://127.0.0.1:8161/ .The user name and password credentials are used to login. The broker url is configured as tcp://localhost:61616
      - publish operator - to publish the records from the DB to the queue after transforming to json
      - on new message operator - triggered each time a new message is published to the queue
   - write operation of file connector - to write the unchanged records consumed in the queue as a json format
   - read operation of file connector - to read the updated employee details serving as an input for the bulk update operation.
   - flow reference - to call the bul update functionality         

### Result

The active MQ web console after the flow execution is 
##### ![activeMQWebConsole](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-04/result-ActiveMQWebConsoleAfterPublish.PNG)

The old employee records are consumed by the on new message operation and processed to a json file as shown
##### ![jsonFile](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-04/result-oldEmpDetailsJSON-1.PNG)

##### ![jsonContent](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-04/result-oldEmpDetailsJSON-2.PNG)


The employee records can be seen as updated. The names and salary details are updated as per the input csv file
##### ![updatedDB](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-04/result-DBAfterBulkUpdate.PNG)

Logger messages in the console
##### ![log1](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-04/result-logger-01.PNG)


Logger messages in the console
##### ![log2](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-04/result-logger-02.PNG)



