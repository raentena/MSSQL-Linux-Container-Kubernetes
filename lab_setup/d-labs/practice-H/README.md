# Installing Portainer 

Deploy Portainer Server on a standalone LINUX Docker host/single node swarm cluster (or Windows 10 Docker Host running in “Linux containers” mode).
Use the following Docker commands to deploy the Portainer Server; note the agent is not needed on standalone hosts.

# Step 1 

```sh
docker volume create portainer_data
```

# Step 2 

```sh
docker run -d -p 9000:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer

```

# Step 3 

Navigate to port :9000 on your public IP and set a password to use 
* Beware, default installation of Portainer is NOT SECURE , it uses HTTP 
* DO NOT Use in Production ENV