#Enable Tasks from Task Scheduler
get-scheduledtask |where-object {($_.state -eq "Ready") -and ($_.taskname -eq "Microsoft Compatibility Appraiser")}|disable-scheduledtask
get-scheduledtask |where-object {($_.state -eq "Ready") -and ($_.taskname -eq "ProgramDataUpdater")}|disable-scheduledtask
get-scheduledtask |where-object {($_.state -eq "Ready") -and ($_.taskname -eq "Proxy")}|disable-scheduledtask
get-scheduledtask |where-object {($_.state -eq "Ready") -and ($_.taskname -eq "Consolidator")}|disable-scheduledtask
get-scheduledtask |where-object {($_.state -eq "Ready") -and ($_.taskname -eq "KernelCeipTask")}|disable-scheduledtask
get-scheduledtask |where-object {($_.state -eq "Ready") -and ($_.taskname -eq "Uploader")}|disable-scheduledtask
get-scheduledtask |where-object {($_.state -eq "Ready") -and ($_.taskname -eq "UsbCeip")}|disable-scheduledtask
get-scheduledtask |where-object {($_.state -eq "Ready") -and ($_.taskname -eq "FamilySafetyMonitor")}|disable-scheduledtask
get-scheduledtask |where-object {($_.state -eq "Ready") -and ($_.taskname -eq "FamilySafetyRefresh")}|disable-scheduledtask
get-scheduledtask |where-object {($_.state -eq "Ready") -and ($_.taskname -eq "BfeOnServiceStartTypeChange")}|disable-scheduledtask
get-scheduledtask |where-object {($_.state -eq "Ready") -and ($_.taskname -eq "StartupAppTask")}|disable-scheduledtask
get-scheduledtask |where-object {($_.state -eq "Ready") -and ($_.taskname -eq "Proactive Scan")}|disable-scheduledtask
get-scheduledtask |where-object {($_.state -eq "Ready") -and ($_.taskname -eq "Scheduled")}|disable-scheduledtask
get-scheduledtask |where-object {($_.state -eq "Ready") -and ($_.taskname -eq "Microsoft-Windows-DiskDiagnosticDataCollector")}|disable-scheduledtask
get-scheduledtask |where-object {($_.state -eq "Ready") -and ($_.taskname -eq "Microsoft-Windows-DiskDiagnosticResolver")}|disable-scheduledtask
get-scheduledtask |where-object {($_.state -eq "Ready") -and ($_.taskname -eq "ScheduledDefrag")}|disable-scheduledtask
get-scheduledtask |where-object {($_.state -eq "Ready") -and ($_.taskname -eq "File History")}|disable-scheduledtask
get-scheduledtask |where-object {($_.state -eq "Ready") -and ($_.taskname -eq "WinSAT")}|disable-scheduledtask
get-scheduledtask |where-object {($_.state -eq "Ready") -and ($_.taskname -eq "Sqm-Tasks")}|disable-scheduledtask

get-scheduledtask |where-object {($_.state -eq "Ready") -and ($_.taskname -eq "ProcessMemoryDiagnosticEvents")}|disable-scheduledtask
get-scheduledtask |where-object {($_.state -eq "Ready") -and ($_.taskname -eq "RunFullMemoryDiagnostic")}|disable-scheduledtask
get-scheduledtask |where-object {($_.state -eq "Ready") -and ($_.taskname -eq "AnalyzeSystem")}|disable-scheduledtask
get-scheduledtask |where-object {($_.state -eq "Ready") -and ($_.taskname -eq "Verify-WinRE")}|disable-scheduledtask
get-scheduledtask |where-object {($_.state -eq "Ready") -and ($_.taskname -eq "RegIdleBackup")}|disable-scheduledtask
get-scheduledtask |where-object {($_.state -eq "Ready") -and ($_.taskname -eq "SR")}|disable-scheduledtask
get-scheduledtask |where-object {($_.state -eq "Ready") -and ($_.taskname -eq "ResolutionHost")}|disable-scheduledtask
get-scheduledtask |where-object {($_.state -eq "Ready") -and ($_.taskname -eq "WinSAT")}|disable-scheduledtask

get-scheduledtask |where-object {($_.state -eq "Ready") -and ($_.taskname -eq "Smartscreenspecific")}|disable-scheduledtask
get-scheduledtask |where-object {($_.state -eq "Ready") -and ($_.taskname -eq "DmClient")}|disable-scheduledtask
get-scheduledtask |where-object {($_.state -eq "Ready") -and ($_.taskname -eq "QueueReporting")}|disable-scheduledtask
get-scheduledtask |where-object {($_.state -eq "Ready") -and ($_.taskname -eq "Automatic App Update")}|disable-scheduledtask
get-scheduledtask |where-object {($_.state -eq "Ready") -and ($_.taskname -eq "WiFiTask")}|disable-scheduledtask
