#Enable Tasks from Task Scheduler
get-scheduledtask |where-object {($_.state -eq "Ready") -and ($_.taskname -eq "Microsoft Compatibility Appraiser")}|enable-scheduledtask
get-scheduledtask |where-object {($_.state -eq "Ready") -and ($_.taskname -eq "ProgramDataUpdater")}|enable-scheduledtask
get-scheduledtask |where-object {($_.state -eq "Ready") -and ($_.taskname -eq "Proxy")}|enable-scheduledtask
get-scheduledtask |where-object {($_.state -eq "Ready") -and ($_.taskname -eq "Consolidator")}|enable-scheduledtask
get-scheduledtask |where-object {($_.state -eq "Ready") -and ($_.taskname -eq "KernelCeipTask")}|enable-scheduledtask
get-scheduledtask |where-object {($_.state -eq "Ready") -and ($_.taskname -eq "Uploader")}|enable-scheduledtask
get-scheduledtask |where-object {($_.state -eq "Ready") -and ($_.taskname -eq "UsbCeip")}|enable-scheduledtask
get-scheduledtask |where-object {($_.state -eq "Ready") -and ($_.taskname -eq "FamilySafetyMonitor")}|enable-scheduledtask
get-scheduledtask |where-object {($_.state -eq "Ready") -and ($_.taskname -eq "FamilySafetyRefresh")}|enable-scheduledtask
get-scheduledtask |where-object {($_.state -eq "Ready") -and ($_.taskname -eq "BfeOnServiceStartTypeChange")}|enable-scheduledtask
get-scheduledtask |where-object {($_.state -eq "Ready") -and ($_.taskname -eq "StartupAppTask")}|enable-scheduledtask
get-scheduledtask |where-object {($_.state -eq "Ready") -and ($_.taskname -eq "Proactive Scan")}|enable-scheduledtask
get-scheduledtask |where-object {($_.state -eq "Ready") -and ($_.taskname -eq "Scheduled")}|enable-scheduledtask
get-scheduledtask |where-object {($_.state -eq "Ready") -and ($_.taskname -eq "Microsoft-Windows-DiskDiagnosticDataCollector")}|enable-scheduledtask
get-scheduledtask |where-object {($_.state -eq "Ready") -and ($_.taskname -eq "Microsoft-Windows-DiskDiagnosticResolver")}|enable-scheduledtask
get-scheduledtask |where-object {($_.state -eq "Ready") -and ($_.taskname -eq "ScheduledDefrag")}|enable-scheduledtask
get-scheduledtask |where-object {($_.state -eq "Ready") -and ($_.taskname -eq "File History")}|enable-scheduledtask
get-scheduledtask |where-object {($_.state -eq "Ready") -and ($_.taskname -eq "WinSAT")}|enable-scheduledtask
get-scheduledtask |where-object {($_.state -eq "Ready") -and ($_.taskname -eq "Sqm-Tasks")}|enable-scheduledtask

get-scheduledtask |where-object {($_.state -eq "Ready") -and ($_.taskname -eq "ProcessMemoryDiagnosticEvents")}|enable-scheduledtask
get-scheduledtask |where-object {($_.state -eq "Ready") -and ($_.taskname -eq "RunFullMemoryDiagnostic")}|enable-scheduledtask
get-scheduledtask |where-object {($_.state -eq "Ready") -and ($_.taskname -eq "AnalyzeSystem")}|enable-scheduledtask
get-scheduledtask |where-object {($_.state -eq "Ready") -and ($_.taskname -eq "Verify-WinRE")}|enable-scheduledtask
get-scheduledtask |where-object {($_.state -eq "Ready") -and ($_.taskname -eq "RegIdleBackup")}|enable-scheduledtask
get-scheduledtask |where-object {($_.state -eq "Ready") -and ($_.taskname -eq "SR")}|enable-scheduledtask
get-scheduledtask |where-object {($_.state -eq "Ready") -and ($_.taskname -eq "ResolutionHost")}|enable-scheduledtask
get-scheduledtask |where-object {($_.state -eq "Ready") -and ($_.taskname -eq "WinSAT")}|enable-scheduledtask

get-scheduledtask |where-object {($_.state -eq "Ready") -and ($_.taskname -eq "Smartscreenspecific")}|enable-scheduledtask
get-scheduledtask |where-object {($_.state -eq "Ready") -and ($_.taskname -eq "DmClient")}|enable-scheduledtask
get-scheduledtask |where-object {($_.state -eq "Ready") -and ($_.taskname -eq "QueueReporting")}|enable-scheduledtask
get-scheduledtask |where-object {($_.state -eq "Ready") -and ($_.taskname -eq "Automatic App Update")}|enable-scheduledtask
get-scheduledtask |where-object {($_.state -eq "Ready") -and ($_.taskname -eq "WiFiTask")}|enable-scheduledtask
