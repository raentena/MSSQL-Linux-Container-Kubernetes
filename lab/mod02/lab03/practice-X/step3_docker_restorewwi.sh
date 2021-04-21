
sudo docker exec -d mssql\
  /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P 'Pa$$w0rd2019' -i /var/opt/mssql/restorewwi_linux.sql 