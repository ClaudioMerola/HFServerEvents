write-host 'Starting HF Event Server Setup Script..'

$EvtServer = ((Get-WmiObject win32_computersystem).DNSHostName+"."+(Get-WmiObject win32_computersystem).Domain)

$EvtS = (Get-WmiObject win32_computersystem).DNSHostName

$Forest = [system.directoryservices.activedirectory.Forest]::GetCurrentForest()

$DCs = $Forest.domains | ForEach-Object {$_.DomainControllers}



################################################## Configure Collector Server ###########################################################

function ConfigCollector {

try{

if ((Test-Path -Path C:\EvtHF -PathType Container) -eq $false) {New-Item -Type Directory -Force -Path C:\EvtHF}

$DCSec = ("C:\EvtHF\EvtHF_DC_Sec.xml") 
if ((test-path $DCSec) -eq $false) {new-item $DCSec -Type file -Force}
Clear-Content $DCSec

$DCSys = ("C:\EvtHF\EvtHF_DC_Sys.xml") 
if ((test-path $DCSys) -eq $false) {new-item $DCSys -Type file -Force}
Clear-Content $DCSys


$XMLDCSec = @'
<?xml version="1.0" encoding="UTF-8"?>
<Subscription xmlns="http://schemas.microsoft.com/2006/03/windows/events/subscription">
	<SubscriptionId>HFEventServer_DC_Security</SubscriptionId>
	<SubscriptionType>SourceInitiated</SubscriptionType>
	<Description></Description>
	<Enabled>true</Enabled>
	<Uri>http://schemas.microsoft.com/wbem/wsman/1/windows/EventLog</Uri>
	<ConfigurationMode>Custom</ConfigurationMode>
	<Delivery Mode="Push">
		<Batching>
			<MaxLatencyTime>900000</MaxLatencyTime>
		</Batching>
		<PushSettings>
			<Heartbeat Interval="900000"/>
		</PushSettings>
	</Delivery>
<Query>
		<![CDATA[
<QueryList>
    <Query Id="0"><Select Path="Security">*[System[(EventID=4618 or EventID=4618 or EventID=4649 or EventID=4719 or EventID=4765 or EventID=4766 or EventID=4794 or EventID=4897)]]</Select></Query>
    <Query Id="1"><Select Path="Security">*[System[(EventID=4964 or EventID=5124 or EventID=1102 or EventID=4621 or EventID=4675 or EventID=4692 or EventID=4693 or EventID=4706)]]</Select></Query>
    <Query Id="2"><Select Path="Security">*[System[(EventID=4713 or EventID=4714 or EventID=4715 or EventID=4716 or EventID=4724 or EventID=4727 or EventID=4735 or EventID=4737)]]</Select></Query>
    <Query Id="3"><Select Path="Security">*[System[(EventID=4739 or EventID=4754 or EventID=4755 or EventID=4764 or EventID=4764 or EventID=4780 or EventID=4816 or EventID=4865)]]</Select></Query>
    <Query Id="4"><Select Path="Security">*[System[(EventID=4866 or EventID=4867 or EventID=4868 or EventID=4870 or EventID=4882 or EventID=4885 or EventID=4890 or EventID=4892)]]</Select></Query>
    <Query Id="5"><Select Path="Security">*[System[(EventID=4896 or EventID=4906 or EventID=4907 or EventID=4908 or EventID=4912 or EventID=4960 or EventID=4961 or EventID=4962)]]</Select></Query>
    <Query Id="6"><Select Path="Security">*[System[(EventID=4963 or EventID=4965 or EventID=4976 or EventID=4977 or EventID=4978 or EventID=4983 or EventID=4984 or EventID=5027)]]</Select></Query>
    <Query Id="7"><Select Path="Security">*[System[(EventID=5028 or EventID=5029 or EventID=5030 or EventID=5035 or EventID=5037 or EventID=5038 or EventID=5120 or EventID=5121)]]</Select></Query>
    <Query Id="8"><Select Path="Security">*[System[(EventID=5122 or EventID=5123 or EventID=5376 or EventID=5377 or EventID=5453 or EventID=5480 or EventID=5483 or EventID=5484)]]</Select></Query>
    <Query Id="9"><Select Path="Security">*[System[(EventID=5485 or EventID=6145 or EventID=6273 or EventID=6274 or EventID=6275 or EventID=6276 or EventID=6277 or EventID=6278)]]</Select></Query>
    <Query Id="10"><Select Path="Security">*[System[(EventID=6279 or EventID=6280 or EventID=24586 or EventID=24592 or EventID=24593 or EventID=24594 or EventID=4608 or EventID=4609)]]</Select></Query>
    <Query Id="11"><Select Path="Security">*[System[(EventID=4610 or EventID=4611 or EventID=4612 or EventID=4614 or EventID=4615 or EventID=4616 or EventID=4622 or EventID=4624)]]</Select></Query>
    <Query Id="12"><Select Path="Security">*[System[(EventID=4625 or EventID=4634 or EventID=4646 or EventID=4647 or EventID=4648 or EventID=4650 or EventID=4651 or EventID=4652)]]</Select></Query>
    <Query Id="13"><Select Path="Security">*[System[(EventID=4653 or EventID=4654 or EventID=4655 or EventID=4656 or EventID=4657 or EventID=4658 or EventID=4659 or EventID=4660)]]</Select></Query>
    <Query Id="14"><Select Path="Security">*[System[(EventID=4661 or EventID=4662 or EventID=4663 or EventID=4664 or EventID=4665 or EventID=4666 or EventID=4667 or EventID=4668)]]</Select></Query>
    <Query Id="15"><Select Path="Security">*[System[(EventID=4670 or EventID=4671 or EventID=4672 or EventID=4673 or EventID=4674 or EventID=4688 or EventID=4689 or EventID=4690)]]</Select></Query>
    <Query Id="16"><Select Path="Security">*[System[(EventID=4691 or EventID=4694 or EventID=4695 or EventID=4696 or EventID=4697 or EventID=4698 or EventID=4699 or EventID=4700)]]</Select></Query>
    <Query Id="17"><Select Path="Security">*[System[(EventID=4701 or EventID=4702 or EventID=4704 or EventID=4705 or EventID=4707 or EventID=4709 or EventID=4710 or EventID=4711)]]</Select></Query>
    <Query Id="18"><Select Path="Security">*[System[(EventID=4712 or EventID=4717 or EventID=4718 or EventID=4720 or EventID=4722 or EventID=4723 or EventID=4725 or EventID=4726)]]</Select></Query>
    <Query Id="19"><Select Path="Security">*[System[(EventID=4728 or EventID=4729 or EventID=4730 or EventID=4731 or EventID=4732 or EventID=4733 or EventID=4734 or EventID=4738)]]</Select></Query>
    <Query Id="20"><Select Path="Security">*[System[(EventID=4740 or EventID=4741 or EventID=4742 or EventID=4743 or EventID=4744 or EventID=4745 or EventID=4746 or EventID=4747)]]</Select></Query>
    <Query Id="21"><Select Path="Security">*[System[(EventID=4748 or EventID=4749 or EventID=4750 or EventID=4751 or EventID=4752 or EventID=4753 or EventID=4756 or EventID=4757)]]</Select></Query>
    <Query Id="22"><Select Path="Security">*[System[(EventID=4758 or EventID=4759 or EventID=4760 or EventID=4761 or EventID=4762 or EventID=4767 or EventID=4768 or EventID=4769)]]</Select></Query>
    <Query Id="23"><Select Path="Security">*[System[(EventID=4770 or EventID=4771 or EventID=4772 or EventID=4774 or EventID=4775 or EventID=4776 or EventID=4777 or EventID=4778)]]</Select></Query>
    <Query Id="24"><Select Path="Security">*[System[(EventID=4779 or EventID=4781 or EventID=4782 or EventID=4783 or EventID=4784 or EventID=4785 or EventID=4786 or EventID=4787)]]</Select></Query>
    <Query Id="25"><Select Path="Security">*[System[(EventID=4788 or EventID=4789 or EventID=4790 or EventID=4793 or EventID=4800 or EventID=4801 or EventID=4802 or EventID=4803)]]</Select></Query>
    <Query Id="26"><Select Path="Security">*[System[(EventID=4864 or EventID=4869 or EventID=4871 or EventID=4872 or EventID=4873 or EventID=4874 or EventID=4875 or EventID=4876)]]</Select></Query>
    <Query Id="27"><Select Path="Security">*[System[(EventID=4877 or EventID=4878 or EventID=4879 or EventID=4880 or EventID=4881 or EventID=4883 or EventID=4884 or EventID=4886)]]</Select></Query>
    <Query Id="28"><Select Path="Security">*[System[(EventID=4887 or EventID=4888 or EventID=4889 or EventID=4891 or EventID=4893 or EventID=4894 or EventID=4895 or EventID=4898)]]</Select></Query>
    <Query Id="29"><Select Path="Security">*[System[(EventID=4902 or EventID=4904 or EventID=4905 or EventID=4909 or EventID=4910 or EventID=4928 or EventID=4929 or EventID=4930)]]</Select></Query>
    <Query Id="30"><Select Path="Security">*[System[(EventID=4931 or EventID=4932 or EventID=4933 or EventID=4934 or EventID=4935 or EventID=4936 or EventID=4937 or EventID=4944)]]</Select></Query>
    <Query Id="31"><Select Path="Security">*[System[(EventID=4945 or EventID=4946 or EventID=4947 or EventID=4948 or EventID=4949 or EventID=4950 or EventID=4951 or EventID=4952)]]</Select></Query>
    <Query Id="32"><Select Path="Security">*[System[(EventID=4953 or EventID=4954 or EventID=4956 or EventID=4957 or EventID=4958 or EventID=4979 or EventID=4980 or EventID=4981)]]</Select></Query>
    <Query Id="33"><Select Path="Security">*[System[(EventID=4982 or EventID=4985 or EventID=5024 or EventID=5025 or EventID=5031 or EventID=5032 or EventID=5033 or EventID=5034)]]</Select></Query>
    <Query Id="34"><Select Path="Security">*[System[(EventID=5039 or EventID=5040 or EventID=5041 or EventID=5042 or EventID=5043 or EventID=5044 or EventID=5045 or EventID=5046)]]</Select></Query>
    <Query Id="35"><Select Path="Security">*[System[(EventID=5047 or EventID=5048 or EventID=5050 or EventID=5051 or EventID=5056 or EventID=5057 or EventID=5058 or EventID=5059)]]</Select></Query>
    <Query Id="36"><Select Path="Security">*[System[(EventID=5060 or EventID=5061 or EventID=5062 or EventID=5063 or EventID=5064 or EventID=5065 or EventID=5066 or EventID=5067)]]</Select></Query>
    <Query Id="37"><Select Path="Security">*[System[(EventID=5068 or EventID=5069 or EventID=5070 or EventID=5125 or EventID=5126 or EventID=5127 or EventID=5136 or EventID=5137)]]</Select></Query>
    <Query Id="38"><Select Path="Security">*[System[(EventID=5138 or EventID=5139 or EventID=5140 or EventID=5141 or EventID=5152 or EventID=5153 or EventID=5154 or EventID=5155)]]</Select></Query>
    <Query Id="39"><Select Path="Security">*[System[(EventID=5156 or EventID=5157 or EventID=5158 or EventID=5159 or EventID=5378 or EventID=5440 or EventID=5441 or EventID=5442)]]</Select></Query>
    <Query Id="40"><Select Path="Security">*[System[(EventID=5443 or EventID=5444 or EventID=5446 or EventID=5447 or EventID=5448 or EventID=5449 or EventID=5450 or EventID=5451)]]</Select></Query>
    <Query Id="41"><Select Path="Security">*[System[(EventID=5452 or EventID=5456 or EventID=5457 or EventID=5458 or EventID=5459 or EventID=5460 or EventID=5461 or EventID=5462)]]</Select></Query>
    <Query Id="42"><Select Path="Security">*[System[(EventID=5463 or EventID=5464 or EventID=5465 or EventID=5466 or EventID=5467 or EventID=5468 or EventID=5471 or EventID=5472)]]</Select></Query>
    <Query Id="43"><Select Path="Security">*[System[(EventID=5473 or EventID=5474 or EventID=5477 or EventID=5479 or EventID=5632 or EventID=5633 or EventID=5712 or EventID=5888)]]</Select></Query>
    <Query Id="44"><Select Path="Security">*[System[(EventID=5889 or EventID=5890 or EventID=6008 or EventID=6144 or EventID=6272 or EventID=24577 or EventID=24578 or EventID=24579)]]</Select></Query>
    <Query Id="45"><Select Path="Security">*[System[(EventID=24580 or EventID=24581 or EventID=24582 or EventID=24583 or EventID=24584 or EventID=24588 or EventID=24595 or EventID=24621)]]</Select></Query>
    <Query Id="46"><Select Path="Security">*[System[(EventID=5049 or EventID=5478)]]</Select></Query>
    </QueryList>
        ]]>
	</Query>
	<ReadExistingEvents>false</ReadExistingEvents>
	<TransportName>HTTP</TransportName>
	<ContentFormat>RenderedText</ContentFormat>
	<Locale Language="en-US"/>
	<LogFile>ForwardedEvents</LogFile>
	<PublisherName>Microsoft-Windows-EventCollector</PublisherName>
	<AllowedSourceNonDomainComputers>
		<AllowedIssuerCAList>
		</AllowedIssuerCAList>
	</AllowedSourceNonDomainComputers>
	<AllowedSourceDomainComputers>O:NSG:BAD:P(A;;GA;;;DD)S:</AllowedSourceDomainComputers>
</Subscription>
'@

Add-Content $DCSec $XMLDCSec


$XMLDCSys = @'
<?xml version="1.0" encoding="UTF-8"?>
<Subscription xmlns="http://schemas.microsoft.com/2006/03/windows/events/subscription">
	<SubscriptionId>HFEventServer_DC_System</SubscriptionId>
	<SubscriptionType>SourceInitiated</SubscriptionType>
	<Description></Description>
	<Enabled>true</Enabled>
	<Uri>http://schemas.microsoft.com/wbem/wsman/1/windows/EventLog</Uri>
	<ConfigurationMode>Custom</ConfigurationMode>
	<Delivery Mode="Push">
		<Batching>
			<MaxLatencyTime>900000</MaxLatencyTime>
		</Batching>
		<PushSettings>
			<Heartbeat Interval="900000"/>
		</PushSettings>
	</Delivery>
<Query>
		<![CDATA[
<QueryList><Query Id="0"><Select Path="System">*[System[(Level=1  or Level=2 or Level=3)]]</Select></Query></QueryList>
		]]>
	</Query>
	<ReadExistingEvents>false</ReadExistingEvents>
	<TransportName>HTTP</TransportName>
	<ContentFormat>RenderedText</ContentFormat>
	<Locale Language="en-US"/>
	<LogFile>ForwardedEvents</LogFile>
	<PublisherName>Microsoft-Windows-EventCollector</PublisherName>
	<AllowedSourceNonDomainComputers>
		<AllowedIssuerCAList>
		</AllowedIssuerCAList>
	</AllowedSourceNonDomainComputers>
	<AllowedSourceDomainComputers>O:NSG:BAD:P(A;;GA;;;DD)S:</AllowedSourceDomainComputers>
</Subscription>
'@

Add-Content $DCSys $XMLDCSys



################################################## Configure Collector Server ###########################################################


write-host 'Configuring Collector Server..'

Invoke-Command -ScriptBlock {winrm quickconfig} 
Invoke-Command -ScriptBlock {net stop wecsvc}
Invoke-Command -ScriptBlock {net start wecsvc}
Invoke-Command -ScriptBlock {wecutil qc /quiet}
Invoke-Command -ScriptBlock {wecutil cs $DCSec}
Invoke-Command -ScriptBlock {wecutil cs $DCSys}
Invoke-Command -ScriptBlock {New-LocalGroup -Name 'HF Event Report Viewer' -Description 'Group Created by the HF Event Server Script.'}
Invoke-Command -ScriptBlock {New-NetFirewallRule -DisplayName 'HF Server Event Reports' -Direction Inbound -LocalPort 80 -Protocol TCP -Action Allow}

write-host 'Setting Forwarded Events Max Size to 4 GB..'

Set-Itemproperty -path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\ForwardedEvents' -Name 'MaxSize' -value '4294901760' 

}
catch
{
throw $Error
}

}

