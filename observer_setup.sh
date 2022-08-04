#!/bin/bash
set -x
sudo apt update
sudo apt install -y nfs-common
sudo mkdir /var/webserver_monitor
sudo mount 192.168.1.1:/var/webserver_log/ /var/webserver_monitor/
