$conf = $args[0];

if ($conf -eq "on") {
  get-scheduledtask |where-object {($_.state -eq "Disabled") -and ($_.taskname -eq "Office Automatic Updates")}|enable-scheduledtask
  get-scheduledtask |where-object {($_.state -eq "Disabled") -and ($_.taskname -eq "Office ClickToRun Service Monitor")}|enable-scheduledtask
  get-scheduledtask |where-object {($_.state -eq "Disabled") -and ($_.taskname -eq "Office Subscription Maintenance")}|enable-scheduledtask
  get-scheduledtask |where-object {($_.state -eq "Disabled") -and ($_.taskname -eq "OfficeBackgroundTaskHandlerLogon")}|enable-scheduledtask
  get-scheduledtask |where-object {($_.state -eq "Disabled") -and ($_.taskname -eq "OfficeBackgroundTaskHandlerRegistration")}|enable-scheduledtask
  get-scheduledtask |where-object {($_.state -eq "Disabled") -and ($_.taskname -eq "OfficeTelemetryAgentFallBack2016")}|enable-scheduledtask
  get-scheduledtask |where-object {($_.state -eq "Disabled") -and ($_.taskname -eq "OfficeTelemetryAgentLogOn2016")}|enable-scheduledtask
} elseif ($conf -eq "off") {
  get-scheduledtask |where-object {($_.state -eq "Ready") -and ($_.taskname -eq "Office Automatic Updates")}|disable-scheduledtask
  get-scheduledtask |where-object {($_.state -eq "Ready") -and ($_.taskname -eq "Office ClickToRun Service Monitor")}|disable-scheduledtask
  get-scheduledtask |where-object {($_.state -eq "Ready") -and ($_.taskname -eq "Office Subscription Maintenance")}|disable-scheduledtask
  get-scheduledtask |where-object {($_.state -eq "Ready") -and ($_.taskname -eq "OfficeBackgroundTaskHandlerLogon")}|disable-scheduledtask
  get-scheduledtask |where-object {($_.state -eq "Ready") -and ($_.taskname -eq "OfficeBackgroundTaskHandlerRegistration")}|disable-scheduledtask
  get-scheduledtask |where-object {($_.state -eq "Ready") -and ($_.taskname -eq "OfficeTelemetryAgentFallBack2016")}|disable-scheduledtask
  get-scheduledtask |where-object {($_.state -eq "Ready") -and ($_.taskname -eq "OfficeTelemetryAgentLogOn2016")}|disable-scheduledtask
} else {
  Write-Host "Nothing specified";
}