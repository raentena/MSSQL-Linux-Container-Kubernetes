# SQL Server 2019 Availability Groups with Kubernetes

    >> Make sure you have already configured aks on Azure to Run this

### Steps

1. Create the namespace 


```sh 
kubectl create namespace ag1
```

2. Create the Operator under the namespace ag1 
```sh 
kubectl apply -f operator.yaml –namespace ag1
```