$conf = $args[0];

if ($conf -eq "on") {
  Get-Service | ? {$_.Name -eq "WTabletServicePro"} | Set-Service -StartupType Automatic
  Start-Service "WTabletServicePro"
} elseif ($conf -eq "off") {
  Stop-Service "WTabletServicePro"
  Get-Service | ? {$_.Name -eq "WTabletServicePro"} | Set-Service -StartupType Disabled
} else {
  Write-Host "Nothing specified";
}