#!/bin/bash
MYIP=$(curl -sS ipv4.icanhazip.com)
echo "Checking VPS"
#########################
GitUser="jiwakentantal"
# Color Validation
BGWHITE='\e[0;47;30m'
BGBLUE='\e[1;44m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
RED='\033[0;31m'
DF='\e[39m'
Bold='\e[1m'
Blink='\e[5m'
yell='\e[36m'
red='\e[31m'
green='\e[32m'
blue='\e[34m'
PURPLE='\e[35m'
cyan='\e[36m'
Lred='\e[91m'
Lgreen='\e[92m'
Lyellow='\e[93m'
NC='\e[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;36m'
LIGHT='\033[0;37m'
# VPS Information
#Domain
domain=$(cat /usr/local/etc/xray/domain)
#Status certificate
modifyTime=$(stat $HOME/.acme.sh/${domain}_ecc/${domain}.key | sed -n '7,6p' | awk '{print $2" "$3" "$4" "$5}')
modifyTime1=$(date +%s -d "${modifyTime}")
currentTime=$(date +%s)
stampDiff=$(expr ${currentTime} - ${modifyTime1})
days=$(expr ${stampDiff} / 86400)
remainingDays=$(expr 90 - ${days})
tlsStatus=${remainingDays}
if [[ ${remainingDays} -le 0 ]]; then
	tlsStatus="expired"
