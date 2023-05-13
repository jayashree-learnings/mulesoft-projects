### Description

The xlsx file is read and converted to one of the three data types (csv, json or xml) as specified by the user. 

File to be read
##### ![file](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-02/0-xlsxFileToBeRead.png)  

The user specifies the required data format as a query parameter or in the request headers. If it is specified in both, priority is for data format specified in query parameter The entire process is tested using postman. If none is specified, it returns the data format in json. If invalid data type is specified, an appropriate  message is sent back to the user. The functionality needed to achieve this is stored as an external dwl file  and imported  

- Main functionalities used 
   - read operation - to read the xlsx from the proper sheet
   - transform message - the data format sent by the user is stored as variables. The function to get the required data format is imported to get the required data format 
   - choice router - to route the flow to the needed data format . If an invalid data format is sent, it is routed to the default route giving an appropriate message

### Result

main flow  

##### ![mainflow](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-02/01-MainFlow.png)  

data transformer  

##### ![02a-requiredDataFormat](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-02/02a-requiredDataFormat.PNG)

Script for the function  

##### ![02b-functionScript](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-02/02b-functionScript.PNG)


transforming the xlsx to csv  

##### ![03a-toCSV](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-02/03a-toCSV.PNG)

transforming the xlsx to json  

##### ![03b-toJSON](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-02/03b-toJSON.PNG)


transforming the xlsx to xml   

##### ![03c-toXML](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-02/03c-toXML.PNG)

handling the invalid data format  

##### ![03d-invalidFormat](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-02/03d-InvaldDataFormat.PNG)

In the postman when the query parameter is specified properly, appropriate responses are obtained as shown below for all the three data conversions.  

##### ![04a-XMLQueryParamt](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-02/04a-XMLQueryParam.PNG)

##### ![04b-JSONQueryParamt](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-02/04b-JSONQueryParam.PNG)

##### ![04c-CSVQueryParamt](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-02/04c-CSVQueryParam.PNG)

When an invalid data format is specified, it returns an appropriate message  

##### ![04d](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-02/04d-InvalidDataFormat.PNG)

In the postman when the content type in headers is specified properly, appropriate responses are obtained as shown below for all the three data conversions.

##### ![05a](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-02/05a-XMLHeaders.PNG)

##### ![05b](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-02/05b-CSVHeaders.PNG)

##### ![05c](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-02/05c-jSONHeaders.PNG)

When nothing is specified in either the query parameters or content type in headers, it returns data in json format  

##### ![06](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-02/06-NothingMentioned-json.PNG)
