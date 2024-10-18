# TheAlabaster92 (Antonio Martino) - v2020.0118.1848
# Prev Version: 2018.0220.1352
# Actual Version: 2020.0118.1848

$scheduleTweaks = 0;

#Add stuff to PATH Variable
$oldPath = (Get-ItemProperty -Path "Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment" -Name PATH).Path
#$oldModulePath = (Get-ItemProperty -Path "Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment" -Name PSModulePath).Path
$newPath = $oldPath + ";C:\Windows;C:\Windows\system32;C:\Windows\System32\OpenSSH\;C:\Windows\System32\Wbem;C:\Windows\System32\WindowsPowerShell\v1.0\;E:\dns\bin;E:\Program64\Defraggler;E:\Program64\Java\jdk-14\bin;E:\Program64\Notepad++\;E:\Program86\Nmap\;E:\xampp\php;E:\xampp\mysql\bin;F:\workspace_global\tools\tsystem\modules;F:\workspace_global\tools\SDK\Python27;F:\workspace_global\tools\SDK\GnuWin32\bin;F:\workspace_global\tools\PSTools;C:\Program Files\dotnet\;C:\Program Files\Git\cmd;C:\Program Files\NVIDIA Corporation\NVIDIA NvDLISR;C:\Program Files (x86)\Android\android-sdk\platform-tools;C:\Program Files (x86)\NVIDIA Corporation\PhysX\Common;"
$newModulePath = "C:\Program Files\WindowsPowerShell\Modules;c:\windows\system32\windowspowershell\v1.0\Modules;F:\WorkSpace_Global\Tools\TSystem\Modules"
Set-ItemProperty -Path "Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment" -Name PATH -Value $newPath
Set-ItemProperty -Path "Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment" -Name PSModulePath -Value $newModulePath

#Restore shortcuts to programs in Start menu
robocopy "F:\restore\Windows_Backup\System_Shortcuts" "C:\ProgramData\Microsoft\Windows\Start Menu\Programs" /E /B /MT:8 /R:1 /W:3 /LOG+:C:\TSDeployLog.txt;

#Restore AppData Shortcuts
robocopy "F:\restore\Windows_Backup\User_Shortcuts" "$env:userprofile\AppData\Roaming\Microsoft\Windows\Start Menu\Programs" /E /B /MT:8 /R:1 /W:3;

#MakeLinks
$list64 = Get-ChildItem -Directory "E:\Program64\"
$list86 = Get-ChildItem -Directory "E:\Program86\"
$progData = Get-ChildItem -Directory "E:\ProgramData"
foreach ($d in $list64) {cmd /c mklink /j "C:\Program Files\$($d.Name)" "E:\Program64\$($d.Name)"};
foreach ($d in $list86) {cmd /c mklink /j "C:\Program Files (x86)\$($d.Name)" "E:\Program86\$($d.Name)"}
foreach ($d in $progData) {cmd /c mklink /j "C:\ProgramData\$($d.Name)" "E:\ProgramData\$($d.Name)"}

#Restoring RegBackup to Tweak TCP/IP and Superfetch
#Disabled since 01/052017 - Better overall performances if prefetch/superfetch runs at boot to bring data into the RAM.
#regedit.exe /s "E:\Files\Documents\Tools\Scripts\Regedit\PostInstall-PrefetchSuperfetch.reg"
regedit.exe /s ".\Reg\setNetworkGamingProfile.reg"
regedit.exe /s ".\Reg\setSystemProfilePerformance.reg"
regedit.exe /s ".\Reg\setCrashControl.reg"
regedit.exe /s ".\Reg\setMaintenanceDisabled.reg"
regedit.exe /s ".\Reg\setPowerSettings.reg"

#Disable Tasks from Task Scheduler
if ($scheduleTweaks) {
	setScheduledTasksDisabled; #Has to be executed with path since new installation.
}

#compact the os
compact.exe /CompactOS:always

Write-Host "All Settings completed. Is suggested to run a maintenance to improve overall performances."
pause

# ChangeLog:
#
#	2020.0512.2334 - Fix module path
#	2020.0313.1408:
#	Change PSModulePath to add standard module path	
#
#	2020.0118.1848:
#	Fixed Paths and procedures for new backup structure	
#
#	2018.0220.1352:
#   Outsourced some code;
#   Added variable to set scheduled tasks;
#   Deleted old procedures;