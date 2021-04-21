sudo docker exec -d mssql\
  /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P 'Pa$$w0rd2019' -Q 'CREATE DATABASE WideWorldImporters'


sudo docker exec -d mssql\
  /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P 'Pa$$w0rd2019' -Q 'RESTORE DATABASE WideWorldImporters'