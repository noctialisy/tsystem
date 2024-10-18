if ($args[0] -eq "") {
    
    Write-Host "Missing Parameters, nothing will be done.";

} else {
    $adapter = $args[0];

    if ($args[1] -eq "") {
        
        Write-Host "Missing Parameters, nothing will be done.";

    } else {
        $conf = $args[1];
        $checks = 1;
    }
}

if ($checks) {

    if ($args[1] -eq "Auto") {
        netsh interface ipv4 set dnsserver $adapter source=dhcp
    } elseif ($args[1] -eq "Personal") {
        netsh interface ipv4 add dnsserver $adapter 127.0.0.1 index=1;
        netsh interface ipv4 add dnsserver $adapter 8.8.4.4 index=2;
        netsh interface ipv4 add dnsserver $adapter 8.8.8.8 index=3;
        netsh interface ipv4 add dnsserver $adapter 208.67.222.222 index=4;
        netsh interface ipv4 add dnsserver $adapter 64.6.64.6 index=5;
    }

}