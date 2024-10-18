$j = Start-Job -ScriptBlock {defrag C: /O}; $j | Wait-Job;

#Other drives to optimize
#$j = Start-Job -ScriptBlock {df64.exe F: /QD}; $j | Wait-Job;
#$j = Start-Job -ScriptBlock {df64.exe G: /QD}; $j | Wait-Job;