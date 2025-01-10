#Check Mailbox Details and Inbox Rules for Mailboxes of Interest:
#[First auth to Exchange Online via PowerShell! – connect-exchangeonline]
#To overcome truncated output…
$formatenumerationlimit=-1
Get-Mailbox -identity sallysmith | select identity,litigationholdenabled,protocolsettings,antispambypassenabled,userprincipalname,auditowner,whenmailboxcreated,accountdisabled,emailaddresses | out-string -width 1000
Get-InboxRule -mailbox pc@securecake.com | Select *

#Output All Inbox Rule Details to CSV:
$mailboxes = get-mailbox -Identity * | select primarysmtpaddress
foreach ($mailbox in $mailboxes) {Get-InboxRule -mailbox $mailbox.primarysmtpaddress | select mailboxownerid,name,movetofolder,sentto,from,enabled | export-csv 'D:\Cases\2023-0829-abc\inbox-rules.csv' -NoTypeInformation -append}

#For Mailboxes of Interest, Export ALL Inbox Rules with Details:
get-inboxrule –mailbox userxyz@company.com | select * | export-csv ‘D:\Cases\2023-0829-abc\userxyz-inbox-rules.csv -notypeinformation

#Search Mailbox Audit Log: 
#NOTE: Inbox Rule operations = updateinboxrules (all I saw in testing anyhow)
Search-MailboxAuditLog -StartDate 01/06/2020 -EndDate 01/20/2020 -Identity <user> -Operations MailItemsAccessed -ResultSize 10000 -ShowDetails | Where {$_.OperationProperties -like "*MailAccessType:Sync*"} | FL
#Sync Context Identifiers: clientinfostring; clientipaddress; sessionid; userid

#Search a specific identity and specific operation: 
Search-MailboxAuditLog -identity pc@securecake.com -showdetails -ResultSize 500 -operations updateinboxrules

#Options for Searching UAL for “rule” related entries: 
search-unifiedAuditLog -userids pc -startdate 11/01/2022 -enddate 12/9/2023 | where {$_.operations -like "*rule*"} | select *

#Create a list of user accounts, userids.txt...then search “rule” operations for those accounts
$userids = get-content userids.txt
foreach ($userid in $userids){search-unifiedAuditLog -userids $userid -startdate 11/01/2022 -enddate 12/9/2023 | where {$_.operations -like "*rule*"} | select *}
