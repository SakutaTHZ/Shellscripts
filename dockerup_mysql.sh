cd /root/Documents/zabbix_jobarg_env/mysql/
if [ -z "$1" ]; then
    	echo "Add parameter to change NAT ip"
	echo "For eg. ./dockerup_mysql.sh 10.1.2.6"
else
	sed "s/$1/$2/g" docker-compose.yml
    	echo "New ip changed from $1 to $2"
fi

docker-compose up -d
docker ps -a
cat docker-compose.yml

echo "Run ./after_ctnr_up.sh if it is your first time creating this docker container"
