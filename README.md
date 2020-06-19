## HF Server Events Setup Script

The main idea of this project is to help companies that don’t want to expend a lot of money on Centralization of Logs solutions. Most of this can be accomplished using default tools in Windows. 

This is the v1 of this project and I’m just using Windows Server and SQL Server.

<br/><br/>

I'm already working in a new HF Server Events v2 that will much likely be based on Windows Server and ElasticSearch to support larger environments.

<br/><br/>


The final result will be the Web Reports created in the Reporting Services:

<br/>

![alt text](https://github.com/ClaudioMerola/HFServerEvents/raw/master/Docs/ReportWorking.png)

<br/><br/>
<br/>

## Steps:

<br/>

### 1. Join a Windows Server to domain
### 2. Install SQL Server 
### 3. Run the script

<br/><br/>

## The script will:

<br/>

#### On the server:

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

<br/>

#### On the Domain Controllers:

 - Add a registry key in all your Domain Controllers (to configure the Centralized Event Server)
 - Configure WinRM in all your Domain Controllers (this is a default pre-requisite to Event Forwarders to work)
 - Configure Event Forward Service in all your Domain Controllers
 - Add the account "NETWORK SERVICE" the Domain Group "Log Event Readers"

<br/><br/>

Obs: The Events forwaded are configured based on the Microsoft's Best Practices [Events to monitor](https://docs.microsoft.com/en-us/windows-server/identity/ad-ds/plan/appendix-l--events-to-monitor)

<br/><br/>

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

## Important Details in the SQL Server Installation.

<br/>

There is not many configuration required by the SQL Server installation besides the ones listed bellow

<br/>

### The Following are required components (Red):

 - Database Engine Services
 - Full-Text and Semantic Extractions for Search
 - Reporting Services - Native
 
### The Following are recommended components (Blue):

  - Management Tools - Complete
  
<br/>

![alt text](https://github.com/ClaudioMerola/HFServerEvents/raw/master/Docs/DB.png)

<br/>

### Reporting Services Installation and Configuration:

Just use the default "Install and configure"

<br/>

![alt text](https://github.com/ClaudioMerola/HFServerEvents/raw/master/Docs/ReportingSetup.png)

<br/>

### SQL Server Permissions:

During the installation, just add the account running the setup as SQL Server Administrator:

<br/>

![alt text](https://github.com/ClaudioMerola/HFServerEvents/raw/master/Docs/SQLServerAdmin.png)


<br/><br/>
<br/>

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

And you can browse http://HOSTNAME_OF_YOUR_SERVER/Reports and the folder "HF Event Reports" will be there with the 2 default reports:

<br/><br/>

![alt text](https://github.com/ClaudioMerola/HFServerEvents/raw/master/Docs/ReportingFolder.png)

<br/><br/>

To give permissions to more users access the reports, just add them to the local group "HF Event Report Viewer":

<br/><br/>

![alt text](https://github.com/ClaudioMerola/HFServerEvents/raw/master/Docs/GivePermissions.png)

<br/><br/>

in some environments is necessary to open Internet Explorer elevated (Run as Administrator), to correct see the folder and reports.

<br/><br/>

### In case one of the steps in the script didn't work as expected. Or if you have an issue during any of the steps. You can run the specific step again after you fix the issue. 

<br/><br/>

### Just run the script again and select "N", then chose the specific step you want to run:

<br/><br/>

![alt text](https://github.com/ClaudioMerola/HFServerEvents/raw/master/Docs/Script.png)
