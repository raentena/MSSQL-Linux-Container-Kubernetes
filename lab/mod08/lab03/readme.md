# SQL Server 2019 Availability Groups with Kubernetes

    >> Make sure you have already configured aks on Azure to Run this

### Steps

1. Create the namespace 


```sh 
kubectl create namespace ag1
```

2. Create the Operator under the namespace ag1 
```sh 
kubectl apply -f operator.yaml --namespace ag1
```

3. Create the secrets for sql server
```sh 
kubectl create secret generic sql-secrets –-from-literal=sapassword="Pa55w0rd2019" –-from-literal=masterkeypassword="masterPa55w0rd2019" --namespace ag1 
```

4. Create SQL Server 2019 Deployment of 3 Pods ( AG ) 
```sh 
kubectl apply -f sqlserver2019.yaml --namespace ag1
```

5. Create Load Balance Service 
```sh 
kubectl apply -f ag-service.yaml --namespace ag1
```
