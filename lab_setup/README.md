# k8_training
k8s Training Assets

This Hub contains the Scripts/JSON files to provision VM(s) needed for Docker/k8s and Labs files needed for training

This Scriplet/JSON files can be only used in MS Azure Cloud

VM creation:

Docker/Container
- VM001 - Centos78/Docker - for Docker training

Kubernetes
- VM002(master.example.local) - Centos78/K8s - k8 Master Node
- VM003(node1.example.local)  - Centos78/K8s - k8 worker Node
- VM004(node2.example.local)  - Centos78/K8s - k8 worker Node

Additional Script Setup - 

Cloud based Container/Kubernetes Service
- Azure Container Instances Setup  ( ACI )
- Azure Kubernetes Service Setup ( AKS ) [ in progress ]

The only script you need to run is main.sh

main.sh will call all the other scripts automatically

# Steps: 

1. Go Azure CLI - Bash
2. use git clone to clone this HUB
3. How to use this script? 

- cd into the hub clone (k8_training)
- chmod +x main.sh 
- ./main.sh  [ vm001 | k8s | cloud | aks ]
- You need to pass vm001 or k8s or cloud or aks as arguments
- vm001 arg will create single VM with docker capabilities 
- k8s arg will create 3 VM  (vm002[master], vm003[node1] and vm004[node2]) 
- cloud arg will create ACI to run container in cloud
- aks arg will create AKS to run Azure Kubernetes Service in cloud
- there is a hidden argument called init - WARNING - this will delete resources 

All the scripts are free for reuse

Thank You, Have Fun, Cheers<br>
Steven<br>

steven@cognitoz.com | steven@outlook.my

- Hub will go private on 23/08/2020 1500hrs GMT+8