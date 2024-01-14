#!/bin/bash

# Function to get host data
getHostData() {
  echo $(hostname)
}
hostdata=$(getHostData)

echo "Host Data: $hostdata"

sudo echo "Setting up Jobarranger configs"
sudo yes | cp -rf configs/jobarg_server.conf /etc/jobarranger/jobarg_server.conf
sudo yes | cp -rf configs/jobarg_agentd.conf /etc/jobarranger/jobarg_agentd.conf
sudo yes | cp -rf configs/jobarg_monitor.conf /etc/jobarranger/jobarg_monitor.conf
sudo echo "Jobarranger configs moved to /etc/jobarranger/"
	
sudo systemctl restart jobarg-server
sudo echo "Jobarranger Server started"

sudo systemctl restart jobarg-agentd
sudo echo "Jobarranger Agentd started"
	
sudo systemctl restart zabbix-server zabbix-agent httpd php-fpm
sudo echo "Relative services started"
sudo systemctl status zabbix-server zabbix-agent httpd php-fpm jobarg-server jobarg-agentd

#Replace data

sed -i "s/oss-oracle-env/$hostdata/g" /etc/jobarranger/jobarg_agentd.conf

echo "Hostname changed to $hostdata in /etc/jobarranger/jobarg_agentd.conf"

# Check if the first command-line argument is null or empty
if [ -z "$1" ]; then
        echo "Add a parameter in case u are using docker. Current (DBHost=localhost)"
	echo "for.eg ./jobArrangerconfigSetup.sh 10.1.8.85"
else
	sed -i "s/DBHost=localhost/DBHost=$1/g" /etc/jobarranger/jobarg_server.conf

	echo "DBHost set to $1"
fi