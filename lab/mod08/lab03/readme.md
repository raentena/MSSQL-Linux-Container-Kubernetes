![](./graphics/microsoftlogo.png)

# Workshop: SQL Server 2019 Workshop

#### <i>A Microsoft workshop from the SQL Server team</i>

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/textbubble.png?raw=true"><b>     SQL Server on Kubernetes</b></h2>

Kubernetes is an open source container orchestration engine for automating deployment, scaling, and management of containerized applications. The open source project is hosted by the Cloud Native Computing Foundation (CNCF).
 
Kubernetes comes with built-in basic high-availability, networking, storage, and container interfaces. You can read more about the Kubernetes platform at https://kubernetes.io/.

Kubernetes is deployed in both private and public clouds. It could be you deploying your own open-source Kubernetes cluster using or using Kubernetes in a cloud service like Azure Kubernetes Service (AKS).

A Kubernetes deployment is known as a cluster and consists of software components to run the cluster, and various objects such as nodes, pods, services, and storage.

In this module you will learn how to deploy, use, manage a SQL Server running in Kubernetes.

You will cover the following topics in this Module:

<dl>

  <dt><a href="#7-0">7.0 Deploying SQL Server on Kubernetes</a></dt>
  <dt><a href="#7-1">7.1 SQL Server High Availability on Kubernetes</a></dt>
    
</dl>

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/pencil2.png?raw=true"><b><a name="7-0">     7.0 Deploying SQL Server on Kubernetes</a></b></h2>

Since SQL Server is a stateful container application it is a perfect fit to deploy and use on a Kubernetes platform.

<h3><b><a name="challenge">The Challenge</a></b></h3>

Users that want to deploy SQL Server containers need a platform that supports built-in high availability, networking, and storage to power a SQL Server database. Users and developers who want to deploy multiple SQL Server containers need a scalable platform instead of having to manage all the containers manually.

<h3><b><a name="solution">The Solution</a></b></h3>

Kubernetes is a natural fit for these challenges. Kubernetes support built-in high availability through a concept called a ReplicaSet or StatefulSet using persistent volume storage.

Kubernetes comes built-in with networking services such as a Load Balancer and NodePort to expose connection information to a SQL Server no matter what it lives in the cluster.

Kubernetes is available as a consistent platform to run a SQL Server container on private and public clouds and supports built-in scalability for clusters needing hundreds or even thousands of containers. Kubernetes is the platform that powers SQL Server Big Data Clusters which you will learn more about in Module 09 of this workshop.

In this module you will learn the fundamentals of how to deploy and use a SQL Server container in a Kubernetes cluster. This module also includes activities to learn the built-in basic high availability Kubernetes provides SQL Server as a container application.

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b><a name="activity7.0">     Activity: Deploying SQL Server on Kubernetes</a></b></h2>

In this activity you will learn the basics of how to deploy a SQL Server container in a Kubernetes cluster. You will learn various aspects of deploying in Kubernetes including common patterns such a namespace, node, pod, service, persistent volume claim, deployment, and ReplicaSet.

This activity is designed to be used with an Azure Kubernetes Service (AKS) cluster but most of the scripts and steps can be used with any Kubernetes cluster. This activity only requires a single-node Kubernetes cluster with only 6Gb RAM. Therefore this activity could be used even on a minikube cluster. While this module could be used on a RedHat OpenShift cluster you should use the workshop specifically designed for RedHat OpenShift at https://github.com/Microsoft/sqlworkshops/tree/master/SQLonOpenShift.

One of the key elements to using Kubernetes is declarative programming. The **kubectl** tool communicates with the Kubernetes API Server to execute API in the cluster. Much of the API can be executed by applying a YAML file. You will use kubectl and a series of command and YAML files to deploy a pod with a SQL Server Container.

This activity assumes the following:

- You have access to a Kubernetes cluster
- You have installed the **kubectl** tool on your preferred client whether that be Windows, Linux, or MacOS. You can read more about how to install kubectl at https://kubernetes.io/docs/tasks/tools/install-kubectl/. Kubectl needs to be in the path on your computer.

