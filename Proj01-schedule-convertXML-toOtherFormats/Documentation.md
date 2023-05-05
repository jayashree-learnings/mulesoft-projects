### Description

The input folder is monitored for all files of the extension xml and is written to csv, json and xslx formats in output folder with appropriate name and time stamp. Once the file is read, it is renamed and moved to backup folder so that it is not deleted. The entire process is tested using postman.

The main flow consists of the scatter gather which refers to 3 flows.
The 3 private flows are meant for the appropriate data conversion
 
- Main functionalities used 
   - On new Or Updated File checks and  the folder for pattern matching with *.xml every 5 minutes. The read file is moved to back up folder and renamed as 'backup-filename-time'  
   - write  operation - writes to output folder as 'processed-filename-time' with proper extension. To get the time now() is formatted as now() as String {format:"Y-MM-dd-HH-mm-ss"}
   - scatter-gather to route to 3 flow references parallely
   - flow reference to refer appropriate privateflows
   - transform message for appropriate data conversions using map function
   
### Result

main flow

##### ![mainflow](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-01/01-MainFlow.png)

private flows
 
##### ![privateflows](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-01/02-privateFlows.PNG)

processed files in the output folder

##### ![outputFolder](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-01/03-outputFolder.PNG)

the actual file renamed and moved to back up folder

##### ![backupFolder](https://github.com/jayashree-learnings/mulesoft-projects/blob/main/00_includes/proj-01/04-backupFolder.PNG)
 
 
   
 




  
   














