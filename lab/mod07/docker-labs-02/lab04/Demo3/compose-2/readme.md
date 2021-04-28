# Docker Build and Docker-Compose UPDATE APP MSSQL 2019 
### In this exercise, you will build MSSQL 2019 and a NODEJS WebApp container Image 
### The MSSQL 2019 will build with AUTO seed data and with extra mssql-conf configuration 
    >> Its important you do this exercise, as we will use this Image for Kubernetes and HA
    >> all Steps to be performed in vm002 


### Build container set using docker-compose 

1. Navigate to Demo3 directory 

2. Review the docker-compose.yml file 

    ` cat docker-compose.yml` 

3. Run docker-compose command to bring up both mssql and webapp container 

    ` docker-compose up -d` 

4. Verify docker-compose have created the container sets

    ` docker-compose ps`

5. Use your web browser to navigate to vm002 public ip address and verify you can access the webapp and its connected to MSSQL. 

END