>**NOTE**: *If at anytime during the Activities of this Module you need to "start over" you can run the script **cleanup.ps1** or **cleanup.sh** and go back to the first Activity in 7.0 and run through all the steps again.*

<h3><img style="margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkmark.png?raw=true"><b><a name="actvitysteps7.0">Activity Steps</a></b></h3>

All scripts for this activity can be found in the **sql2019workshop\07_SQLOnKubernetes\deploy** folder.

There are two subfolders for scripts to be used in different shells:

- **powershell** - Use scripts here for kubectl on Windows
- **bash** - Use these scripts for kubectl on Linux or MacOS

In this module, you will see the steps for kubectl on Powershell but the same sequence can be used with bash shell scripts.

**NOTE:** You may need to run the following command on your computer to execute Powershell scripts:

`Set-ExecutionPolicy -ExecutionPolicy RemoteSigned`

>**WARNING**: Run these scripts from powershell. Do not run these scripts from Windows Powershell ISE

**STEP 1: Connect to the cluster**

Consult your administrator for how to connect to your Kubernetes cluster. For Azure Kubernetes Service (AKS) you will use the Azure CLI (az) to get credentials to use kubectl. Modify the script **step1_connectcluster.ps1** to put in your *clustername* and *resource group*. 

>**NOTE**: For instructor led workshops, you instructor may provide you Azure credentials, the name of the Azure Resource Group, and AKS cluster name.*

In order to run these steps you must first login to Azure using the following command:

`az login`

Run the script **step1_connectcluster.ps1** which runs the following command:

```powershell
az aks get-credentials --resource-group <resource group> --name <clustername>
```
For example, if your *resource group* is called **myaksrg** and your *clustername* is called **myaks**, the command should look like this:

```powershell
az aks get-credentials --resource-group myaksrg --name myaks
```

When this command completes you should see a message like

<pre>Merged *clustername* as current context in *path*\.kube\config</pre>

where path is the *path* to your home directory on your computer.

**STEP 2: Create a namespace**

A Kubernetes namespace is a scope object to organize your Kubernetes deployment and objects from other deployments. Run the script **step2_create_namespace.ps1** which runs the following command:

```powershell
kubectl create namespace mssql
```
When this command completes you should see a message like

<pre>namespace/mssql created</pre>

**STEP 3: Set the default context**

To now deploy in Kubernetes you can specify which namespace to use with parameters. But there is also a method to set the *context* to the new namespace. 

**ST0P:** Modify the script **step3_setcontext.ps1** to put in your **clustername** and **resource group**.

>**NOTE**: For instructor led workshops, you instructor will provide you the name of the Azure Resource Group and AKS cluster name.*

Run the script **step3_setcontext.ps1** which runs these commands:

```Powershell
kubectl config set-context mssql --namespace=mssql --cluster=<clustername> --user=clusterUser_<resource group>_<clustername>
kubectl config use-context mssql
```

For example if your resource group is called **myaksrg** and your clustername is **myaks**, the following script should be modified to look like this:

```Powershell
kubectl config set-context mssql --namespace=mssql --cluster=myaks --user=clusterUser_myaksrg_myaks
kubectl config use-context mssql
```
When this command completes you should see messages like

<pre>Context "mssql" created.
Switched to context "mssql".</pre>

**STEP 4: Create a Load Balancer Service**

Deploy objects in Kubernetes is done in a declarative fashion. One of the key objects to create is a LoadBalancer service which is supported by default in Azure Kubernetes Service (AKS). A LoadBalancer provides a static public IP address mapped to a public IP address in Azure. You will be able to map the LoadBalancer to a SQL Server deployment including a port to map to the SQL Server port 1433. Non-cloud Kubernetes clusters also support a similar concept called a NodePort.

Run the script **step4_create_service.ps1** to create the Load Balancer. This script uses the following command to create the LoadBalancer

