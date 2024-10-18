$j = Start-Job -ScriptBlock {SFC /ScanNow}; $j | Wait-Job;
$j = Start-Job -ScriptBlock {DISM /Online /Cleanup-Image /CheckHealth}; $j | Wait-Job;
$j = Start-Job -ScriptBlock {DISM /Online /Cleanup-Image /ScanHealth}; $j | Wait-Job;
$j = Start-Job -ScriptBlock {DISM /Online /Cleanup-Image /AnalyzeComponentStore}; $j | Wait-Job;
$j = Start-Job -ScriptBlock {DISM /Online /Cleanup-Image /StartComponentCleanup}; $j | Wait-Job;
$j = Start-Job -ScriptBlock {DISM /Online /Cleanup-Image /RestoreHealth}; $j | Wait-Job;