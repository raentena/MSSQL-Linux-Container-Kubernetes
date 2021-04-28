#!/bin/bash 

function list  
{
cat <<EOF 

node:10.24                   
mcr.microsoft.com/mssql/server:2019-latest                              
mcr.microsoft.com/mssql/server:2019-CU5-ubuntu-16.04
redis
node:alpine

EOF
}


yum install git -y 

for i in $(list)
do 

docker pull $i

done