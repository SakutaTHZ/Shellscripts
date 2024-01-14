#!/bin/bash

if [ -z "$1" ]; then
	echo "The installation link is $1"

	#Install zabbix repository
	rpm -Uvh $1
	dnf clean all

	#Install Zabbix server, frontend, agent 
	dnf install zabbix-server-mysql zabbix-web-mysql zabbix-apache-conf zabbix-sql-scripts zabbix-selinux-policy zabbix-agent

	#Setup Database
	MYSQL_CMD="mysql -uroot -pzabbix"

	$MYSQL_CMD <<EOF
	create database zabbix character set utf8mb4 collate utf8mb4_bin;
	create user zabbix@localhost identified by 'password';
	grant all privileges on zabbix.* to zabbix@localhost;
	set global log_bin_trust_function_creators = 1;
	quit;
	EOF

	#Zabbix server host import initial schema and data
	zcat /usr/share/zabbix-sql-scripts/mysql/server.sql.gz | mysql --default-character-set=utf8mb4 -uzabbix -pzabbix zabbix

	#Disable log_bin_trust_function_creators option after importing database schema
	MYSQL_CMD2="mysql -uroot -p"

	$MYSQL_CMD2 <<EOF
	set global log_bin_trust_function_creators = 0;
	quit;
	EOF

	#Configure the database for Zabbix server
	sed -i '/^DBPassword=/ s/.*/DBPassword=zabbix/' /etc/zabbix/zabbix_server.conf

	#Start Zabbix server and agent processes
	systemctl restart zabbix-server zabbix-agent httpd php-fpm
	systemctl enable zabbix-server zabbix-agent httpd php-fpm
else
	echo "Need installation link as parameter"
	echo "For eg. ./zabbixInstaller.sh https://repo.zabbix.com/zabbix/6.0/rhel/9/x86_64/zabbix-release-6.0-4.el9.noarch.rpm"
fi