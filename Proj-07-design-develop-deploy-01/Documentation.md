### Design-Develop-Deploy

The project tries to mimic bank transactions in a very basic manner by creating an accoun for a new user, checking the balance and updating the balance if some amount is withdrawn. In this project, design center is used for the api design, mySQL (freesqldatabase.com which offers a remote database server set up) is used in the backend to store the account details, run time manager is used to deploy and api manager is used to define policies.  

The 4 distinct api life cycle management phases used are  

1)design phase - The api design is designed in the any point platform design centre in RAML 1.0. The root file has 3 resources  
- createAcount - The user sends details (8 fields) like customerName, bankName, branchName, mailid, atmPin etc using POST method in JSON format. Appropriate  response is sent to the user based on if the a new user account is created or the account exists. 

- checkBalance - The user sends the relevant details in the body of the POST method in JSON. First the validation is done if such an account exists and if so, validation is done for the pin number. Based on the result, appropriate response is sent.  

- withdraw - The user sends the required data in the POST method in JSON format. Checks are done for the existence of the account number, correct pin and sufficient balance. If the user has sufficient balance the amount is withdrawn and total Balance column  updated. If not, appropriate responses are given.  

For all the resources, the datatype of each filed, enum specifications, min length , max length, whether the field is required or not is specified. For re-use purpose and to avoid a single long root file, the data types and example files are defined separately and used in the root file. The designed api spec is published to the exchange and it is made public so that its available in the portal. The root file is shown below
##### ![d1a-designRaml](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-07-design-develop-deploy-01/d1a-raml.PNG)

##### ![d1b-RESTAPIpublicPortal](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-07-design-develop-deploy-01/d1b-publicPortal.PNG)


2)development phase - The published api is imported to any point studio and the back end implementation is completed. The api kit router validates the requests and send it to the correct resource implementation. It also handles all the validation errors like the data type of each field, whether it meets the specified criteria of min and max length etc.  

The main files are split into 4 mule configuration files  
   - interface.xml - has only the api-main flow, api-console flow and three private flows defined in the RAML. These 3 flows in turn uses flow reference to call the flows the corresponding flows defined  in the implementation.xml as shown.
   ##### ![d2a-interface](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-07-design-develop-deploy-01/d2a-InterfaceFile.PNG)  

   -  implementation. xml - The file consists of only  the main flows and private flows for the backend logic as shown. 
   ##### ![d2b-implementation](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-07-design-develop-deploy-01/d2b-ImplementationFile.PNG)  

   - errorHandling.xml - has only the error related configurations as shown
   ##### ![d2c-errorHandling](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-07-design-develop-deploy-01/d2c-ErrorHandling.PNG)  

   - globalConfigurations - only the configuration elements like HTTP listener,  DB configuration, ApI auto discovery(configured before deploying to cloudhub so as to apply policies), configuration properties.  
   ##### ![d2d-globalConfig](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-07-design-develop-deploy-01/d2d-globalConf.PNG)  

The ConfigProperties.yaml in the src/main/resources has the configuration properties defined for each configuration element which is then accessed using the syntax for example ${http.port}
##### ![d2e-configProp](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-07-design-develop-deploy-01/d2e-configProp.PNG)   

The backend has a remote database set up in the  freesqldatabase.com. The implementation is done as follows  

a)createAcount - When the user sends the required fields, first a check is made to see if the account exists based on bankName,branchName and accountNumber by selecting those fields from the table. If  matching records are selected, the user already exists. If not , a new record is created. Appropriate  response is sent to the user.
##### ![flow-01a-createAcct](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-07-design-develop-deploy-01/flow-01a-createAccountFlow.png)  

b)checkBalance - The user sends the required details including the atmPin. First the credentials are verified by checking if the user account exists. If so, the sent atmPin is compared with the atmPin selected from the database for that user. If it does not match, the message is sent as wrong pin. Else the balance amount from the database is displayed to the user as a message.
##### ![flow-01b-checkBalance](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-07-design-develop-deploy-01/flow-01b-checkBalanceFlow.png)   


c)withdraw - The user send all the required data including the atmPin and the amount to be withdrawn. First the uer credentials are checked and then atmPin. if both are verified as correct, the withdrawl amount sent by the user is compared with the total balance of that user. If the total balance is greater than the the withdrawl amount,  total Balance column  updated and message is displayed to the user.  If not insufficient message is displayed.
##### ![flow-01c-withdraw](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-07-design-develop-deploy-01/flow-01c-withdrawAmountFlow.png)  

The flows used repeatedly are used as private flows as shown
##### ![flow-02a-variableSetting](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-07-design-develop-deploy-01/flow-02a-variableSettingFlow.png) 
##### ![flow-02b-VerifyUserCred](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-07-design-develop-deploy-01/flow-02b-checkCustomerCredentialsFlow.png)   
##### ![flow-02c-VerifyAtmPin](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-07-design-develop-deploy-01/flow-02c-validateAtmPinFlow.png)
##### ![flow-02d-CheckSufficientBal](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-07-design-develop-deploy-01/flow-02d-checkSufficientBalanceFlow.png)  

Main functionalities used  
  - select operation of DB - selects matching employee records from muleEmployee table.
   -  insert operation of DB - to create a new user account
   - update operation of DB - to update the total balance of the user after withdrawing the specified amount
   - transform message - for appropriate data conversions. To  
   - logger  - to print to the console
   - choice router - to route based on appropriate conditions  

3)deploy - The application after successfully testing in the local host was deployed to the cloud hub from the any point studio and tested again using postman as shown below.  

