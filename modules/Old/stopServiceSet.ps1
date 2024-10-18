# TheAlbaster92 (Antonio Martino) - v20171121.0939

$conf = $args[0];

$regKey = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings"
$vmwareNetDevice1 = Get-WmiObject -Class Win32_NetworkAdapter -Filter "Name LIKE '%VMNet1%'";
$vmwareNetDevice8 = Get-WmiObject -Class Win32_NetworkAdapter -Filter "Name LIKE '%VMNet8%'";

$deviceArray = $vmwareNetDevice1, $vmwareNetDevice8;
$serviceArray = "VMAuthdService", "VMnetDHCP", "VMware NAT Service", "VMUSBArbService", "FileZilla Server";

$proxyServersArray = @{"Home" = ""; "Work-PI" = "proxy.gss.rete.poste:8080"};
$overridesArray = @{"Home" = ""; "Work-PI" = "10.*;*.poste;*.local;<local>"};

$adapterArray = "Ethernet", "Wi-Fi";

if ($conf -eq "Home") {

    #Set Devices
    foreach ($device in $deviceArray) {
        $device.disable();
    }

    #Set Services
    foreach ($service in $serviceArray) {
		Stop-Service $service
		#Get-Service | ? {$_.Name -eq $service} | Set-Service -StartupType Disabled
    }
	
	#Start ISC
	#Get-Service | ? {$_.Name -eq "named"} | Set-Service -StartupType Automatic
    Start-Service "named"

    #Set Proxy
    Set-ItemProperty -path $regKey ProxyEnable -value 0
    Set-ItemProperty -path $regKey ProxyServer -value $proxyServersArray.$conf;
    Set-ItemProperty -path $regKey ProxyOverride -value $overridesArray.$conf;

    #Set DNS
    foreach ($adapter in $adapterArray) {
        netsh interface ipv4 add dnsserver $adapter 127.0.0.1 index=1;
        netsh interface ipv4 add dnsserver $adapter 85.37.17.13 index=2;
        netsh interface ipv4 add dnsserver $adapter 8.8.4.4 index=3;
		netsh interface ipv4 add dnsserver $adapter 8.8.8.8 index=4;
		netsh interface ipv4 add dnsserver $adapter 199.85.126.10 index=5;
		#netsh interface ipv4 add dnsserver $adapter 74.82.42.42 index=6;
		netsh interface ipv4 add dnsserver $adapter 208.67.222.222 index=6;
		netsh interface ipv4 add dnsserver $adapter 64.6.64.6 index=7; 
    }
	
	stopOffice
	stopWacom

    [Environment]::SetEnvironmentVariable("CFGSTATE", "Home", "Machine");

} elseif ($conf -eq "Work-PI") {

    #Set Devices
    foreach ($device in $deviceArray) {
        $device.enable();
    }

    #Set Services
    foreach ($service in $serviceArray) {
		#Get-Service | ? {$_.Name -eq $service} | Set-Service -StartupType Automatic
        Start-Service $service
    }
	
	#Stop ISC
	Stop-Service "named"
	Get-Service | ? {$_.Name -eq "named"} | Set-Service -StartupType Disabled

    #Set Proxy
    Set-ItemProperty -path $regKey ProxyEnable -value 1;
    Set-ItemProperty -path $regKey ProxyServer -value $proxyServersArray.$conf;
    Set-ItemProperty -path $regKey ProxyOverride -value $overridesArray.$conf;

    #Set DNS
    foreach ($adapter in $adapterArray) {
        netsh interface ip set dns $adapter dhcp
    }
	
	startOffice
	stopWacom

    [Environment]::SetEnvironmentVariable("CFGSTATE", "Work-PI", "Machine");
}