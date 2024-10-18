Write-Host "Checking for available updates, this may take a few minutes...";

$result = Get-WindowsUpdate | Measure-Object | Select-Object Count; 
$count = $result.Count;

if ($count -ge 1) {
    Write-Host "Found $($count) updates in total.";
    Write-Host "Will now proceed to install them...";

    Install-WindowsUpdate -AcceptAll;

} else {
	Write-Host "The system is up to date.";
	
}