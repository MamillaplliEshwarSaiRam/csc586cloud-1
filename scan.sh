#!/bin/bash
sudo apt-get install jq -y
ips=$(sudo cat /var/log/auth.log | grep "Disconnected" | awk '{print $10}')
dates1=$(sudo cat /var/log/auth.log | grep "Disconnected" | awk '{print $1}')
dates=$(sudo cat /var/log/auth.log | grep "Disconnected" | awk '{print $2}')

all_ips=()
for ip in $ips; do
        all_ips+=($ip)
done

all_dates1=()
for date in ${dates1}; do
        all_dates1+=($date)
done

all_dates=()
for date in ${dates}; do
        all_dates+=($date)
done
countries={}
for ip in $ips; do
        country=$(curl -s ipinfo.io/${ip} | jq ".country")
        countries+=($country)
done
for ip in ${!countries[*]}; do
        echo "${all_ips[ip]} ${countries[ip]} ${all_dates1[ip]} ${all_dates[ip]}" >>  /var/webserver_log/unauthorized.log
done
