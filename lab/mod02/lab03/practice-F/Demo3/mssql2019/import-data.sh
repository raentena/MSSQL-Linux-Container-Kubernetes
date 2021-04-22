#run the setup script to create the DB and the schema only if WideWorldImporters does not exists
#do this in a loop because the timing for when the SQL instance is ready is indeterminate

if [ ! -s /var/opt/mssql/data/WideWorldImporters.mdf ]
then 
for i in {1..50};
do
    /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P 'Pa55w0rd2019' -d master -i /seed/setup.sql
    if [ $? -eq 0 ]
    then
        echo "setup.sql completed"
        break
    else
        echo "not ready yet..."
        sleep 1
    fi
done
fi