#!/bin/bash
set -x
sudo apt update
sudo apt install -y nfs-common
sudo mkdir /var/webserver_monitor
sudo chmod ugo+rwx /users/eshwar/monitor.sh
sudo chmod ugo+rwx /var/webserver_monitor/counter.txt
sudo mount 192.168.1.1:/var/webserver_log/ /var/webserver_monitor/
sudo chmod -x /local/repository/monitor.sh
