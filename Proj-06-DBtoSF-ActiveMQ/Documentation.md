### Description-Transferring records from DB to SF

The sqlServer has a database named muleDB which consists of a table called muleEmployee. The table currently has 5 employee records with emp_id being the primary key as shown. 
##### ![DBWithFiveReords](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-06/01a-currentFiveRecodsInDB.PNG)

The objective is to migrate the employee records from the legacy sql server to the salesforce. In the Salesforce, a custom object called emp_profiles is created and the fields match with those of DB. Initially, it does not have any records
##### ![empCustomObjSF](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-06/01c-noRecordsInSFEmpProfile.PNG)

There are two flows in this mule project as shown below. 
##### ![publishTojmsQ](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-06/00a-jmsPublish-DB_resultsFlow.png)

##### ![ConsumejmsQ](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-06/00b-jmsReceive-CheckIfAccountExistsFlow.png) 

In the first flow,  all the records are selected from DB, converted to json and published to the jms(The JMS client with the web console is used here). 
##### ![SelectDBRec](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-06/a-selectRecordsFromDB.PNG)

The on new message operation of the jms in the second flow checks if new messages are published to the queue and consumes it. The records are converted to java array list and passed on to the batch job. The batch job splits the ArrayList into each record. In the first batch step, query operation of the salesforce checks if the record already exists based on the  emp_id in the payload. The result of the query operation is saved as a variable recordExistsInSF when (sizeOf(payload)>0). If any record is selected from the salesforce(meaning that DB record exists in SF as well), the variable becomes true and if not, false. To the second batch step, only those records where this variable is false is allowed by setting the accept expression as #[(vars.recordExistsInSF==false)]. In the batch aggregator of the second batch step, each record is mapped to the appropriate custom fields in the sales force and inserted as 3 records at once. The diagrams are shown below

querying from SF
##### ![queryInSF](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-06/b0-SFQuery.PNG)

storing the output of query as a variable
##### ![recordExistsStoredAsQueryVar](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-06/b1-StoringOutputInaVar.PNG)

response message for each record
##### ![responseMsgEachRec](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-06/c-responseMsgAsVar.PNG)

mapping to match the custom fieds in SF
##### ![MappingToCustomSFFields](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-06/d-MappingToCustomFieldsInSF.PNG)

create only those records which doesnot exist in SF, but in DB
##### ![createCustomObjectRecordInSF](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-06/e-createCustomObjectRecordInSF.PNG)

- File organization
   - 3 main mule configuration files in the src/main/mule
      - the main implementation file called SyncDBWithSF-JMS-batchprocess.xml consisting of the flows only
      - errorHandling.xml - has only the error related configurations
      - globalConfigurations - only the configuration elements like HTTP listener, Salesforce Configuration, Database configuration, JMS configuration and configuration properties.  
   - ConfigProperties.yaml in the src/main/resources has the configuration properties defined for each configuration element which is then accessed using the syntax for example ${http.port} 

   main implementation file with main flows only
   ##### ![createCustomObjectRecordInSF](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-06/fileOrg1-implementation.PNG)

   global configuration settings only
   ##### ![createCustomObjectRecordInSF](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-06/fileOrg2-globalConf.PNG)

   error handling file
   ##### ![createCustomObjectRecordInSF](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-06/fileOrg3-errorHandling.PNG)

   Configuration property values
   ##### ![createCustomObjectRecordInSF](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-06/fileOrg4-COnfigProp.PNG)


- Main functionalities used 
   - select operation of DB - selects all employee records from muleEmployee table. 
   - transform message - for appropriate data conversions. To publish to jms, the java array from the DB is converted to json. 
   - logger  - to print to the console the payload and media type
   -  jms activeMQ client - jms activeMQ of appropriate version is installed on the local machine,with the webConsole available at  http://127.0.0.1:8161/ .The user name and password credentials are used to login. The broker url is configured as tcp://localhost:61616
      - publish operator - to publish the records from the DB to the queue 
      - on new message operator - triggered each time a new message is published to the queue
   - sales force connector - A custom emp_profiles object is created in the sales force matching with the fields of the muleEmployee table. Initially the object does not have any records.
      - query operation - selects only those records where emp_id equals the payload.emp_id. The output of the query operation is stored in a variable called recordExistsInSF based on the sizeOfpayload. The variable is true, if any matching records exists in SF, else false. 
      - create operation - used to write those records which does not exist in SF.
   - batch job - to split the java array list into each record. It consists of two steps
      - first batch step - checks if each record exists in the SF in its processing stage using SF query.
      - second batch step - Only those records which do not exist in the SF are allowed by applying the filter criteria. In the aggregator, array is mapped  to the appropriate custom fields of SF and inserted into the custom emp_profiles object.

### Result

Inserting five records in SF
##### ![fiveRecInsertedInSF](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-06/02a-RecordsInsertedInSFAfterExecutingTheFlow.PNG)

Active MQ web console after the first flow execution
##### ![ActiveMQWebConsole](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-06/02b-ActiveMQWebConsoleAfterExecutingFlow.PNG)

Last two records newly added to DB
##### ![TwoNewRecAddedInDB](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-06/03a-2NewRecordsAddedInDB.PNG)

ActiveMQ console after the seconfd flow execution
##### ![ActiveMQAfterSecondMsg](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-06/03b-activeMQWebConsoleAfterExecutingTheFlowASecondTime.PNG)

Last two records added to SF without duplication of the previous records
##### ![OnlyTwoNewRecAddedInSF](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-06/03c-OnlyNewRecordsInsertedINSFWoithOutDuplicates.PNG)

logger in batch step 01
##### ![loggerBatchStep01](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-06/f-loggerInBatchStep01.PNG)

logger in batch step 02
##### ![loggerBatchStep02](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-06/g-loggerInBatchStep02.PNG)


