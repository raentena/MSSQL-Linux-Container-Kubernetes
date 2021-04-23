# Login to Azure

az login

# Create an Azure resource group

az group create --name SQL-RG --location southeastasia

# Create a two node cluster
 
az aks create --resource-group SQL-RG --name SQLSVR --node-count 2 --generate-ssh-keys --node-vm-size=Standard_B2ms
 
# Get credentials for the cluster

az aks get-credentials --resource-group SQL-RG --name SQLSVR
 
# List nodes

kubectl get nodes
 
# Create the load balancing service

kubectl apply -f sqlloadbalancer.yaml --record
 
# Create external storage with PV and PVC

kubectl apply -f sqlstorage.yaml --record
 
# Display the persistent volume and claim

kubectl get pv
kubectl get pvc
 
# Optional: In case if you want to explore different choices of storage classes you can run this line otherwise you can ignore it
kubectl get storageclass
 
# Use Kubernetes secrets to store required sa password for SQL Server container. This is a best Practice
# If you want to delete the previously created secret use this one otherwise avoid it and go to next line
kubectl delete secret mssql-secret 
 
# use complex password
kubectl create secret generic mssql-secret --from-literal=SA_PASSWORD="Pa55w0rd2019"
 
# Deploy the SQL Server 2019 container
kubectl apply -f sqldeployment.yaml --record
 
# List the running pods and services
kubectl get pods
kubectl get services
 
# TO fetch details about the POD
kubectl describe pod mssql
 
# Connect to the SQL Server pod with Azure Data Studio
# Retrieve external IP address
ip=$(kubectl get services | grep mssql | cut -c45-60)
echo $ip
  
# Simulate a failure by killing the pod. Delete pod exactkly does it.

podname=$(kubectl get pods | grep mssql | cut -c1-32)

#Display the variable name

echo $podname

kubectl delete pod ${podname}
 
# Wait one second
echo Waiting 3 second to show newly started pod
sleep 3
 
# now retrieve the running POD and you see the that POD name is different because Kubernetes recreated it after we deleted the earlier one
echo Retrieving running pods
kubectl get pods
 
# Get all of the running components
kubectl get all
 
# for Troubleshooting purpose you can use this command to view the events  
 
kubectl describe pod -l app=mssql

# Display the container logs
kubectl logs -l app=mssql