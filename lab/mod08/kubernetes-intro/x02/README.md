#  Lab02 - Pods 


# Step 1 

Create and Verify your pod 

To create the pod from your YAML file, use the kubectl create command:

```sh
 kubectl create -f kubia-manual.yaml 
 kubectl get po kubia-manual -o yaml
 kubectl get po kubia-manual -o json
 kubectl get pods
```

# Step 2 

To see your pod’s log (more precisely, the container’s log) you run the following command on your local machine (no need to ssh anywhere):
```sh
kubectl logs kubia-manual
```

# Step 3 
Now, you’ll be creating a new pod with two labels. Use the file called kubia-manual-with-labels.yaml 

```sh
kubectl create -f kubia-manual-with-labels.yaml
kubectl get po --show-labels
kubectl get po -L creation_method,env
```

# Step 4 
Labels can also be added to and modified on existing pods. 
```sh
kubectl label po kubia-manual creation_method=manual
kubectl label po kubia-manual-v2 env=debug --overwrite
kubectl get po -L creation_method,env
kubectl get po -l creation_method=manual
kubectl get po -l env
kubectl get po -l '!env'
```

# Step 5
Labels can be attached to any Kubernetes object, including nodes
```sh
kubectl label node node1.example.local gpu=true
kubectl get nodes -l gpu=true

```

# Step 6

To ask the scheduler to only choose among the nodes that provide a GPU, you’ll
add a node selector to the pod’s YAML
```sh
kubectl create -f kubia-gpu.yaml
```

# Step 7
list all namespaces in your cluster:
```sh
kubectl get ns
kubectl get po --namespace kube-system
```

# Step 8 
A namespace is a Kubernetes resource like any other, so you can create it by posting a
YAML file to the Kubernetes API server

```sh
 kubectl create -f custom-namespace.yaml
```
or
```sh
kubectl create namespace custom-namespace
kubectl create -f kubia-manual.yaml -n custom-namespace
```

# Step 9 
You’re going to stop all of of the pods now, because you don’t need them anymore
```sh
kubectl delete po kubia-gpu
kubectl delete po -l creation_method=manual
kubectl delete ns custom-namespace
kubectl delete po --all
```

# Step 10 

Delete everthing ....opss 

```sh
kubectl delete all --all
kubectl get pods --all-namespaces
```

END