```Powershell
kubectl apply -f sqlloadbalancer.yaml --record
```
This is an example of declarative programming with Kubernetes. The contents of the sqlloadbalancer.yaml file looks like this:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: mssql-service
spec:
  selector:
    app: mssql
  ports:
    - protocol: TCP
      port: 31433
      targetPort: 1433
  type: LoadBalancer
```
The **kind:Service** is the built-in support for a Service in Kubernetes with a **type: LoadBalancer**. The name of the service is mssql-service which you will use when deploying the pod later in this Activity. The **app:mssql** is a *label* which can be used for various ways to refer to a collection of objects of the same project. In this case the label is being used as a *label selector* for the service. Any pod deployed with the mssql label will be bound to the LoadBalancer. Finally, the **ports:** section declares the protocol and how to map a public port to the port in the container of the pod which for SQL Server is 1433.

When this command completes you should see a message like:

<pre>service/mssql-service created</pre>

The creation of the LoadBalancer service happens in the background. You will check the status of this service being created later in this Activity.

**STEP 5: Create a secret to hold the sa password**

In order to use a password to connect to SQL Server, Kubernetes provides an object called a *secret*. Use the script **step5_create_secret.ps1** to create the secret which runs the following command: (You are free to change the password but you will need to use the new password later in this Activity to connect to SQL Server)

```Powershell
kubectl create secret generic mssql-secret --from-literal=SA_PASSWORD="Sql2019isfast"
```
The name of the secret is called mssql-secret which you will need when deploying a pod later in this Activity.

When this command completes you should see the following message:

<pre>secret/mssql-secret created</pre>

You cannot retrieve the plaintext of the password from the secret later so you need to remember this password.

**STEP 6: Create persistent storage for databases**

SQL Server needs persistent storage for databases and files. This is a similar concept to using a volume with containers to map to directories in the SQL Server container. Disk systems are exposed in Kubernetes as a **StorageClass**. Azure Kubernetes Service (AKS) exposes a StorageClass called **managed-premium** which is mapped to Azure Premium Storage. Applications like SQL Server can use a Persistent Volume Claim (PVC) to request storage from the azure-disk StorageClass.

Execute the script **step6_create_storage.ps1** to create a Persistent Volume Claim using the following command:

```Powershell
kubectl apply -f storage.yaml
```
The **storage.yaml** file declare the PVC request:

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: mssql-data
  annotations:
    volume.beta.kubernetes.io/storage-class: managed-premium
spec:
  accessModes:
  - ReadWriteOnce
  resources:
    requests:
      storage: 8Gi
```
The name of the PVC is mssql-data which will be used to map to the SQL Server container directory for databases when deploying the pod. The **annotations:** maps the PVC to the managed-premium StorageClass. The rest of the declaration specifies how to access the PVC which is ReadWriteOnce. ReadWriteOnce means *one node a time* in the cluster can access the PVC. The size of the PVC in this case is 8Gb which for the purposes of this activity is plenty of space.

When this command completes you should see the following message:

<pre>persistentvolumeclaim/mssql-data created</pre>

**STEP 7: Deploy a pod with a SQL Server container**

Now that you have deployed a LoadBalancer service, a secret, and a Persistent Volume Claim (PVC),you have all the components to deploy a pod running a SQL Server container. To deploy the pod you will use a concept called **Deployment** which provides the ability to declare a **ReplicaSet**. Run the script **step7_deploy_sql2019.ps1** and after it executes you will analyze the details of the deployment. This scripts runs the command:

```Powershell
kubectl apply -f sql2019deployment.yaml --record
```

When this command completes you should see the following message:

<pre>deployment.apps/mssql-deployment created</pre>

The pod is deployed in the background. Before you check on the status of the deployment, examine the contents of the **sql2019deployment.yaml** file:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: mssql-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: mssql
  strategy:
    type: Recreate
  template:
    metadata:
      labels:
        app: mssql
    spec:
      terminationGracePeriodSeconds: 10
      securityContext:
        fsGroup: 1000
      containers:
      - name: mssql
        image: mcr.microsoft.com/mssql/rhel/server:2019-latest
        securityContext:
          runAsUser: 0
        env:
        - name: MSSQL_PID
          value: "Developer"
        - name: ACCEPT_EULA
          value: "Y"
        - name: MSSQL_SA_PASSWORD
          valueFrom:
            secretKeyRef:
              name: mssql-secret
              key: SA_PASSWORD 
        volumeMounts:
        - name: mssqldb
          mountPath: /var/opt/mssql
      volumes:
      - name: mssqldb
        persistentVolumeClaim:
          claimName: mssql-data
