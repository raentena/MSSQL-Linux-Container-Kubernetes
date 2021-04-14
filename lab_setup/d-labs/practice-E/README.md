# Install docker-compose 

Install Compose on Linux systems
On Linux, you can download the Docker Compose binary from the Compose repository release page on GitHub. Follow the instructions from the link, which involve running the curl command in your terminal to download the binaries. Refer these step-by-step instructions below.

# Step 1 

```sh
curl -L "https://github.com/docker/compose/releases/download/1.26.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
```

# Step 2 

```sh
chmod +x /usr/local/bin/docker-compose
```

# Step 3 

```sh
docker-compose -v
```