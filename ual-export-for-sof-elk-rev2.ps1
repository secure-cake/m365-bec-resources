#From EXO PowerShell - Use script to export for ingestion into SOF-ELK
#Change path to desired output location and change name to reflect userID and date range, as desired
$OutputFile = ".\ual-userid-07012023-07202023.json"
#Enter "UserID" in quotes or leave as $null for all Users
#NOTE: "UserID" should match the mailbox "Alias," the part to the left of the @ symbol in their email address
$userids = $null
#Enter start search date in format mm-dd-yyyy
$StartSearchDate = get-date "12-10-2024”
#Enter start search date in format mm-dd-yyyy
$EndSearchDate = get-date "12-15-2024"
#NOTE: Max output is 5K entries per query. Default below is "30-minute" timeslots. You can reduce this number in very busy environments to ensure max results stay under 5K.
$ual_interval_minutes = "30"
$FormattedStartDate = Get-Date $EndSearchDate
$DaysToSearch = (new-timespan -start $StartSearchDate -End $EndSearchDate).days
For ($i=0; $i -le $DaysToSearch; $i++){
  For ($j=1440; $j -ge 0; $j -= $ual_interval_minutes){
    $StartDate = ($EndSearchDate.AddDays(-$i)).AddMinutes($j)
    $EndDate = ($EndSearchDate.AddDays(-$i)).AddMinutes($j + 30)
    $Audit = Search-UnifiedAuditLog -StartDate $StartDate -EndDate $EndDate -userIDs $userids -ResultSize 5000
$ConvertAudit = $Audit | select-object -expandproperty AuditData | out-file -encoding UTF8 $OutputFile -Append
Write-Host $StartDate $Audit.Count
  }
} 
