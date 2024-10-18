# TheAlabaster92 (Antonio Martino) - v20171110.1012
# Prev Version: 1.2.0.20170501
# Actual Version: 2018.0220.1352
# ChangeLog:
#   Outsourced some code;
#   Added variable to set scheduled tasks;
#   Deleted old procedures;

$scheduleTweaks = 0;

#Add stuff to PATH Variable
$oldPath = (Get-ItemProperty -Path "Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment" -Name PATH).Path
$oldModulePath = (Get-ItemProperty -Path "Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment" -Name PSModulePath).Path
$newPath = $oldPath + ";G:\Program64\Defraggler;G:\Program86\Auslogics\DD;G:\Program64\Java\jdk1.8.0_102\bin;G:\Program64\Notepad++\;G:\Program86\Nmap\;G:\TSystem\Modules;G:\Workspace_Global\Tools\SDK\Python27"
$newModulePath = $oldModulePath + "G:\TSystem\Modules"
Set-ItemProperty -Path "Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment" -Name PATH -Value $newPath
Set-ItemProperty -Path "Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment" -Name PSModulePath -Value $newModulePath

#Restore shortcuts to programs in Start menu
robocopy "G:\Restore\OW.ProgramData.Shortcuts" "C:\ProgramData\Microsoft\Windows\Start Menu\Programs" /E /B /MT:8 /R:1 /W:3 /LOG+:C:\TSDeployLog.txt;

#Restore AppData Shortcuts
robocopy "G:\Restore\OW.AppData.Shortcuts" "$env:userprofile\AppData\Roaming\Microsoft\Windows\Start Menu\Programs" /E /B /MT:8 /R:1 /W:3;

#Restore desktop workspace
robocopy "G:\Restore\OW.Desktop" "$env:userprofile\Desktop" /E /B /MT:8 /R:1 /W:3 /LOG+:C:\TSDeployLog.txt;

#Restore AppData
$listAppDataLocal = dir -Directory "G:\Restore\OW.AppData\Local";
$listAppDataLocalLow = dir -Directory "G:\Restore\OW.AppData\LocalLow";
$listAppDataRoaming = dir -Directory "G:\Restore\OW.AppData\Roaming";
foreach ($directory in $listAppDataLocal) {if (-NOT (Test-Path -Path $directory)) {robocopy "G:\Restore\OW.AppData\Local\$($directory)" "$env:userprofile\AppData\Local" /E /B /MT:8 /R:1 /W:3;} };
foreach ($directory in $listAppDataLocalLow) {if (-NOT (Test-Path -Path $directory)) {robocopy "G:\Restore\OW.AppData\LocalLow\$($directory)" "$env:userprofile\AppData\LocalLow" /E /B /MT:8 /R:1 /W:3;} };
foreach ($directory in $listAppDataRoaming) {if (-NOT (Test-Path -Path $directory)) {robocopy "G:\Restore\OW.AppData\Roaming\$($directory)" "$env:userprofile\AppData\Roaming" /E /B /MT:8 /R:1 /W:3;} };

#Restore Dns-Server
robocopy "G:\Restore\OW.DNS-Server" "C:\DNS-Server" /E /B /MT:8 /R:1 /W:3;

#MakeLinks
$list64 = dir -Directory "G:\Program64\"
$list86 = dir -Directory "G:\Program86\"
$progData = dir -Directory "G:\ProgramData"
foreach ($d in $list64) {cmd /c mklink /j "C:\Program Files\$($d.Name)" "G:\Program64\$($d.Name)"};
foreach ($d in $list86) {cmd /c mklink /j "C:\Program Files (x86)\$($d.Name)" "G:\Program86\$($d.Name)"}
foreach ($d in $progData) {cmd /c mklink /j "C:\ProgramData\$($d.Name)" "G:\ProgramData\$($d.Name)"}

#Restoring RegBackup to Tweak TCP/IP and Superfetch
#Disabled since 01/052017 - Better overall performances if prefetch/superfetch runs at boot to bring data into the RAM.
#regedit.exe /s "G:\Files\Documents\Tools\Scripts\Regedit\PostInstall-PrefetchSuperfetch.reg"
regedit.exe /s "..\setNetworkGamingProfile.reg"
regedit.exe /s "..\setSystemProfilePerformance.reg"
regedit.exe /s "..\setCrashControl.reg"
regedit.exe /s "..\setMaintenanceDisabled.reg"

#Disable Tasks from Task Scheduler
if ($scheduleTweaks) {
	./"G:\TSystem\Modules\setScheduledTasksDisabled" #Has to be executed with path since new installation.
}

#compact the os
compact.exe /CompactOS:always

Write-Host "All Settings completed. Is suggested to run a maintenance to improve overall performances."
pause