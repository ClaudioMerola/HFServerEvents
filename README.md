## HF Server Events Setup Script

The main idea of this project is to help companies that don’t want to expend too much money on Centralized Logs solutions. Most of this can be accomplished using default tools in Windows. 

In this project I’m using Windows Server and SQL Server only.


#### This script may affect your environment!

Even there is no harm in the script itself. It will change a few things in your environment. It will:

- Add a registry key in all your Domain Controllers (to configure the Centralized Event Server)
- Configure WinRM in all your Domain Controllers (this is a default pre-requisite to Event Forwarders to work)
- Configure Event Forward in all your Domain Controllers (this will enable and start the default “Windows Event Collector” service)


### How to run:

Just copy or download the HFEventServer.ps1 and run on any Windows Server computer that meets the requirements below.

### Requirements:

The script must be run with the following requirements:

 - The script was tested in Windows Server 2012 and Windows Server 2019
 - The SQL Server 2014 was the only version tested (you must also install “Reporting Services” and “FullText Search”. This is detailed  in the screenshots)
 - The Account running the script must have rights to connect remotelly and create registry keys on the Domain Controllers
 - Connectivity trough port TCP 5985 (Default Event Forwarder Port) with the Domain Controllers
 - Internet connection is not required*

#### Screenshots:

The final result will be the Web Reports created in the Reporting Services:

![alt text](https://github.com/ClaudioMerola/HFServerEvents/raw/master/Docs/ReportWorking.png)

#### Installation.

### .NET Framework 3.5 Feature

![alt text](https://github.com/ClaudioMerola/HFServerEvents/raw/master/Docs/DOTNET.png)


### Important Details in the SQL Server Installation.

## The Following are required components (Red):
 - Database Engine Services
 - Full-Text and Semantic Extractions for Search
 - Reporting Services - Native
 
 ## The Following are recommended components (Blue):
  - Management Tools - Complete

![alt text](https://github.com/ClaudioMerola/HFServerEvents/raw/master/Docs/DB.png)


### Important Details in the SQL Server Installation.


![alt text](https://github.com/ClaudioMerola/HFServerEvents/raw/master/Docs/ReportWorking.png)



![alt text](https://github.com/ClaudioMerola/HFServerEvents/raw/master/Docs/ReportWorking.png)


