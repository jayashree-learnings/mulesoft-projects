### Description

The input folder is monitored for all files of the extension xml and is written to csv, json and xslx formats in output folder with appropriate name and time stamp. Once the file is read, it is renamed and moved to backup folder so that it is not deleted. Finally the list operation is used on the output folder to verify that the files are created. The entire process is tested using postman.

xml file in the  monitored folder
##### ![xmlformatFile](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-01/0-xmlFormatFile.PNG)  


Scatter gather in used in the main flow which refers to 3 private flows, each corresponding to appropriate data conversion. A private flow containing a list operation is referred at the end to print the attributes and file names of the processed files.  

- Main functionalities used 
   - On new Or Updated File checks and  the folder for pattern matching with *.xml every 5 minutes. The read file is moved to back up folder and renamed as 'backup-filename-time'  
   - write  operation - writes to output folder as 'processed-filename-time' with proper extension. To get the time now() is formatted as now() as String {format:"Y-MM-dd-HH-mm-ss"}
   - scatter-gather to route to 3 flow references in parallel
   - flow reference to refer appropriate private flows
   - transform message for appropriate data conversions using map function
   - list operation - to list the metadata and file names in the output folder which confirming that the file conversion has happened.

### Result

main flow  

##### ![mainflow](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-01/01-MainFlow.png)  


private flows  

##### ![privateflows](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-01/02-privateFlows.PNG)  

converting xml to json  

##### ![xmlTojson](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-01/02a-xmlTojson.PNG)  


converting xml to csv  

##### ![xmlTojson](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-01/02b-xmlTocsv.PNG)  


converting xml to xlsx  

##### ![xmlTojson](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-01/02c-xmlToxlsx.PNG)  


getting the details of files in the private flow  

##### ![listFileDetails](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-01/03a-list.PNG)  


logging the information in the console  

##### ![printingInConsole](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-01/03b-attributesAndFileNames.PNG)  

processed files in the output folder  

##### ![outputFolder](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-01/05-outputFolder.PNG)

the actual file renamed and moved to back up folder  

##### ![backupFolder](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-01/04-backupFolder.PNG)
 
 
   
 




  
   














