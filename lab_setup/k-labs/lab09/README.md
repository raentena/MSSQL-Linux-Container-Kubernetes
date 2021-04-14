# Lab09A
# Step 
Using init container


```sh
kubectl get pods
kubectl apply -f pod-with-initcontainer.yaml
kubectl get pods --watch

kubectl logs pod-with-initcontainer -c init-container-1 --timestamps=true
kubectl logs pod-with-initcontainer -c init-container-2 --timestamps=true

kubectl logs pod-with-initcontainer --timestamps=true 

kubectl get pods
kubectl delete pod pod-with-initcontainer 
```

# Lab09B
# Step 
Using a StatefulSet

```sh
kubectl get pv,pvc
kubectl get sc

kubectl get pod
kubectl get statefulsets

kubectl apply -f kubia-sc-class.yaml
kubectl apply -f kubia-service-headless.yaml

kubectl apply -f kubia-statefulset.yaml

kubectl get pv,pvc
kubectl get sc

kubectl get pod 
kubectl get statefulsets
kubectl get pods --watch

k apply -f kubia-service-public.yaml

**Playing with your Pods 
k get svc

**Hit the pods
curl (kubia-public IP address)

**post some data
curl -X POST -d "DataCON pan pan pan" (kubia-public IP address)
curl (kubia-public IP address)

**Directly post data to pods ( to simulate failure )
k get pod -o wide

curl (kubia-0 IP):8080
curl -X POST -d "DATA: Jedi" (kubia-0 IP):8080
curl (kubia-0 IP):8080

curl (kubia-1 IP):8080
curl -X POST -d "DATA: Sith" (kubia-1 IP):8080
curl (kubia-1 IP):8080

**Simulate POD failure
k get pods 
kubectl delete pods (the_SITH) --grace-period=0 --force
k get pods 
curl (kubia-public IP address)

**Simulate NODE failure ( DO NOT DO THIS ON PRODUCTION )
kubectl drain (node-name) --force --delete-local-data --ignore-daemonsets

k get pods -o wide

**Bring back the node
kubectl uncordon (node-name)
```

# Please clean up before moving to next LAB
```sh
kubectl get statefulsets
k delete statefulsets.apps (statefulset name)
k get pods

k delete pvc --all
k delete pv --all
k delete svc --all

ls /nfsdata/dat3 
delete all the sub folder under dat3
```

# LAB09C
# Steps
MongoDB StatefulSet 
```sh

ls /nfsdata/dat3/
cat mongo-statefulset.yaml

kubectl apply -f mongo-statefulset.yaml
k get pods --watch

```
# Please clean up before moving to next LAB
```sh
kubectl get statefulsets
k delete statefulsets.apps (statefulset name)
k get pods

k delete pvc --all
k delete pv --all
k delete svc --all

ls /nfsdata/dat3
delete all the sub folder under dat3
```


# Lab09D
- Running MySQL Replication with Stateful Sets
- refer: https://kubernetes.io/docs/tasks/run-application/run-replicated-stateful-application/
# Steps
```sh
kubectl apply -f mysql-configmap.yaml
k get cm

kubectl apply -f mysql-services.yaml
k get svc

kubectl apply -f mysql-statefulset.yaml 

kubectl get pods -l app=mysql --watch


** Create some DATA
kubectl run mysql-client --image=mysql:5.7 -i --rm --restart=Never --\
  mysql -h mysql-0.mysql <<EOF
CREATE DATABASE test;
CREATE TABLE test.messages (message VARCHAR(250));
INSERT INTO test.messages VALUES ('hello');
EOF

** Create some data on READ only POD/Service -- it will fail 
kubectl run mysql-client --image=mysql:5.7 -i --rm --restart=Never --\
  mysql -h mysql-read <<EOF
CREATE DATABASE test;
CREATE TABLE test.messages (message VARCHAR(250));
INSERT INTO test.messages VALUES ('hello WORLD 2');
EOF


kubectl run mysql-client --image=mysql:5.7 -i -t --rm --restart=Never --\
  mysql -h mysql-read -e "SELECT * FROM test.messages"


kubectl exec -it mysql-0  -- mysql
mysql> SELECT * FROM test.messages; 
mysql> exit; 

kubectl exec -it mysql-1  -- mysql
mysql> SELECT * FROM test.messages; 
mysql> exit; 

kubectl exec -it mysql-2  -- mysql
mysql> SELECT * FROM test.messages; 
mysql> exit; 


  
kubectl run mysql-client --image=mysql:5.7 -i -t --rm --restart=Never --\
  mysql -h mysql-read -e "SELECT @@server_id,NOW()"


**Run this on new terminal 
kubectl run mysql-client-loop --image=mysql:5.7 -i -t --rm --restart=Never --\
  bash -ic "while sleep 3; do mysql -h mysql-read -e 'SELECT @@server_id,NOW()'; done"

**Simulate POD failure
kubectl delete pod mysql-2

kubectl run mysql-client --image=mysql:5.7 -i -t --rm --restart=Never --\
  mysql -h mysql-read -e "SELECT * FROM test.messages"

**Scale the statefulsets
k get statefulsets.apps

k scale statefulset --replicas=5 mysql
k get pod --watch

kubectl exec -it mysql-3  -- mysql
mysql> SELECT * FROM test.messages; 
mysql> exit; 

kubectl exec -it mysql-4  -- mysql
mysql> SELECT * FROM test.messages;
mysql> exit;

k scale statefulset --replicas=2 mysql
kubectl exec -it mysql-0  -- mysql
mysql> SELECT * FROM test.messages; 
mysql> exit; 

kubectl exec -it mysql-1  -- mysql
mysql> SELECT * FROM test.messages;
mysql> exit;


ls -l /nfsdata/dat3/

k get pv
k get pvc

k scale statefulset --replicas=5 mysql
k get pod --watch

kubectl exec -it mysql-3  -- mysql
mysql> SELECT * FROM test.messages; 
mysql> exit; 

kubectl exec -it mysql-4  -- mysql
mysql> SELECT * FROM test.messages;
mysql> exit;

```
# Please clean up
```sh
kubectl get statefulsets
k delete statefulsets.apps mysql
k get pods

k delete pvc --all
k delete pv --all
k delete svc --all 
k delete cm --all 

ls /nfsdata/dat3
delete all the sub folder under dat3 
```
END