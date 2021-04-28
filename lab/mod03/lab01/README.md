# Configure MSSQL using mssql-conf script 

1. View the contents of the mssql.conf file:

    `sudo cat /var/opt/mssql/mssql.conf`

You will notice that it is almost empty except for showing settings for [sqlagent] and [EULA]. Any settings not shown in this file are using their default value.

2. Make a backup copy of the mssql.conf file before making changes:

    `sudo cp /var/opt/mssql/mssql.conf /var/opt/mssql/mssql-backup.conf`

3. View the contents of the /var/opt/mssql/ folder to confirm you now have a backup copy of the mssql.conf file:

    `sudo ls /var/opt/mssql`

4. Create the directories for the new data, log, error, and backup:

    ```sh 
    sudo mkdir -p /sql/data
    sudo mkdir -p /sql/log
    sudo mkdir -p /sql/error
    sudo mkdir -p /sql/backup
    ```

The names of the directories are self-explanatory. /sql/data to store data, /sql/log to store log, /sql/error to store the error log file, and /sql/backup to store the database backups.

5. Change to your root directory:

    `cd /`

6. Change to the sql directory:

    `cd sql/`

7. List the contents of the sql directory:

    `ls`

8. Change the owner and group of the /sql directory to the mssql user:

    ```sh 
    sudo chown mssql /sql
    sudo chgrp mssql /sql
    ```
This will enable mssql user to have the required permissions to write files to the /sql subfolders.

9. Change the default data and log directory:
    `sudo /opt/mssql/bin/mssql-conf set filelocation.defaultdatadir /sql/data`

    `sudo /opt/mssql/bin/mssql-conf set filelocation.defaultlogdir /sql/log`

You will notice the message telling you “SQL Server needs to be restarted in order to apply this setting. Please run ‘systemctl restart mssql-server.service’.” We are making multiple changes here and will restart after the last change.

10. Change the default backup directory:

    `sudo /opt/mssql/bin/mssql-conf set filelocation.defaultbackupdir /sql/backup`

11. Set the memory limit to 2048 MB:

    `sudo /opt/mssql/bin/mssql-conf set memory.memorylimitmb 2048`

12. Change the default TCP port for SQL to 1455:
    `sudo /opt/mssql/bin/mssql-conf set network.tcpport 1455`

By default, SQL Server listens for connections in port 1433. As a test, we had set it to 1455. When connecting to SQL Server, you will need to specify the custom port as in the following:

    `sqlcmd -S localhost, -U UserName -P Password`

13. Restart SQL Server services for the settings to take effect:

    `sudo systemctl restart mssql-server`

14. Try connecting to SQL Server without the custom port 1455 you had set back in step 13, you will see the corresponding error message:

    `sqlcmd -S localhost -U USERNAME -P ‘PASSWORD’`

15. Connect using the custom port will succeed:

    `sqlcmd -S localhost,1455 -U USERNAME -P ‘PASSWORD’`

16. Enter the edit mode of the mssql.conf file to modify the file:
    `sudo nano /var/opt/mssql/mssql.conf`

17. Move the down arrow key to go down to the tcpport = 1455 line.

18. Move the left arrow key to go the space after 1455.

19. Erase 55 and replace with 33.

You can change other parameters on the mssql.conf file using this method.

20. Press Ctrl + O to write the file.

21. Press Enter to accept the file name as mssql.conf.

22. Press Ctrl + X to exit.

23. Restart the SQL Server service for the setting to take effect:

    `sudo systemctl restart mssql-server`

24. Key in your password if prompted for sudo.

25. Try connecting using the default port of SQL and it will connect successfully:

    `sqlcmd -S localhost -U USERNAME -P ‘PASSWORD’`

26. Unset the memory limit using the unset option:

    `sudo /opt/mssql/bin/mssql-conf unset memory.memorylimitmb`

You can unset all other parameters exist in the mssql.conf file using this method.

27. Key in your password if prompted for sudo.

28. Restart SQL Server service for the setting to take effect:

    `sudo systemctl restart mssql-server`

29. Key in your password if prompted for sudo.

30. View the contents of the mssql.conf file to confirm the memory limit is unset:

    `sudo cat /var/opt/mssql/mssql.conf`

31. Review the content of the mssql-backup.conf file:

    `sudo cat /var/opt/mssql/mssql-backup.conf`

32. Revert the changes by renaming the mssql-backup.conf file to overwrite the existing mssql.conf file:

    `sudo mv /var/opt/mssql/mssql-backup.conf /var/opt/mssql/mssql.conf`

33. Review the content of the mssql.conf file:

    `sudo cat /var/opt/mssql/mssql.conf`

34. Restart SQL Server services for it to take effect:

    `systemctl restart mssql-server`



























