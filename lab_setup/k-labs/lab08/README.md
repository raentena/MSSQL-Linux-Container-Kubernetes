# Lab08A
# Step 
Using Deployments for updating apps declaratively<br>
Open up 2 terminal connection to master node <br>

Perform these steps on terminal 1 <br>
```sh

kubectl get svc 
*remove unwanted svc 

kubectl delete rc --all
* remove all Replication Controller 

 cat kubia-deployment-and-service-v1.yaml
 kubectl create -f kubia-deployment-and-service-v1.yaml --record 
*Be sure to include the --record command-line option when creating it.
*This records the command in the revision history, which will be useful later.

 kubectl get svc
 kubectl get deployment
 kubectl describe deployment
 kubectl rollout status deployment kubia
 kubectl get pod
 kubectl get replicasets
```

Perform these steps on terminal 2 <br>
we are using ClusterIP type for service, check the IP <br>
```sh
  kubectl get svc kubia
  while true; do curl http://<kubia_app_ClusterIP>; sleep 5 ;  done
```

Perform these steps on terminal 1 <br>
```sh
kubectl set image deployment kubia nodejs=luksa/kubia:v2 --record
*this will perform the update from v1 to v2 of the app 

kubectl rollout history deployment kubia
kubectl get rs

```
# Lab08B
# Step 
Rolling back a deployment<br>
Make sure Terminal 2 still running the while loop <br>

```sh
kubectl get pods
kubectl set image deployment kubia nodejs=luksa/kubia:v3 --record
kubectl rollout history deployment kubia
kubectl get rs

kubectl rollout undo deployment kubia
kubectl rollout undo deployment kubia --to-revision=1
```

# Lab08C
# Step 
Blocking rollouts with readinessProbe<br>
Make sure Terminal 2 still running the while loop<br>
```sh
kubectl apply -f kubia-deployment-v3-with-readinesscheck.yaml

kubectl rollout status deployment kubia

kubectl get pods

kubectl rollout undo deployment kubia

kubectl rollout status deployment kubia

kubectl delete -f kubia-deployment-and-service-v1.yaml

```
You can control+c on terminal 2 to stop the while loop 

END