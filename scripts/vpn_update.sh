#!/bin/bash

set -e

#	extract password from current connection
vpn_id=$(nmcli -g TYPE,UUID c s --active | grep vpn | head -1 | cut -d: -f2)
pass=$(sudo nmcli -s -g vpn.secrets c s "$vpn_id")
if [[ "$pass"q == "q" ]]; then
	echo "Empty VPN password found in current config!"
	exit 1
fi

# extract id of current active ethernet/wifi connection
net_id=$(nmcli -t c s --active | grep "ethernet\|802-11-wireless" | cut -f2 -d:)
if [[ "$net_id"q == "q" ]]; then
  echo "No active internet connection found!"
  exit 1
fi

dname=$(date +"%Y%m%d_%s")
mkdir $dname
cd $dname
echo "Downloading ovpn.zip"
curl -#o ovpn.zip https://downloads.nordcdn.com/configs/archives/servers/ovpn.zip

if [[ $? -ne 0 ]]; then
	echo "Download failed: $?"
	exit 1
fi

#	set connection down
nmcli connection down "$net_id"
#	remove old VPNs
for i in $(nmcli -g TYPE,UUID c s | grep vpn | cut -d: -f2); do
	nmcli c delete "$i"
done
udp_servers=$(unzip -l ovpn.zip ovpn_udp/{nl,at,hu,fr,se,ch}* | grep nordvpn.com | sed 's/^.\{30\}//')
tcp_servers=$(unzip -l ovpn.zip ovpn_tcp/{nl,at,hu,fr,se,ch}* | grep nordvpn.com | sed 's/^.\{30\}//')

declare -a tservers
declare -a uservers

unz=""

for i in {nl,at,de,hu,fr,se,ch}; do
	tmp=("$(echo "$udp_servers" | grep "$i" | shuf -n 1)")
	unz+="$tmp "
	uservers+=("$tmp")
	tmp=("$(echo "$tcp_servers" | grep "$i" | shuf -n 1)")
	unz+="$tmp "
	tservers+=("$tmp")
done;

unzip ovpn.zip $unz

echo "UDP:"
for serv in ${uservers[@]}; do
	nmcli connection import type openvpn file "$serv"
	t=$(basename "$serv" ".ovpn")
	nmcli connection modify "$t" +vpn.data "password-flags=0, username=bezet@poczta.onet.pl"
	nmcli connection modify "$t" +vpn.secrets "$pass" +connection.autoconnect "false"
	grep "^remote " "$serv" | cut -f2 -d' '
done

echo "TCP:"
for serv in ${tservers[@]}; do
	nmcli connection import type openvpn file "$serv"
	t=$(basename "$serv" ".ovpn")
	nmcli connection modify "$t" +vpn.data "password-flags=0, username=bezet@poczta.onet.pl"
	nmcli connection modify "$t" +vpn.secrets "$pass" +connection.autoconnect "false"
	grep "^remote " "$serv" | cut -f2 -d' '
done

#	set first TCP as default VPN
t=$(basename "${tservers[0]}" ".ovpn")
nmcli connection modify "$net_id" connection.secondaries "$t"

echo -n "Set up VPN for all ethernet/wifi connections? [y/N] "
read setAll

if [[ "$setAll" == "y" || "$setAll" == "Y" ]]; then
  nmcli -t c s --active | grep "ethernet\|wifi" | cut -f2 -d: | while read net; do
    echo "Setting secondary for $net"
    nmcli connection modify "$net" connection.secondaries "$t"
  done
fi

#	clean-up
rm -Rf ovpn_tcp ovpn_udp

echo -n "Activate previous connection? [Y/n] "
read act
if [[ "$act" != "n" && "$act" != "N" ]]; then
  nmcli connection up "$net_id"
else
  echo "Update fw and run : 'nmcli connection up \"$net_id\"'"
fi
