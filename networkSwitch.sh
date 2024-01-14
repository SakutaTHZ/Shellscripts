#!/bin/bash

# Replace data
filepath="/etc/sysconfig/network-scripts/ifcfg-enp0s3"

# Check if the first command-line argument is null or empty
if [ -z "$1" ]; then
	sed -i '/^BOOTPROTO=/ s/.*/BOOTPROTO=dhcp/' $filepath

	# Set IP address
	if [ "$(grep -c "IPADDR=" $filepath)" -gt 0 ]; then
		sed -i "/^IPADDR=/ s/.*/#IPADDR=$1/" $filepath
		echo "IPADDR set to $1"
	else
    		echo "IPADDR=... does not exist in the file."
		echo "IPADDR=$1" >> $filepath
		echo "IPADDR=$1 added to file."
	fi

	# Set NETMASK
	if [ "$(grep -c "NETMASK=" $filepath)" -gt 0 ]; then
		sed -i '/^NETMASK=x.x.x.x/ s/.*/#NETMASK=x.x.x.x/' $filepath
		echo "IPADDR set to $1"
	else
    		echo "#NETMASK=... does not exist in the file."
		echo "#NETMASK=x.x.x.x" >> $filepath
	fi

	# Set DNS1
	if [ "$(grep -c "DNS1=" $filepath)" -gt 0 ]; then
		sed -i '/^DNS1=x.x.x.x/ s/.*/#DNS1=x.x.x.x/' $filepath
		echo "DNS1 set to x.x.x.x"
	else
    		echo "#DNS1=... does not exist in the file."
		echo "#DNS1=x.x.x.x" >> $filepath
	fi

	# Set DNS2
	if [ "$(grep -c "DNS2=" $filepath)" -gt 0 ]; then
		sed -i '/^DNS2=x.x.x.x/ s/.*/#DNS2=x.x.x.x/' $filepath
		echo "DNS2 set to x.x.x.x"
	else
    		echo "#DNS2=... does not exist in the file."
		echo "#DNS2=x.x.x.x" >> $filepath
	fi

	# Set GATEWAY
	if [ "$(grep -c "GATEWAY=" $filepath)" -gt 0 ]; then
		sed -i '/^GATEWAY=x.x.x.x/ s/.*/#GATEWAY=x.x.x.x/' $filepath
		echo "GATEWAY set to x.x.x.x"
	else
    		echo "#GATEWAY=... does not exist in the file."
		echo "#GATEWAY=x.x.x.x" >> $filepath
	fi

	# Set PREFIX
	if [ "$(grep -c "PREFIX=" $filepath)" -gt 0 ]; then
		sed -i '/^PREFIX=8/ s/.*/#PREFIX=8/' $filepath
		echo "PREFIX set to 8"
	else
    		echo "#PREFIX=... does not exist in the file."
		echo "#PREFIX=8" >> $filepath
	fi

	echo ""	
	cat $filepath
	systemctl restart NetworkManager
	echo ""	

	echo "Add a parameter in case u want to change to Static IP"
	echo "for.eg ./networkSwitch.sh 10.1.8.85"
else
	sed -i '/^BOOTPROTO=/ s/.*/BOOTPROTO=static/' $filepath

	# Set IP address
	if [ "$(grep -c "IPADDR=" $filepath)" -gt 0 ]; then
		sed -i "/^#IPADDR=/ s/.*/IPADDR=$1/" $filepath
		echo "IPADDR set to $1"
	else
    		echo "IPADDR=... does not exist in the file."
		echo "IPADDR=$1" >> $filepath
		echo "IPADDR=$1 added to file."
	fi

	# Set NETMASK
	if [ "$(grep -c "NETMASK=" $filepath)" -gt 0 ]; then
		sed -i '/^#NETMASK=x.x.x.x/ s/.*/NETMASK=x.x.x.x/' $filepath
		echo "IPADDR set to $1"
	else
    		echo "NETMASK=... does not exist in the file."
		echo "NETMASK=x.x.x.x" >> $filepath
	fi

	# Set DNS1
	if [ "$(grep -c "DNS1=" $filepath)" -gt 0 ]; then
		sed -i '/^#DNS1=x.x.x.x/ s/.*/DNS1=x.x.x.x/' $filepath
		echo "DNS1 set to x.x.x.x"
	else
    		echo "DNS1=... does not exist in the file."
		echo "DNS1=x.x.x.x" >> $filepath
	fi

	# Set DNS2
	if [ "$(grep -c "DNS2=" $filepath)" -gt 0 ]; then
		sed -i '/^#DNS2=x.x.x.x/ s/.*/DNS2=x.x.x.x/' $filepath
		echo "DNS2 set to x.x.x.x"
	else
    		echo "DNS2=... does not exist in the file."
		echo "DNS2=x.x.x.x" >> $filepath
	fi

	# Set GATEWAY
	if [ "$(grep -c "GATEWAY=" $filepath)" -gt 0 ]; then
		sed -i '/^#GATEWAY=x.x.x.x/ s/.*/GATEWAY=x.x.x.x/' $filepath
		echo "GATEWAY set to x.x.x.x"
	else
    		echo "GATEWAY=... does not exist in the file."
		echo "GATEWAY=x.x.x.x" >> $filepath
	fi

	# Set PREFIX
	if [ "$(grep -c "PREFIX=" $filepath)" -gt 0 ]; then
		sed -i '/^#PREFIX=8/ s/.*/PREFIX=8/' $filepath
		echo "PREFIX set to 8"
	else
    		echo "PREFIX=... does not exist in the file."
		echo "PREFIX=8" >> $filepath
	fi

	echo ""	
	cat $filepath
	systemctl restart NetworkManager

fi
