# Lab10A
# Step 
Limiting resources available to a pods/containers
```sh

**Request Resource 

cat requests-pod.yaml

kubectl apply -f requests-pod.yaml 

kubectl exec -it requests-pod -- sh 
> top 
> exit


kubectl run requests-pod-2 --image=busybox --restart Never --requests='cpu=800m,memory=20Mi' -- dd if=/dev/zero of=/dev/null 

kubectl run requests-pod-3 --image=busybox --restart Never --requests='cpu=1,memory=20Mi' -- dd if=/dev/zero of=/dev/null 

kubectl run requests-pod-4 --image=busybox --restart Never --requests='cpu=1,memory=20Mi' -- dd if=/dev/zero of=/dev/null 

kubectl run requests-pod-5 --image=busybox --restart Never --requests='cpu=1,memory=20Mi' -- dd if=/dev/zero of=/dev/null 

ssh node1.example.local 
top 
exit

ssh node1.example.local
top
exit

kubectl describe po requests-pod-5

k get pods 
kubectl delete po requests-pod-4 --force
k get pods 

k delete pod requests-pod-2 requests-pod-3 requests-pod-5 requests-pod  --force 

**Explore limits
k create -f limited-pod.yaml

k get pods -o wide

k describe nodes (node where the pod is running)

k delete  -f  limited-pod.yaml --force

**Some memory test 

k apply -f memoryhog.yaml
k get pods --watch 

**Check the detail on what happen? 
kubectl describe pod memoryhog 

k delete -f memoryhog.yaml --force 

**Explore limitsranges
k apply -f limits.yaml
k get limitranges

k describe limitranges example

k apply -f kubia-manual.yaml
k get pod

k describe pod kubia-manual

```
# Lab10B
# Step 
ResourceQuota
```sh

* create NameSpace 
kubectl create namespace jedi
kubectl create namespace sith 


* run create_user_namespace.sh to generate kubeconfig 
chmod +x create_user_namespace.sh
./create_user_namespace.sh jedi
./create_user_namespace.sh sith


* create hard pod limit 
kubectl apply -f quota-pod_jedi.yaml --namespace=jedi 

kubectl apply -f quota-pod_sith.yaml --namespace=sith


* create linux user 
useradd jedi1 
useradd sith1

* copy the config file to home dir of each 
cp jedi_kubeconfig   ~jedi1 

cp sith_kubeconfig   ~sith1 


* copy quota_test_jedi.yaml to jedi1 user $HOME
cp quota_test_jedi.yaml  ~jedi1

* copy quota_test_sith.yaml to sith1 user $HOME
cp quota_test_sith.yaml  ~sith1


* set .bashrc to call the kubeconfig file on each home dir 
echo "export KUBECONFIG=/home/jedi1/jedi_kubeconfig"  >> ~jedi1/.bashrc 
echo "export KUBECONFIG=/home/sith1/sith_kubeconfig"  >> ~sith1/.bashrc 

* update Access

chown -R jedi1:jedi1  ~jedi1/* 

chown -R sith1:sith1  ~sith1/*

su - jedi1 
kubectl apply -f quota_test_jedi.yaml
*check the pods / deployments 

*on another Terminal 
su - sith1 
kubectl apply -f quota_test_sith.yaml
*check the pods / deployments 
```

END