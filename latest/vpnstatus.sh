#!/bin/sh

active="$(nmcli -g name,type con show --active | grep -iv ":tun" | grep vpn | sed -e 's#:vpn$##')"

if [ -n "$active" ]; then
    ip="$(nmcli con show "$active" | grep "IP4.ADDRESS" | grep -E -o '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}')"
    if [ "$1" = "nocolor" ]; then
	echo "$active: $ip "
    else
    	echo "$active: $ip %{F#00FF00}%{F-}"
   fi
else
    if [ "$1" = "nocolor" ]; then
    	echo "NO VPN "
    else
    	echo "NO VPN %{F#FF0000}%{F-}"
   fi
fi
