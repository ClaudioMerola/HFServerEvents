## HF Server Events Setup Script

The main idea of this project is to help companies that don’t want to expend a lot of money on Centralization of Logs solutions. Most of this can be accomplished using default tools in Windows. 

In this project I’m just using Windows Server and SQL Server only.
<br/><br/>
<br/>

The final result will be the Web Reports created in the Reporting Services:

<br/>

![alt text](https://github.com/ClaudioMerola/HFServerEvents/raw/master/Docs/ReportWorking.png)

<br/><br/>
<br/>

## After you join a Windows Server to domain and Install SQL Server. Run the script and it will:

<br/><br/>

 - Configure and enable WinRM and Event Collector Service
 - Create the Event Forward Subscription
 - Configure all the Domain Controllers to forward the events to this server
 - Increase the maximum size of the Forwarded Events to 4 GB 
 - Create a local group named: "HF Event Report Viewer"
 - Create the SQL Server database and tables
 - Configure the SQL Server's Full Text Search
 - Configure a Scheduled Task to Synchronize the Forwarded Events with the SQL Server Database (hourly)
 - Configure the Reporting Services 
 - Create and import the Reporting Services Reports
 - Configure the Reporting Services Permissions (to give permissions to more users just add them to the Windows "HF Event Report Viewer" local group)

<br/><br/>
<br/>

Obs: The Events forwaded are configured based on the Microsoft's Best Practices [Events to monitor](https://docs.microsoft.com/en-us/windows-server/identity/ad-ds/plan/appendix-l--events-to-monitor)

<br/><br/>

#### This script may affect your environment!

<br/>

Even there is no harm in the script itself. It will change a few things in your Domain Controller's environment. It will:

<br/>

- Add a registry key in all your Domain Controllers (to configure the Centralized Event Server)
- Configure WinRM in all your Domain Controllers (this is a default pre-requisite to Event Forwarders to work)
- Configure Event Forward in all your Domain Controllers (this will enable and start the default “Windows Event Collector” service)
- Adds the account "NETWORK SERVICE" the Domain Group "Log Event Readers"

<br/><br/>
<br/>


## How to run the script:

<br/><br/>
<br/>

On a Windows Server with SQL Server installed, just copy or download the HFEventServer.ps1 and run on any Windows Server computer that meets the requirements below.

<br/><br/>
<br/>

### Requirements:

The script must be run with the following requirements:

<br/><br/>

| Requirements | Description |
| --- | --- |
| Windows Server | tested in Windows Server 2012 and Windows Server 2019 |
| SQL Server | SQL Server 2014 was the only version tested |
| Domain Account | must have rights to connect remotelly and create registry keys on the Domain Controllers | 
| TCP 5985 | Default Event Forwarder Port |

<br/><br/>
<br/>

# Windows Server Installation.

<br/><br/>
<br/>

#### .NET Framework 3.5 Feature 

This is required by the SQL Server

![alt text](https://github.com/ClaudioMerola/HFServerEvents/raw/master/Docs/DOTNET.png)

<br/><br/>
<br/>

## Important Details in the SQL Server Installation.

<br/><br/>

There is not many configuration required by the SQL Server installation besides the ones listed bellow

<br/><br/>
<br/>

### The Following are required components (Red):

<br/><br/>

 - Database Engine Services
 - Full-Text and Semantic Extractions for Search
 - Reporting Services - Native
 
### The Following are recommended components (Blue):

<br/><br/>

  - Management Tools - Complete
  
<br/><br/>

![alt text](https://github.com/ClaudioMerola/HFServerEvents/raw/master/Docs/DB.png)

<br/><br/>

### Reporting Services Installation and Configuration:

Just use the default "Install and configure"

<br/><br/>

![alt text](https://github.com/ClaudioMerola/HFServerEvents/raw/master/Docs/ReportingSetup.png)

<br/><br/>
<br/><br/>

### After the SQL Server Installation, restart the server.

<br/>

### After the restart, just run the HFEventServer.ps1. 

If everything runs correctly, the following should have been configured automatically in the local server:

<br/><br/>

A local group named "HF Event Report Viewer" must now exist:

<br/>

![alt text](https://github.com/ClaudioMerola/HFServerEvents/raw/master/Docs/LocalGroup.png)

<br/><br/>

The folder C:\EvtHF and C:\EvtHF\Reports were created and the following files should be there:

<br/><br/>

![alt text](https://github.com/ClaudioMerola/HFServerEvents/raw/master/Docs/Files.png)

<br/><br/>

The forwarding Subscriptions were created:

<br/><br/>

![alt text](https://github.com/ClaudioMerola/HFServerEvents/raw/master/Docs/Subscription.png)

<br/><br/>

The Scheduled Task "HFEventServer\HFEventServer-DCEssentials" were created:

<br/><br/>

![alt text](https://github.com/ClaudioMerola/HFServerEvents/raw/master/Docs/Task.png)

<br/><br/>

### In case one of the steps in the script didn't work as expected. Or if you have an issue during any of the steps. You can run the specific step again after you fix the issue. 

<br/><br/>

### Just run the script again and select "N", then chose the specific step you want to run:

<br/><br/>

![alt text](https://github.com/ClaudioMerola/HFServerEvents/raw/master/Docs/Script.png)
