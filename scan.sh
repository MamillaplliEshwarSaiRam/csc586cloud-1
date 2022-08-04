#!/bin/bash
ips=($(sudo cat /var/log/auth.log | grep "Invalid user" | awk '{print $10}'))
dates1=($(sudo cat /var/log/auth.log | grep "Invalid user" | awk '{print $1}'))
dates=($(sudo cat /var/log/auth.log | grep "Invalid user" | awk '{print $2}')) 

all_ips=()
for ip in $ips; do
        all_ips+=${ip}
done

all_dates1=()
for date in ${dates1}; do
        all_dates1+=${date}
done

all_dates=()
for date in ${dates}; do
        all_dates+=${date}
done

#echo "${all_dates[*]}"
countries={}
for ip in $ips; do
        country=$(curl ipinfo.io/$ip/country)
        countries+=${country}
        echo ${country}
done

for ip in ${!countries[*]}; do
        echo "${all_ips[$ip]} ${countries[$ip]} ${all_dates1[$ip]} ${all_dates[$ip]}" >> /var/webserver_log/unauthorized.log
done
