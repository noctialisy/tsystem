$logPath = "$($PSScriptRoot)\..\logs\Dism.log";

$j = Start-Job -ScriptBlock {DISM /Online /Cleanup-Image /CheckHealth /LogPath:$input} -InputObject $logPath; $j | Wait-Job;
$j = Start-Job -ScriptBlock {DISM /Online /Cleanup-Image /ScanHealth/LogPath:$input} -InputObject $logPath; $j | Wait-Job;
$j = Start-Job -ScriptBlock {DISM /Online /Cleanup-Image /AnalyzeComponentStore/LogPath:$input} -InputObject $logPath; $j | Wait-Job;
$j = Start-Job -ScriptBlock {DISM /Online /Cleanup-Image /StartComponentCleanup/LogPath:$input} -InputObject $logPath; $j | Wait-Job;
$j = Start-Job -ScriptBlock {DISM /Online /Cleanup-Image /RestoreHealth/LogPath:$input} -InputObject $logPath; $j | Wait-Job;
$j = Start-Job -ScriptBlock {SFC /ScanNow}; $j | Wait-Job;