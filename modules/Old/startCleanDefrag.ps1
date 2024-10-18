#$j = Start-Job -ScriptBlock {cleanmgr /sagerun:1}; $j | Wait-Job;
$j = Start-Job -ScriptBlock {defrag C: /O}; $j | Wait-Job;
$j = Start-Job -ScriptBlock {cdefrag.exe D: -o}; $j | Wait-Job;
$j = Start-Job -ScriptBlock {cdefrag.exe E: -o}; $j | Wait-Job;
$j = Start-Job -ScriptBlock {cdefrag.exe F: -o}; $j | Wait-Job;
$j = Start-Job -ScriptBlock {cdefrag.exe G: -o}; $j | Wait-Job;