```
Here are important components of the yaml file

```yaml
kind: Deployment
metadata:
  name: mssql-deployment
```

This defines the name of the deployment

```yaml
spec:
  replicas: 1
  selector:
    matchLabels:
      app: mssql
  template:
    metadata:
      labels:
        app: mssql
```
This defines a ReplicaSet of 1 for the deployment. This is a key component of basic high availability. Kubernetes will try to ensure at least one pod for this container is always Running in the cluster. You will learn more how this works in the next Activity. Labels for mssql are also used for the deployment and pod. This automatically associates the LoadBalancer service with the pod because of the use of the mssql label.

```yaml
   spec:
      terminationGracePeriodSeconds: 10
      securityContext:
        fsGroup: 1000
      containers:
      - name: mssql
        image: mcr.microsoft.com/mssql/rhel/server:2019-latest
        env:
        - name: MSSQL_PID
          value: "Developer"
        - name: ACCEPT_EULA
          value: "Y"
        - name: MSSQL_SA_PASSWORD
          valueFrom:
            secretKeyRef:
              name: mssql-secret
              key: SA_PASSWORD
```
This section defines key element of how to deploy a container for the pod. This includes the image for the containers (which is the latest SQL 2019 image based on Red Hat Enterprise Linux), the edition for SQL Server, accepting the EULA agreement, and the sa password based on the previous defined secret.

```yaml
       volumeMounts:
        - name: mssqldb
          mountPath: /var/opt/mssql
      volumes:
      - name: mssqldb
        persistentVolumeClaim:
          claimName: mssql-data
