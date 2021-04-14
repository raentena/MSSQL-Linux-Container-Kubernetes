# Lab06A
# Step 
Passing an argument in the pod definition

```sh
cat fortune-args/fortuneloop.sh

cat fortune-pod-args.yaml
**You can change the ARG Value.

kubectl apply -f fortune-pod-args.yaml

kubectl get pods -o wide
curl <ip_address_pod> ( * you have to wait 2 sec before the fortune changes 
watch -n1 curl <ip_address_pod> 
```

# Lab06B
# Step 
Setting environment variables for a container

```sh
cat fortune-env/fortuneloop.sh
cat fortune-pod-env.yaml 
kubectl create -f fortune-pod-env.yaml

kubectl get pods -o wide
curl <ip_address_pod>   ( * you have to wait 30 sec before the fortune changes )
watch -n1 curl <ip_address_pod> 
```

# Lab06C
# Step 
Creating ConfigMaps 

```sh
kubectl create -f fortune-config.yaml
kubectl get configmaps
kubectl get configmaps -o yaml 

cat fortune-pod-env-configmap.yaml
kubectl create -f fortune-pod-env-configmap.yaml

kubectl get pods -o wide
curl <ip_address_pod>   ( * you have to wait 25 sec before the fortune changes )
watch -n1 curl <ip_address_pod>
```

# Lab06D
# Step 
ConfigMap volume 


```sh
kubectl delete configmap fortune-config

ls -l ./configmap-files
cat configmap-files/my-nginx-config.conf
cat configmap-files/sleep-interval

kubectl create configmap fortune-config --from-file=configmap-files
kubectl get configmap fortune-config -o yaml

cat fortune-pod-configmap-volume.yaml
kubectl create -f fortune-pod-configmap-volume.yaml

kubectl get pods  -o wide

curl -H "Accept-Encoding: gzip" -I <POD_IP_Address>

kubectl exec fortune-configmap-volume -c web-server -- ls /etc/nginx/conf.d

```
# Lab06E
# Step
Creating Secrets <br>
Create your own little Secret. You’ll improve your fortune-serving Nginx <br>
container by configuring it to also serve HTTPS traffic. For this, you need to create a<br>
certificate and a private key. The private key needs to be kept secure, so you’ll put it<br>
and the certificate into a Secret. <br>

```sh
kubectl delete configmap fortune-config

openssl genrsa -out https.key 2048

openssl req -new -x509 -key https.key -out https.cert -days 3650 -subj /CN=www.kubia-example.com

kubectl create secret generic fortune-https --from-file=https.key --from-file=https.cert --from-file=foo

kubectl get secret fortune-https -o yaml

ls -l ./configmap-files-https

cat configmap-files-https/my-nginx-config.conf

cat configmap-files/sleep-interval

kubectl create configmap fortune-config --from-file=configmap-files-https

kubectl  create -f fortune-pod-https.yaml

kubectl get pods -o wide

  curl   https://<fortune-https_pod_ip> -k 
  curl   https://<fortune-https_pod_ip> -k -v 

kubectl exec fortune-https -c web-server -- mount | grep certs

```
END