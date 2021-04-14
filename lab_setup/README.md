# LinuxSQL_training
LinuxSQL Training Assets

This Hub contains the Scripts/JSON files to provision VM(s) needed for MSSQL Linux training

This Scriplet/JSON files can be only used in MS Azure Cloud

VM creation:

MSSQL 
- VM001 - RHEL 8.1 for MSSQL 

DOCKER
- VM002 - CentOS 7_8 for Docker MSSQL 

KUBERNETES ( Disabled )
- master(master.example.local) - Centos78/K8s - k8 Master Node
- node1(node1.example.local)  - Centos78/K8s - k8 worker Node
- node2(node2.example.local)  - Centos78/K8s - k8 worker Node

Additional Script Setup - 

Cloud based Container/Kubernetes Service
- Azure Container Instances Setup  ( ACI )
- Azure Kubernetes Service Setup ( AKS ) 

The only script you need to run is main.sh

main.sh will call all the other scripts automatically

# Steps: 

1. Go Azure CLI - Bash
2. use git clone to clone this HUB
3. How to use this script? 

- cd into the hub clone 
- chmod +x main.sh 
- ./main.sh  [ vm001 | vm002 | k8s | cloud | aks ]
- You need to pass vm001/vm002 or k8s or cloud or aks as arguments
- vm001 arg will create single VM with MSSQL Linux ready 
- vm002 arg will create single VM with DOCKER Linux ready  
- k8s arg will create 3 VM  (master, node1 and node2) 
- cloud arg will create ACI to run container in cloud
- aks arg will create AKS to run Azure Kubernetes Service in cloud
- there is a hidden argument called init - WARNING - this will delete resources 

All the scripts are free for reuse

Thank You, Have Fun, Cheers<br>
Steven<br>

steven@cognitoz.com | steven@outlook.my