
# Deploy a SQL Server big data HA cluster on Azure Kubernetes Service (AKS) 

In this lab, you will deploy a Kubernetes cluster in Azure using AKS and a SQL Server big data HA cluster using this AKS cluster as its environment. 

Login to **vm001** via ssh 

install pre-requisites on **vm001** 

## Pre-requisites (vm001 [ RHEL ] )

1. run the following command to install all the pre-requisites 
    ```sh 
    bash setup_linux.sh
    ```

1. you will see output like this, means all OK.
    ```sh 
    Verifying az is in path
    Verifying azdata is in path
    Verifying kubectl is in path
    Verifying curl is in path
    Verifying wget is in path           
    

    ```
    > **NOTE:** This script will expand /tmp to 4GB ( required when we want to download sample DB and Push to BDC Cluster)

1. Login into your Azure account. Run this command and follow the instruction: 
    ```sh
    az login
    ```
    > **NOTE:** Once az login succeeded , Copy the sub ID of your Azure Account for next step  (json line:**id**)

## Instructions
#### Deploy SQL Big Data HA Cluster 

1. Run the script using:
    
    ```sh
    python3 deploy-sql-big-data-aks.py
    ```


2. When prompted, provide your input for Azure subscription ID (the id you copied earlier ), Azure resource group to create the resources in.  

3. This script will prompt for input, you can USE DEFAULT values on prompt ( just press enter  )

4. Optionally, you can also provide your input for below configurations or use the defaults provided:

    - azure_region
    - vm_size - we recommend to use a VM size to accommodate your workload. For an optimal experience while you are validating basic scenarios, we recommend at least 8 vCPUs and 64GB memory across all agent nodes in the cluster. The script uses **Standard_L8s** as default. A default size configuration also uses about 24 disks for persistent volume claims across all components.
    - aks_node_count - this is the number of the worker nodes for the AKS cluster, excluding master node. The script is using a default of 5 agent node. This is the minimum required for this VM size to have enough resources and disks to provision all the necessary persistent volumes.
    - cluster_name - this value is used for both AKS cluster and SQL big data cluster created on top of AKS. Note that the name of the SQL big data cluster is going to be a Kubernetes namespace
    - password - same value is going to be used for all accounts that require user password input: SQL Server master instance account created for the below **username**, controller user and Knox **root** user
    - username - this is the username for the accounts provisioned during deployment for the controller admin account and SQL Server master instance account. Note that **sa** SQL Server account is disabled automatically for you, as a best practice. Username for Knox gateway account is going to be **root**.

    > **NOTE:** Deployment will take 16min tops  ( 5 node Kubernetes, with 24 pods thats hold SQL BDC / SQL AG ). You need to wait until the deployment is successful before proceeding to next step.  ( get a coffee )

    > **NOTE:** If the deployment fails for some reason, you need to do manual clean up before rerunning the script, otherwise it will fail again. You been WARNED!!

#### Deploy Sample Database to BDC 




















