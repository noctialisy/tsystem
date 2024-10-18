$ndis = getNetworkBytes | Where-Object {$_.Name -like "*NDIS*"};
if ($ndis) {
	$megabytes_day = [System.Environment]::GetEnvironmentVariable('DataMB');
	$megabytes_total = [System.Environment]::GetEnvironmentVariable('DataMBTotal');
	$megabytes_total = $megabytes_total + $megabytes_day;
	
	[System.Environment]::SetEnvironmentVariable('DataMB', 0, [System.EnvironmentVariableTarget]::User);
	[System.Environment]::SetEnvironmentVariable('DataMBTotal', $megabytes_total, [System.EnvironmentVariableTarget]::User);
}