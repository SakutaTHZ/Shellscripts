cd RpmToInstall
pwd

rpm -qa | grep job
yum remove job*

rpm -ivh jobarranger-agentd*rpm
sleep 3
rpm -ivh jobarranger-server*rpm
sleep 3

echo "run jobArrangerConfigSetup.sh in configsSetup/ for auto config setup"