#################################################### SQL Server Local #################################################################


function ConfigSQLServer {
try{
$EvtTables = ('SecurityLog','SystemLog')
Invoke-Sqlcmd
if(Get-Module -Name "*Sql*") {
CD SQLSERVER:\sql\localhost\ 
$srv = get-item default 
$sqlsrv = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Server($EvtS)
$db = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Database -argumentlist $srv, "EventServerDB" 
$db.Create()
$ftc = New-Object -TypeName Microsoft.SqlServer.Management.SMO.FullTextCatalog -argumentlist $db, "FTS_Catalog"
$ftc.IsDefault = $true 
$ftc.Create()
Foreach ($Table in $EvtTables) 
    {    
$tb = New-Object -TypeName Microsoft.SqlServer.Management.SMO.Table -argumentlist $db, $Table
$Type = [Microsoft.SqlServer.Management.SMO.DataType]::NChar(50)
$col0 =  New-Object -TypeName Microsoft.SqlServer.Management.SMO.Column -argumentlist $tb,"SQLID", ([Microsoft.SqlServer.Management.SMO.DataType]::bigint) 
$col1 =  New-Object -TypeName Microsoft.SqlServer.Management.SMO.Column -argumentlist $tb,"ID", ([Microsoft.SqlServer.Management.SMO.DataType]::int) 
$col2 =  New-Object -TypeName Microsoft.SqlServer.Management.SMO.Column -argumentlist $tb,"LevelDisplayName", ([Microsoft.SqlServer.Management.SMO.DataType]::varchar(255))
$col3 =  New-Object -TypeName Microsoft.SqlServer.Management.SMO.Column -argumentlist $tb,"LogName", ([Microsoft.SqlServer.Management.SMO.DataType]::varchar(255)) 
$col4 =  New-Object -TypeName Microsoft.SqlServer.Management.SMO.Column -argumentlist $tb,"MachineName", ([Microsoft.SqlServer.Management.SMO.DataType]::varchar(255))
$col5 =  New-Object -TypeName Microsoft.SqlServer.Management.SMO.Column -argumentlist $tb,"Message", ([Microsoft.SqlServer.Management.SMO.DataType]::varcharmax)
$col6 =  New-Object -TypeName Microsoft.SqlServer.Management.SMO.Column -argumentlist $tb,"Source", ([Microsoft.SqlServer.Management.SMO.DataType]::varchar(255)) 
$col7 =  New-Object -TypeName Microsoft.SqlServer.Management.SMO.Column -argumentlist $tb,"RecordID", ([Microsoft.SqlServer.Management.SMO.DataType]::bigint) 
$col8 =  New-Object -TypeName Microsoft.SqlServer.Management.SMO.Column -argumentlist $tb,"TaskDisplayName", ([Microsoft.SqlServer.Management.SMO.DataType]::varchar(255))
$col9 =  New-Object -TypeName Microsoft.SqlServer.Management.SMO.Column -argumentlist $tb,"TimeCreated", ([Microsoft.SqlServer.Management.SMO.DataType]::smalldatetime)   
$col0.Nullable = $false
$col0.Identity = $true  
$col0.IdentitySeed = 1  
$col0.IdentityIncrement = 1 
$col1.Nullable = $true
$col2.Nullable = $true
$col3.Nullable = $true
$col4.Nullable = $true
$col5.Nullable = $true
$col6.Nullable = $true
$col7.Nullable = $true
$col8.Nullable = $true
$col9.Nullable = $true
$tb.Columns.Add($col0) 
$tb.Columns.Add($col1) 
$tb.Columns.Add($col2)
$tb.Columns.Add($col3)
$tb.Columns.Add($col4)
$tb.Columns.Add($col5)
$tb.Columns.Add($col6)
$tb.Columns.Add($col7)
$tb.Columns.Add($col8)
$tb.Columns.Add($col9)
$tb.Create()
$idx = New-Object -TypeName Microsoft.SqlServer.Management.SMO.Index -argumentlist $tb, ('UniquedIndex-'+$Table)
$icol0 = New-Object -TypeName Microsoft.SqlServer.Management.SMO.IndexedColumn -argumentlist $idx, "SQLID", $true 
$idx.IndexedColumns.Add($icol0)
$idx.IndexKeyType = [Microsoft.SqlServer.Management.SMO.IndexKeyType]::DriUniqueKey   
$idx.Create()
$idx = New-Object -TypeName Microsoft.SqlServer.Management.SMO.Index -argumentlist $tb, ('ClusteredIndex-'+$Table)
$icol1 = New-Object -TypeName Microsoft.SqlServer.Management.SMO.IndexedColumn -argumentlist $idx, "ID", $true 
$idx.IndexedColumns.Add($icol1)
$icol2 = New-Object -TypeName Microsoft.SqlServer.Management.SMO.IndexedColumn -argumentlist $idx, "MachineName", $true 
$idx.IndexedColumns.Add($icol2)
$icol3 = New-Object -TypeName Microsoft.SqlServer.Management.SMO.IndexedColumn -argumentlist $idx, "Source", $true 
$idx.IndexedColumns.Add($icol3)
$idx.IsClustered = $true 
$idx.IgnoreDuplicateKeys = $true
$idx.Create()
$fti = New-Object -TypeName Microsoft.SqlServer.Management.SMO.FullTextIndex -argumentlist $tb
$ftic = New-Object -TypeName Microsoft.SqlServer.Management.SMO.FullTextIndexColumn -argumentlist $fti, "Message"
$fti.IndexedColumns.Add($ftic) 
$fti.ChangeTracking = [Microsoft.SqlServer.Management.SMO.ChangeTracking]::Automatic  
$fti.UniqueIndexName = ('UniquedIndex-'+$Table)
$fti.CatalogName = "FTS_Catalog"
$fti.Create()
}
$db2 = $sqlsrv.Databases['EventServerDB']
$login = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Login -ArgumentList $sqlsrv, ($EvtS+'\HF Event Report Viewer')
$login.LoginType = "WindowsGroup"
$login.DefaultDatabase = 'EventServerDB'
$login.Create()
$user = New-Object -typeName Microsoft.SqlServer.Management.Smo.User -ArgumentList $db2, ($EvtS+'\HF Event Report Viewer')
$user.Login = ($EvtS+'\HF Event Report Viewer')
$user.create()
$role = $db2.Roles['db_datareader']
$role.AddMember(($EvtS+'\HF Event Report Viewer'))
}
else {Write-Host 'SQL Server Powershell Module NOT FOUND!'}
CD C:
}
catch
{
throw $Error
}
}


#################################################### Configure Client Machines to forward #################################################################


