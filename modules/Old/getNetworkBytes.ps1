$computer = "LocalHost" ;
$namespace = "root\CIMV2" ;
$Tcpip_NI = Get-WmiObject -class Win32_PerfRawData_Tcpip_NetworkInterface -computername $computer -namespace $namespace ;
$Tcpip_NI | Select Name,BytesReceivedPersec,BytesSentPersec,BytesTotalPersec ;

$netsh_interface_stats = netsh interface ip show interface ;
$netsh_interface_stats | Select-string "In Octets" ;
$netsh_interface_stats | Select-string "Out Octets" ;