fi
# Order ID
rm -f /usr/bin/ver
user=$( curl https://raw.githubusercontent.com/${GitUser}/allow/main/ipvps.conf | grep $MYIP | awk '{print $3}' )
echo "$user" > /usr/bin/ver

# validity
rm -f /usr/bin/e
valid=$( curl https://raw.githubusercontent.com/${GitUser}/allow/main/ipvps.conf | grep $MYIP | awk '{print $4}' )
echo "$valid" > /usr/bin/e

today=`date -d "0 days" +"%Y-%m-%d"`

# CERTIFICATE STATUS
d1=$(date -d "$valid" +%s)
d2=$(date -d "$today" +%s)
certifacate=$(( (d1 - d2) / 86400 ))

# USERNAME
rm -f /usr/bin/user
username=$( curl https://raw.githubusercontent.com/${GitUser}/allow/main/ipvps.conf | grep $MYIP | awk '{print $2}' )
echo "$username" > /usr/bin/user

# DETAIL ORDER
username=$(cat /usr/bin/user)
oid=$(cat /usr/bin/ver)
exp=$(cat /usr/bin/e)

# PROVIDED
creditt=$(cat /root/provided)

# OS Uptime
uptime="$(uptime -p | cut -d " " -f 2-10)"
# Download
#Download/Upload today
dtoday="$(vnstat -i eth0 | grep "today" | awk '{print $2" "substr ($3, 1, 1)}')"
utoday="$(vnstat -i eth0 | grep "today" | awk '{print $5" "substr ($6, 1, 1)}')"
ttoday="$(vnstat -i eth0 | grep "today" | awk '{print $8" "substr ($9, 1, 1)}')"
#Download/Upload yesterday
dyest="$(vnstat -i eth0 | grep "yesterday" | awk '{print $2" "substr ($3, 1, 1)}')"
uyest="$(vnstat -i eth0 | grep "yesterday" | awk '{print $5" "substr ($6, 1, 1)}')"
tyest="$(vnstat -i eth0 | grep "yesterday" | awk '{print $8" "substr ($9, 1, 1)}')"
#Download/Upload current month
dmon="$(vnstat -i eth0 -m | grep "`date +"%b '%y"`" | awk '{print $3" "substr ($4, 1, 1)}')"
umon="$(vnstat -i eth0 -m | grep "`date +"%b '%y"`" | awk '{print $6" "substr ($7, 1, 1)}')"
tmon="$(vnstat -i eth0 -m | grep "`date +"%b '%y"`" | awk '{print $9" "substr ($10, 1, 1)}')"
# Getting CPU Information
cpu_usage1="$(ps aux | awk 'BEGIN {sum=0} {sum+=$3}; END {print sum}')"
cpu_usage="$((${cpu_usage1/\.*} / ${corediilik:-1}))"
cpu_usage+=" %"
ISP=$(curl -s ipinfo.io/org | cut -d " " -f 2-10 )
CITY=$(curl -s ipinfo.io/city )
IPVPS=$(curl -s ipinfo.io/ip )
cname=$( awk -F: '/model name/ {name=$2} END {print name}' /proc/cpuinfo )
cores=$( awk -F: '/model name/ {core++} END {print core}' /proc/cpuinfo )
freq=$( awk -F: ' /cpu MHz/ {freq=$2} END {print freq}' /proc/cpuinfo )
tram=$( free -m | awk 'NR==2 {print $2}' )
uram=$( free -m | awk 'NR==2 {print $3}' )
fram=$( free -m | awk 'NR==2 {print $4}' )
clear 
figlet DrugVPN | lolcat
echo -e "$BLUE Premium Script" | lolcat
echo -e "${BLUE}════════════════════════════════════════════════════════════${NC}" | lolcat
echo -e "${BGWHITE}                      SERVER INFORMATION                    ${NC}"
echo -e "${BLUE}════════════════════════════════════════════════════════════${NC}" | lolcat
echo -e "\e[36m CPU Model            :$cname"
echo -e "\e[36m CPU Frequency        :$freq MHz" | lolcat
echo -e "\e[36m Number Of Cores      : $cores" | lolcat
echo -e "\e[36m CPU Usage            : $cpu_usage" | lolcat
echo -e "\e[36m Operating System     : "`hostnamectl | grep "Operating System" | cut -d ' ' -f5-` | lolcat
echo -e "\e[36m Kernel               : `uname -r`" | lolcat
echo -e "\e[36m Total Amount Of RAM  : $tram MB" | lolcat
echo -e "\e[36m Used RAM             :$red $uram\e[0m MB" | lolcat
echo -e "\e[36m Free RAM             : $fram MB" | lolcat
echo -e "\e[36m System Uptime        : $uptime " | lolcat
echo -e "\e[36m Isp Name             : $ISP" | lolcat
echo -e "\e[36m City                 : $CITY" | lolcat
echo -e "\e[36m Ip Vps               : $IPVPS" | lolcat	
echo -e "\e[36m Domain               : $domain" | lolcat
echo -e "\e[36m Script Version       : PAKYAVPN(v5)" | lolcat	
echo -e "\e[36m Client Name          : $username" | lolcat
echo -e "\e[36m Oder ID              : $oid" | lolcat
echo -e "\e[36m Script Expired       : $exp" | lolcat
echo -e "\e[36m Certificate status   : Expired in $certifacate days" | lolcat
echo -e "\e[36m Provided By          : $creditt" | lolcat
echo -e "${BLUE}════════════════════════════════════════════════════════════${NC}" | lolcat
echo -e "${BGWHITE}                     [ MAIN MENU ]                          ${NC}"
echo -e "${BLUE}════════════════════════════════════════════════════════════${NC}" | lolcat
echo -e " $PURPLE (•1) $NC $Lyellow SSH & OpenVPN Menu      $PURPLE (•7) $NC $Lyellow Clear Log " | lolcat
echo -e " $PURPLE (•2) $NC $Lyellow Wireguard Menu          $PURPLE (•8) $NC $Lyellow CHECK RUNNING SC " | lolcat
echo -e " $PURPLE (•3) $NC $Lyellow SSR & SS Menu           $PURPLE (•9) $NC $Lyellow MENU THEME " | lolcat
echo -e " $PURPLE (•4) $NC $Lyellow Vmess & Vless Menu      $PURPLE (10) $NC $Lyellow Info All Port " | lolcat
echo -e " $PURPLE (•5) $NC $Lyellow Trojan Menu             $PURPLE (11) $NC $Lyellow ADD IP ADMIN ONLY " | lolcat
echo -e " $PURPLE (•6) $NC $Lyellow System Menu             $PURPLE (12) $NC $Lyellow REBOOT VPS " | lolcat
echo -e "${BLUE}════════════════════════════════════════════════════════════${NC}" | lolcat
echo -e " $BLUE Premium VPS by $creditt" | lolcat
echo -e " $BLUE Thank you for using script by PAKYAVPN" | lolcat
echo -e "${BLUE}════════════════════════════════════════════════════════════${NC}" | lolcat
echo -e   ""
echo -e "$BLUE    [Ctrl + C] For exit from main menu" | lolcat
echo -e   ""
read -p "    Select From Options [1-12 or x:  "  opt
echo -e   ""
case $opt in
1) clear ; ssh ;;
2) clear ; wgr ;;
3) clear ; ssssr ;;
4) clear ; xraay ;;
5) clear ; trojaan ;;
6) clear ; system ;;
7) clear ; clear-log ;;
8) clear ; check-sc ;;
9) clear ; menu-theme ;;
10) clear ; info ;;
11) clear ; addip ;;
12) clear ; reboot ;;
x) exit ;;
esac
