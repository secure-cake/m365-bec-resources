#These are as example query/syntax, copy/paste/edit and run independently!
#For large-scale analysis, I rely on UAL export. But for "exploratory" operations, the queries below can be useful:
#Using EXOL PowerShell Module...you can query Exchange MessageTrace, with the MAJOR caveat that this is only valid for MT entries less than 10 days old
Get-MessageTrace -StartDate 12/12/2024 -EndDate 12/14/2024 -RecipientAddress user@yourdomain.com | select * | select received,senderaddress,recipientaddress,subject,fromip,status,messagetraceid
#You can also search the UAL for specific querstions, strings, indicators...remembering that UAL data is easily truncated so verify results!
Search-MailboxAuditLog -startdate 12/1/2024 -EndDate 12/12/2024 -identity user -ShowDetails -ResultSize 100
#Search for a specific operation, like "Update Inbox Rules"
Search-MailboxAuditLog -startdate 12/1/2024 -EndDate 12/12/2024 -ShowDetails -ResultSize 500 -Operations updateinboxrules
Search-UnifiedAuditLog -StartDate 1/1/2023 -EndDate 7/20/2023 -operations new-inboxrule -ResultSize 5000 | select userids
#Search for a specific operation, like a imoqie User Agent String
Search-UnifiedAuditLog -StartDate 12/1/2024 -EndDate 12/12/2024 -ResultSize 5000 | Select-Object -ExpandProperty AuditData | ConvertFrom-Json | Where-Object ExtendedProperties -like “*Mozilla*” | Select-Object workload,userid,extendedproperties
#Output All Inbox Rule Details to CSV...in large environments this is challenging/slow!
$mailboxes = get-mailbox -Identity * | select primarysmtpaddress
foreach ($mailbox in $mailboxes) {Get-InboxRule -mailbox $mailbox.primarysmtpaddress | select mailboxownerid,name,movetofolder,sentto,from,enabled | export-csv 'D:\Cases\your-case\inbox-rules.csv' -NoTypeInformation -append}
#Investigate Inbox Rules for a Single User
get-inboxrule –mailbox user@yourcompany.com | select * | export-csv 'D:\Cases\your-case\userxyz-inbox-rules.csv' -notypeinformation
#Export all Enterprise Apps ('service principals') and all Application (via Entra PowerShell Module)
Install-Module -Name Microsoft.Entra -Repository PSGallery -Scope CurrentUser -Force -AllowClobber
Connect-Entra
get-entraapplication -all | select displayname,appid | Sort-Object displayname | Export-Csv ..\entra-enterprise-apps-09122025.csv -NoTypeInformation
Get-EntraServicePrincipal -all | select displayname,appid | Sort-Object displayname | Export-Csv ..\entra-enterprise-spn-09122025.csv -NoTypeInformation
