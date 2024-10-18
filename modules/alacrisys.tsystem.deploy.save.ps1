# TheAlabaster92 (Antonio Martino) - v0.1.20200118
# Prev Version: 0.1.20180724
# Actual Version: 0.1.20200118

#Clear the receiving folders of old contents to actualize
Remove-Item -r -fo "F:\restore\Windows_Backup\User_Shortcuts";
Remove-Item -r -fo "F:\restore\Windows_Backup\System_Shortcuts";

#Recreates the folder structure
mkdir "F:\restore\Windows_Backup\User_Shortcuts";
mkdir "F:\restore\Windows_Backup\System_Shortcuts";

#Dumps the content of the actual System
robocopy "$env:userprofile\AppData\Roaming\Microsoft\Windows\Start Menu\Programs" "F:\restore\Windows_Backup\User_Shortcuts\" /E /B /MT:8 /R:1 /W:3 /LOG+:C:\UndeployLog.txt;
robocopy "C:\ProgramData\Microsoft\Windows\Start Menu\Programs" "F:\restore\Windows_Backup\System_Shortcuts\" /E /B /MT:8 /R:1 /W:3 /LOG+:C:\UndeployLog.txt;


#Dumps Programs to Data Storage
$list64 = Get-ChildItem -Directory "C:\Program Files\"
$list86 = Get-ChildItem -Directory "C:\Program Files (x86)\"
#$progData = dir -Directory "C:\ProgramData\"
foreach ($d in $list64) {robocopy "C:\Program Files\$($d.Name)" "E:\Program64\$($d.Name)" /E /B /MT:8 /R:1 /W:3 /LOG+:C:\UndeployLog.txt};
foreach ($d in $list86) {robocopy "C:\Program Files (x86)\$($d.Name)" "E:\Program86\$($d.Name)" /E /B /MT:8 /R:1 /W:3 /LOG+:C:\UndeployLog.txt};
#foreach ($d in $progData) {robocopy "C:\ProgramData\$($d.Name)" "E:\ProgramData\$($d.Name)" /E /B /MT:8 /R:1 /W:3 /LOG+:C:\UndeployLog.txt};

#Clean the backup from system files and tools
#x64
Remove-Item -r -fo "E:\Program64\Application Verifier";
Remove-Item -r -fo "E:\Program64\Common Files";
Remove-Item -r -fo "E:\Program64\dotnet";
Remove-Item -r -fo "E:\Program64\Intel";
Remove-Item -r -fo "E:\Program64\internet explorer";
Remove-Item -r -fo "E:\Program64\Microsoft Office";
Remove-Item -r -fo "E:\Program64\MSBuild";
Remove-Item -r -fo "E:\Program64\NTLite";
Remove-Item -r -fo "E:\Program64\NVIDIA Corporation";
Remove-Item -r -fo "E:\Program64\Realtek";
Remove-Item -r -fo "E:\Program86\Reference Assemblies";
Remove-Item -r -fo "E:\Program86\Temp";
Remove-Item -r -fo "E:\Program64\Windows Defender";
Remove-Item -r -fo "E:\Program64\Windows Mail";
Remove-Item -r -fo "E:\Program64\Windows Media Player";
Remove-Item -r -fo "E:\Program64\Windows Multimedia Platform";
Remove-Item -r -fo "E:\Program64\windows nt";
Remove-Item -r -fo "E:\Program64\Windows Photo Viewer";
Remove-Item -r -fo "E:\Program64\Windows Portable Devices";
Remove-Item -r -fo "E:\Program64\Windows Security";
Remove-Item -r -fo "E:\Program64\Windows Sidebar";
Remove-Item -r -fo "E:\Program64\WindowsApps";
Remove-Item -r -fo "E:\Program64\WindowsPowerShell";
#x86
Remove-Item -r -fo "E:\Program86\Application Verifier";
Remove-Item -r -fo "E:\Program86\Common Files";
Remove-Item -r -fo "E:\Program86\InstallShield Installation Information";
Remove-Item -r -fo "E:\Program86\Intel";
Remove-Item -r -fo "E:\Program86\Internet Explorer";
Remove-Item -r -fo "E:\Program86\Microsoft.NET";
Remove-Item -r -fo "E:\Program86\MSBuild";
Remove-Item -r -fo "E:\Program86\NVIDIA Corporation";
Remove-Item -r -fo "E:\Program86\Realtek";
Remove-Item -r -fo "E:\Program86\Reference Assemblies";
Remove-Item -r -fo "E:\Program86\Temp";
Remove-Item -r -fo "E:\Program86\Windows Defender";
Remove-Item -r -fo "E:\Program86\Windows Mail";
Remove-Item -r -fo "E:\Program86\Windows Media Player";
Remove-Item -r -fo "E:\Program86\Windows Multimedia Platform";
Remove-Item -r -fo "E:\Program86\windows nt";
Remove-Item -r -fo "E:\Program86\Windows Photo Viewer";
Remove-Item -r -fo "E:\Program86\Windows Portable Devices";
Remove-Item -r -fo "E:\Program64\Windows Sidebar";
Remove-Item -r -fo "E:\Program86\WindowsPowerShell";
#ProgramData
Remove-Item -r -fo "E:\ProgramData\Intel";
Remove-Item -r -fo "E:\ProgramData\Microsoft";
Remove-Item -r -fo "E:\ProgramData\Microsoft OneDrive";
Remove-Item -r -fo "E:\ProgramData\NVIDIA";
Remove-Item -r -fo "E:\ProgramData\NVIDIA Corporation";
Remove-Item -r -fo "E:\ProgramData\Package Cache";
Remove-Item -r -fo "E:\ProgramData\Packages";
Remove-Item -r -fo "E:\ProgramData\USOPrivate";
Remove-Item -r -fo "E:\ProgramData\USOShared";
Remove-Item -r -fo "E:\ProgramData\regid.1991-06.com.microsoft";

Write-Host "Undeply preparation completed, can now re-install Windows and run the deploy script to redeploy."
pause

# ChangeLog:
#   
#	0.1.20200512 - Fix paths to use F: unit
#	0.1.20200118 - Fixed Restore paths
#	0.1.20180724 - Switched from xcopy to robocopy