```
This final section maps the Persistent Volume Claim (PVC) with the directory /var/opt/mssql in the container in the pod. Now any file stored in that directory in the container will be stored in the PVC.

**STEP 8: Check the deployment and pod status**

Check the status of the deployment and pod by executing the script **step8_check_deployment.ps1**which runs these commands:

```Powershell
kubectl get pods
kubectl get all
```
If the deployment was successful, the results should look like the following:

<pre>
NAME                                READY   STATUS    RESTARTS   AGE
mssql-deployment-68769447bc-2rw7q   1/1     Running   0          19m
NAME                                    READY   STATUS    RESTARTS   AGE
pod/mssql-deployment-68769447bc-2rw7q   1/1     Running   0          19m

NAME                    TYPE           CLUSTER-IP    EXTERNAL-IP       PORT(S)           AGE
service/mssql-service   LoadBalancer   10.0.97.225   104.209.223.215   31433:32240/TCP   80m

NAME                               READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/mssql-deployment   1/1     1            1           19m

NAME                                          DESIRED   CURRENT   READY   AGE
replicaset.apps/mssql-deployment-68769447bc   1         1         1       19m</pre>

In this example output, the name of the pod is mssql-deployment-68769447bc-2rw7q. Your name will be different but start with mssql-deployment.

They key aspects to this output are the STATUS of the pod which should be Running and the EXTERNAL-IP for the LoadBalancer will should be a valid IP address. If the service is still being created it will have an EXTERNAL-IP value of *Pending*. The deployment is on the last line of the output and if the pod is successfully running, READY will be 1. The LoadBalancer status is independent of the Deployment status.

Before trying to connect to SQL Server, examine other details of the pod and container.

If your deployment has not completed, continue through the Activity and check it again before running queries against SQL Server in STEP 12.

**STEP 9: Look at logs from the pod**

You can examine the contents of logs from the container in the pod by executing the script **step9_getlogs.ps1** which runs the following command:

```Powershell
kubectl logs -l app=mssql --tail=100000
```
In this case we can take advantage of the mssql label instead of having to discover the exact name of the pod.

Your output should be the standard SQL Server ERRORLOG output.

**STEP 10: Look at events from the cluster**

One way to gain insights for the cluster *for the current namespace* is to look at *events*. Events are a sequence of actions performed across the cluster. They can be used to gain insights across the cluster especially if there are issues. Execute the script **step10_getevents.ps1** which runs the following command:

```Powershell
kubectl get events
```
Your results should look similar to the following because these are the events for the current namespace that have occurred in the cluster:

<pre>
LAST SEEN   TYPE     REASON                   OBJECT                                  34m         Normal   ProvisioningSucceeded    persistentvolumeclaim/mssql-data         Successfully provisioned volume pvc-a5349fbd-edfb-11e9-9a90-66910c93f627 using kubernetes.io/azure-disk
32m         Normal   Scheduled                pod/mssql-deployment-68769447bc-2rw7q    Successfully assigned mssql/mssql-deployment-68769447bc-2rw7q to aks-nodepool1-90949249-2
31m         Normal   SuccessfulAttachVolume   pod/mssql-deployment-68769447bc-2rw7q    AttachVolume.Attach succeeded for volume "pvc-a5349fbd-edfb-11e9-9a90-66910c93f627"
31m         Normal   Pulled                   pod/mssql-deployment-68769447bc-2rw7q    Container image "mcr.microsoft.com/mssql/rhel/server:2019-latest" already present on machine
31m         Normal   Created                  pod/mssql-deployment-68769447bc-2rw7q    Created container mssql
31m         Normal   Started                  pod/mssql-deployment-68769447bc-2rw7q    Started container mssql
32m         Normal   SuccessfulCreate         replicaset/mssql-deployment-68769447bc   Created pod: mssql-deployment-68769447bc-2rw7q
32m         Normal   ScalingReplicaSet        deployment/mssql-deployment              Scaled up replica set mssql-deployment-68769447bc to 1</pre>

You can see the sequence of events to deploy the pod and run a container in the pod.

**STEP 11: Look at details of the pod**

Kubernetes also provides the ability to gain insights into the details of the pod deployment by *describing* the pod. Run the script **step11_describe_pod.ps1** which runs the following command:

```Powershell
kubectl describe pod -l app=mssql
```
This command is another example of the advantage of using a label so you don't have to specify the exact pod name.

The output of this command is lengthy but provides details of the pod including what node it was schedule to deploy on, details about the container, and sequence of specific events to deploy the pod.

**STEP 12: Run a query against SQL Server**

Now using the LoadBalancer service as the "servername" which includes a port you can run a query against SQL Server deployed in the pod. Use the script **step12_querysql.ps1** to run a query to find the version of SQL Server. The script uses Powershell to dynamically find the EXTERNAL IP address of the Load Balancer service with this command (Note: the bash shell equivalent uses grep and awk):


```powershell
$Service = kubectl get service | Select-String -Pattern mssql-service | Out-String
$Service = $Service.split(" ")
$Server+="-S"
$Server+=$Service[9]
$Server+=",31433"
sqlcmd '-Usa' '-PSql2019isfast' $Server '-Q"SELECT @@version"'
```

The result of the query should provide a result of the SQL Server version which can vary given the image is based on the latest SQL Server 2019 build using Red Hat Enterprise Linux.

As a **bonus activity**, try to connect to SQL Server in the pod using SQL Server Management Studio or Azure Data Studio. The server name is the External IP address of the LoadBalancer and the port of 31433.

When you are done proceed to the **Activity Summary** section for the Activity below.

<h3><b><a name="activitysummary">Activity Summary</a></b></h3>

In this activity you have learned the fundamentals of deploying SQL Server with Kubernetes. You have learned various Kubernetes objects used to deploy SQL Server including a node, pod, secret, LoadBalancer, Persistent Volume Claim, and deployment.

This deployment is required to proceed and complete the next activity.

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/pencil2.png?raw=true"><b><a name="7-1">     7.1 Advanced: SQL Server High Availability on Kubernetes</a></b></h2>

Kubernetes comes built-in with capabilities to support a basic high availability solution for a containerized stateful application. In this module you will learn how SQL Server high availability can be achieved through Kubernetes. Always On Availability Groups are not covered in this module. Always On Availability Groups are supported through the Big Data Clusters solution but are not yet supported outside of that solution on Kubernetes.

<h3><b><a name="challenge">The Challenge</a></b></h3>

Containers provide many advantages for applications including consistency, portability, reduced footprint, and faster patching. Container runtimes do not provide any type of built-in high availability which is critical for a data platform like SQL Server.

<h3><b><a name="solution">The Solution</a></b></h3>

Kubernetes has built-in capabilities to provide high-availability through the concepts of a ReplicaSet (or StatefulSet) combined with Persistent Storage and a Load Balancer. In this module you will learn how to use all of these components with SQL Server on Kubernetes.

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b><a name="activity7.1">     Advanced Activity: Testing High Availability for SQL Server on Kubernetes</a></b></h2>

>**STOP**: This activity requires you go through all the steps in Activity 7.0 first.

This activity will walk you the concepts and scenarios for how Kubernetes provides basic high availability for a SQL Server instance. You will see how the LoadBalancer can be used to consistently connect to SQL Server even if the Private IP address of the pod changes. You will also observe the system databases all remain intact even if the SQL Server container is restarted because these databases are stored on a Persistent Volume Claim (PVC).

>**NOTE**: *If at anytime during the Activities of this Module you need to "start over" you must go back and do all the steps in the Activity for 7.0 in this Module.*

<h3><img style="margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkmark.png?raw=true"><b><a name="actvitysteps7.1">Activity Steps</a></b></h3>

All scripts for this activity can be found in the **sql2019workshop\07_SQLOnKubernetes\ha** folder. Because this is a continuation of Activity 7.0, the steps will start with STEP 13.

**STEP 13: Create a new database on SQL Server**

Connect to SQL Server deployed in Kubernetes and create a new database. Use the script **step13_createdb.ps1** to create the database and query all databases in master. The script runs the following command (using the same technique as in Activity 7.0 to dynamically connect to SQL Server using the Load Balancer)


```powershell
$Service = kubectl get service | Select-String -Pattern mssql-service | Out-String
$Service = $Service.split(" ")
$Server+="-S"
$Server+=$Service[9]
$Server+=",31433"
sqlcmd '-Usa' '-PSql2019isfast' $Server '-Q"CREATE DATABASE sqlk8s;SELECT name FROM sys.databases"'
```

The result of the command should be a list of databases that includes system databases and sqlk8s.

**STEP 14: Get the status of running pods**

Get the status of running pods in the mssql namespace which includes STATUS and the private IP address associated with the pod. Use the script **step14_getpods.ps1** which runs the following command:

```Powershell
kubectl get pods -o wide
```
Your results should look similar to the following (the NAME, IP, and NODE will likely be different)

<pre>NAME                                READY   STATUS    RESTARTS   AGE     IP            NODE                       NOMINATED NODE   READINESS GATES
mssql-deployment-68769447bc-zmgff   1/1     Running   0          7m35s   10.244.2.17   aks-nodepool1-90949249-2   <none>           <none></pre>

**STEP 15: Crash SQL Server**

Because was deployed with a Replicas value of 1, Kubernetes will attempt to ensure all containers in the pod are Running. If the container crashes in the pod, Kubernetes will automatically restart it. Simulate this behavior by running the script **step15_crashsql.ps1** which runs the following command:

```powershell
$Service = kubectl get service | Select-String -Pattern mssql-service | Out-String
$Service = $Service.split(" ")
$Server+="-S"
$Server+=$Service[9]
$Server+=",31433"
sqlcmd '-Usa' '-PSql2019isfast' $Server '-Q"SHUTDOWN WITH NOWAIT"'
```
When this command completes you should see the following message:

<pre>Server shut down by NOWAIT request from login sa.</pre>

**STEP 16: Check status and IP address of running pods**

Check the status of the pod with the SQL Server by running the script **step16_getpods.ps1** which runs the following command (the same command in STEP 14)

```Powershell
kubectl get pods -o wide
```
Your results should look similar as in STEP 14. The name of the pod, STATUS, and IP are all the same. Notice the column RESTARTS now is a value of 1, indicating that Kubernetes has automatically restarted the containers in the pod.

**STEP 17: Query SQL Server**

To validate SQL Server is up and running with the same set of databases, run the script **step17_querysql.ps1** which runs the following command:

```powershell
$Service = kubectl get service | Select-String -Pattern mssql-service | Out-String
$Service = $Service.split(" ")
$Server+="-S"
$Server+=$Service[9]
$Server+=",31433"
sqlcmd '-Usa' '-PSql2019isfast' $Server '-Q"SELECT @@VERSION;SELECT name FROM sys.databases"'
```
Your results should be the same version of SQL Server as it was first deployed and the same set of databases from STEP 13.

**STEP 18: Simulate a pod failure**

If the pod has a failure in the Kubernetes cluster, Kubernetes will automatically schedule a new pod with the same set of containers. The Private IP address of the pod may change but you can still connect to the same SQL Server using the LoadBalancer which will map to the new Private IP address. Use the script **step18_podfailure.ps1** which runs the following command:

```Powershell
kubectl delete pod -l app=mssql
```
When this command completes, you should see the following message (your pod name will likely be different)

<pre>pod "mssql-deployment-68769447bc-55zwx" deleted</pre>

**STEP 19: Check status and IP address of running pods**

Check the status and IP of the pod by running the script **step19_getpods.ps1** which runs the following command:

```Powershell
kubectl get pods -o wide
```
The results of this command will yield a new pod NAME and a new IP address. If you have deployed a mulit-node cluster the name of the NODE may be different as well. If your pod was deployed on a new node and SQL Server was never deployed on that node, it could take longer to deploy the pod to pull the container image.

**STEP 20: Query SQL Server**

Even though the new pod has a new IP address and was rescheduled, the LoadBalancer is redirected to the pod and the databases are still intact. Use the script **step20_querysql.ps1** which runs the following command.

Take time to examine how the Powershell script is written to dynamically retrieve the LoadBalancer IP address and use that to connect to SQL Server:

```powershell
$Service = kubectl get service | Select-String -Pattern mssql-service | Out-String
$Service = $Service.split(" ")
$Server+="-S"
$Server+=$Service[9]
$Server+=",31433"
sqlcmd '-Usa' '-PSql2019isfast' $Server '-Q"SELECT @@VERSION;SELECT name FROM sys.databases"'
```
Your results should be the same SQL Server version and same set of databases. The LoadBalancer redirected your queries to the new pod and IP address.

**STEP 21: Cleanup resources**

Cleanup all deployed resources by running the script **cleanup.ps1**. This will delete the mssql namespace which delete all objects created in this activity. This shows another convenience of using a namespace since a single command can remove all objects created in that namespace.

When you are done proceed to the **Activity Summary** section for the Activity below.

<h3><b><a name="activitysummary">Activity Summary</a></b></h3>

Your learned in this activity how Kubernetes provides basic high-availability for SQL Server in the case of an issue with the container or pod. Kubernetes will also the ReplicaSet concept to schedule a new pod on a new node should one of the nodes become available in the cluster (assuming a multi-node cluster).

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/owl.png?raw=true"><b>     For Further Study</b></h2>

- [The Kubernetes Main Website](https://kubernetes.io/)

- [What is Kubernetes?](https://azure.microsoft.com/en-us/topic/what-is-kubernetes)

- [Azure Kubernetes Service](https://azure.microsoft.com/en-us/services/kubernetes-service/)

- [Deploy SQL Server in Azure Kubernetes Service](https://docs.microsoft.com/en-us/sql/linux/tutorial-sql-server-containers-kubernetes)

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/geopin.png?raw=true"><b>     Next Steps</b></h2>

Next, Continue to <a href="./08_DataVirtualization.md" target="_blank"><i>Data Virtualization</i></a>.
