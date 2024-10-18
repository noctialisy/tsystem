$ndis = getNetworkBytes | Where-Object {$_.Name -like "*NDIS*"};
if ($ndis) {
	$bytes = $ndis.BytesTotalPersec;
	$megabytes = $bytes/1024/1024;

	$date = Get-Date;
	$startMsg = $date.ToString();
	write-output "$($startMsg): $($megabytes) MB;" >> C:\NDIS-UsedBytes.log;
}