Four accounts are created as shown
##### ![d3-1a-createFirstAccount](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-07-design-develop-deploy-01/d3-1a-CH-01a-createFirstAccount.PNG)
##### ![d3-1b-createSecondAccount](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-07-design-develop-deploy-01/d3-1b-CH-01b-createSecondAccount.PNG) 
##### ![d3-1c-createThirdAccount](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-07-design-develop-deploy-01/d3-1c-CH-01c-createThirdAccount.PNG) 
##### ![d3-1d-createFourthAccount](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-07-design-develop-deploy-01/d3-1d-CH-01d-createFourthAccount.PNG)  

All the four records are inserted into the DB as shown
##### ![d3-1e-fourRecsInDB](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-07-design-develop-deploy-01/d3-1e-CH-01e-allRowsInMySQLInserted.PNG)  

When tried to insert the same record again, it displays appropriate message
##### ![d3-1f-NoDuplicateRecAllowed](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-07-design-develop-deploy-01/d3-1f-CH-01f-DuplicateInsertionNotAllowed.PNG)

For checking the balance, initially correct information is given as shown below
##### ![d3-2a-checkBalWithCorrectCred](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-07-design-develop-deploy-01/d3-2a-CH-02a-checkBalWithCorrectCredentials.PNG)

Checking the balance, with incorrect accountNumber
##### ![d3-2b1-checkBalWithInCorrectCred](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-07-design-develop-deploy-01/d3-2b1-CH-02b1-checkBal-IncorrectAcctNum.PNG)  

Checking the balance with correct accountNumber but incorrect atmPin
##### ![d3-2b2-checkBalWithCorrectCredIncorrectPin](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-07-design-develop-deploy-01/d3-2b2-CH-02b2-checkBal-correctAcctNumIncorrectPin.PNG)  

To withdraw the amount, correct credentials are given first and the corresponding record is updated in the table as shown
##### ![d3-3a1-withdrawCorrectCred](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-07-design-develop-deploy-01/d3-3a1-CH-03a1-withdraw-correctCredentials.PNG)

##### ![d3-3a2-updatedMySql](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-07-design-develop-deploy-01/d3-3a2-CH-03a2-withdraw-correctCredentials-UpdatedInMysql.PNG)  

trying to withdraw for an account number which does not exist
##### ![d3-3b-withdrawIncorrectAcctNum](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-07-design-develop-deploy-01/d3-3b-CH-03b-withdraw-IncorrectAccntNum.PNG)  

trying to withdraw with correct account number, but incorrect pin
##### ![d3-3c-withdrawCorrectAcctNumWrongPin](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-07-design-develop-deploy-01/d3-3c-CH-03c-withdraw-correctAccntNumIncorrectPin.PNG)  

trying to withdraw with correct credentials but insufficient balance
##### ![d3-3d-correctCredInsufficientBal](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-07-design-develop-deploy-01/d3-3d-CH-03d-withdraw-correctCredentialsInsufficientBal.PNG)

Some other validations done are shown below
##### ![d3-4a-Incorrectjson](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-07-design-develop-deploy-01/d3-4a-Validation-01-InvalidJsonNodoubleQuoteForName.PNG)

##### ![d3-4b-IncorrectInputdataSent](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-07-design-develop-deploy-01/d3-4b-Validation-04-allValidations.PNG)  


4)manage - The deployed api was managed by defining policies in the api manager. First in the api manager, an api is added to the api manger by pointing to the published api in the exchange and choosing a basic end point configuration(not proxy). The initial status of the added api is unregistered. To register it, two configuration steps are done,
1) in the studio, the api id from the api manager is given in the auto discovery which inturn should be defined in the global elements.
2) The client id and client secret of the environment to which it is deployed is defined in the windows-preferences-api manager as shown

##### ![d4-0-clientidSecretGiven](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-07-design-develop-deploy-01/d4-0-clientidSecretStudio.PNG)  

3) The application is again redeployed over writing the existing application. The status in the api manager turns to active.
##### ![d4-01-apiStatusActive](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-07-design-develop-deploy-01/d4-01-Policy-01-apiManagerActiveWhenClientidScretAndAutodiscoveryIdwereGivenInStudio.PNG)  

The basic authentication, client id enforcement and rate limiting policies are tested as shown below  

1)Basic authentication policy 

The basic authentication policy was implemented as shown.Access to the api denied without user name and password
##### ![d4-1a-NoUsernamePwdGiven](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-07-design-develop-deploy-01/d4-1a-Policy-01a-whenNousernaamePwdGiven.PNG)  

The access was allowed when username and password were given
##### ![d4-1b-accessAllowedWithUsernamePwdGiven](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-07-design-develop-deploy-01/d4-1b-Policy-01b-whenusernaamePwdGivenItWorked.PNG)  

2)client id enforcement policy

After enabling client id enforcement, the access was denied without giving them in the headers
##### ![d4-2a-accessAllowedWithoutclientIdSecret](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-07-design-develop-deploy-01/d4-2a-Policy-02a-WhenOnlyBasicAuthenticationWasUsedandclientidEnforcementNotGiven.PNG)  

The access was allowed when client id and secret were passed in the headers
##### ![d4-2b-accessAllowedWhenclientIdSecretInHeaders](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-07-design-develop-deploy-01/d4-2b-Policy-02b-clientidEnforcement.PNG)  

3)RateLimiting policy

On exceeding the permissible number of api calls in a given time period
##### ![d4-3-RateLimiting](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-07-design-develop-deploy-01/d4-3a-Policy-03a-RateLimiting.PNG) 










   




