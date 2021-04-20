# wwi-webapp Docker Setup

# Step 1 

Make sure you have cloned this repo

# Step 2 

`cd src/config/`

# Step 3 

`vim dbconfig.json` 

>> Change the user, password, server and port ( whichever needed )
>> server should be pointing to an actual SQL server that has WideWorldImporters DB ( can use IP Address )

# Step 4 

Run the docker build script to build docker image locally 

`chmod +x docker_build.sh <Docker_HUB_ID>  && ./docker_build.sh` 

# Step 5

Verify the image is build 

`docker images` 

# Step 6 

