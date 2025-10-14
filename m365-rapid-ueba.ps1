#Connect and authenticate!
Connect-Exchangeonline

#Check for Inbox Rules in the Sus Mailbox
Get-InboxRule -mailbox sususer@companyxyz.com | select *

#Populate a variable with Sus User UAL Data, set the dates accordingly (smallish ragnge if possible, remember "rapid")
$sususerual = Search-unifiedAuditLog -startdate 10/10/2025 -enddate 10/15/2025 -UserIds sususer -resultsize 5000

#Query Sus User UAL data for "Client IP" frequency of occurrence for Auth-Related Events
$sususerual | Select-Object -ExpandProperty auditdata | convertfrom-json | where-object workload -eq azureactivedirectory | select-object clientip | group-object clientip | Select-Object name,count | sort -Property count

#Query Sus User UAL data for "User Agent" frequency of occurrence for Auth-Related Events
$sususerual | Select-Object -ExpandProperty auditdata | convertfrom-json | where-object workload -eq azureactivedirectory | Select -ExpandProperty extendedproperties | where name -eq Useragent | Group-Object value | select count,name | sort -property count
