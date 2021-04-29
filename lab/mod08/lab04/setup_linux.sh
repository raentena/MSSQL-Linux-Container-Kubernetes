#!/bin/bash 
# Install az, azdata and kubectl 

rpm --import https://packages.microsoft.com/keys/microsoft.asc

if [ ! -f /etc/yum.repos.d/azure-cli.repo ]
then 

cat <<EOF > /etc/yum.repos.d/azure-cli.repo
[azure-cli]
name=Azure CLI
baseurl=https://packages.microsoft.com/yumrepos/azure-cli
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc
EOF
fi 

if [ ! -f /etc/yum.repos.d/kubernetes.repo ]
then 

cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF

fi 

if [ ! -f /etc/yum.repos.d/mssql-server.rep  ]
then
curl -o /etc/yum.repos.d/mssql-server.repo https://packages.microsoft.com/config/rhel/8/prodAZDATA.repo
fi 

yum install azure-cli azdata-cli kubectl -y &> /dev/null 
if [ $? -ne 0 ]
then 
 echo 'installation failed for some reason... '
 exit
fi 

sleep 1 


for util in az azdata kubectl curl wget
    do
    echo Verifying $util is in path & which $util 1>/dev/null 2>/dev/null || (echo Unable to locate $util && exit 1)
done

TMPSIZE=$(df -h | grep tmplv | awk '{print $2}')

if [ $TMPSIZE != "4.0G"  ]
 then 
 lvextend -L +2G -n /dev/rootvg/tmplv -r &> /dev/null 
 fi 