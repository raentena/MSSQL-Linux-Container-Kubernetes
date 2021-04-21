sudo docker run\
 -e 'ACCEPT_EULA=Y' -e 'MSSQL_SA_PASSWORD=Pa$$w0rd2017'\
  --hostname sql2\
  -p 1432:1433\
  -v sqlvolume2:/var/opt/mssql\
  --name sql2\
  -d\
  mcr.microsoft.com/mssql/server:2017-latest