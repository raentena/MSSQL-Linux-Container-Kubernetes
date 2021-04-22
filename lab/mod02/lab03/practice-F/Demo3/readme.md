# Docker Build and Docker-Compose APP MSSQL 2019 
### In this exercise, you will build MSSQL 2019 and a NODEJS WebApp container Image 
### The MSSQL 2019 will build with AUTO seed data and with extra mssql-conf configuration 
    >> Its important you do this exercise, as we will use this Image for Kubernetes and HA
    >> all Steps to be performed in vm002 


### Build and Verify  MSSQL 2019 Docker Image/Container 

1. Navigate to ./mssql2019/ directory

2. Review the Dockerfile 
   
    ` cat Dockerfile `

3. Build a new Custom mssql 2019 container image 

    ` docker build . -t <DOCKER_HUB_ID>/mssql2019:v1 `

4. Create a docker volume to hold database files 

    ```sh 
    mkdir /sql

    chmod 777 /sql 

    docker volume create --name sql --opt type=none --opt device=/sql --opt o=bind

    docker volume ls

    docker volume inspect sql

    ls /sql/

    ```

5. Verify the build is successful by running the image as a container

    ` docker run -d -p 1433:1433 --name mssql -v sql:/var/opt/mssql <DOCKER_HUB_ID>/mssql2019:v1 ` 

6. Return to Windows 10 machine , and Use SSMS to connect to the newly deployed mssql2019 

    >> **NOTE:** UserName:**sa**  password:**Pa55w0rd2019** ip:**vm002 Public IP** port:**1433**

7. Once the SSMS connected, open a new query window and run the following T-SQL to create a new DB 

    ```sh 
    USE [master]
    GO

    CREATE DATABASE [flyskyDB]
    CONTAINMENT = NONE
    ON  PRIMARY 
    ( NAME = N'flyskyDB', FILENAME = N'/var/opt/mssql/data/flyskyDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB ) 
    LOG ON 
    ( NAME = N'flyskyDB_log', FILENAME = N'/var/opt/mssql/data/flyskyDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB ) 
    WITH CATALOG_COLLATION = DATABASE_DEFAULT
    GO

    ```

8. Close the connection to MSSQL Server from SSMS 

9. In vm002 machine, run the following to verify the new datafile created in the volume 

    ```sh 
    ls /sql/fly* 

    /sql/flyskyDB.mdf  /sql/flyskyDB_log.ldf

    ```

10. Terminate the mssql container and remove from docker runtime 
    
    ```sh 
    docker stop mssql 

    docker rm mssql 

    docker ps -a 
    ```

11. Rerun the docker run command to deploy new container based on msssql2019 image 

    ` docker run -d -p 1433:1433 --name mssql -v sql:/var/opt/mssql <DOCKER_HUB_ID>/mssql2019:v1 `

12. Return to Windows 10 machine , and Use SSMS to connect to the newly deployed mssql2019 

    >> **NOTE:** UserName:**sa**  password:**Pa55w0rd2019** ip:**vm002 Public IP** port:**1433**

13. Once the SSMS connected, verify the newly created DB exists ( flyskyDB )

    >> This is a POC that with supplied volume , mssql2019 data will be persistent

14. Close the connection to MSSQL Server from SSMS 

15. Navigate back to vm001 and  Terminate the mssql container and remove from docker runtime 
    
    ```sh 
    docker stop mssql 

    docker rm mssql 

    docker ps -a 
    ```
16. END 

### Build and Verify  NODE JS APP Image/Container 

1. Navigate to directory ./webapp 

2. Review the Dockerfile 
   
    ` cat Dockerfile `

3. Build a new NODE JS webapp container image 

    ` docker build . -t <DOCKER_HUB_ID>/nodewebapp:v1 `
















