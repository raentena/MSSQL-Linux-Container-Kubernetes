#!/bin/bash 

function list  
{
cat <<EOF 
node:10.24                   
mcr.microsoft.com/mssql/server:2019-latest              
mcr.microsoft.com/mssql/server:latest                   
mcr.microsoft.com/mssql/server:2017-latest             
portainer/portainer-ce:latest                   
mcr.microsoft.com/mssql/server:2017-CU22-ubuntu-16.04  
mcr.microsoft.com/mssql/server:2017-CU16-ubuntu        
EOF
}


for i in $(list)
do 

docker pull $i

done