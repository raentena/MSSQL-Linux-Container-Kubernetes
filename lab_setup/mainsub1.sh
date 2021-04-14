#Function for SUB Routine - VM PREP 

function sshhost1()
{
cat <<EOF
Host *
   StrictHostKeyChecking no
   UserKnownHostsFile=/dev/null
EOF
}

function yumrepo1()
{
ssh droot@$PIP  "sudo yum-config-manager --add-repo https://packages.microsoft.com/config/rhel/8/mssql-server-2019.repo"
ssh droot@$PIP  "sudo yum makecache"
}

function pubip1()
{
#Get IP address of vm001
PIP1=$(az vm show -d -g vm001_rg -n vm001 --query "publicIps" -o tsv)
}

function open_pub1()
{
# this is Dangerous, but for Training, NO PROBLEM , let them hack, there is nothing inside 
az network nsg rule create -g vm001_rg --nsg-name vm001-nsg -n openpublic --priority 777 \
    --source-address-prefixes '*' --source-port-ranges '*' \
    --destination-address-prefixes '*' --destination-port-ranges 1-65535  --access Allow \
    --protocol Tcp --description "Open all PORT for RHEL MSSQL Testing" > /dev/null 
}

function config_vm001()
{
#Configure vm001 with yum, disable Firewall
#Show user the PUBLIC IP address to connect 
#Print How to connect from WINDOZE system using PUTTY

#Disable strict host check
sshhost1 > $HOME/.ssh/config

#Plumb Public IP
pubip1

#call yumrepo function to install and settle Docker
yumrepo1 &> /dev/null

#Enable root key based access 
ssh -i $HOME/.ssh/id_rsa  droot@$PIP1  "sudo sed -i 's/^#PermitRootLogin yes/PermitRootLogin without-password/g'  /etc/ssh/sshd_config"
ssh -i $HOME/.ssh/id_rsa  droot@$PIP1  "sudo touch /etc/cloud/cloud-init.disabled"
ssh -i $HOME/.ssh/id_rsa  droot@$PIP1  "sudo systemctl stop firewalld.service"
ssh -i $HOME/.ssh/id_rsa  droot@$PIP1  "sudo systemctl disable firewalld.service"
ssh -i $HOME/.ssh/id_rsa  droot@$PIP1  "sudo reboot"

#Wait for reboot to complete
sleep 120 

#RePlumb IP after reboot
pubip1

#prep shellcode for injection
cat <<AA > ak.sh
#!/bin/bash 
cat /home/droot/.ssh/authorized_keys  > /root/.ssh/authorized_keys
AA

#Inject ShellCode and run
scp -i $HOME/.ssh/id_rsa  ak.sh  droot@$PIP1:/home/droot/
ssh -i $HOME/.ssh/id_rsa  droot@$PIP1  "sudo chmod +x ak.sh"
ssh -i $HOME/.ssh/id_rsa  droot@$PIP1  "sudo ./ak.sh"


#call openpub to allow incoming net traffic
open_pub1

#Display INFO for Student
echo 
echo -e "vm001 fully deployed...you may download the private key from azure and use puttygen to convert to use it with putty in your Beloved WINDOZE"
echo 
echo -e "\e[93mDownload this file ($HOME/.ssh/id_rsa) to your WinDOZE computer and refer to \e[92mhttps://www.puttygen.com/convert-pem-to-ppk \e[93mto convert and use putty to connect to $PIP1"
echo 
echo -e "\e[93mPublic IP address for your vm001 is $PIP1"
echo 
echo -e "\e[93mFrom Azure Cloud Shell, you can execute  ( ssh -i \$HOME/.ssh/id_rsa root@$PIP1 )"
echo -e "\e[93mEnjoy...- Steven.Com.My"
echo -e "\033[0m"
}