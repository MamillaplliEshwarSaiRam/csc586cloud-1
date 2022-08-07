#!/bin/bash
ips=($(sudo cat /var/log/auth.log | grep "Invalid user" | awk '{print $10}'))
dates1=($(sudo cat /var/log/auth.log | grep "Invalid user" | awk '{print $1}'))
dates=($(sudo cat /var/log/auth.log | grep "Invalid user" | awk '{print $2}')) 

all_ips=()
em+=""
for ip in $ips; do
        all_ips+=($ip)
        em+="$ip        "
done

all_dates1=()
for date in ${dates1}; do
        all_dates1+=($date)
        em+="$date  "
done

all_dates=()
for date in ${dates}; do
        all_dates+=($date)
        em+="$date      "
done
countries={}
for ip in $ips; do
        country=$(curl ipinfo.io/$ip/country)
        countries+=($country)
        em+="$country"
done
echo "$em"
for ip in ${!countries[*]}; do
        echo "$em" >>  /var/webserver_log/unauthorized.log
done
