# Lab07A
# Step 
Exposing metadata to pods 

```sh
cat downward-non-api.yaml
kubectl create -f downward-non-api.yaml

kubectl exec downward-no-api-env -- env | grep POD
kubectl exec -it downward-no-api-env -- sh
# env
# env | grep POD
# echo $NODE_NAME
# exit

cat downward-api-env.yaml
kubectl create -f downward-api-env.yaml

kubectl exec downward -- env | grep POD
kubectl exec -it downward -- sh
# env
# env | grep POD
# echo $NODE_NAME
# exit


```

# Lab07B
# Step 
Exposing metadata to pods using downwardAPI

```sh
kubectl delete -f downward-non-api.yaml
kubectl delete -f downward-api-env.yaml

kubectl create -f downward-api-volume.yaml

kubectl exec downward -- cat /etc/downward/labels
kubectl exec downward -- cat /etc/downward/annotations
kubectl exec -it downward -- sh

# cd /etc/downward/
# ls -l
# exit 

```
# Lab07C
# Step 
Exploring the Kubernetes REST API via curl

```sh
kubectl cluster-info
curl https://192.168.1.4:6443 -k

kubectl proxy & 

curl localhost:8001
curl http://localhost:8001/apis/batch
curl http://localhost:8001/api/v1/nodes/node1.example.local

jobs 
kill %1 
```

# Lab07D
# Step 
Communication between a Pod and Kubernetes REST API 

```sh

**UPDATE ( allow POD to reach the API - WARNING : NOT FOR PRODUCTION USE )
kubectl create clusterrolebinding permissive-binding --clusterrole=cluster-admin --group=system:serviceaccounts

kubectl create -f curl.yaml
kubectl exec -it curl -- sh
 # env | grep KUBERNETES_SERVICE
 # curl https://kubernetes
 # ls/var/run/secrets/kubernetes.io/serviceaccount/
 # export CURL_CA_BUNDLE=/var/run/secrets/kubernetes.io/serviceaccount/ca.crt
 # curl https://kubernetes
 # TOKEN=$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)
 # curl -H "Authorization: Bearer $TOKEN" https://kubernetes
 # NS=$(cat /var/run/secrets/kubernetes.io/serviceaccount/namespace) 
 # curl -H "Authorization: Bearer $TOKEN" https://kubernetes/api/v1/namespaces/$NS/pods
 # exit 
```

END