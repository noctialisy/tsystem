$logPathDism = "$($PSScriptRoot)\..\logs\dism.log";

$j = Start-Job -ScriptBlock {DISM /Online /Cleanup-Image /CheckHealth /LogPath:$input} -InputObject $logPathDism; $j | Wait-Job;
$j = Start-Job -ScriptBlock {DISM /Online /Cleanup-Image /ScanHealth/LogPath:$input} -InputObject $logPathDism; $j | Wait-Job;
$j = Start-Job -ScriptBlock {DISM /Online /Cleanup-Image /AnalyzeComponentStore/LogPath:$input} -InputObject $logPathDism; $j | Wait-Job;
$j = Start-Job -ScriptBlock {DISM /Online /Cleanup-Image /StartComponentCleanup/LogPath:$input} -InputObject $logPathDism; $j | Wait-Job;
$j = Start-Job -ScriptBlock {DISM /Online /Cleanup-Image /RestoreHealth/LogPath:$input} -InputObject $logPathDism; $j | Wait-Job;
$j = Start-Job -ScriptBlock {SFC /ScanNow}; $j | Wait-Job;