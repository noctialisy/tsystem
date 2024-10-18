# TheAlbaster92 (Antonio Martino) - v2017.1121.0939
# last version: v2018.0129.0841


function setConf($location) {

    $vmwareNetDevice1 = Get-WmiObject -Class Win32_NetworkAdapter -Filter "Name LIKE '%VMNet1%'";
    $vmwareNetDevice8 = Get-WmiObject -Class Win32_NetworkAdapter -Filter "Name LIKE '%VMNet8%'";
    $deviceArray = $vmwareNetDevice1, $vmwareNetDevice8;
    $serviceArray = "VMAuthdService", "VMnetDHCP", "VMware NAT Service", "VMUSBArbService", "PulseSecureService";

    if ($location -eq "Home") {

        #Set Devices
        foreach ($device in $deviceArray) {
            $device.disable();
        }

        #Set Services
        foreach ($service in $serviceArray) {
		    Stop-Service $service
		    Get-Service | ? {$_.Name -eq $service} | Set-Service -StartupType Disabled
        }
	
	    #Start ISC
	    Get-Service | ? {$_.Name -eq "named"} | Set-Service -StartupType Automatic
        Get-Service | ? {$_.Name -eq "wuauserv"} | Set-Service -StartupType Automatic
        Start-Service "named"
        Start-Service "wuauserv"
	
	    stopOffice
	    stopWacom

        [Environment]::SetEnvironmentVariable("CFGSTATE", "Home", "Machine");

    } elseif ($location -eq "Work") {

        #Set Devices
        foreach ($device in $deviceArray) {
            $device.enable();
        }

        #Set Services
        foreach ($service in $serviceArray) {
		    Get-Service | ? {$_.Name -eq $service} | Set-Service -StartupType Automatic
            Start-Service $service
        }
	
	    #Stop ISC
	    Stop-Service "named"
        Stop-Service "wuauserv"
	    Get-Service | ? {$_.Name -eq "named"} | Set-Service -StartupType Disabled
        Get-Service | ? {$_.Name -eq "wuauserv"} | Set-Service -StartupType Disable
	
	    startOffice
	    stopWacom

        [Environment]::SetEnvironmentVariable("CFGSTATE", "Work-PI", "Machine");
    }

}

function setProxyConf($proxylocation) {

    $regKey = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings"
    $proxyServersArray = @{"Home" = ""; "PI" = "proxy.gss.rete.poste:8080"};
    $overridesArray = @{"Home" = ""; "PI" = "10.*;*.poste;*.local;<local>"};
    $adapterArray = "Ethernet", "Wi-Fi";

    if ($proxylocation -eq "Home") {
        #Set Proxy
        Set-ItemProperty -path $regKey ProxyEnable -value 0
        Set-ItemProperty -path $regKey ProxyServer -value $proxyServersArray.$proxylocation;
        Set-ItemProperty -path $regKey ProxyOverride -value $overridesArray.$proxylocation;

        #Set DNS
        cmd /c ipconfig /flushdns
        foreach ($adapter in $adapterArray) {
            cmd /c netsh interface ipv4 add dnsserver $adapter 127.0.0.1 index=1;
            #netsh interface ipv4 add dnsserver $adapter 85.37.17.13 index=2;
            #netsh interface ipv4 add dnsserver $adapter 8.8.4.4 index=2;
		    #netsh interface ipv4 add dnsserver $adapter 8.8.8.8 index=3;
		    #netsh interface ipv4 add dnsserver $adapter 199.85.126.10 index=4;
		    #netsh interface ipv4 add dnsserver $adapter 74.82.42.42 index=6;
		    #netsh interface ipv4 add dnsserver $adapter 208.67.222.222 index=5;
		    #netsh interface ipv4 add dnsserver $adapter 64.6.64.6 index=6; 
        }
    } elseif ($proxylocation -eq "PI") {
        #Set Proxy
        Set-ItemProperty -path $regKey ProxyEnable -value 1;
        Set-ItemProperty -path $regKey ProxyServer -value $proxyServersArray.$proxylocation;
        Set-ItemProperty -path $regKey ProxyOverride -value $overridesArray.$proxylocation;

        #Set DNS
        cmd /c ipconfig /flushdns
        foreach ($adapter in $adapterArray) {
            cmd /c netsh interface ip set dns $adapter dhcp
        }
    }
}
