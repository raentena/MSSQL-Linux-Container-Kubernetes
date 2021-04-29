#!/bin/bash 

# Install az, azdata and kubectl 

rpm --import https://packages.microsoft.com/keys/microsoft.asc



cat <<EOF > /etc/yum.repos.d/azure-cli.repo
[azure-cli]
name=Azure CLI
baseurl=https://packages.microsoft.com/yumrepos/azure-cli
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc
EOF
  

cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF

curl -o /etc/yum.repos.d/mssql-server.repo https://packages.microsoft.com/config/rhel/8/prodAZDATA.repo

yum install azure-cli azdata-cli kubectl -y 
if [ $? -ne 0 ]
then 
 echo 'installation failed for some reason... '
 exit
fi 

sleep 1 

clear 
echo 'Installation of az cli , kubectl and azdata seems OK'

kubectl version --client

az --version

azdata --version 