# Choose your docker files location
cd /root/Documents/zabbix_jobarg_env/mysql/
docker ps -a
echo "In case u didnt want to remove the database Press Ctrl+C"
sleep 5

docker rm -f $(docker ps -aq)
docker network prune -f

echo "Docker Containers removed successfully"
docker ps -a