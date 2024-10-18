# TheAlabaster92 (Antonio Martino) - v0.1.20180724
# Prev Version: 0.0.20180714
# Actual Version: 0.1.20180724
# ChangeLog:
#   Switched from xcopy to robocopy

#Clear the receiving folders of old contents to actualize
rm -r -fo "G:\Restore\OW.ProgramData.Shortcuts";
rm -r -fo "G:\Restore\OW.Desktop";
rm -r -fo "G:\Restore\OW.AppData";
rm -r -fo "G:\Restore\OW.AppData.Shortcuts";
rm -r -fo "G:\Restore\OW.DNS-Server";

#Recreates the folder structure
mkdir "G:\Restore\OW.ProgramData.Shortcuts";
mkdir "G:\Restore\OW.Desktop";
mkdir "G:\Restore\OW.AppData";
mkdir "G:\Restore\OW.AppData.Shortcuts";
mkdir "G:\Restore\OW.DNS-Server";

#Dumps the content of the actual System
robocopy "$env:userprofile\Desktop" "G:\Restore\OW.Desktop" /E /B /MT:8 /R:1 /W:3 /LOG+:C:\UndeployLog.txt;
robocopy "$env:userprofile\AppData" "G:\Restore\OW.AppData" /E /B /MT:8 /R:1 /W:3 /LOG+:C:\UndeployLog.txt /XD "$env:userprofile\AppData\Local\Application Data" /XD "$env:userprofile\AppData\Local\Temp" /XD "$env:userprofile\AppData\Local\History" /XD "$env:userprofile\AppData\Local\Temporary Internet Files";
robocopy "$env:userprofile\AppData\Roaming\Microsoft\Windows\Start Menu\Programs" "G:\Restore\OW.AppData.Shortcuts" /E /B /MT:8 /R:1 /W:3 /LOG+:C:\UndeployLog.txt;
robocopy "C:\ProgramData\Microsoft\Windows\Start Menu\Programs" "G:\Restore\OW.ProgramData.Shortcuts" /E /B /MT:8 /R:1 /W:3 /LOG+:C:\UndeployLog.txt;
robocopy "C:\DNS-Server" "G:\Restore\OW.DNS-Server" /E /B /MT:8 /R:1 /W:3 /LOG+:C:\UndeployLog.txt;

#Dumps Programs to Data Storage
$list64 = dir -Directory "C:\Program Files\"
$list86 = dir -Directory "C:\Program Files (x86)\"
$progData = dir -Directory "C:\ProgramData\"
foreach ($d in $list64) {robocopy "C:\Program Files\$($d.Name)" "G:\Program64\$($d.Name)" /E /B /MT:8 /R:1 /W:3 /LOG+:C:\UndeployLog.txt};
foreach ($d in $list86) {robocopy "C:\Program Files (x86)\$($d.Name)" "G:\Program86\$($d.Name)" /E /B /MT:8 /R:1 /W:3 /LOG+:C:\UndeployLog.txt};
foreach ($d in $progData) {robocopy "C:\ProgramData\$($d.Name)" "G:\ProgramData\$($d.Name)" /E /B /MT:8 /R:1 /W:3 /LOG+:C:\UndeployLog.txt};

#Clean the backup from system files and tools
#x64
rm -r -fo "G:\Program64\Application Verifier";
rm -r -fo "G:\Program64\Common Files";
rm -r -fo "G:\Program64\dotnet";
rm -r -fo "G:\Program64\Intel";
rm -r -fo "G:\Program64\internet explorer";
rm -r -fo "G:\Program64\Microsoft Office";
rm -r -fo "G:\Program64\MSBuild";
rm -r -fo "G:\Program64\NTLite";
rm -r -fo "G:\Program64\NVIDIA Corporation";
rm -r -fo "G:\Program64\Realtek";
rm -r -fo "G:\Program86\Reference Assemblies";
rm -r -fo "G:\Program86\Temp";
rm -r -fo "G:\Program64\Windows Defender";
rm -r -fo "G:\Program64\Windows Mail";
rm -r -fo "G:\Program64\Windows Media Player";
rm -r -fo "G:\Program64\Windows Multimedia Platform";
rm -r -fo "G:\Program64\windows nt";
rm -r -fo "G:\Program64\Windows Photo Viewer";
rm -r -fo "G:\Program64\Windows Portable Devices";
rm -r -fo "G:\Program64\Windows Security";
rm -r -fo "G:\Program64\Windows Sidebar";
rm -r -fo "G:\Program64\WindowsApps";
rm -r -fo "G:\Program64\WindowsPowerShell";
#x86
rm -r -fo "G:\Program86\Application Verifier";
rm -r -fo "G:\Program86\Common Files";
rm -r -fo "G:\Program86\InstallShield Installation Information";
rm -r -fo "G:\Program86\Intel";
rm -r -fo "G:\Program86\Internet Explorer";
rm -r -fo "G:\Program86\Microsoft.NET";
rm -r -fo "G:\Program86\MSBuild";
rm -r -fo "G:\Program86\NVIDIA Corporation";
rm -r -fo "G:\Program86\Realtek";
rm -r -fo "G:\Program86\Reference Assemblies";
rm -r -fo "G:\Program86\Temp";
rm -r -fo "G:\Program86\Windows Defender";
rm -r -fo "G:\Program86\Windows Mail";
rm -r -fo "G:\Program86\Windows Media Player";
rm -r -fo "G:\Program86\Windows Multimedia Platform";
rm -r -fo "G:\Program86\windows nt";
rm -r -fo "G:\Program86\Windows Photo Viewer";
rm -r -fo "G:\Program86\Windows Portable Devices";
rm -r -fo "G:\Program64\Windows Sidebar";
rm -r -fo "G:\Program86\WindowsPowerShell";
#ProgramData
rm -r -fo "G:\ProgramData\Intel";
rm -r -fo "G:\ProgramData\Microsoft";
rm -r -fo "G:\ProgramData\Microsoft OneDrive";
rm -r -fo "G:\ProgramData\NVIDIA";
rm -r -fo "G:\ProgramData\NVIDIA Corporation";
rm -r -fo "G:\ProgramData\Package Cache";
rm -r -fo "G:\ProgramData\Packages";
rm -r -fo "G:\ProgramData\USOPrivate";
rm -r -fo "G:\ProgramData\USOShared";
rm -r -fo "G:\ProgramData\regid.1991-06.com.microsoft";

Write-Host "Undeply preparation completed, can now re-install Windows and run the deploy script to redeploy."
pause
