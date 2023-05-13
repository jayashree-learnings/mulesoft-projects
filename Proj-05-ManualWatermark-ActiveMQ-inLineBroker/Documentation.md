### Description-Manual Water Marking For DB Records

The requirement is to water mark the records in the muleEmployee table(sqlServer) manually so that duplicate processing of records is avoided. The two flows in the project are shown below 

publishing SQL records to the jms queue
##### ![publishFlow](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-05/01a-jmsInlineBrokerPublishFlow.png)


whenever a new message is published, flow is triggered automatically
##### ![consumeFlow](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-05/01b-jmsInlineBrokerConsumeFlow.png)


A scheduler is used to trigger the flow every 5 minutes. The retrieve operator of the object store connector is used to retrieve the value of a key called maxEmpId which defaults to a value of zero as shown. 
##### ![retrieveOS](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-05/a-retreiveMaxEmpIdDefaultZero.PNG)

The muleEmployee table initially has 3 records as shown.
##### ![3RecInDB](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-05/02a-dbWith3records.PNG)

Only those records are selected from the DB where the emp_id> vars.maxEmpId. 
##### ![SelectFromDB](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-05/b-selectFromDB.PNG)

Initially, when the MaxEmpId is zero, all record are selected from the DB. A choice router is used to implement two scenarios. If any records are selected from DB, the maxEmpId-key in the object store is reset to have the value as the maximum among the selected emp_id. 
##### ![StoreMaxEmpIdOS](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-05/c-storemaxAmongEmpIdValues.PNG)

The selected payload is transformed to json and published to a jms queue. 
##### ![publishToQueue](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-05/d-publishToQueue.PNG)

If records are not selected from the DB, a response message indicating the same is sent to the user.
##### ![responseMsg](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-05/e-responseMsgForNoNewRec.PNG)    

The on new message operation of the jms in the second flow checks if new messages are published to the queue and consumes it. The payload is converted to csv in the transform message and then written as a csv file in append mode.
##### ![toCSVWithTimeStamp](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-05/f-transformToCSVWithTimeStamp.PNG)

##### ![toCSVWithTimeStamp](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-05/g-writingInAppendMode.PNG)


To verify that the records are not processed repeatedly, 2 more rows were added to the DB table. In the final CSV, only these 2 new records were appended with headers. If headers need to be avoided,headers=false can be given in the transform message. 

- File organization
   - 3 main mule configuration files in the src/main/mule
      - the main implementation file  consisting of the  flows only
      - errorHandling.xml - has only the error related configurations
      - globalConfigurations - only the configuration elements like HTTP listener, jms configuration, Database configuration, and configuration properties.  
   - ConfigProperties.yaml in the src/main/resources has the configuration properties defined for each configuration element which is then accessed using the syntax for example ${http.port} 

   main implementation file with main flows only
   ##### ![mainImplementationFile](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-05/fileOrgMainImplentation-01.PNG)

   global configuration settings only
   ##### ![globalConfigSettings](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-05/fileOrgGlobalConf-02.PNG)

   error handling file
   ##### ![errorHandlingFile](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-05/fileOrgErrorHandling-03.PNG)

   Configuration property values
   ##### ![createCustomObjectRecordInSF](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-05/fileOrgConfigProp-04.PNG)


- Main functionalities used 
   - object store - retrieve connector is used to retrieve the value of the key named maxEmpId each time the flow is triggered. This value can be accessed like a variable as vars.maxEmpId. The store connector is used to readjust the value of the key in case, the records are selected from the DB and it set to maximum of the emp_id among the selected records.
   - select operation of DB - to select only those records from muleEmployee table
   where the emp_id is greater than the current value of maxEmpId. 
   - transform message - for appropriate data conversions. 
   - logger  - to print to the console appropriate messages.
   -  jms activeMQ broker - the inline broker url is used. 
      - publish operator - to publish the records from the DB to the queue 
      - on new message operator - triggered each time a new message is published to the queue   

### Result

The initial 3 records processed and written in csv format with headers
##### ![3RecTocsv](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-05/03a-3RecWrittenToFile.PNG)

The scheduler checks regularly and confirms no new records are added to the DB
##### ![repeatedMsgNoDuplicateProcessing](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-05/03b-repeatedMsgNoDuplicateProcessing.PNG)

Two new records being added to the DB
##### ![TwoRecAdded](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-05/03c-TwoRecAdded.PNG)

Logger message after adding two new records to the DB
##### ![LoggerMsgAfterAddingTwoRecInDB](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-05/03d-LoggerMsgAfterAddingTwoRecInDB.PNG)

Only the two new records are appended to the same CSV (headers are also getting added since it is not set to false in the transform message)
##### ![TwoNewRecAppended](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-05/03e-TwoNewRecAppended.PNG)

The scheduler re-checks again and confirms no new records are added to the DB
##### ![repeatedMsgInLoggerNoNewRecsFound](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-05/03f-repeatedMsgInLoggerNoNewRecsFound.PNG)






