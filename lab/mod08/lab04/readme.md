
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

    > **NOTE:** Do NOT enter any custom value on the prompt, as this action will fail the later script

    > **NOTE:** Cluster creation can take a significant amount of time depending on configuration, network speed, and the number of nodes in the cluster. ( Tops @ 20 min, it may go 30 min  )

    > **NOTE:** If the deployment fails for some reason, you need to do manual clean up before rerunning the script, otherwise it will fail again. You been WARNED!!

4. If the deployment is successful, you will receive information on the SQL BDC cluster endpoint 
    > **NOTE:** You can execute this command `azdata bdc endpoint list -o table` to view the endpoint details 

5. You can use SSMS  to connect to SQL Server Master Instance Front-End and SQL Server Master Readable Secondary Replicas . Note the IP  and Port number 
    > **NOTE:** username: **admin** password: **Pa55w0rd2019**

#### Deploy Sample Database to BDC

1. In this step you will deploy sample database ( Sales and WideWorldImporters ) to the SQL BDC Cluster 

    ```sh 
    bash bootstrap-sample-db.sh 
    ```
    > **NOTE:** This command will download several database backup from MSFT and push that to SQL BDC Cluster and Add those Database into AG to make them HA. 

2. While the previous command is running , you can monitor the progress in SSMS 
    > It will create 2 database called Sales and WideWorldImporters-Full database and add them into AG 