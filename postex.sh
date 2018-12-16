#!/bin/bash
echo "------------------------------------------------------------------------------------------"
echo "[+] hostname FQDN $(hostname -f)"
echo "------------------------------------------------------------------------------------------"
echo "[+] kernel version $(uname -r)"
echo "------------------------------------------------------------------------------------------"
echo "[+] CPU arch $(uname -m)"
echo "------------------------------------------------------------------------------------------"
echo "[+] Linux release $(cat /etc/issue | sed 's/.\{6\}$//')"
echo "------------------------------------------------------------------------------------------"
if [ -e /etc/lsb-release ]
then
    echo "[+] LSB release version $(cat /etc/lsb-release | grep DISTRIB_DESCRIPTION | cut -d '=' -f 2)"
else
    echo "[-] No LSB release file present"
fi
if [ -e /etc/SUSE-release ]
then
    echo "[+] SUSE release version $(cat /etc/SUSE-release)"
else
    echo "[-] No SUSE release file present"
fi
if [ -e /etc/redhat-release ]
then
    echo "[+] Red Hat release version $(cat /etc/redhat-release)"
else
    echo "[-] No Red Hat release file present"
fi
if [ -e /etc/fedora-release ]
then
    echo "[+] Fedora release version $(cat /etc/fedora-release)"
else
    echo "[-] No Fedora release file present"
fi
if [ -e /etc/slackware-release ]
then
    echo "[+] Slackware release version $(cat /etc/slackware-release)"
else
    echo "[-] No Slackware release file present"
fi
if [ -e /etc/debian-release ]
then
    echo "[+] Debian release version $(cat /etc/debian-release)"
else
    echo "[-] No Debian release file present"
fi
if [ -e /etc/gentoo-release ]
then
    echo "[+] Gentoo release version $(cat /etc/gentoo-release)"
else
    echo "[-] No Gentoo release file present"
fi
echo "------------------------------------------------------------------------------------------"
echo "[+] current user $(id)"
echo "------------------------------------------------------------------------------------------"
echo "[+] users in /home/"
echo "$(ls /home/)"
echo "------------------------------------------------------------------------------------------"
echo "[+] users in /home/ in sudo or adm group"
for i in $(ls /home/); do grep $i /etc/group | grep "sudo\|adm"; done
echo "------------------------------------------------------------------------------------------"
echo "[+] uptime $(uptime)"
echo "------------------------------------------------------------------------------------------"
echo "[+] Checking if number of CPUs mentioned in dmesg"
dmesg | grep "Brought up"
echo "------------------------------------------------------------------------------------------"
echo "[+] total memory $(cat /proc/meminfo | grep MemTotal)"
echo "------------------------------------------------------------------------------------------"
echo "[+] nearby hosts from the ARP table"
arp -n -a
echo "------------------------------------------------------------------------------------------"
echo "[+] DNS servers from /etc/resolv.conf"
grep nameserver /etc/resolv.conf | grep nameserver | cut -d " " -f 2
echo "------------------------------------------------------------------------------------------"
if [ -e "/usr/sbin/ip" ] || [ -e "/sbin/ip" ]
then     
    echo "[+] local IP address $(ip route get 1 | awk '{print $NF;exit}')"
else
    echo "[+] local IP address $(ifconfig | grep -v inet6 | grep inet| grep -v '127.0.0.1' |  cut -d ' ' -f 2)"
fi
echo "------------------------------------------------------------------------------------------"
echo "[+] external IP address $(dig TXT +short o-o.myaddr.l.google.com @ns1.google.com | sed 's/^.\(.*\).$/\1/')"
echo "------------------------------------------------------------------------------------------"
if [ -e "/usr/sbin/ip" ] || [ -e "/sbin/ip" ]
then     
    echo "[+] default route $(ip ro show | grep "default via" | cut -d " " -f 3)"
else
    echo "[+] default route $(netstat -nr | grep default | cut -d ' ' -f 13)"
fi
echo "------------------------------------------------------------------------------------------"
echo "[+] local listening ports (non-root)"
netstat -anop 2>/dev/null | grep LISTEN | cut -d " " -f 15 | grep ::: | cut -c 4-
echo "------------------------------------------------------------------------------------------"
echo "[+] local listening TCP ports (non-root) which are in /etc/services"
for i in $(netstat -anop 2>/dev/null | grep LISTEN | cut -d " " -f 15 | grep ::: | cut -c 4-); do grep "\b$i/tcp\b" /etc/services; done
echo "------------------------------------------------------------------------------------------"
# check for bash history
if [ -e $HOME/.bash_history ]
then
    echo "[+] Bash history present in $HOME/.bash_history"
    echo "[+] SSH commands in bash history"
    grep ^ssh $HOME/.bash_history
else
    echo "[-] No Bash history present in $HOME/.bash_history"
fi
# check for ssh keys
echo "------------------------------------------------------------------------------------------"
if [ -e $HOME/.ssh/id_rsa ]
then
    echo "[+] SSH RSA key present in $HOME/.ssh/id_rsa"
else
    echo "[-] No SSH RSA key present in $HOME/.ssh/id_rsa"
fi
if [ -e $HOME/.ssh/id_dsa ]
then
    echo "[+] SSH DSA key present in $HOME/.ssh/id_dsa"
else
    echo "[-] No SSH DSA key present in $HOME/.ssh/id_dsa"
fi
if [ -e $HOME/.ssh/id_ecdsa ]
then
    echo "[+] SSH ECDSA key present in $HOME/.ssh/id_dsa"
else
    echo "[-] No SSH ECDSA key present in $HOME/.ssh/id_dsa"
fi
# check for users query tool
echo "------------------------------------------------------------------------------------------"
if [ -e /usr/bin/users ]
then
    echo "[+] User accounts"
    /usr/bin/users
else
    echo "[-] /usr/bin/users not present"
fi

# check for scutil MacOS query tool
echo "------------------------------------------------------------------------------------------"
if [ -e /usr/sbin/scutil ]
then
    echo "[+] MacOS Active Directory domain name"
    echo show com.apple.opendirectoryd.ActiveDirectory | scutil | grep DomainNameFlat | awk '{print $3}'
else
    echo "[-] scutil not present - this machine is likely not a MacOS machine"
fi

# check for dsconfigad MacOS query tool
echo "------------------------------------------------------------------------------------------"
if [ -e /usr/sbin/dsconfigad ]
then
    echo "[+] MacOS Active Directory forest and domain name"
    dsconfigad -show | grep "Active Directory Forest" | cut -d '=' -f 2
    dsconfigad -show | grep "Active Directory Domain" | cut -d '=' -f 2
else
    echo "[-] dsconfigad not present - this machine is likely not a MacOS machine"
fi



# TODO clear bash history