function ConfigDCs {

Foreach ($DC in $DCs)
{
write-host 'Configuring Domain Controllers to Forward Events..'
Invoke-Command -ScriptBlock {winrm quickconfig} -ComputerName $DC.Name
Invoke-Command -ScriptBlock {wecutil qc /quiet} -ComputerName $DC.Name
Invoke-Command -ScriptBlock {if (!(Test-Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\EventForwarding\SubscriptionManager')) {New-Item -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\EventForwarding\SubscriptionManager' -Force | Out-Null}} -ComputerName $DC.Name
Invoke-Command -ComputerName $DC.Name -ScriptBlock {if (!(Get-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\EventForwarding\SubscriptionManager' -Name 1)) {New-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\EventForwarding\SubscriptionManager' -Name 1 -Value ('Server=http://'+$($args)+':5985/wsman/SubscriptionManager/WEC,Refresh=60') -PropertyType String -Force | Out-Null}}  -ArgumentList $EvtServer
}

Invoke-Command -ComputerName $DC.Name -ScriptBlock {net localgroup "Event Log Readers" /add 'Network Service'}
#Invoke-Command -ComputerName $DC.Name -ScriptBlock {$Acc = Get-ADComputer -Identity $($args); Get-ADGroup -Identity "Event Log Readers" | Add-ADGroupMember -Members $Acc} -ArgumentList $EvtS

}


#################################################### Creating de Task Scheduler #################################################################


Function CreateTask {
try{
$PsScript = @'
$time = Get-Date 

$SyncLog = ("C:\EvtHF\DBSync.log") 
if ((test-path $SyncLog) -eq $false) 
{
new-item $SyncLog -Type file -Force
Add-Content $SyncLog 'New HF Event Server Database Sincronization log'
Add-Content $SyncLog ('New HF DB Sync log created at: '+$time)
Add-Content $SyncLog ('Starting First Sync')
}

if (!(Get-Item -Path 'HKLM:\SOFTWARE\HFEvents' -ErrorAction SilentlyContinue)) 
{
New-Item -Path 'HKLM:\SOFTWARE\HFEvents' -Force | Out-Null
New-ItemProperty -Path 'HKLM:\SOFTWARE\HFEvents' -Name 'LastSync' -Value $time -PropertyType string -Force | Out-Null
$Regkey = $false
} 
else 
{
$Regkey = $true
}
if ($Regkey -eq $true) {$TimeKey = Get-ItemProperty -Path 'HKLM:\SOFTWARE\HFEvents' -Name 'LastSync' -ErrorAction SilentlyContinue}

$events = Get-WinEvent -LogName 'ForwardedEvents' | Select-Object ID, LevelDisplayName, LogName, MachineName, Message, ProviderName, RecordID, TaskDisplayName, TimeCreated 
$curtime = (Get-Date)

$evt = $events | ? {$_.LogName -eq 'System'}
$totalevts = $evt.Count
if ($Regkey -eq $true) 
{
$evt = $evt | ? {$_.TimeCreated -ge [DateTime]$TimeKey.LastSync}
$totalevts = $evt.Count
}

Add-Content $SyncLog ([string]$curtime+' - Starting DB Sync of: '+$totalevts + ' System Events.')

$EvtServer = ((Get-WmiObject win32_computersystem).DNSHostName+"."+(Get-WmiObject win32_computersystem).Domain)

$connectionString = ('Data Source='+$EvtServer+';Integrated Security=true;Initial Catalog=EventServerDB;')

$bulkCopy = new-object ("Data.SqlClient.SqlBulkCopy") $connectionString
$bulkCopy.DestinationTableName = "SystemLog"
$dt = New-Object "System.Data.DataTable"

$cols = $evt | select -first 1 | get-member -MemberType NoteProperty | select -Expand Name
$null = $dt.Columns.Add('SQLID')
foreach ($col in $cols)  {$null = $dt.Columns.Add($col)}

foreach ($event in $evt)
  {
     $row = $dt.NewRow()
     $row.Item('SQLID') = (([guid]::NewGuid()).Guid)
     foreach ($col in $cols) { $row.Item($col) = $event.$col }
     $dt.Rows.Add($row)
  }

$bulkCopy.WriteToServer($dt)


$curtime = (Get-Date)

$evt = $events | ? {$_.LogName -eq 'Security'}
$totalevts = $evt.Count

if ($Regkey -eq $true) 
{
$evt = $evt | ? {$_.TimeCreated -ge [DateTime]$TimeKey.LastSync}
$totalevts = $evt.Count
}

Add-Content $SyncLog ([string]$curtime+' - Starting DB Sync of: '+$totalevts + ' Security Events.')

$bulkCopy = new-object ("Data.SqlClient.SqlBulkCopy") $connectionString
$bulkCopy.DestinationTableName = "SecurityLog"
$dt = New-Object "System.Data.DataTable"

$cols = $evt | select -first 1 | get-member -MemberType NoteProperty | select -Expand Name
$null = $dt.Columns.Add('SQLID')
foreach ($col in $cols)  {$null = $dt.Columns.Add($col)}

foreach ($event in $evt)
  {
     $row = $dt.NewRow()
     $row.Item('SQLID') = (([guid]::NewGuid()).Guid)
     foreach ($col in $cols) { $row.Item($col) = $event.$col }
     $dt.Rows.Add($row)
  }

$bulkCopy.WriteToServer($dt)

if ($Regkey -eq $true) {Set-ItemProperty -Path 'HKLM:\SOFTWARE\HFEvents' -Name 'LastSync' -Value $time -Force | Out-Null}
'@

$PsScript | Out-File C:\EvtHF\DefaultScript.ps1

$user = [Security.Principal.WindowsIdentity]::GetCurrent()
$action = New-ScheduledTaskAction -Execute 'C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe' -Argument '-NoProfile -WindowStyle Hidden -command "& {C:\EvtHF\DefaultScript.ps1}"'
$trigger =  New-ScheduledTaskTrigger -Once -at (Get-Date) -RepetitionInterval (New-TimeSpan -hours 1)  
$principal = New-ScheduledTaskPrincipal -UserId $user.Name -LogonType S4U -RunLevel Highest
$task = New-ScheduledTask -Action $action -Trigger $trigger -Principal $principal -Description "Hourly task to add Forwarded Events into de SQL Server Database. This Task was created automatically by the HF Event Server script (by Claudio Merola)"
Register-ScheduledTask "HFEventServer\HFEventServer-DCEssentials" -InputObject $task
}
catch
{
throw $Error
}

}


#################################################### Creating the Reports Files #################################################################



function ReportFiles {

try{

if ((Test-Path -Path C:\EvtHF\Reports -PathType Container) -eq $false) {New-Item -Type Directory -Force -Path C:\EvtHF\Reports}

$SecReport = @'
<?xml version="1.0" encoding="utf-8"?>
<Report xmlns:rd="http://schemas.microsoft.com/SQLServer/reporting/reportdesigner" xmlns:cl="http://schemas.microsoft.com/sqlserver/reporting/2010/01/componentdefinition" xmlns="http://schemas.microsoft.com/sqlserver/reporting/2010/01/reportdefinition">
  <AutoRefresh>0</AutoRefresh>
  <DataSources>
    <DataSource Name="HardFinger">
      <ConnectionProperties>
        <DataProvider>SQL</DataProvider>
        <ConnectString>Data Source=localhost;Initial Catalog=EventServerDB</ConnectString>
        <IntegratedSecurity>true</IntegratedSecurity>
      </ConnectionProperties>
      <rd:SecurityType>Integrated</rd:SecurityType>
      <rd:DataSourceID>94c9029b-e7c6-4bc0-b977-66e92cc2c98f</rd:DataSourceID>
    </DataSource>
  </DataSources>
  <DataSets>
    <DataSet Name="MainReport">
      <Query>
        <DataSourceName>HardFinger</DataSourceName>
        <QueryParameters>
          <QueryParameter Name="@ID">
            <Value>=Parameters!ID.Value</Value>
          </QueryParameter>
          <QueryParameter Name="@Message">
            <Value>=Parameters!Message.Value</Value>
            <rd:UserDefined>true</rd:UserDefined>
          </QueryParameter>
          <QueryParameter Name="@Source">
            <Value>=Parameters!Source.Value</Value>
          </QueryParameter>
          <QueryParameter Name="@Level">
            <Value>=Parameters!Level.Value</Value>
            <rd:UserDefined>true</rd:UserDefined>
          </QueryParameter>
        </QueryParameters>
        <CommandText>if (@Message = '')
SELECT
  SecurityLog.ID
  ,SecurityLog.LevelDisplayName
  ,SecurityLog.LogName
  ,SecurityLog.MachineName
  ,SecurityLog.Message
  ,SecurityLog.Source
  ,SecurityLog.RecordID
  ,SecurityLog.TaskDisplayName
  ,SecurityLog.TimeCreated
FROM
  SecurityLog
WHERE
SecurityLog.ID like 
case 
when @ID = 'All' then '%'
ELSE @ID
END
and SecurityLog.Source like 
case 
when @Source = 'All' then '%'
ELSE @Source
END
and SecurityLog.LevelDisplayName like 
case 
when @Level = 'All' then '%'
ELSE @Level
END

else

SELECT
  SecurityLog.ID
  ,SecurityLog.LevelDisplayName
  ,SecurityLog.LogName
  ,SecurityLog.MachineName
  ,SecurityLog.Message
  ,SecurityLog.Source
  ,SecurityLog.RecordID
  ,SecurityLog.TaskDisplayName
  ,SecurityLog.TimeCreated
FROM
  SecurityLog
WHERE
SecurityLog.ID like 
case 
when @ID = 'All' then '%'
ELSE @ID
END
and SecurityLog.Source like 
case 
when @Source = 'All' then '%'
ELSE @Source
END
and SecurityLog.LevelDisplayName like 
case 
when @Level = 'All' then '%'
ELSE @Level
END
and FREETEXT (SecurityLog.Message, @Message)</CommandText>
        <rd:UseGenericDesigner>true</rd:UseGenericDesigner>
      </Query>
      <Fields>
        <Field Name="Id">
          <DataField>ID</DataField>
          <rd:TypeName>System.Int32</rd:TypeName>
        </Field>
        <Field Name="LevelDisplayName">
          <DataField>LevelDisplayName</DataField>
          <rd:TypeName>System.String</rd:TypeName>
        </Field>
        <Field Name="LogName">
          <DataField>LogName</DataField>
          <rd:TypeName>System.String</rd:TypeName>
        </Field>
        <Field Name="MachineName">
          <DataField>MachineName</DataField>
          <rd:TypeName>System.String</rd:TypeName>
        </Field>
        <Field Name="Message">
          <DataField>Message</DataField>
          <rd:TypeName>System.String</rd:TypeName>
        </Field>
        <Field Name="Source">
          <DataField>Source</DataField>
          <rd:TypeName>System.String</rd:TypeName>
        </Field>
        <Field Name="RecordID">
          <DataField>RecordID</DataField>
          <rd:TypeName>System.Int64</rd:TypeName>
        </Field>
        <Field Name="TaskDisplayName">
          <DataField>TaskDisplayName</DataField>
          <rd:TypeName>System.String</rd:TypeName>
        </Field>
        <Field Name="TimeCreated">
          <DataField>TimeCreated</DataField>
          <rd:TypeName>System.DateTime</rd:TypeName>
        </Field>
      </Fields>
      <Filters>
        <Filter>
          <FilterExpression>=Fields!TimeCreated.Value</FilterExpression>
          <Operator>Between</Operator>
          <FilterValues>
            <FilterValue>=Parameters!StartDate.Value</FilterValue>
            <FilterValue>=Parameters!EndDate.Value</FilterValue>
          </FilterValues>
        </Filter>
      </Filters>
    </DataSet>
    <DataSet Name="IDs">
      <Query>
        <DataSourceName>HardFinger</DataSourceName>
        <CommandText>select 0 as [Order],'All' as [ID]
union
SELECT  Distinct
1,
  cast(SecurityLog.ID as varchar)
FROM
  SecurityLog
  order by 1</CommandText>
        <rd:UseGenericDesigner>true</rd:UseGenericDesigner>
      </Query>
      <Fields>
        <Field Name="ID">
          <DataField>ID</DataField>
          <rd:TypeName>System.String</rd:TypeName>
        </Field>
      </Fields>
    </DataSet>
    <DataSet Name="Source">
      <Query>
        <DataSourceName>HardFinger</DataSourceName>
        <CommandText>select 0 as [Order],'All' as [Source]
union
SELECT  Distinct
1,
  SecurityLog.Source
FROM
  SecurityLog
  order by 1</CommandText>
        <rd:UseGenericDesigner>true</rd:UseGenericDesigner>
      </Query>
      <Fields>
        <Field Name="Source">
          <DataField>Source</DataField>
          <rd:TypeName>System.String</rd:TypeName>
        </Field>
      </Fields>
    </DataSet>
    <DataSet Name="Level">
      <Query>
        <DataSourceName>HardFinger</DataSourceName>
        <CommandText>select 0 as [Order],'All' as [Level]
union
SELECT  Distinct
1,
  SecurityLog.LevelDisplayName
FROM
  SecurityLog
  order by 1</CommandText>
        <rd:UseGenericDesigner>true</rd:UseGenericDesigner>
      </Query>
      <Fields>
        <Field Name="Level">
          <DataField>Level</DataField>
          <rd:TypeName>System.String</rd:TypeName>
        </Field>
      </Fields>
    </DataSet>
    <DataSet Name="StartDate">
      <Query>
        <DataSourceName>HardFinger</DataSourceName>
        <CommandText>SELECT top 1
  SecurityLog.TimeCreated
FROM
  SecurityLog
  order by 1</CommandText>
        <rd:UseGenericDesigner>true</rd:UseGenericDesigner>
      </Query>
      <Fields>
        <Field Name="TimeCreated">
          <DataField>TimeCreated</DataField>
          <rd:TypeName>System.DateTime</rd:TypeName>
        </Field>
      </Fields>
    </DataSet>
    <DataSet Name="EndDate">
      <Query>
        <DataSourceName>HardFinger</DataSourceName>
        <CommandText>SELECT top 1
  SecurityLog.TimeCreated
FROM
  SecurityLog
  order by 1 Desc</CommandText>
        <rd:UseGenericDesigner>true</rd:UseGenericDesigner>
      </Query>
      <Fields>
        <Field Name="TimeCreated">
          <DataField>TimeCreated</DataField>
          <rd:TypeName>System.DateTime</rd:TypeName>
        </Field>
      </Fields>
    </DataSet>
  </DataSets>
  <ReportSections>
    <ReportSection>
      <Body>
        <ReportItems>
          <Tablix Name="Tablix1">
            <TablixBody>
              <TablixColumns>
                <TablixColumn>
                  <Width>1.8253in</Width>
                </TablixColumn>
                <TablixColumn>
                  <Width>1.4503in</Width>
                </TablixColumn>
                <TablixColumn>
                  <Width>1.72113in</Width>
                </TablixColumn>
                <TablixColumn>
                  <Width>1.40863in</Width>
                </TablixColumn>
                <TablixColumn>
                  <Width>5.9753in</Width>
                </TablixColumn>
                <TablixColumn>
                  <Width>2.37738in</Width>
                </TablixColumn>
                <TablixColumn>
                  <Width>2.37738in</Width>
                </TablixColumn>
              </TablixColumns>
              <TablixRows>
                <TablixRow>
                  <Height>0.25in</Height>
                  <TablixCells>
                    <TablixCell>
                      <CellContents>
                        <Textbox Name="Textbox2">
                          <CanGrow>true</CanGrow>
                          <KeepTogether>true</KeepTogether>
                          <Paragraphs>
                            <Paragraph>
                              <TextRuns>
                                <TextRun>
                                  <Value>Machine Name</Value>
                                  <Style>
                                    <FontFamily>Tahoma</FontFamily>
                                    <FontSize>11pt</FontSize>
                                    <FontWeight>Bold</FontWeight>
                                    <Color>White</Color>
                                  </Style>
                                </TextRun>
                              </TextRuns>
                              <Style />
                            </Paragraph>
                          </Paragraphs>
                          <rd:DefaultName>Textbox2</rd:DefaultName>
                          <Style>
                            <Border>
                              <Color>#4e648a</Color>
                              <Style>Solid</Style>
                            </Border>
                            <BackgroundColor>#384c70</BackgroundColor>
                            <PaddingLeft>2pt</PaddingLeft>
                            <PaddingRight>2pt</PaddingRight>
                            <PaddingTop>2pt</PaddingTop>
                            <PaddingBottom>2pt</PaddingBottom>
                          </Style>
                        </Textbox>
                      </CellContents>
                    </TablixCell>
                    <TablixCell>
                      <CellContents>
                        <Textbox Name="Textbox3">
                          <CanGrow>true</CanGrow>
                          <KeepTogether>true</KeepTogether>
                          <Paragraphs>
                            <Paragraph>
                              <TextRuns>
                                <TextRun>
                                  <Value>Log Name</Value>
                                  <Style>
                                    <FontFamily>Tahoma</FontFamily>
                                    <FontSize>11pt</FontSize>
                                    <FontWeight>Bold</FontWeight>
                                    <Color>White</Color>
                                  </Style>
                                </TextRun>
                              </TextRuns>
                              <Style>
                                <TextAlign>Center</TextAlign>
                              </Style>
                            </Paragraph>
                          </Paragraphs>
                          <rd:DefaultName>Textbox3</rd:DefaultName>
                          <Style>
                            <Border>
                              <Color>#4e648a</Color>
                              <Style>Solid</Style>
                            </Border>
                            <BackgroundColor>#384c70</BackgroundColor>
                            <PaddingLeft>2pt</PaddingLeft>
                            <PaddingRight>2pt</PaddingRight>
                            <PaddingTop>2pt</PaddingTop>
                            <PaddingBottom>2pt</PaddingBottom>
                          </Style>
                        </Textbox>
                      </CellContents>
                    </TablixCell>
                    <TablixCell>
                      <CellContents>
                        <Textbox Name="Textbox5">
                          <CanGrow>true</CanGrow>
                          <KeepTogether>true</KeepTogether>
                          <Paragraphs>
                            <Paragraph>
                              <TextRuns>
                                <TextRun>
                                  <Value>Category</Value>
                                  <Style>
                                    <FontFamily>Tahoma</FontFamily>
                                    <FontSize>11pt</FontSize>
                                    <FontWeight>Bold</FontWeight>
                                    <Color>White</Color>
                                  </Style>
                                </TextRun>
                              </TextRuns>
                              <Style>
                                <TextAlign>Center</TextAlign>
                              </Style>
                            </Paragraph>
                          </Paragraphs>
                          <rd:DefaultName>Textbox5</rd:DefaultName>
                          <Style>
                            <Border>
                              <Color>#4e648a</Color>
                              <Style>Solid</Style>
                            </Border>
                            <BackgroundColor>#384c70</BackgroundColor>
                            <PaddingLeft>2pt</PaddingLeft>
                            <PaddingRight>2pt</PaddingRight>
                            <PaddingTop>2pt</PaddingTop>
                            <PaddingBottom>2pt</PaddingBottom>
                          </Style>
                        </Textbox>
                      </CellContents>
                    </TablixCell>
                    <TablixCell>
                      <CellContents>
                        <Textbox Name="Textbox7">
                          <CanGrow>true</CanGrow>
                          <KeepTogether>true</KeepTogether>
                          <Paragraphs>
                            <Paragraph>
                              <TextRuns>
                                <TextRun>
                                  <Value>Event ID</Value>
                                  <Style>
                                    <FontFamily>Tahoma</FontFamily>
                                    <FontSize>11pt</FontSize>
                                    <FontWeight>Bold</FontWeight>
                                    <Color>White</Color>
                                  </Style>
                                </TextRun>
                              </TextRuns>
                              <Style>
                                <TextAlign>Center</TextAlign>
                              </Style>
                            </Paragraph>
                          </Paragraphs>
                          <rd:DefaultName>Textbox7</rd:DefaultName>
                          <Style>
                            <Border>
                              <Color>#4e648a</Color>
                              <Style>Solid</Style>
                            </Border>
                            <BackgroundColor>#384c70</BackgroundColor>
                            <PaddingLeft>2pt</PaddingLeft>
                            <PaddingRight>2pt</PaddingRight>
                            <PaddingTop>2pt</PaddingTop>
                            <PaddingBottom>2pt</PaddingBottom>
                          </Style>
                        </Textbox>
                      </CellContents>
                    </TablixCell>
                    <TablixCell>
                      <CellContents>
                        <Textbox Name="Textbox9">
                          <CanGrow>true</CanGrow>
                          <KeepTogether>true</KeepTogether>
                          <Paragraphs>
                            <Paragraph>
                              <TextRuns>
                                <TextRun>
                                  <Value>Message</Value>
                                  <Style>
                                    <FontFamily>Tahoma</FontFamily>
                                    <FontSize>11pt</FontSize>
                                    <FontWeight>Bold</FontWeight>
                                    <Color>White</Color>
                                  </Style>
                                </TextRun>
                              </TextRuns>
                              <Style>
                                <TextAlign>Center</TextAlign>
                              </Style>
                            </Paragraph>
                          </Paragraphs>
                          <rd:DefaultName>Textbox9</rd:DefaultName>
                          <Style>
                            <Border>
                              <Color>#4e648a</Color>
                              <Style>Solid</Style>
                            </Border>
                            <BackgroundColor>#384c70</BackgroundColor>
                            <PaddingLeft>2pt</PaddingLeft>
                            <PaddingRight>2pt</PaddingRight>
                            <PaddingTop>2pt</PaddingTop>
                            <PaddingBottom>2pt</PaddingBottom>
                          </Style>
                        </Textbox>
                      </CellContents>
                    </TablixCell>
                    <TablixCell>
                      <CellContents>
                        <Textbox Name="Textbox11">
                          <CanGrow>true</CanGrow>
                          <KeepTogether>true</KeepTogether>
                          <Paragraphs>
                            <Paragraph>
                              <TextRuns>
                                <TextRun>
                                  <Value>Source</Value>
                                  <Style>
                                    <FontFamily>Tahoma</FontFamily>
                                    <FontSize>11pt</FontSize>
                                    <FontWeight>Bold</FontWeight>
                                    <Color>White</Color>
                                  </Style>
                                </TextRun>
                              </TextRuns>
                              <Style>
                                <TextAlign>Center</TextAlign>
                              </Style>
                            </Paragraph>
                          </Paragraphs>
                          <rd:DefaultName>Textbox11</rd:DefaultName>
                          <Style>
                            <Border>
                              <Color>#4e648a</Color>
                              <Style>Solid</Style>
                            </Border>
                            <BackgroundColor>#384c70</BackgroundColor>
                            <PaddingLeft>2pt</PaddingLeft>
                            <PaddingRight>2pt</PaddingRight>
                            <PaddingTop>2pt</PaddingTop>
                            <PaddingBottom>2pt</PaddingBottom>
                          </Style>
                        </Textbox>
                      </CellContents>
                    </TablixCell>
                    <TablixCell>
                      <CellContents>
                        <Textbox Name="Textbox13">
                          <CanGrow>true</CanGrow>
                          <KeepTogether>true</KeepTogether>
                          <Paragraphs>
                            <Paragraph>
                              <TextRuns>
                                <TextRun>
                                  <Value>Event Date</Value>
                                  <Style>
                                    <FontFamily>Tahoma</FontFamily>
                                    <FontSize>11pt</FontSize>
                                    <FontWeight>Bold</FontWeight>
                                    <Color>White</Color>
                                  </Style>
                                </TextRun>
                              </TextRuns>
                              <Style>
                                <TextAlign>Center</TextAlign>
                              </Style>
                            </Paragraph>
                          </Paragraphs>
                          <rd:DefaultName>Textbox13</rd:DefaultName>
                          <Style>
                            <Border>
                              <Color>#4e648a</Color>
                              <Style>Solid</Style>
                            </Border>
                            <BackgroundColor>#384c70</BackgroundColor>
                            <PaddingLeft>2pt</PaddingLeft>
                            <PaddingRight>2pt</PaddingRight>
                            <PaddingTop>2pt</PaddingTop>
                            <PaddingBottom>2pt</PaddingBottom>
                          </Style>
                        </Textbox>
                      </CellContents>
                    </TablixCell>
                  </TablixCells>
                </TablixRow>
                <TablixRow>
                  <Height>0.25in</Height>
                  <TablixCells>
                    <TablixCell>
                      <CellContents>
                        <Textbox Name="MachineName">
                          <CanGrow>true</CanGrow>
                          <KeepTogether>true</KeepTogether>
                          <Paragraphs>
                            <Paragraph>
                              <TextRuns>
                                <TextRun>
                                  <Value>=Fields!MachineName.Value</Value>
                                  <Style>
                                    <FontFamily>Tahoma</FontFamily>
                                    <Color>#4d4d4d</Color>
                                  </Style>
                                </TextRun>
                              </TextRuns>
                              <Style />
                            </Paragraph>
                          </Paragraphs>
                          <rd:DefaultName>MachineName</rd:DefaultName>
                          <Style>
                            <Border>
                              <Color>#e5e5e5</Color>
                              <Style>Solid</Style>
                            </Border>
                            <PaddingLeft>2pt</PaddingLeft>
                            <PaddingRight>2pt</PaddingRight>
                            <PaddingTop>2pt</PaddingTop>
                            <PaddingBottom>2pt</PaddingBottom>
                          </Style>
                        </Textbox>
                      </CellContents>
                    </TablixCell>
                    <TablixCell>
                      <CellContents>
                        <Textbox Name="LogName">
                          <CanGrow>true</CanGrow>
                          <KeepTogether>true</KeepTogether>
                          <Paragraphs>
                            <Paragraph>
                              <TextRuns>
                                <TextRun>
                                  <Value>=Fields!LogName.Value</Value>
                                  <Style>
                                    <FontFamily>Tahoma</FontFamily>
                                    <Color>#4d4d4d</Color>
                                  </Style>
                                </TextRun>
                              </TextRuns>
                              <Style>
                                <TextAlign>Center</TextAlign>
                              </Style>
                            </Paragraph>
                          </Paragraphs>
                          <rd:DefaultName>LogName</rd:DefaultName>
                          <Style>
                            <Border>
                              <Color>#e5e5e5</Color>
                              <Style>Solid</Style>
                            </Border>
                            <PaddingLeft>2pt</PaddingLeft>
                            <PaddingRight>2pt</PaddingRight>
                            <PaddingTop>2pt</PaddingTop>
                            <PaddingBottom>2pt</PaddingBottom>
                          </Style>
                        </Textbox>
                      </CellContents>
                    </TablixCell>
                    <TablixCell>
                      <CellContents>
                        <Textbox Name="LevelDisplayName">
                          <CanGrow>true</CanGrow>
                          <KeepTogether>true</KeepTogether>
                          <Paragraphs>
                            <Paragraph>
                              <TextRuns>
                                <TextRun>
                                  <Value>=Fields!LevelDisplayName.Value</Value>
                                  <Style>
                                    <FontFamily>Tahoma</FontFamily>
                                    <Color>#4d4d4d</Color>
                                  </Style>
                                </TextRun>
                              </TextRuns>
                              <Style />
                            </Paragraph>
                          </Paragraphs>
                          <rd:DefaultName>LevelDisplayName</rd:DefaultName>
                          <Style>
                            <Border>
                              <Color>#e5e5e5</Color>
                              <Style>Solid</Style>
                            </Border>
                            <PaddingLeft>2pt</PaddingLeft>
                            <PaddingRight>2pt</PaddingRight>
                            <PaddingTop>2pt</PaddingTop>
                            <PaddingBottom>2pt</PaddingBottom>
                          </Style>
                        </Textbox>
                      </CellContents>
                    </TablixCell>
                    <TablixCell>
                      <CellContents>
                        <Textbox Name="Id">
                          <CanGrow>true</CanGrow>
                          <KeepTogether>true</KeepTogether>
                          <Paragraphs>
                            <Paragraph>
                              <TextRuns>
                                <TextRun>
                                  <Value>=Fields!Id.Value</Value>
                                  <Style>
                                    <FontFamily>Tahoma</FontFamily>
                                    <Color>#4d4d4d</Color>
                                  </Style>
                                </TextRun>
                              </TextRuns>
                              <Style>
                                <TextAlign>Center</TextAlign>
                              </Style>
                            </Paragraph>
                          </Paragraphs>
                          <rd:DefaultName>Id</rd:DefaultName>
                          <Style>
                            <Border>
                              <Color>#e5e5e5</Color>
                              <Style>Solid</Style>
                            </Border>
                            <PaddingLeft>2pt</PaddingLeft>
                            <PaddingRight>2pt</PaddingRight>
                            <PaddingTop>2pt</PaddingTop>
                            <PaddingBottom>2pt</PaddingBottom>
                          </Style>
                        </Textbox>
                      </CellContents>
                    </TablixCell>
                    <TablixCell>
                      <CellContents>
                        <Textbox Name="Message">
                          <CanGrow>true</CanGrow>
                          <KeepTogether>true</KeepTogether>
                          <Paragraphs>
                            <Paragraph>
                              <TextRuns>
                                <TextRun>
                                  <Value>=Fields!Message.Value</Value>
                                  <Style>
                                    <FontFamily>Tahoma</FontFamily>
                                    <Color>#4d4d4d</Color>
                                  </Style>
                                </TextRun>
                              </TextRuns>
                              <Style />
                            </Paragraph>
                          </Paragraphs>
                          <rd:DefaultName>Message</rd:DefaultName>
                          <Style>
                            <Border>
                              <Color>#e5e5e5</Color>
                              <Style>Solid</Style>
                            </Border>
                            <PaddingLeft>2pt</PaddingLeft>
                            <PaddingRight>2pt</PaddingRight>
                            <PaddingTop>2pt</PaddingTop>
                            <PaddingBottom>2pt</PaddingBottom>
                          </Style>
                        </Textbox>
                      </CellContents>
                    </TablixCell>
                    <TablixCell>
                      <CellContents>
                        <Textbox Name="Source">
                          <CanGrow>true</CanGrow>
                          <KeepTogether>true</KeepTogether>
                          <Paragraphs>
                            <Paragraph>
                              <TextRuns>
                                <TextRun>
                                  <Value>=Fields!Source.Value</Value>
                                  <Style>
                                    <FontFamily>Tahoma</FontFamily>
                                    <Color>#4d4d4d</Color>
                                  </Style>
                                </TextRun>
                              </TextRuns>
                              <Style />
                            </Paragraph>
                          </Paragraphs>
                          <rd:DefaultName>Source</rd:DefaultName>
                          <Style>
                            <Border>
                              <Color>#e5e5e5</Color>
                              <Style>Solid</Style>
                            </Border>
                            <PaddingLeft>2pt</PaddingLeft>
                            <PaddingRight>2pt</PaddingRight>
                            <PaddingTop>2pt</PaddingTop>
                            <PaddingBottom>2pt</PaddingBottom>
                          </Style>
                        </Textbox>
                      </CellContents>
                    </TablixCell>
                    <TablixCell>
                      <CellContents>
                        <Textbox Name="TimeCreated">
                          <CanGrow>true</CanGrow>
                          <KeepTogether>true</KeepTogether>
                          <Paragraphs>
                            <Paragraph>
                              <TextRuns>
                                <TextRun>
                                  <Value>=Fields!TimeCreated.Value</Value>
                                  <Style>
                                    <FontFamily>Tahoma</FontFamily>
                                    <Color>#4d4d4d</Color>
                                  </Style>
                                </TextRun>
                              </TextRuns>
                              <Style>
                                <TextAlign>Center</TextAlign>
                              </Style>
                            </Paragraph>
                          </Paragraphs>
                          <rd:DefaultName>TimeCreated</rd:DefaultName>
                          <Style>
                            <Border>
                              <Color>#e5e5e5</Color>
                              <Style>Solid</Style>
                            </Border>
                            <PaddingLeft>2pt</PaddingLeft>
                            <PaddingRight>2pt</PaddingRight>
                            <PaddingTop>2pt</PaddingTop>
                            <PaddingBottom>2pt</PaddingBottom>
                          </Style>
                        </Textbox>
                      </CellContents>
                    </TablixCell>
                  </TablixCells>
                </TablixRow>
              </TablixRows>
            </TablixBody>
            <TablixColumnHierarchy>
              <TablixMembers>
                <TablixMember />
                <TablixMember />
                <TablixMember />
                <TablixMember />
                <TablixMember />
                <TablixMember />
                <TablixMember />
              </TablixMembers>
            </TablixColumnHierarchy>
            <TablixRowHierarchy>
              <TablixMembers>
                <TablixMember>
                  <KeepWithGroup>After</KeepWithGroup>
                </TablixMember>
                <TablixMember>
                  <Group Name="Details" />
                </TablixMember>
              </TablixMembers>
            </TablixRowHierarchy>
            <DataSetName>MainReport</DataSetName>
            <Height>0.5in</Height>
            <Width>17.13542in</Width>
            <Style>
              <Border>
                <Style>None</Style>
                <Width>0.25pt</Width>
              </Border>
            </Style>
          </Tablix>
        </ReportItems>
        <Height>8.65625in</Height>
        <Style>
          <Border>
            <Style>None</Style>
          </Border>
        </Style>
      </Body>
      <Width>17.13542in</Width>
      <Page>
        <PageHeader>
          <Height>1.12847in</Height>
          <PrintOnFirstPage>true</PrintOnFirstPage>
          <PrintOnLastPage>true</PrintOnLastPage>
          <ReportItems>
            <Textbox Name="ReportTitle">
              <CanGrow>true</CanGrow>
              <KeepTogether>true</KeepTogether>
              <Paragraphs>
                <Paragraph>
                  <TextRuns>
                    <TextRun>
                      <Value>HFReport - Security Events</Value>
                      <Style>
                        <FontFamily>Consolas</FontFamily>
                        <FontSize>26pt</FontSize>
                        <Color>MidnightBlue</Color>
                      </Style>
                    </TextRun>
                  </TextRuns>
                  <Style />
                </Paragraph>
              </Paragraphs>
              <rd:WatermarkTextbox>Title</rd:WatermarkTextbox>
              <rd:DefaultName>ReportTitle</rd:DefaultName>
              <Top>0.27083in</Top>
              <Left>0.20833in</Left>
              <Height>0.57708in</Height>
              <Width>5.5in</Width>
              <Style>
                <Border>
                  <Style>None</Style>
                </Border>
                <PaddingLeft>2pt</PaddingLeft>
                <PaddingRight>2pt</PaddingRight>
                <PaddingTop>2pt</PaddingTop>
                <PaddingBottom>2pt</PaddingBottom>
              </Style>
            </Textbox>
            <Textbox Name="Textbox21">
              <CanGrow>true</CanGrow>
              <KeepTogether>true</KeepTogether>
              <Paragraphs>
                <Paragraph>
                  <TextRuns>
                    <TextRun>
                      <Value>This report was created as part of the HF Server Events project (</Value>
                      <Style>
                        <FontFamily>Consolas</FontFamily>
                        <FontSize>8pt</FontSize>
                        <Color>MidnightBlue</Color>
                      </Style>
                    </TextRun>
                    <TextRun>
                      <Value>HF Server Events GitHub Repository</Value>
                      <ActionInfo>
                        <Actions>
                          <Action>
                            <Hyperlink>https://github.com/ClaudioMerola/HFServerEvents</Hyperlink>
                          </Action>
                        </Actions>
                      </ActionInfo>
                      <Style>
                        <FontFamily>Consolas</FontFamily>
                        <FontSize>8pt</FontSize>
                        <TextDecoration>Underline</TextDecoration>
                        <Color>MidnightBlue</Color>
                      </Style>
                    </TextRun>
                    <TextRun>
                      <Value>)</Value>
                      <Style>
                        <FontFamily>Consolas</FontFamily>
                        <FontSize>8pt</FontSize>
                        <Color>MidnightBlue</Color>
                      </Style>
                    </TextRun>
                  </TextRuns>
                  <Style>
                    <TextAlign>Left</TextAlign>
                  </Style>
                </Paragraph>
              </Paragraphs>
              <rd:DefaultName>Textbox21</rd:DefaultName>
              <Top>0.5375in</Top>
              <Left>13.30917in</Left>
              <Height>0.57708in</Height>
              <Width>3.82625in</Width>
              <ZIndex>1</ZIndex>
              <Style>
                <Border>
                  <Style>None</Style>
                </Border>
                <VerticalAlign>Bottom</VerticalAlign>
                <PaddingLeft>2pt</PaddingLeft>
                <PaddingRight>2pt</PaddingRight>
                <PaddingTop>2pt</PaddingTop>
                <PaddingBottom>2pt</PaddingBottom>
              </Style>
            </Textbox>
          </ReportItems>
          <Style>
            <Border>
              <Style>None</Style>
              <Width>0.25pt</Width>
            </Border>
            <BackgroundColor>LightSteelBlue</BackgroundColor>
          </Style>
        </PageHeader>
        <PageFooter>
          <Height>0.77292in</Height>
          <PrintOnFirstPage>true</PrintOnFirstPage>
          <PrintOnLastPage>true</PrintOnLastPage>
          <ReportItems>
            <Textbox Name="ExecutionTime">
              <CanGrow>true</CanGrow>
              <KeepTogether>true</KeepTogether>
              <Paragraphs>
                <Paragraph>
                  <TextRuns>
                    <TextRun>
                      <Value>=Globals!ExecutionTime</Value>
                      <Style>
                        <FontFamily>Consolas</FontFamily>
                        <Color>MidnightBlue</Color>
                      </Style>
                    </TextRun>
                  </TextRuns>
                  <Style>
                    <TextAlign>Center</TextAlign>
                  </Style>
                </Paragraph>
              </Paragraphs>
              <rd:DefaultName>ExecutionTime</rd:DefaultName>
              <Top>0.43625in</Top>
              <Left>1in</Left>
              <Height>0.26375in</Height>
              <Width>2.31726in</Width>
              <Style>
                <Border>
                  <Style>None</Style>
                </Border>
                <PaddingLeft>2pt</PaddingLeft>
                <PaddingRight>2pt</PaddingRight>
                <PaddingTop>2pt</PaddingTop>
                <PaddingBottom>2pt</PaddingBottom>
              </Style>
            </Textbox>
            <Textbox Name="Textbox22">
              <CanGrow>true</CanGrow>
              <KeepTogether>true</KeepTogether>
              <Paragraphs>
                <Paragraph>
                  <TextRuns>
                    <TextRun>
                      <Value>Report Date:</Value>
                      <Style>
                        <FontFamily>Consolas</FontFamily>
                        <Color>MidnightBlue</Color>
                      </Style>
                    </TextRun>
                  </TextRuns>
                  <Style />
                </Paragraph>
              </Paragraphs>
              <rd:DefaultName>Textbox22</rd:DefaultName>
              <Top>0.43625in</Top>
              <Left>0.04042in</Left>
              <Height>0.26375in</Height>
              <Width>0.95958in</Width>
              <ZIndex>1</ZIndex>
              <Style>
                <Border>
                  <Style>None</Style>
                </Border>
                <PaddingLeft>2pt</PaddingLeft>
                <PaddingRight>2pt</PaddingRight>
                <PaddingTop>2pt</PaddingTop>
                <PaddingBottom>2pt</PaddingBottom>
              </Style>
            </Textbox>
            <Textbox Name="Pages">
              <CanGrow>true</CanGrow>
              <KeepTogether>true</KeepTogether>
              <Paragraphs>
                <Paragraph>
                  <TextRuns>
                    <TextRun>
                      <Value>="Page "&amp;Globals!PageNumber &amp;" of "&amp;Globals!TotalPages</Value>
                      <Style>
                        <FontFamily>Consolas</FontFamily>
                        <FontSize>12pt</FontSize>
                        <Color>MidnightBlue</Color>
                      </Style>
                    </TextRun>
                  </TextRuns>
                  <Style />
                </Paragraph>
              </Paragraphs>
              <Top>0.43625in</Top>
              <Left>15.45708in</Left>
              <Height>0.30889in</Height>
              <Width>1.67833in</Width>
              <ZIndex>2</ZIndex>
              <Style>
                <Border>
                  <Style>None</Style>
                </Border>
                <PaddingLeft>2pt</PaddingLeft>
                <PaddingRight>2pt</PaddingRight>
                <PaddingTop>2pt</PaddingTop>
                <PaddingBottom>2pt</PaddingBottom>
              </Style>
            </Textbox>
          </ReportItems>
          <Style>
            <Border>
              <Style>None</Style>
            </Border>
            <BackgroundColor>LightSteelBlue</BackgroundColor>
          </Style>
        </PageFooter>
        <LeftMargin>1in</LeftMargin>
        <RightMargin>1in</RightMargin>
        <TopMargin>1in</TopMargin>
        <BottomMargin>1in</BottomMargin>
        <Style />
      </Page>
    </ReportSection>
  </ReportSections>
  <ReportParameters>
    <ReportParameter Name="ID">
      <DataType>String</DataType>
      <DefaultValue>
        <Values>
          <Value>All</Value>
        </Values>
      </DefaultValue>
      <AllowBlank>true</AllowBlank>
      <Prompt>Event ID</Prompt>
      <ValidValues>
        <DataSetReference>
          <DataSetName>IDs</DataSetName>
          <ValueField>ID</ValueField>
          <LabelField>ID</LabelField>
        </DataSetReference>
      </ValidValues>
    </ReportParameter>
    <ReportParameter Name="Message">
      <DataType>String</DataType>
      <AllowBlank>true</AllowBlank>
      <Prompt>Message</Prompt>
    </ReportParameter>
    <ReportParameter Name="Source">
      <DataType>String</DataType>
      <DefaultValue>
        <Values>
          <Value>All</Value>
        </Values>
      </DefaultValue>
      <Prompt>Source</Prompt>
      <ValidValues>
        <DataSetReference>
          <DataSetName>Source</DataSetName>
          <ValueField>Source</ValueField>
          <LabelField>Source</LabelField>
        </DataSetReference>
      </ValidValues>
    </ReportParameter>
    <ReportParameter Name="Level">
      <DataType>String</DataType>
      <DefaultValue>
        <Values>
          <Value>All</Value>
        </Values>
      </DefaultValue>
      <Prompt>Event Leve</Prompt>
      <ValidValues>
        <DataSetReference>
          <DataSetName>Level</DataSetName>
          <ValueField>Level</ValueField>
          <LabelField>Level</LabelField>
        </DataSetReference>
      </ValidValues>
    </ReportParameter>
    <ReportParameter Name="StartDate">
      <DataType>DateTime</DataType>
      <DefaultValue>
        <DataSetReference>
          <DataSetName>StartDate</DataSetName>
          <ValueField>TimeCreated</ValueField>
        </DataSetReference>
      </DefaultValue>
      <Prompt>Start Date</Prompt>
    </ReportParameter>
    <ReportParameter Name="EndDate">
      <DataType>DateTime</DataType>
      <DefaultValue>
        <DataSetReference>
          <DataSetName>EndDate</DataSetName>
          <ValueField>TimeCreated</ValueField>
        </DataSetReference>
      </DefaultValue>
      <Prompt>End Date</Prompt>
    </ReportParameter>
  </ReportParameters>
  <rd:ReportUnitType>Inch</rd:ReportUnitType>
  <rd:ReportID>5a3370e1-7f42-4ab2-a7d5-3f1be84b97ce</rd:ReportID>
</Report>
'@

$SecReport | Out-File C:\EvtHF\Reports\SecurityEvents.rdl -Encoding utf8


$SysReport = @'
<?xml version="1.0" encoding="utf-8"?>
<Report xmlns:rd="http://schemas.microsoft.com/SQLServer/reporting/reportdesigner" xmlns:cl="http://schemas.microsoft.com/sqlserver/reporting/2010/01/componentdefinition" xmlns="http://schemas.microsoft.com/sqlserver/reporting/2010/01/reportdefinition">
  <AutoRefresh>0</AutoRefresh>
  <DataSources>
    <DataSource Name="HardFinger">
      <ConnectionProperties>
        <DataProvider>SQL</DataProvider>
        <ConnectString>Data Source=localhost;Initial Catalog=EventServerDB</ConnectString>
        <IntegratedSecurity>true</IntegratedSecurity>
      </ConnectionProperties>
      <rd:SecurityType>Integrated</rd:SecurityType>
      <rd:DataSourceID>94c9029b-e7c6-4bc0-b977-66e92cc2c98f</rd:DataSourceID>
    </DataSource>
  </DataSources>
  <DataSets>
    <DataSet Name="MainReport">
      <Query>
        <DataSourceName>HardFinger</DataSourceName>
        <QueryParameters>
          <QueryParameter Name="@ID">
            <Value>=Parameters!ID.Value</Value>
          </QueryParameter>
          <QueryParameter Name="@Message">
            <Value>=Parameters!Message.Value</Value>
            <rd:UserDefined>true</rd:UserDefined>
          </QueryParameter>
          <QueryParameter Name="@Source">
            <Value>=Parameters!Source.Value</Value>
          </QueryParameter>
          <QueryParameter Name="@Level">
            <Value>=Parameters!Level.Value</Value>
            <rd:UserDefined>true</rd:UserDefined>
          </QueryParameter>
        </QueryParameters>
        <CommandText>if (@Message = '')
SELECT
  SystemLog.ID
  ,SystemLog.LevelDisplayName
  ,SystemLog.LogName
  ,SystemLog.MachineName
  ,SystemLog.Message
  ,SystemLog.Source
  ,SystemLog.RecordID
  ,SystemLog.TaskDisplayName
  ,SystemLog.TimeCreated
FROM
  SystemLog
WHERE
SystemLog.ID like 
case 
when @ID = 'All' then '%'
ELSE @ID
END
and SystemLog.Source like 
case 
when @Source = 'All' then '%'
ELSE @Source
END
and SystemLog.LevelDisplayName like 
case 
when @Level = 'All' then '%'
ELSE @Level
END

else

SELECT
  SystemLog.ID
  ,SystemLog.LevelDisplayName
  ,SystemLog.LogName
  ,SystemLog.MachineName
  ,SystemLog.Message
  ,SystemLog.Source
  ,SystemLog.RecordID
  ,SystemLog.TaskDisplayName
  ,SystemLog.TimeCreated
FROM
  SystemLog
WHERE
SystemLog.ID like 
case 
when @ID = 'All' then '%'
ELSE @ID
END
and SystemLog.Source like 
case 
when @Source = 'All' then '%'
ELSE @Source
END
and SystemLog.LevelDisplayName like 
case 
when @Level = 'All' then '%'
ELSE @Level
END
and FREETEXT (SystemLog.Message, @Message)</CommandText>
        <rd:UseGenericDesigner>true</rd:UseGenericDesigner>
      </Query>
      <Fields>
        <Field Name="Id">
          <DataField>ID</DataField>
          <rd:TypeName>System.Int32</rd:TypeName>
        </Field>
        <Field Name="LevelDisplayName">
          <DataField>LevelDisplayName</DataField>
          <rd:TypeName>System.String</rd:TypeName>
        </Field>
        <Field Name="LogName">
          <DataField>LogName</DataField>
          <rd:TypeName>System.String</rd:TypeName>
        </Field>
        <Field Name="MachineName">
          <DataField>MachineName</DataField>
          <rd:TypeName>System.String</rd:TypeName>
        </Field>
        <Field Name="Message">
          <DataField>Message</DataField>
          <rd:TypeName>System.String</rd:TypeName>
        </Field>
        <Field Name="Source">
          <DataField>Source</DataField>
          <rd:TypeName>System.String</rd:TypeName>
        </Field>
        <Field Name="RecordID">
          <DataField>RecordID</DataField>
          <rd:TypeName>System.Int64</rd:TypeName>
        </Field>
        <Field Name="TaskDisplayName">
          <DataField>TaskDisplayName</DataField>
          <rd:TypeName>System.String</rd:TypeName>
        </Field>
        <Field Name="TimeCreated">
          <DataField>TimeCreated</DataField>
          <rd:TypeName>System.DateTime</rd:TypeName>
        </Field>
      </Fields>
      <Filters>
        <Filter>
          <FilterExpression>=Fields!TimeCreated.Value</FilterExpression>
          <Operator>Between</Operator>
          <FilterValues>
            <FilterValue>=Parameters!StartDate.Value</FilterValue>
            <FilterValue>=Parameters!EndDate.Value</FilterValue>
          </FilterValues>
        </Filter>
      </Filters>
    </DataSet>
    <DataSet Name="IDs">
      <Query>
        <DataSourceName>HardFinger</DataSourceName>
        <CommandText>select 0 as [Order],'All' as [ID]
union
SELECT  Distinct
1,
  cast(SystemLog.ID as varchar)
FROM
  SystemLog
  order by 1</CommandText>
        <rd:UseGenericDesigner>true</rd:UseGenericDesigner>
      </Query>
      <Fields>
        <Field Name="ID">
          <DataField>ID</DataField>
          <rd:TypeName>System.String</rd:TypeName>
        </Field>
      </Fields>
    </DataSet>
    <DataSet Name="Source">
      <Query>
        <DataSourceName>HardFinger</DataSourceName>
        <CommandText>select 0 as [Order],'All' as [Source]
union
SELECT  Distinct
1,
  SystemLog.Source
FROM
  SystemLog
  order by 1</CommandText>
        <rd:UseGenericDesigner>true</rd:UseGenericDesigner>
      </Query>
      <Fields>
        <Field Name="Source">
          <DataField>Source</DataField>
          <rd:TypeName>System.String</rd:TypeName>
        </Field>
      </Fields>
    </DataSet>
    <DataSet Name="Level">
      <Query>
        <DataSourceName>HardFinger</DataSourceName>
        <CommandText>select 0 as [Order],'All' as [Level]
union
SELECT  Distinct
1,
  SystemLog.LevelDisplayName
FROM
  SystemLog
  order by 1</CommandText>
        <rd:UseGenericDesigner>true</rd:UseGenericDesigner>
      </Query>
      <Fields>
        <Field Name="Level">
          <DataField>Level</DataField>
          <rd:TypeName>System.String</rd:TypeName>
        </Field>
      </Fields>
    </DataSet>
    <DataSet Name="StartDate">
      <Query>
        <DataSourceName>HardFinger</DataSourceName>
        <CommandText>SELECT top 1
  SystemLog.TimeCreated
FROM
  SystemLog
  order by 1</CommandText>
        <rd:UseGenericDesigner>true</rd:UseGenericDesigner>
      </Query>
      <Fields>
        <Field Name="TimeCreated">
          <DataField>TimeCreated</DataField>
          <rd:TypeName>System.DateTime</rd:TypeName>
        </Field>
      </Fields>
    </DataSet>
    <DataSet Name="EndDate">
      <Query>
        <DataSourceName>HardFinger</DataSourceName>
        <CommandText>SELECT top 1
  SystemLog.TimeCreated
FROM
  SystemLog
  order by 1 Desc</CommandText>
        <rd:UseGenericDesigner>true</rd:UseGenericDesigner>
      </Query>
      <Fields>
        <Field Name="TimeCreated">
          <DataField>TimeCreated</DataField>
          <rd:TypeName>System.DateTime</rd:TypeName>
        </Field>
      </Fields>
    </DataSet>
  </DataSets>
  <ReportSections>
    <ReportSection>
      <Body>
        <ReportItems>
          <Tablix Name="Tablix1">
            <TablixBody>
              <TablixColumns>
                <TablixColumn>
                  <Width>1.8253in</Width>
                </TablixColumn>
                <TablixColumn>
                  <Width>1.4503in</Width>
                </TablixColumn>
                <TablixColumn>
                  <Width>1.72113in</Width>
                </TablixColumn>
                <TablixColumn>
                  <Width>1.40863in</Width>
                </TablixColumn>
                <TablixColumn>
                  <Width>5.9753in</Width>
                </TablixColumn>
                <TablixColumn>
                  <Width>2.37738in</Width>
                </TablixColumn>
                <TablixColumn>
                  <Width>2.37738in</Width>
                </TablixColumn>
              </TablixColumns>
              <TablixRows>
                <TablixRow>
                  <Height>0.25in</Height>
                  <TablixCells>
                    <TablixCell>
                      <CellContents>
                        <Textbox Name="Textbox2">
                          <CanGrow>true</CanGrow>
                          <KeepTogether>true</KeepTogether>
                          <Paragraphs>
                            <Paragraph>
                              <TextRuns>
                                <TextRun>
                                  <Value>Machine Name</Value>
                                  <Style>
                                    <FontFamily>Tahoma</FontFamily>
                                    <FontSize>11pt</FontSize>
                                    <FontWeight>Bold</FontWeight>
                                    <Color>White</Color>
                                  </Style>
                                </TextRun>
                              </TextRuns>
                              <Style />
                            </Paragraph>
                          </Paragraphs>
                          <rd:DefaultName>Textbox2</rd:DefaultName>
                          <Style>
                            <Border>
                              <Color>#4e648a</Color>
                              <Style>Solid</Style>
                            </Border>
                            <BackgroundColor>#384c70</BackgroundColor>
                            <PaddingLeft>2pt</PaddingLeft>
                            <PaddingRight>2pt</PaddingRight>
                            <PaddingTop>2pt</PaddingTop>
                            <PaddingBottom>2pt</PaddingBottom>
                          </Style>
                        </Textbox>
                      </CellContents>
                    </TablixCell>
                    <TablixCell>
                      <CellContents>
                        <Textbox Name="Textbox3">
                          <CanGrow>true</CanGrow>
                          <KeepTogether>true</KeepTogether>
                          <Paragraphs>
                            <Paragraph>
                              <TextRuns>
                                <TextRun>
                                  <Value>Log Name</Value>
                                  <Style>
                                    <FontFamily>Tahoma</FontFamily>
                                    <FontSize>11pt</FontSize>
                                    <FontWeight>Bold</FontWeight>
                                    <Color>White</Color>
                                  </Style>
                                </TextRun>
                              </TextRuns>
                              <Style>
                                <TextAlign>Center</TextAlign>
                              </Style>
                            </Paragraph>
                          </Paragraphs>
                          <rd:DefaultName>Textbox3</rd:DefaultName>
                          <Style>
                            <Border>
                              <Color>#4e648a</Color>
                              <Style>Solid</Style>
                            </Border>
                            <BackgroundColor>#384c70</BackgroundColor>
                            <PaddingLeft>2pt</PaddingLeft>
                            <PaddingRight>2pt</PaddingRight>
                            <PaddingTop>2pt</PaddingTop>
                            <PaddingBottom>2pt</PaddingBottom>
                          </Style>
                        </Textbox>
                      </CellContents>
                    </TablixCell>
                    <TablixCell>
                      <CellContents>
                        <Textbox Name="Textbox5">
                          <CanGrow>true</CanGrow>
                          <KeepTogether>true</KeepTogether>
                          <Paragraphs>
                            <Paragraph>
                              <TextRuns>
                                <TextRun>
                                  <Value>Category</Value>
                                  <Style>
                                    <FontFamily>Tahoma</FontFamily>
                                    <FontSize>11pt</FontSize>
                                    <FontWeight>Bold</FontWeight>
                                    <Color>White</Color>
                                  </Style>
                                </TextRun>
                              </TextRuns>
                              <Style>
                                <TextAlign>Center</TextAlign>
                              </Style>
                            </Paragraph>
                          </Paragraphs>
                          <rd:DefaultName>Textbox5</rd:DefaultName>
                          <Style>
                            <Border>
                              <Color>#4e648a</Color>
                              <Style>Solid</Style>
                            </Border>
                            <BackgroundColor>#384c70</BackgroundColor>
                            <PaddingLeft>2pt</PaddingLeft>
                            <PaddingRight>2pt</PaddingRight>
                            <PaddingTop>2pt</PaddingTop>
                            <PaddingBottom>2pt</PaddingBottom>
                          </Style>
                        </Textbox>
                      </CellContents>
                    </TablixCell>
                    <TablixCell>
                      <CellContents>
                        <Textbox Name="Textbox7">
                          <CanGrow>true</CanGrow>
                          <KeepTogether>true</KeepTogether>
                          <Paragraphs>
                            <Paragraph>
                              <TextRuns>
                                <TextRun>
                                  <Value>Event ID</Value>
                                  <Style>
                                    <FontFamily>Tahoma</FontFamily>
                                    <FontSize>11pt</FontSize>
                                    <FontWeight>Bold</FontWeight>
                                    <Color>White</Color>
                                  </Style>
                                </TextRun>
                              </TextRuns>
                              <Style>
                                <TextAlign>Center</TextAlign>
                              </Style>
                            </Paragraph>
                          </Paragraphs>
                          <rd:DefaultName>Textbox7</rd:DefaultName>
                          <Style>
                            <Border>
                              <Color>#4e648a</Color>
                              <Style>Solid</Style>
                            </Border>
                            <BackgroundColor>#384c70</BackgroundColor>
                            <PaddingLeft>2pt</PaddingLeft>
                            <PaddingRight>2pt</PaddingRight>
                            <PaddingTop>2pt</PaddingTop>
                            <PaddingBottom>2pt</PaddingBottom>
                          </Style>
                        </Textbox>
                      </CellContents>
                    </TablixCell>
                    <TablixCell>
                      <CellContents>
                        <Textbox Name="Textbox9">
                          <CanGrow>true</CanGrow>
                          <KeepTogether>true</KeepTogether>
                          <Paragraphs>
                            <Paragraph>
                              <TextRuns>
                                <TextRun>
                                  <Value>Message</Value>
                                  <Style>
                                    <FontFamily>Tahoma</FontFamily>
                                    <FontSize>11pt</FontSize>
                                    <FontWeight>Bold</FontWeight>
                                    <Color>White</Color>
                                  </Style>
                                </TextRun>
                              </TextRuns>
                              <Style>
                                <TextAlign>Center</TextAlign>
                              </Style>
                            </Paragraph>
                          </Paragraphs>
                          <rd:DefaultName>Textbox9</rd:DefaultName>
                          <Style>
                            <Border>
                              <Color>#4e648a</Color>
                              <Style>Solid</Style>
                            </Border>
                            <BackgroundColor>#384c70</BackgroundColor>
                            <PaddingLeft>2pt</PaddingLeft>
                            <PaddingRight>2pt</PaddingRight>
                            <PaddingTop>2pt</PaddingTop>
                            <PaddingBottom>2pt</PaddingBottom>
                          </Style>
                        </Textbox>
                      </CellContents>
                    </TablixCell>
                    <TablixCell>
                      <CellContents>
                        <Textbox Name="Textbox11">
                          <CanGrow>true</CanGrow>
                          <KeepTogether>true</KeepTogether>
                          <Paragraphs>
                            <Paragraph>
                              <TextRuns>
                                <TextRun>
                                  <Value>Source</Value>
                                  <Style>
                                    <FontFamily>Tahoma</FontFamily>
                                    <FontSize>11pt</FontSize>
                                    <FontWeight>Bold</FontWeight>
                                    <Color>White</Color>
                                  </Style>
                                </TextRun>
                              </TextRuns>
                              <Style>
                                <TextAlign>Center</TextAlign>
                              </Style>
                            </Paragraph>
                          </Paragraphs>
                          <rd:DefaultName>Textbox11</rd:DefaultName>
                          <Style>
                            <Border>
                              <Color>#4e648a</Color>
                              <Style>Solid</Style>
                            </Border>
                            <BackgroundColor>#384c70</BackgroundColor>
                            <PaddingLeft>2pt</PaddingLeft>
                            <PaddingRight>2pt</PaddingRight>
                            <PaddingTop>2pt</PaddingTop>
                            <PaddingBottom>2pt</PaddingBottom>
                          </Style>
                        </Textbox>
                      </CellContents>
                    </TablixCell>
                    <TablixCell>
                      <CellContents>
                        <Textbox Name="Textbox13">
                          <CanGrow>true</CanGrow>
                          <KeepTogether>true</KeepTogether>
                          <Paragraphs>
                            <Paragraph>
                              <TextRuns>
                                <TextRun>
                                  <Value>Event Date</Value>
                                  <Style>
                                    <FontFamily>Tahoma</FontFamily>
                                    <FontSize>11pt</FontSize>
                                    <FontWeight>Bold</FontWeight>
                                    <Color>White</Color>
                                  </Style>
                                </TextRun>
                              </TextRuns>
                              <Style>
                                <TextAlign>Center</TextAlign>
                              </Style>
                            </Paragraph>
                          </Paragraphs>
                          <rd:DefaultName>Textbox13</rd:DefaultName>
                          <Style>
                            <Border>
                              <Color>#4e648a</Color>
                              <Style>Solid</Style>
                            </Border>
                            <BackgroundColor>#384c70</BackgroundColor>
                            <PaddingLeft>2pt</PaddingLeft>
                            <PaddingRight>2pt</PaddingRight>
                            <PaddingTop>2pt</PaddingTop>
                            <PaddingBottom>2pt</PaddingBottom>
                          </Style>
                        </Textbox>
                      </CellContents>
                    </TablixCell>
                  </TablixCells>
                </TablixRow>
                <TablixRow>
                  <Height>0.25in</Height>
                  <TablixCells>
                    <TablixCell>
                      <CellContents>
                        <Textbox Name="MachineName">
                          <CanGrow>true</CanGrow>
                          <KeepTogether>true</KeepTogether>
                          <Paragraphs>
                            <Paragraph>
                              <TextRuns>
                                <TextRun>
                                  <Value>=Fields!MachineName.Value</Value>
                                  <Style>
                                    <FontFamily>Tahoma</FontFamily>
                                    <Color>#4d4d4d</Color>
                                  </Style>
                                </TextRun>
                              </TextRuns>
                              <Style />
                            </Paragraph>
                          </Paragraphs>
                          <rd:DefaultName>MachineName</rd:DefaultName>
                          <Style>
                            <Border>
                              <Color>#e5e5e5</Color>
                              <Style>Solid</Style>
                            </Border>
                            <PaddingLeft>2pt</PaddingLeft>
                            <PaddingRight>2pt</PaddingRight>
                            <PaddingTop>2pt</PaddingTop>
                            <PaddingBottom>2pt</PaddingBottom>
                          </Style>
                        </Textbox>
                      </CellContents>
                    </TablixCell>
                    <TablixCell>
                      <CellContents>
                        <Textbox Name="LogName">
                          <CanGrow>true</CanGrow>
                          <KeepTogether>true</KeepTogether>
                          <Paragraphs>
                            <Paragraph>
                              <TextRuns>
                                <TextRun>
                                  <Value>=Fields!LogName.Value</Value>
                                  <Style>
                                    <FontFamily>Tahoma</FontFamily>
                                    <Color>#4d4d4d</Color>
                                  </Style>
                                </TextRun>
                              </TextRuns>
                              <Style>
                                <TextAlign>Center</TextAlign>
                              </Style>
                            </Paragraph>
                          </Paragraphs>
                          <rd:DefaultName>LogName</rd:DefaultName>
                          <Style>
                            <Border>
                              <Color>#e5e5e5</Color>
                              <Style>Solid</Style>
                            </Border>
                            <PaddingLeft>2pt</PaddingLeft>
                            <PaddingRight>2pt</PaddingRight>
                            <PaddingTop>2pt</PaddingTop>
                            <PaddingBottom>2pt</PaddingBottom>
                          </Style>
                        </Textbox>
                      </CellContents>
                    </TablixCell>
                    <TablixCell>
                      <CellContents>
                        <Textbox Name="LevelDisplayName">
                          <CanGrow>true</CanGrow>
                          <KeepTogether>true</KeepTogether>
                          <Paragraphs>
                            <Paragraph>
                              <TextRuns>
                                <TextRun>
                                  <Value>=Fields!LevelDisplayName.Value</Value>
                                  <Style>
                                    <FontFamily>Tahoma</FontFamily>
                                    <Color>#4d4d4d</Color>
                                  </Style>
                                </TextRun>
                              </TextRuns>
                              <Style />
                            </Paragraph>
                          </Paragraphs>
                          <rd:DefaultName>LevelDisplayName</rd:DefaultName>
                          <Style>
                            <Border>
                              <Color>#e5e5e5</Color>
                              <Style>Solid</Style>
                            </Border>
                            <PaddingLeft>2pt</PaddingLeft>
                            <PaddingRight>2pt</PaddingRight>
                            <PaddingTop>2pt</PaddingTop>
                            <PaddingBottom>2pt</PaddingBottom>
                          </Style>
                        </Textbox>
                      </CellContents>
                    </TablixCell>
                    <TablixCell>
                      <CellContents>
                        <Textbox Name="Id">
                          <CanGrow>true</CanGrow>
                          <KeepTogether>true</KeepTogether>
                          <Paragraphs>
                            <Paragraph>
                              <TextRuns>
                                <TextRun>
                                  <Value>=Fields!Id.Value</Value>
                                  <Style>
                                    <FontFamily>Tahoma</FontFamily>
                                    <Color>#4d4d4d</Color>
                                  </Style>
                                </TextRun>
                              </TextRuns>
                              <Style>
                                <TextAlign>Center</TextAlign>
                              </Style>
                            </Paragraph>
                          </Paragraphs>
                          <rd:DefaultName>Id</rd:DefaultName>
                          <Style>
                            <Border>
                              <Color>#e5e5e5</Color>
                              <Style>Solid</Style>
                            </Border>
                            <PaddingLeft>2pt</PaddingLeft>
                            <PaddingRight>2pt</PaddingRight>
                            <PaddingTop>2pt</PaddingTop>
                            <PaddingBottom>2pt</PaddingBottom>
                          </Style>
                        </Textbox>
                      </CellContents>
                    </TablixCell>
                    <TablixCell>
                      <CellContents>
                        <Textbox Name="Message">
                          <CanGrow>true</CanGrow>
                          <KeepTogether>true</KeepTogether>
                          <Paragraphs>
                            <Paragraph>
                              <TextRuns>
                                <TextRun>
                                  <Value>=Fields!Message.Value</Value>
                                  <Style>
                                    <FontFamily>Tahoma</FontFamily>
                                    <Color>#4d4d4d</Color>
                                  </Style>
                                </TextRun>
                              </TextRuns>
                              <Style />
                            </Paragraph>
                          </Paragraphs>
                          <rd:DefaultName>Message</rd:DefaultName>
                          <Style>
                            <Border>
                              <Color>#e5e5e5</Color>
                              <Style>Solid</Style>
                            </Border>
                            <PaddingLeft>2pt</PaddingLeft>
                            <PaddingRight>2pt</PaddingRight>
                            <PaddingTop>2pt</PaddingTop>
                            <PaddingBottom>2pt</PaddingBottom>
                          </Style>
                        </Textbox>
                      </CellContents>
                    </TablixCell>
                    <TablixCell>
                      <CellContents>
                        <Textbox Name="Source">
                          <CanGrow>true</CanGrow>
                          <KeepTogether>true</KeepTogether>
                          <Paragraphs>
                            <Paragraph>
                              <TextRuns>
                                <TextRun>
                                  <Value>=Fields!Source.Value</Value>
                                  <Style>
                                    <FontFamily>Tahoma</FontFamily>
                                    <Color>#4d4d4d</Color>
                                  </Style>
                                </TextRun>
                              </TextRuns>
                              <Style />
                            </Paragraph>
                          </Paragraphs>
                          <rd:DefaultName>Source</rd:DefaultName>
                          <Style>
                            <Border>
                              <Color>#e5e5e5</Color>
                              <Style>Solid</Style>
                            </Border>
                            <PaddingLeft>2pt</PaddingLeft>
                            <PaddingRight>2pt</PaddingRight>
                            <PaddingTop>2pt</PaddingTop>
                            <PaddingBottom>2pt</PaddingBottom>
                          </Style>
                        </Textbox>
                      </CellContents>
                    </TablixCell>
                    <TablixCell>
                      <CellContents>
                        <Textbox Name="TimeCreated">
                          <CanGrow>true</CanGrow>
                          <KeepTogether>true</KeepTogether>
                          <Paragraphs>
                            <Paragraph>
                              <TextRuns>
                                <TextRun>
                                  <Value>=Fields!TimeCreated.Value</Value>
                                  <Style>
                                    <FontFamily>Tahoma</FontFamily>
                                    <Color>#4d4d4d</Color>
                                  </Style>
                                </TextRun>
                              </TextRuns>
                              <Style>
                                <TextAlign>Center</TextAlign>
                              </Style>
                            </Paragraph>
                          </Paragraphs>
                          <rd:DefaultName>TimeCreated</rd:DefaultName>
                          <Style>
                            <Border>
                              <Color>#e5e5e5</Color>
                              <Style>Solid</Style>
                            </Border>
                            <PaddingLeft>2pt</PaddingLeft>
                            <PaddingRight>2pt</PaddingRight>
                            <PaddingTop>2pt</PaddingTop>
                            <PaddingBottom>2pt</PaddingBottom>
                          </Style>
                        </Textbox>
                      </CellContents>
                    </TablixCell>
                  </TablixCells>
                </TablixRow>
              </TablixRows>
            </TablixBody>
            <TablixColumnHierarchy>
              <TablixMembers>
                <TablixMember />
                <TablixMember />
                <TablixMember />
                <TablixMember />
                <TablixMember />
                <TablixMember />
                <TablixMember />
              </TablixMembers>
            </TablixColumnHierarchy>
            <TablixRowHierarchy>
              <TablixMembers>
                <TablixMember>
                  <KeepWithGroup>After</KeepWithGroup>
                </TablixMember>
                <TablixMember>
                  <Group Name="Details" />
                </TablixMember>
              </TablixMembers>
            </TablixRowHierarchy>
            <DataSetName>MainReport</DataSetName>
            <Height>0.5in</Height>
            <Width>17.13542in</Width>
            <Style>
              <Border>
                <Style>None</Style>
                <Width>0.25pt</Width>
              </Border>
            </Style>
          </Tablix>
        </ReportItems>
        <Height>8.65625in</Height>
        <Style>
          <Border>
            <Style>None</Style>
          </Border>
        </Style>
      </Body>
      <Width>17.13542in</Width>
      <Page>
        <PageHeader>
          <Height>1.12847in</Height>
          <PrintOnFirstPage>true</PrintOnFirstPage>
          <PrintOnLastPage>true</PrintOnLastPage>
          <ReportItems>
            <Textbox Name="ReportTitle">
              <CanGrow>true</CanGrow>
              <KeepTogether>true</KeepTogether>
              <Paragraphs>
                <Paragraph>
                  <TextRuns>
                    <TextRun>
                      <Value>HFReport - System Events</Value>
                      <Style>
                        <FontFamily>Consolas</FontFamily>
                        <FontSize>26pt</FontSize>
                        <Color>MidnightBlue</Color>
                      </Style>
                    </TextRun>
                  </TextRuns>
                  <Style />
                </Paragraph>
              </Paragraphs>
              <rd:WatermarkTextbox>Title</rd:WatermarkTextbox>
              <rd:DefaultName>ReportTitle</rd:DefaultName>
              <Top>0.27083in</Top>
              <Left>0.20833in</Left>
              <Height>0.57708in</Height>
              <Width>5.5in</Width>
              <Style>
                <Border>
                  <Style>None</Style>
                </Border>
                <PaddingLeft>2pt</PaddingLeft>
                <PaddingRight>2pt</PaddingRight>
                <PaddingTop>2pt</PaddingTop>
                <PaddingBottom>2pt</PaddingBottom>
              </Style>
            </Textbox>
            <Textbox Name="Textbox21">
              <CanGrow>true</CanGrow>
              <KeepTogether>true</KeepTogether>
              <Paragraphs>
                <Paragraph>
                  <TextRuns>
                    <TextRun>
                      <Value>This report was created as part of the HF Server Events project (</Value>
                      <Style>
                        <FontFamily>Consolas</FontFamily>
                        <FontSize>8pt</FontSize>
                        <Color>MidnightBlue</Color>
                      </Style>
                    </TextRun>
                    <TextRun>
                      <Value>HF Server Events GitHub Repository</Value>
                      <ActionInfo>
                        <Actions>
                          <Action>
                            <Hyperlink>https://github.com/ClaudioMerola/HFServerEvents</Hyperlink>
                          </Action>
                        </Actions>
                      </ActionInfo>
                      <Style>
                        <FontFamily>Consolas</FontFamily>
                        <FontSize>8pt</FontSize>
                        <TextDecoration>Underline</TextDecoration>
                        <Color>MidnightBlue</Color>
                      </Style>
                    </TextRun>
                    <TextRun>
                      <Value>)</Value>
                      <Style>
                        <FontFamily>Consolas</FontFamily>
                        <FontSize>8pt</FontSize>
                        <Color>MidnightBlue</Color>
                      </Style>
                    </TextRun>
                  </TextRuns>
                  <Style>
                    <TextAlign>Left</TextAlign>
                  </Style>
                </Paragraph>
              </Paragraphs>
              <rd:DefaultName>Textbox21</rd:DefaultName>
              <Top>0.5375in</Top>
              <Left>13.30917in</Left>
              <Height>0.57708in</Height>
              <Width>3.82625in</Width>
              <ZIndex>1</ZIndex>
              <Style>
                <Border>
                  <Style>None</Style>
                </Border>
                <VerticalAlign>Bottom</VerticalAlign>
                <PaddingLeft>2pt</PaddingLeft>
                <PaddingRight>2pt</PaddingRight>
                <PaddingTop>2pt</PaddingTop>
                <PaddingBottom>2pt</PaddingBottom>
              </Style>
            </Textbox>
          </ReportItems>
          <Style>
            <Border>
              <Style>None</Style>
              <Width>0.25pt</Width>
            </Border>
            <BackgroundColor>LightSteelBlue</BackgroundColor>
          </Style>
        </PageHeader>
        <PageFooter>
          <Height>0.77292in</Height>
          <PrintOnFirstPage>true</PrintOnFirstPage>
          <PrintOnLastPage>true</PrintOnLastPage>
          <ReportItems>
            <Textbox Name="ExecutionTime">
              <CanGrow>true</CanGrow>
              <KeepTogether>true</KeepTogether>
              <Paragraphs>
                <Paragraph>
                  <TextRuns>
                    <TextRun>
                      <Value>=Globals!ExecutionTime</Value>
                      <Style>
                        <FontFamily>Consolas</FontFamily>
                        <Color>MidnightBlue</Color>
                      </Style>
                    </TextRun>
                  </TextRuns>
                  <Style>
                    <TextAlign>Center</TextAlign>
                  </Style>
                </Paragraph>
              </Paragraphs>
              <rd:DefaultName>ExecutionTime</rd:DefaultName>
              <Top>0.43625in</Top>
              <Left>1in</Left>
              <Height>0.26375in</Height>
              <Width>2.31726in</Width>
              <Style>
                <Border>
                  <Style>None</Style>
                </Border>
                <PaddingLeft>2pt</PaddingLeft>
                <PaddingRight>2pt</PaddingRight>
                <PaddingTop>2pt</PaddingTop>
                <PaddingBottom>2pt</PaddingBottom>
              </Style>
            </Textbox>
            <Textbox Name="Textbox22">
              <CanGrow>true</CanGrow>
              <KeepTogether>true</KeepTogether>
              <Paragraphs>
                <Paragraph>
                  <TextRuns>
                    <TextRun>
                      <Value>Report Date:</Value>
                      <Style>
                        <FontFamily>Consolas</FontFamily>
                        <Color>MidnightBlue</Color>
                      </Style>
                    </TextRun>
                  </TextRuns>
                  <Style />
                </Paragraph>
              </Paragraphs>
              <rd:DefaultName>Textbox22</rd:DefaultName>
              <Top>0.43625in</Top>
              <Left>0.04042in</Left>
              <Height>0.26375in</Height>
              <Width>0.95958in</Width>
              <ZIndex>1</ZIndex>
              <Style>
                <Border>
                  <Style>None</Style>
                </Border>
                <PaddingLeft>2pt</PaddingLeft>
                <PaddingRight>2pt</PaddingRight>
                <PaddingTop>2pt</PaddingTop>
                <PaddingBottom>2pt</PaddingBottom>
              </Style>
            </Textbox>
            <Textbox Name="Pages">
              <CanGrow>true</CanGrow>
              <KeepTogether>true</KeepTogether>
              <Paragraphs>
                <Paragraph>
                  <TextRuns>
                    <TextRun>
                      <Value>="Page "&amp;Globals!PageNumber &amp;" of "&amp;Globals!TotalPages</Value>
                      <Style>
                        <FontFamily>Consolas</FontFamily>
                        <FontSize>12pt</FontSize>
                        <Color>MidnightBlue</Color>
                      </Style>
                    </TextRun>
                  </TextRuns>
                  <Style />
                </Paragraph>
              </Paragraphs>
              <Top>0.43625in</Top>
              <Left>15.45708in</Left>
              <Height>0.30889in</Height>
              <Width>1.67833in</Width>
              <ZIndex>2</ZIndex>
              <Style>
                <Border>
                  <Style>None</Style>
                </Border>
                <PaddingLeft>2pt</PaddingLeft>
                <PaddingRight>2pt</PaddingRight>
                <PaddingTop>2pt</PaddingTop>
                <PaddingBottom>2pt</PaddingBottom>
              </Style>
            </Textbox>
          </ReportItems>
          <Style>
            <Border>
              <Style>None</Style>
            </Border>
            <BackgroundColor>LightSteelBlue</BackgroundColor>
          </Style>
        </PageFooter>
        <LeftMargin>1in</LeftMargin>
        <RightMargin>1in</RightMargin>
        <TopMargin>1in</TopMargin>
        <BottomMargin>1in</BottomMargin>
        <Style />
      </Page>
    </ReportSection>
  </ReportSections>
  <ReportParameters>
    <ReportParameter Name="ID">
      <DataType>String</DataType>
      <DefaultValue>
        <Values>
          <Value>All</Value>
        </Values>
      </DefaultValue>
      <AllowBlank>true</AllowBlank>
      <Prompt>Event ID</Prompt>
      <ValidValues>
        <DataSetReference>
          <DataSetName>IDs</DataSetName>
          <ValueField>ID</ValueField>
          <LabelField>ID</LabelField>
        </DataSetReference>
      </ValidValues>
    </ReportParameter>
    <ReportParameter Name="Message">
      <DataType>String</DataType>
      <AllowBlank>true</AllowBlank>
      <Prompt>Message</Prompt>
    </ReportParameter>
    <ReportParameter Name="Source">
      <DataType>String</DataType>
      <DefaultValue>
        <Values>
          <Value>All</Value>
        </Values>
      </DefaultValue>
      <Prompt>Source</Prompt>
      <ValidValues>
        <DataSetReference>
          <DataSetName>Source</DataSetName>
          <ValueField>Source</ValueField>
          <LabelField>Source</LabelField>
        </DataSetReference>
      </ValidValues>
    </ReportParameter>
    <ReportParameter Name="Level">
      <DataType>String</DataType>
      <DefaultValue>
        <Values>
          <Value>All</Value>
        </Values>
      </DefaultValue>
      <Prompt>Event Leve</Prompt>
      <ValidValues>
        <DataSetReference>
          <DataSetName>Level</DataSetName>
          <ValueField>Level</ValueField>
          <LabelField>Level</LabelField>
        </DataSetReference>
      </ValidValues>
    </ReportParameter>
    <ReportParameter Name="StartDate">
      <DataType>DateTime</DataType>
      <DefaultValue>
        <DataSetReference>
          <DataSetName>StartDate</DataSetName>
          <ValueField>TimeCreated</ValueField>
        </DataSetReference>
      </DefaultValue>
      <Prompt>Start Date</Prompt>
    </ReportParameter>
    <ReportParameter Name="EndDate">
      <DataType>DateTime</DataType>
      <DefaultValue>
        <DataSetReference>
          <DataSetName>EndDate</DataSetName>
          <ValueField>TimeCreated</ValueField>
        </DataSetReference>
      </DefaultValue>
      <Prompt>End Date</Prompt>
    </ReportParameter>
  </ReportParameters>
  <rd:ReportUnitType>Inch</rd:ReportUnitType>
  <rd:ReportID>5a3370e1-7f42-4ab2-a7d5-3f1be84b97ce</rd:ReportID>
</Report>
'@

$SysReport | Out-File C:\EvtHF\Reports\SystemEvents.rdl -Encoding utf8

}
catch
{
throw $Error
}
}


#################################################### Importing the Reports  #################################################################


function ReportPages {
try{
$reportWebService = ('http://'+$EvtServer+'/ReportServer/ReportService2010.asmx')
$reportproxy = New-WebServiceProxy -uri $reportWebService -UseDefaultCredential
$reportproxy.CreateFolder('HF Event Reports', '/', $null)
$Warning = $null

$rdlFile = 'C:\EvtHF\Reports\SecurityEvents.rdl'
$reportName = [System.IO.Path]::GetFileNameWithoutExtension($rdlFile);
$byteArray = gc $rdlFile -encoding byte
$reportProxy.CreateCatalogItem("Report", $reportName,'/HF Event Reports', $true,$byteArray,$null,[ref]$Warning)

$rdlFile = 'C:\EvtHF\Reports\SystemEvents.rdl'
$reportName = [System.IO.Path]::GetFileNameWithoutExtension($rdlFile);
$byteArray = gc $rdlFile -encoding byte
$reportProxy.CreateCatalogItem("Report", $reportName,'/HF Event Reports', $true,$byteArray,$null,[ref]$Warning)

$namespace = $reportproxy.getType().namespace
$systempolicies = $reportproxy.GetSystemPolicies()
$roles = $reportproxy.ListRoles(“Catalog”,$null)
$rolenames = $roles | select-object -ExpandProperty name
$tasks = $reportProxy.ListTasks(“Catalog”)
$roletasks = $tasks | where-object {$_.name -like ‘View *’}
$roletaskIDs = $roletasks | Select-Object -ExpandProperty taskID

$role = $reportproxy.CreateRole('HF Report Viewers','May view and run HF Event Reports',$roletaskIDs)
$role = $reportproxy.ListRoles(“Catalog”,$null) | ? {$_.name -eq 'HF Report Viewers'}
$roletasks = $reportproxy.GetRoleProperties($role.name,$null,[ref]$role.Description)
$roletasknames = $reportproxy.ListTasks(“Catalog”) | ? {$roletasks -contains $_.taskID}
$inherited = $true
$itempolicies = $reportproxy.GetPolicies('/HF Event Reports',[ref]$inherited)
$policy = New-Object ($namespace + “.policy”)
$policy.GroupUserName = 'HF Event Report Viewer'
$policy.Roles = $role
$itempolicies += $policy
$reportproxy.SetPolicies('/HF Event Reports',$itempolicies)
}
catch
{
throw $Error
}
}


#################################################### Running the Functions #################################################################

$Prompt2 = ''
$Prompt = Read-Host -Prompt 'Install HF Server Events Full? (Y or N)'
if ($Prompt -eq 'N'){
Write-Host 'Select Option:'
Write-Host 'Press "1" to Run Phase 1 - Config Collector'
Write-Host 'Press "2" to Run Phase 2 - Config SQL Server'
Write-Host 'Press "3" to Run Phase 3 - Config Domain Controllers'
Write-Host 'Press "4" to Run Phase 4 - Create local task'
Write-Host 'Press "5" to Run Phase 5 - Creating Report Files'
Write-Host 'Press "6" to Run Phase Final Phase - Importing Reports'
Write-Host 'Press "0" to Exit'
Write-Host '-----------------------------'
$Prompt2 = Read-Host -Prompt 'Press Key:'
if($Prompt2 -eq '0') {exit}
if($Prompt2 -notin ('1','2','3','4','5','6','0')) {exit}
}
if ($Prompt -eq 'Y' -or $Prompt2 -eq '1'){
Write-Host 'Calling Phase 1 - Config Collector'
ConfigCollector
Write-Host 'Phase 1 - Complete'
}
if ($Prompt -eq 'Y' -or $Prompt2 -eq '2'){
Write-Host 'Calling Phase 2 - Config SQL Server'
ConfigSQLServer
Write-Host 'Phase 2 - Complete'
}
if ($Prompt -eq 'Y' -or $Prompt2 -eq '3'){
Write-Host 'Calling Phase 3 - Config Domain Controllers'
ConfigDCs
Write-Host 'Phase 3 - Complete'
}
if ($Prompt -eq 'Y' -or $Prompt2 -eq '4'){
Write-Host 'Calling Phase 4 - Create local task'
CreateTask
Write-Host 'Phase 4 - Complete'
}
if ($Prompt -eq 'Y' -or $Prompt2 -eq '5'){
Write-Host 'Calling Phase 5 - Creating Report Files'
ReportFiles
Write-Host 'Phase 5 - Complete'
}
if ($Prompt -eq 'Y' -or $Prompt2 -eq '6'){
Write-Host 'Calling Final Phase - Importing Reports'
ReportPages
Write-Host 'Final Phase Complete'
Write-Host 'Installation Complete'
}

