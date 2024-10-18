$conf = $args[0];

if ($conf -eq "on") {
  Get-Service | ? {$_.Name -eq "ClickToRunSvc"} | Set-Service -StartupType Automatic
  Start-Service "ClickToRunSvc"
} elseif ($conf -eq "off") {
  Stop-Service "ClickToRunSvc"
  Get-Service | ? {$_.Name -eq "ClickToRunSvc"} | Set-Service -StartupType Disabled
} else {
  Write-Host "Nothing specified";
}