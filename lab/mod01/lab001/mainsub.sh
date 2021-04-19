#Function for SUB Routine - VM PREP 

function sshhost()
{
cat <<EOF
Host *
   StrictHostKeyChecking no
   UserKnownHostsFile=/dev/null
EOF
}

function yumrepo()
{
ssh droot@$PIP  "sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo"
ssh droot@$PIP  "sudo yum makecache"
ssh droot@$PIP  "sudo yum install docker-ce -y"
ssh droot@$PIP  "sudo systemctl start docker"
ssh droot@$PIP  "sudo systemctl enable docker"
}

function pubip()
{
#Get IP address of vm002
PIP=$(az vm show -d -g vm002_rg -n vm002 --query "publicIps" -o tsv)
}

function open_pub()
{
# this is Dangerous, but for Training, NO PROBLEM , let them hack, there is nothing inside 
az network nsg rule create -g vm002_rg --nsg-name vm002-nsg -n openpublic --priority 777 \
    --source-address-prefixes '*' --source-port-ranges '*' \
    --destination-address-prefixes '*' --destination-port-ranges 1-65535  --access Allow \
    --protocol Tcp --description "Open all PORT for Docker Container Testing" > /dev/null 
}

function config_vm002()
{
#Configure vm002 with yum, disable Firewall , enable docker and run docker
#Show user the PUBLIC IP address to connect 
#Print How to connect from WINDOZE system using PUTTY

#Disable strict host check
sshhost > $HOME/.ssh/config

#Plumb Public IP
pubip

#call yumrepo function to install and settle Docker
yumrepo &> /dev/null

#Enable root key based access 
ssh -i $HOME/.ssh/id_rsa  droot@$PIP  "sudo sed -i 's/^#PermitRootLogin yes/PermitRootLogin without-password/g'  /etc/ssh/sshd_config"
ssh -i $HOME/.ssh/id_rsa  droot@$PIP  "sudo touch /etc/cloud/cloud-init.disabled"
ssh -i $HOME/.ssh/id_rsa  droot@$PIP  "sudo reboot"

#Wait for reboot to complete
sleep 120 

#RePlumb IP after reboot
pubip

#prep shellcode for injection
cat <<AA > ak.sh
#!/bin/bash 
cat /home/droot/.ssh/authorized_keys  > /root/.ssh/authorized_keys
AA

#Inject ShellCode and run
scp -i $HOME/.ssh/id_rsa  ak.sh  droot@$PIP:/home/droot/
ssh -i $HOME/.ssh/id_rsa  droot@$PIP  "sudo chmod +x ak.sh"
ssh -i $HOME/.ssh/id_rsa  droot@$PIP  "sudo ./ak.sh"


#call openpub to allow incoming net traffic
open_pub

#Display INFO for Student
echo 
echo -e "vm002 fully deployed...you may download the private key from azure and use puttygen to convert to use it with putty in your Beloved WINDOZE"
echo 
echo -e "\e[93mDownload this file ($HOME/.ssh/id_rsa) to your WinDOZE computer and refer to \e[92mhttps://www.puttygen.com/convert-pem-to-ppk \e[93mto convert and use putty to connect to $PIP"
echo 
echo -e "\e[93mPublic IP address for your vm001 is $PIP"
echo 
echo -e "\e[93mFrom Azure Cloud Shell, you can execute  ( ssh -i \$HOME/.ssh/id_rsa root@$PIP )"
echo -e "\e[93mEnjoy...- Steven.Com.My"
echo -e "\033[0m"
}