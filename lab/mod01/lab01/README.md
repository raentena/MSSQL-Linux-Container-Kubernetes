# Lab Setup


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

- cd into the hub clone  ( lab/mod01/lab01/)
- chmod +x main.sh 
- ./main.sh vm001  ( wait until complete before proceeding to next step )
- ./main.sh vm002  ( wait until complete before proceeding to next step )
- ./main.sh aks 

