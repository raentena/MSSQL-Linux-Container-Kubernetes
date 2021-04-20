# Lab04A

# Step 
Create Service and Test the Service

```sh
kubectl create -f kubia-svc.yaml
kubectl create -f kubia.yaml

kubectl get svc
kubectl get pods -o wide

curl <ip_pod>:8080
curl <ip_svc>

kubectl get pods  -o wide

curl <ip_pod_1>:8080
curl <ip_pod_2>:8080

kubectl get svc
curl <ip_svc>
curl <ip_svc>
```

# Lab04B
# Step
Create NodePort Service and Test the Service

```sh
kubectl create -f kubia-svc-nodeport.yaml

curl <public_ip_vm002>:30123

curl 192.168.1.4:30123
curl 192.168.1.5:30123
curl 192.168.1.6:30123
```

# Lab04C
# Step
Create LoadBalancer Service and Test the Service
```sh
kubectl create -f kubia-svc-loadbalancer.yaml
kubectl get svc
```
Here, you will see External IP is in Pending State forever 

The Reason behind this is, we are not running our VM/System under Cloud Provided Kubernetes, therefore We Don't have External LoadBalancer to give us IP address 

# Lab04D
# Step 1
Setup HAproxy to act as LoadBalancer 

```sh
master#> chmod +x haproxy.sh 

master#> ./haproxy.sh 
```

# Step 2
Setup Ingress Controller using nginx
```sh
kubectl apply -f common/ns-and-sa.yaml

kubectl apply -f common/default-server-secret.yaml

kubectl apply -f common/nginx-config.yaml

kubectl apply -f rbac/rbac.yaml

kubectl apply -f daemon-set/nginx-ingress.yaml
```

# Step 3
Deploy Ingress based Service 

```sh
kubectl create -f kubia-ingress.yaml
kubectl get ingresses
```

ADDRESS = vm002 Public IP address ( Check in Azure ) <br>
You can add the following line to /etc/hosts (or C:\windows\system32\drivers\etc\hosts on Windows):

(ADDRESS)  kubia.example.com

Use your Web browser and reach http://kubia.example.com

# Step 4
Deploy Ingress based Service 

Deploy Red and Blue svc, rc and single ingress to route to both services

```sh
kubectl apply -f  multi-ingress/kubia-red-svc.yaml

kubectl apply -f multi-ingress/kubia-red-rc.yaml

kubectl apply -f multi-ingress/kubia-blue-svc.yaml

kubectl apply -f multi-ingress/kubia-blue-rc.yaml

kubectl apply -f multi-ingress/kubia-rb-ingress.yaml

kubectl get ingresses
```
ADDRESS = vm002 Public IP address ( Check in Azure ) <br>
You can add the following line to /etc/hosts (or C:\windows\system32\drivers\etc\hosts on Windows):

(ADDRESS)  kubiared.example.com <br>
(ADDRESS)  kubiablue.example.com

Use your Web browser and reach http://kubiared.example.com and http://kubiablue.example.com

END