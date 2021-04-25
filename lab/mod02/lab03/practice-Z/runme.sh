#!/bin/bash
# Setup dbconfig.json based on env or fall back to default
# Function Set

function setallvar {

if [ ! -z ${DBPASS} ] ; then echo "we got DBPASS" ; else export DBPASS=Pa55w0rd2019 ; fi

if [ ! -z ${DUSER} ]  ; then echo "we got DBUSER" ; else export DBUSER=sa ; fi

if [ ! -z ${DBSVR} ]  ; then echo "we got DBSVR"  ; else export DBSVR=mssql ; fi

export DB=WideWorldImporters
export DBPORT=1433
export DPOPT=false
}

function gendbconf {
cat <<EOF
{
    "user": "${DBUSER}",
    "password": "${DBPASS}",
    "server": "${DBSVR}",
    "database": "WideWorldImporters",
    "port": 1433,
    "options": {
        "encrypt": false
    }
}
EOF
}
#Main Body
cp ./src/config/dbconfig.json ./src/config/dbconfig.bak

setallvar

gendbconf > ./src/config/dbconfig.json