write-host 'Starting Hard Finger Script..'

$EvtServer = ((Get-WmiObject win32_computersystem).DNSHostName+"."+(Get-WmiObject win32_computersystem).Domain)

$Forest = [system.directoryservices.activedirectory.Forest]::GetCurrentForest()

$DCs = $Forest.domains | ForEach-Object {$_.DomainControllers}

function ConfigCollector {

if ((Test-Path -Path C:\EvtHF -PathType Container) -eq $false) {New-Item -Type Directory -Force -Path C:\EvtHF}

$DCEssen = ("C:\EvtHF\EvtHF-DC-Essentials.xml") 
if ((test-path $DCEssen) -eq $false) {new-item $DCEssen -Type file -Force}
Clear-Content $DCEssen

$XMLDCEssentials = @'
<?xml version="1.0" encoding="UTF-8"?>
<Subscription xmlns="http://schemas.microsoft.com/2006/03/windows/events/subscription">
	<SubscriptionId>Domain Controllers - Essentials</SubscriptionId>
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
<QueryList><Query Id="0"><Select Path="System">*[System[(Level=1  or Level=2 or Level=3)]]</Select><Select Path="Security">*[System[(EventID=4618 or EventID=4618 or EventID=4649 or EventID=4719 or EventID=4765 or EventID=4766 or EventID=4794 or EventID=4897 or EventID=4964 or EventID=5124 or EventID=1102 or EventID=4621 or EventID=4675 or EventID=4692 or EventID=4693 or EventID=4706 or EventID=4713 or EventID=4714 or EventID=4715 or EventID=4716 or EventID=4724 or EventID=4727 or EventID=4735 or EventID=4737 or EventID=4739 or EventID=4754 or EventID=4755 or EventID=4764 or EventID=4764 or EventID=4780 or EventID=4816 or EventID=4865 or EventID=4866 or EventID=4867 or EventID=4868 or EventID=4870 or EventID=4882 or EventID=4885 or EventID=4890 or EventID=4892 or EventID=4896 or EventID=4906 or EventID=4907 or EventID=4908 or EventID=4912 or EventID=4960 or EventID=4961 or EventID=4962 or EventID=4963 or EventID=4965 or EventID=4976 or EventID=4977 or EventID=4978 or EventID=4983 or EventID=4984 or EventID=5027 or EventID=5028 or EventID=5029 or EventID=5030 or EventID=5035 or EventID=5037 or EventID=5038 or EventID=5120 or EventID=5121 or EventID=5122 or EventID=5123 or EventID=5376 or EventID=5377 or EventID=5453 or EventID=5480 or EventID=5483 or EventID=5484 or EventID=5485 or EventID=6145 or EventID=6273 or EventID=6274 or EventID=6275 or EventID=6276 or EventID=6277 or EventID=6278 or EventID=6279 or EventID=6280 or EventID=24586 or EventID=24592 or EventID=24593 or EventID=24594 or EventID=4608 or EventID=4609 or EventID=4610 or EventID=4611 or EventID=4612 or EventID=4614 or EventID=4615 or EventID=4616 or EventID=4622 or EventID=4624 or EventID=4625 or EventID=4634 or EventID=4646 or EventID=4647 or EventID=4648 or EventID=4650 or EventID=4651 or EventID=4652 or EventID=4653 or EventID=4654 or EventID=4655 or EventID=4656 or EventID=4657 or EventID=4658 or EventID=4659 or EventID=4660 or EventID=4661 or EventID=4662 or EventID=4663 or EventID=4664 or EventID=4665 or EventID=4666 or EventID=4667 or EventID=4668 or EventID=4670 or EventID=4671 or EventID=4672 or EventID=4673 or EventID=4674 or EventID=4688 or EventID=4689 or EventID=4690 or EventID=4691 or EventID=4694 or EventID=4695 or EventID=4696 or EventID=4697 or EventID=4698 or EventID=4699 or EventID=4700 or EventID=4701 or EventID=4702 or EventID=4704 or EventID=4705 or EventID=4707 or EventID=4709 or EventID=4710 or EventID=4711 or EventID=4712 or EventID=4717 or EventID=4718 or EventID=4720 or EventID=4722 or EventID=4723 or EventID=4725 or EventID=4726 or EventID=4728 or EventID=4729 or EventID=4730 or EventID=4731 or EventID=4732 or EventID=4733 or EventID=4734 or EventID=4738 or EventID=4740 or EventID=4741 or EventID=4742 or EventID=4743 or EventID=4744 or EventID=4745 or EventID=4746 or EventID=4747 or EventID=4748 or EventID=4749 or EventID=4750 or EventID=4751 or EventID=4752 or EventID=4753 or EventID=4756 or EventID=4757 or EventID=4758 or EventID=4759 or EventID=4760 or EventID=4761 or EventID=4762 or EventID=4767 or EventID=4768 or EventID=4769 or EventID=4770 or EventID=4771 or EventID=4772 or EventID=4774 or EventID=4775 or EventID=4776 or EventID=4777 or EventID=4778 or EventID=4779 or EventID=4781 or EventID=4782 or EventID=4783 or EventID=4784 or EventID=4785 or EventID=4786 or EventID=4787 or EventID=4788 or EventID=4789 or EventID=4790 or EventID=4793 or EventID=4800 or EventID=4801 or EventID=4802 or EventID=4803 or EventID=4864 or EventID=4869 or EventID=4871 or EventID=4872 or EventID=4873 or EventID=4874 or EventID=4875 or EventID=4876 or EventID=4877 or EventID=4878 or EventID=4879 or EventID=4880 or EventID=4881 or EventID=4883 or EventID=4884 or EventID=4886 or EventID=4887 or EventID=4888 or EventID=4889 or EventID=4891 or EventID=4893 or EventID=4894 or EventID=4895 or EventID=4898 or EventID=4902 or EventID=4904 or EventID=4905 or EventID=4909 or EventID=4910 or EventID=4928 or EventID=4929 or EventID=4930 or EventID=4931 or EventID=4932 or EventID=4933 or EventID=4934 or EventID=4935 or EventID=4936 or EventID=4937 or EventID=4944 or EventID=4945 or EventID=4946 or EventID=4947 or EventID=4948 or EventID=4949 or EventID=4950 or EventID=4951 or EventID=4952 or EventID=4953 or EventID=4954 or EventID=4956 or EventID=4957 or EventID=4958 or EventID=4979 or EventID=4980 or EventID=4981 or EventID=4982 or EventID=4985 or EventID=5024 or EventID=5025 or EventID=5031 or EventID=5032 or EventID=5033 or EventID=5034 or EventID=5039 or EventID=5040 or EventID=5041 or EventID=5042 or EventID=5043 or EventID=5044 or EventID=5045 or EventID=5046 or EventID=5047 or EventID=5048 or EventID=5050 or EventID=5051 or EventID=5056 or EventID=5057 or EventID=5058 or EventID=5059 or EventID=5060 or EventID=5061 or EventID=5062 or EventID=5063 or EventID=5064 or EventID=5065 or EventID=5066 or EventID=5067 or EventID=5068 or EventID=5069 or EventID=5070 or EventID=5125 or EventID=5126 or EventID=5127 or EventID=5136 or EventID=5137 or EventID=5138 or EventID=5139 or EventID=5140 or EventID=5141 or EventID=5152 or EventID=5153 or EventID=5154 or EventID=5155 or EventID=5156 or EventID=5157 or EventID=5158 or EventID=5159 or EventID=5378 or EventID=5440 or EventID=5441 or EventID=5442 or EventID=5443 or EventID=5444 or EventID=5446 or EventID=5447 or EventID=5448 or EventID=5449 or EventID=5450 or EventID=5451 or EventID=5452 or EventID=5456 or EventID=5457 or EventID=5458 or EventID=5459 or EventID=5460 or EventID=5461 or EventID=5462 or EventID=5463 or EventID=5464 or EventID=5465 or EventID=5466 or EventID=5467 or EventID=5468 or EventID=5471 or EventID=5472 or EventID=5473 or EventID=5474 or EventID=5477 or EventID=5479 or EventID=5632 or EventID=5633 or EventID=5712 or EventID=5888 or EventID=5889 or EventID=5890 or EventID=6008 or EventID=6144 or EventID=6272 or EventID=24577 or EventID=24578 or EventID=24579 or EventID=24580 or EventID=24581 or EventID=24582 or EventID=24583 or EventID=24584 or EventID=24588 or EventID=24595 or EventID=24621 or EventID=5049 or EventID=5478)]]</Select></Query></QueryList>
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

Add-Content $DCEssen $XMLDCEssentials


################################################## Configure Collector Server ###########################################################


write-host 'Configuring Collector Server..'

Invoke-Command -ScriptBlock {winrm quickconfig} 
Invoke-Command -ScriptBlock {net stop wecsvc}
Invoke-Command -ScriptBlock {net start wecsvc}
Invoke-Command -ScriptBlock {wecutil qc /quiet}
Invoke-Command -ScriptBlock {wecutil cs $DCEssen}

write-host 'Setting Forwarded Events Max Size to 4 GB..'

Set-Itemproperty -path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\ForwardedEvents' -Name 'MaxSize' -value '4294901760' 

}

