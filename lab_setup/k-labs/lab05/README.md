# Lab05A
# Step 
Using an emptyDir volume<br>
The yaml file will create 1 pod with 2 containers<br>
The html-generator container will run a script and generate index.html on /var/htdocs <br>
The web-server container will serve index.html from /usr/share/nginx/html/ <br>
Pod: fortune <br>
Container: html-generator mounts html <br>
Container: web-server mount html<br>
the volume html is a emptyDir type <br> 
see fortune-pod.yaml for settings <br>

```sh
cat fortune-pod.yaml
kubectl create -f fortune-pod.yaml

kubectl get po fortune -o=custom-columns=NAME:.metadata.name,CONTAINERS:.spec.containers[*].name

kubectl exec -i -t fortune --container html-generator  -- /bin/sh
cat /var/htdocs/index.html
exit

kubectl exec -i -t fortune --container web-server  -- /bin/sh
cat  /usr/share/nginx/html/index.html
exit
```

# Lab05B
# Step 
Using an hostPath volume <br>
The yaml file will create 2 pods (mongo-xxx), which will run on both worker node<br>
hostPath volume will mount local worker node path <br>
Data will persists on both worker node as separate data not shared <br>

```sh
cat mongodb-rc-pod-hostpath.yaml
kubectl create -f mongodb-rc-pod-hostpath.yaml

kubectl get pods -o wide

ssh node1.example.local 'ls /tmp/mongodb/'
ssh node2.example.local 'ls /tmp/mongodb/'

kubectl exec -it mongo-<pod1> -- mongo
> use mystore
> db.foo.insert({name:'foo Pan Pan'})
> db.foo.find()

kubectl exec -it mongo-<pod2> -- mongo
> use mystore
> db.bar.insert({name:'bar Pan Pan'})
> db.bar.find()

kubectl get pods
kubectl delete pods mongo-<pod1>
kubectl delete pods mongo-<pod1>

kubectl get pods
kubectl exec -it mongo-<new_pod1> -- mongo
> use mystore
> db.foo.find()

kubectl exec -it mongo-<new_pod2> -- mongo
> use mystore
> db.bar.find()
```

Cleanup 
```sh
kubectl get pods
kubectl get rc
kubectl delete rc mongo

kubectl get pods
kubectl get rc
```

# Lab05C
# Step
Using an NFS volume <br>
You will make the master.example.local node to act as a NFS server <br>
A rc that will bring 2 pods up <br>
Both pods will mount the NFS volume in master /nfsdata/dat1/ <br>
Data on both pod will be stored on NFS volume in master /nfsdata/dat1/ <br>

```sh
chmod +x nfssetup.sh 
./nfssetup.sh 

kubectl create -f alpine-rc-pod-nfs.yaml
kubectl get pods

master> ls /nfsdata/dat1/
master> cat  /nfsdata/dat1/dates.txt

```

# Lab05D
# Step
Using PersistentVolumes and PersistentVolumeClaims <br>
You will create PersistentVolumes and PersistentVolumeClaims <br>
Bring up a pod that uses claim (mongodb-pod-pvc-1.yaml) <br>

```sh
kubectl get pv
kubectl create -f mongodb-pv-nfs-1.yaml
kubectl get pv

kubectl get pvc
kubectl create -f mongodb-pvc-1.yaml
kubectl get pvc

kubectl create -f mongodb-pod-pvc-1.yaml

ls /nfsdata/dat2

kubectl exec -it mongodb1 -- mongo
> use mystore
> db.foo.insert({name:'foo Pan Pan'})
> db.foo.find()
exit

kubectl get pods
kubectl delete pods mongodb1
ls /nfsdata/dat1

kubectl get pv
kubectl get pvc
```

Cleanup 
```sh

kubectl delete -f mongodb-pvc-1.yaml

kubectl delete  -f mongodb-pv-nfs-1.yaml

```

# Lab05E
# Step
Using Dynamic provisioning of PersistentVolumes<br>
In order to use Dynamic provisioning, you need to use a provisioner <br>
Cloud based Kubernetes provides this, in bare metal (private) Kubernetes,you need to create provisioner <br>
Here you will deploy a NFS Provisioner and Storageclass <br>

```sh
 kubectl create -f nfs-provisioning/rbac.yaml
 kubectl create -f nfs-provisioning/deployment.yaml

 kubectl create -f nfs-provisioning/class.yaml
 kubectl get storageclass

 kubectl get pv
 kubectl get pvc
 ls /nfsdata/dat3/
 
 **This will create PersistentVolumeClaims ( we do need to create PersistentVolume )

 kubectl create -f nfs-provisioning/pvc-nfs.yaml
 kubectl get pv
 kubectl get pvc

 kubectl create -f    nfs-provisioning/busybox-pv-nfs.yaml
 kubectl get pods 
 ls /nfsdata/dat3/

 **Create another pod to take the claim 

 kubectl create -f nfs-provisioning/pvc-nfs2.yaml
 kubectl create -f    nfs-provisioning/busybox-pv-nfs2.yaml
 ls /nfsdata/dat3/

```

Cleanup
```sh
kubectl get pods
kubectl delete pods busybox
kubectl delete pods busybox2

kubectl delete pvc --all

 kubectl delete -f nfs-provisioning/class.yaml
 
```
END