
# Deploy a SQL Server big data HA cluster on Azure Kubernetes Service (AKS) 

Using this sample Python script, you will deploy a Kubernetes cluster in Azure using AKS and a SQL Server big data HA cluster using this AKS cluster as its environment. The script can be run from any client OS that has all the pre-requisites installed.

If you can't install the pre-requisites, consider running the script from **vm001** which was create elsewhere as part of Linux SQL training. 

You still need to install pre-requisites on **vm001** 

## Pre-requisites (vm001 [ RHEL 7/8 ] )

1. run the following command to install all the pre-requisites 
    ```sh 
    chmod +x setup_linux.sh

    ./setup_linux.sh 
    ```

1. you will see output like this, means all OK.
    ```sh 
    Installation of az cli , kubectl and azdata seems OK
    Client Version: version.Info{Major:"1", Minor:"21", GitVersion:"v1.21.0", GitCommit:"cb303e613a121a29364f75cc67d3d580833a7479", GitTreeState:"clean", BuildDate:"2021-04-08T16:31:21Z", GoVersion:"go1.16.1", Compiler:"gc", Platform:"linux/amd64"}
    azure-cli                         2.22.1

    core                              2.22.1
    telemetry                          1.0.6

    Python location '/usr/bin/python3'
    Extensions directory '/root/.azure/cliextensions'

    Python (Linux) 3.6.8 (default, Oct 11 2019, 15:04:54)
    [GCC 8.3.1 20190507 (Red Hat 8.3.1-4)]

    Legal docs and information: aka.ms/AzureCliLegal


    Your CLI is up-to-date.

    Please let us know how we are doing: https://aka.ms/azureclihats
    and let us know if you're interested in trying out our newest features: https://aka.ms/CLIUXstudy
    20.3.2

    Build (20210330.1)

    SQL Server 2019 (15.0.4123)

    Legal docs and information: https://aka.ms/eula-azdata-en

    Python (Linux) 3.6.8 (default, Oct 11 2019, 15:04:54)
    [GCC 8.3.1 20190507 (Red Hat 8.3.1-4)]

    Python location '/usr/bin/python3'

    ```

1. Login into your Azure account. Run this command and follow the instruction: 
    ````sh
    az login
    ````
    > **NOTE:** Copy the sub ID of your Azure Account for next step  (id)

## Instructions
#### Deploy SQL Big Data HA Cluster 

Run the script using:
    ````sh
    python deploy-sql-big-data-aks.py
    ````

>**Note**
    >
    >If you have both python3 and python2 on your client machine and in the path, you will have to run the command using python3:
    >```
    >python3 deploy-sql-big-data-aks.py
    >```


When prompted, provide your input for Azure subscription ID, Azure resource group to create the resources in.  Optionally, you can also provide your input for below configurations or use the defaults provided:
- azure_region
- vm_size - we recommend to use a VM size to accommodate your workload. For an optimal experience while you are validating basic scenarios, we recommend at least 8 vCPUs and 64GB memory across all agent nodes in the cluster. The script uses **Standard_L8s** as default. A default size configuration also uses about 24 disks for persistent volume claims across all components.
- aks_node_count - this is the number of the worker nodes for the AKS cluster, excluding master node. The script is using a default of 1 agent node. This is the minimum required for this VM size to have enough resources and disks to provision all the necessary persistent volumes.
- cluster_name - this value is used for both AKS cluster and SQL big data cluster created on top of AKS. Note that the name of the SQL big data cluster is going to be a Kubernetes namespace
- password - same value is going to be used for all accounts that require user password input: SQL Server master instance account created for the below **username**, controller user and Knox **root** user
- username - this is the username for the accounts provisioned during deployment for the controller admin account and SQL Server master instance account. Note that **sa** SQL Server account is disabled automatically for you, as a best practice. Username for Knox gateway account is going to be **root**.