#################################################### SQL Server Local #################################################################


function ConfigSQLServer {

$EvtTables = ('SecurityLog','SystemLog')
Invoke-Sqlcmd
if(Get-Module -Name "*Sql*") {
CD SQLSERVER:\sql\localhost\ 
$srv = get-item default 
$db = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Database -argumentlist $srv, "EventServerDB" 
$db.Create()
$ftc = New-Object -TypeName Microsoft.SqlServer.Management.SMO.FullTextCatalog -argumentlist $db, "FTS_Catalog"
$ftc.IsDefault = $true 
$ftc.Create()
Foreach ($Table in $EvtTables) 
    {    
$tb = New-Object -TypeName Microsoft.SqlServer.Management.SMO.Table -argumentlist $db, $Table
$Type = [Microsoft.SqlServer.Management.SMO.DataType]::NChar(50)    
$col1 =  New-Object -TypeName Microsoft.SqlServer.Management.SMO.Column -argumentlist $tb,"Id", ([Microsoft.SqlServer.Management.SMO.DataType]::int) 
$col2 =  New-Object -TypeName Microsoft.SqlServer.Management.SMO.Column -argumentlist $tb,"LevelDisplayName", ([Microsoft.SqlServer.Management.SMO.DataType]::varchar(255))
$col3 =  New-Object -TypeName Microsoft.SqlServer.Management.SMO.Column -argumentlist $tb,"LogName", ([Microsoft.SqlServer.Management.SMO.DataType]::varchar(255)) 
$col4 =  New-Object -TypeName Microsoft.SqlServer.Management.SMO.Column -argumentlist $tb,"MachineName", ([Microsoft.SqlServer.Management.SMO.DataType]::varchar(255))
$col5 =  New-Object -TypeName Microsoft.SqlServer.Management.SMO.Column -argumentlist $tb,"Message", ([Microsoft.SqlServer.Management.SMO.DataType]::varcharmax)
$col6 =  New-Object -TypeName Microsoft.SqlServer.Management.SMO.Column -argumentlist $tb,"Source", ([Microsoft.SqlServer.Management.SMO.DataType]::varchar(255)) 
$col7 =  New-Object -TypeName Microsoft.SqlServer.Management.SMO.Column -argumentlist $tb,"RecordID", ([Microsoft.SqlServer.Management.SMO.DataType]::bigint) 
$col8 =  New-Object -TypeName Microsoft.SqlServer.Management.SMO.Column -argumentlist $tb,"TaskDisplayName", ([Microsoft.SqlServer.Management.SMO.DataType]::varchar(255))
$col9 =  New-Object -TypeName Microsoft.SqlServer.Management.SMO.Column -argumentlist $tb,"TimeCreated", ([Microsoft.SqlServer.Management.SMO.DataType]::smalldatetime)   
$col1.Nullable = $false
$col1.Identity = $true  
$col1.IdentitySeed = 1  
$col1.IdentityIncrement = 1  
$col2.Nullable = $true
$col3.Nullable = $true
$col4.Nullable = $true
$col5.Nullable = $true
$col6.Nullable = $true
$col7.Nullable = $true
$col8.Nullable = $true
$col9.Nullable = $true
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
$icol0 = New-Object -TypeName Microsoft.SqlServer.Management.SMO.IndexedColumn -argumentlist $idx, "Id", $true 
$idx.IndexedColumns.Add($icol0)
$idx.IndexKeyType = [Microsoft.SqlServer.Management.SMO.IndexKeyType]::DriUniqueKey   
$idx.Create()
$idx = New-Object -TypeName Microsoft.SqlServer.Management.SMO.Index -argumentlist $tb, ('ClusteredIndex-'+$Table)
$icol1 = New-Object -TypeName Microsoft.SqlServer.Management.SMO.IndexedColumn -argumentlist $idx, "RecordID", $true 
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
}
else {Write-Host 'SQL Server Powershell Module NOT FOUND!'}
CD C:

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

}


#################################################### Creating de Task Scheduler #################################################################


Function CreateTask {

$PsScript = @'
$XMLQuery = @"
<QueryList>
  <Query Id="0" Path="ForwardedEvents">
    <Select Path="ForwardedEvents">*[System[TimeCreated[timediff(@SystemTime) &lt;= 3900000]]]</Select>
  </Query>
</QueryList>
"@

$events = Get-WinEvent -FilterXml $XMLQuery |  Select-Object ID, LevelDisplayName, LogName, MachineName, Message, ProviderName, RecordID, TaskDisplayName, TimeCreated  | ? {$_.LogName -eq 'System'}

$EvtServer = ((Get-WmiObject win32_computersystem).DNSHostName+"."+(Get-WmiObject win32_computersystem).Domain)

$connectionString = ('Data Source='+$EvtServer+';Integrated Security=true;Initial Catalog=EventServerDB;')

$bulkCopy = new-object ("Data.SqlClient.SqlBulkCopy") $connectionString
$bulkCopy.DestinationTableName = "SystemLog"
$dt = New-Object "System.Data.DataTable"

$cols = $events | select -first 1 | get-member -MemberType NoteProperty | select -Expand Name
foreach ($col in $cols)  {$null = $dt.Columns.Add($col)}
  
foreach ($event in $events)
  {
     $row = $dt.NewRow()
     foreach ($col in $cols) { $row.Item($col) = $event.$col }
     $dt.Rows.Add($row)
  }

$bulkCopy.WriteToServer($dt)

$events = Get-WinEvent -FilterXml $xml |  Select-Object ID, LevelDisplayName, LogName, MachineName, Message, ProviderName, RecordID, TaskDisplayName, TimeCreated  | ? {$_.LogName -eq 'Security'}

$connectionString = ('Data Source='+$EvtServer+';Integrated Security=true;Initial Catalog=EventServerDB;')
$bulkCopy = new-object ("Data.SqlClient.SqlBulkCopy") $connectionString
$bulkCopy.DestinationTableName = "SecurityLog"
$dt = New-Object "System.Data.DataTable"

$cols = $events | select -first 1 | get-member -MemberType NoteProperty | select -Expand Name
foreach ($col in $cols)  {$null = $dt.Columns.Add($col)}
  
foreach ($event in $events)
  {
     $row = $dt.NewRow()
     foreach ($col in $cols) { $row.Item($col) = $event.$col }
     $dt.Rows.Add($row)
  }

$bulkCopy.WriteToServer($dt)
'@

$PsScript | Out-File C:\EvtHF\DefaultScript.ps1

$user = [Security.Principal.WindowsIdentity]::GetCurrent()
$action = New-ScheduledTaskAction -Execute 'C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe' -Argument '-NoProfile -WindowStyle Hidden -command "& {C:\EvtHF\DefaultScript.ps1}"'
$trigger =  New-ScheduledTaskTrigger -Once -at (Get-Date) -RepetitionInterval (New-TimeSpan -Minutes 1)  -RepetitionDuration ([System.TimeSpan]::MaxValue)
$principal = New-ScheduledTaskPrincipal -UserId $user.Name -LogonType S4U -RunLevel Highest
$task = New-ScheduledTask -Action $action -Trigger $trigger -Principal $principal -Description "Hourly task to add Forwarded Events into de SQL Server Database. This Task was created automatically by the Hard Finger script (by Claudio Merola)"
Register-ScheduledTask "EventForwarders\DomainControllers-Essentials" -InputObject $task

}


#################################################### Running the Functions #################################################################


ConfigCollector
ConfigSQLServer
ConfigDCs
CreateTask
 

