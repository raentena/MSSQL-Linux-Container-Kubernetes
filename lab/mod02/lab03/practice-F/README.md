# Using Docker-Compose

# Exercise 1 
### Use docker-compose to build a container and bring up multi container env
>> all steps to be performed in vm002 
>> please stop and remove all other containers before proceeding. 


1. Navigate to Demo1 dir

2. Examine Dockerfile and docker-compose.yml 

    `cat Dockerfile` 

    * Dockerfile have the instructions on how to build the node js application container (node-app)

    `cat docker-compose.yml` 

    * docker-compose.yml have instruction on how to build multi container named :  node-app ( build )  and redis ( will pull )

3. using the docker-compose.yml

    `docker-compose up -d`

4. verify the Containers 

    `docker-compose ps` 

    `docker ps` 

5. Connect to application and verify the app

    Use your browser to access vm002 public ip address on port 4001 

# Exercise 2
### Use docker-compose to bring up multi container env

1. Navigate to Demo1 dir

2. Examine docker-compose.yml 

    `cat docker-compose.yml` 

3. using the docker-compose.yml

    `docker-compose up -d`

4. verify the Containers 

    `docker-compose ps` 

5. Connect to application and verify the app

    Use your browser to access vm002 public ip address and port 8082

6. Create a sample Database and a Table with some Data using the phpMyAdmin 
   >> This data/table will be used on SSMA exercise on Module 6



