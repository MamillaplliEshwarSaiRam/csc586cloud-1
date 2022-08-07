#!/bin/bash
sudo apt-get install jq -y
ips=$(sudo cat /var/log/auth.log | grep "Disconnected" | awk '{print $10}')
months=$(sudo cat /var/log/auth.log | grep "Disconnected" | awk '{print $1}')
days=$(sudo cat /var/log/auth.log | grep "Disconnected" | awk '{print $2}')

all_ips=()
for ip in $ips; do
        all_ips+=($ip)
done
all_datesm=()
for date in $dates1; do
        all_datesm+=($date)
done
all_datesd=()
for date in $dates; do
        all_datesd+=($date)
done
countries=()
for ip in $ips; do
        country=$(curl -s ipinfo.io/${ip} | jq ".country")
        countries+=($country)
done
for ip in ${!countries[*]}; do
    echo "${all_[ip]}  ${countries[ip]}  ${all_datesm[ip]}  ${all_datesd[ip]}" >> /var/webserver_log/unauthorized.log
done
