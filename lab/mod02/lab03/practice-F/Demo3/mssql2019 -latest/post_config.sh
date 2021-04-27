# This extra script is to enable post settings ( inspired from Raymond@DHL )
# This will exec setup2.sql which will set the COMPATIBILITY , SERVER MEMORY and EXTRA TRACE ( refer setup2.sql )

for i in {1..50};
do
    /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P 'Pa55w0rd2019' -d master -i /seed/setup2.sql
    if [ $? -eq 0 ]
    then
        echo "setup2.sql completed"
        break
    else
        echo "not ready yet..."
        sleep 1
    fi
done