Remove-Item "$($PSScriptRoot)\ActualSoftwareListScript.txt";

$programList = Get-ItemProperty "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*" | Select-Object DisplayName, DisplayVersion;
Write-Output $programList >> "$($PSScriptRoot)\ActualSoftwareList.txt";

$i = 0;
while ($i -le $programList.Length) {
    if ($programList[$i].DisplayName -and $programList[$i].DisplayVersion) {
        $name = $programList[$i].DisplayName;
        $version = $programList[$i].DisplayVersion;
        Write-Output "$($name)|$($version)" >> "$($PSScriptRoot)\ActualSoftwareListScript.txt";
    }
    $i++;
}
"EOF|0.0.0" >> "$($PSScriptRoot)\ActualSoftwareListScript.txt";

Remove-Item "$($PSScriptRoot)\ActualSoftwareList.txt";