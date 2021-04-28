sudo docker run -e\
  'ACCEPT_EULA=Y' -e 'MSSQL_SA_PASSWORD=Pa$$w0rd2019'\
 --hostname mssql\
 -p 1433:1433\
 -v sqlvolume:/var/opt/mssql\
 --name mssql\
 -d\
 mcr.microsoft.com/mssql/server:2019-latest
