$logFileName = "ActualSoftwareListScript.txt";
$logPath = "$($PSScriptRoot)\..\logs\$($logFileName)";
Remove-Item "$($logPath)";

$programList = Get-ItemProperty "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*" | Select-Object DisplayName, DisplayVersion;
Write-Output $programList >> "$($logPath)";

$i = 0;
while ($i -le $programList.Length) {
    if ($programList[$i].DisplayName -and $programList[$i].DisplayVersion) {
        $name = $programList[$i].DisplayName;
        $version = $programList[$i].DisplayVersion;
        Write-Output "$($name)|$($version)" >> "$($logPath)";
    }
    $i++;
}
"EOF|0.0.0" >> "$($logPath)";

#Remove-Item "$($logPath)";