# TheAlabaster92 (Antonio Martino) - v0.1.20200118
# Prev Version: 0.1.20180724
# Actual Version: 0.1.20200118

#Clear the receiving folders of old contents to actualize
rm -r -fo "F:\restore\Windows_Backup\User_Shortcuts";
rm -r -fo "F:\restore\Windows_Backup\System_Shortcuts";

#Recreates the folder structure
mkdir "F:\restore\Windows_Backup\User_Shortcuts";
mkdir "F:\restore\Windows_Backup\System_Shortcuts";

#Dumps the content of the actual System
robocopy "$env:userprofile\AppData\Roaming\Microsoft\Windows\Start Menu\Programs" "F:\restore\Windows_Backup\User_Shortcuts\" /E /B /MT:8 /R:1 /W:3 /LOG+:C:\UndeployLog.txt;
robocopy "C:\ProgramData\Microsoft\Windows\Start Menu\Programs" "F:\restore\Windows_Backup\System_Shortcuts\" /E /B /MT:8 /R:1 /W:3 /LOG+:C:\UndeployLog.txt;


#Dumps Programs to Data Storage
$list64 = dir -Directory "C:\Program Files\"
$list86 = dir -Directory "C:\Program Files (x86)\"
#$progData = dir -Directory "C:\ProgramData\"
foreach ($d in $list64) {robocopy "C:\Program Files\$($d.Name)" "E:\Program64\$($d.Name)" /E /B /MT:8 /R:1 /W:3 /LOG+:C:\UndeployLog.txt};
foreach ($d in $list86) {robocopy "C:\Program Files (x86)\$($d.Name)" "E:\Program86\$($d.Name)" /E /B /MT:8 /R:1 /W:3 /LOG+:C:\UndeployLog.txt};
#foreach ($d in $progData) {robocopy "C:\ProgramData\$($d.Name)" "E:\ProgramData\$($d.Name)" /E /B /MT:8 /R:1 /W:3 /LOG+:C:\UndeployLog.txt};

#Clean the backup from system files and tools
#x64
rm -r -fo "E:\Program64\Application Verifier";
rm -r -fo "E:\Program64\Common Files";
rm -r -fo "E:\Program64\dotnet";
rm -r -fo "E:\Program64\Intel";
rm -r -fo "E:\Program64\internet explorer";
rm -r -fo "E:\Program64\Microsoft Office";
rm -r -fo "E:\Program64\MSBuild";
rm -r -fo "E:\Program64\NTLite";
rm -r -fo "E:\Program64\NVIDIA Corporation";
rm -r -fo "E:\Program64\Realtek";
rm -r -fo "E:\Program86\Reference Assemblies";
rm -r -fo "E:\Program86\Temp";
rm -r -fo "E:\Program64\Windows Defender";
rm -r -fo "E:\Program64\Windows Mail";
rm -r -fo "E:\Program64\Windows Media Player";
rm -r -fo "E:\Program64\Windows Multimedia Platform";
rm -r -fo "E:\Program64\windows nt";
rm -r -fo "E:\Program64\Windows Photo Viewer";
rm -r -fo "E:\Program64\Windows Portable Devices";
rm -r -fo "E:\Program64\Windows Security";
rm -r -fo "E:\Program64\Windows Sidebar";
rm -r -fo "E:\Program64\WindowsApps";
rm -r -fo "E:\Program64\WindowsPowerShell";
#x86
rm -r -fo "E:\Program86\Application Verifier";
rm -r -fo "E:\Program86\Common Files";
rm -r -fo "E:\Program86\InstallShield Installation Information";
rm -r -fo "E:\Program86\Intel";
rm -r -fo "E:\Program86\Internet Explorer";
rm -r -fo "E:\Program86\Microsoft.NET";
rm -r -fo "E:\Program86\MSBuild";
rm -r -fo "E:\Program86\NVIDIA Corporation";
rm -r -fo "E:\Program86\Realtek";
rm -r -fo "E:\Program86\Reference Assemblies";
rm -r -fo "E:\Program86\Temp";
rm -r -fo "E:\Program86\Windows Defender";
rm -r -fo "E:\Program86\Windows Mail";
rm -r -fo "E:\Program86\Windows Media Player";
rm -r -fo "E:\Program86\Windows Multimedia Platform";
rm -r -fo "E:\Program86\windows nt";
rm -r -fo "E:\Program86\Windows Photo Viewer";
rm -r -fo "E:\Program86\Windows Portable Devices";
rm -r -fo "E:\Program64\Windows Sidebar";
rm -r -fo "E:\Program86\WindowsPowerShell";
#ProgramData
rm -r -fo "E:\ProgramData\Intel";
rm -r -fo "E:\ProgramData\Microsoft";
rm -r -fo "E:\ProgramData\Microsoft OneDrive";
rm -r -fo "E:\ProgramData\NVIDIA";
rm -r -fo "E:\ProgramData\NVIDIA Corporation";
rm -r -fo "E:\ProgramData\Package Cache";
rm -r -fo "E:\ProgramData\Packages";
rm -r -fo "E:\ProgramData\USOPrivate";
rm -r -fo "E:\ProgramData\USOShared";
rm -r -fo "E:\ProgramData\regid.1991-06.com.microsoft";

Write-Host "Undeply preparation completed, can now re-install Windows and run the deploy script to redeploy."
pause

# ChangeLog:
#   
#	0.1.20200512 - Fix paths to use F: unit
#	0.1.20200118 - Fixed Restore paths
#	0.1.20180724 - Switched from xcopy to robocopy
