# Enable SQL Agent and configure a SQL Agent JOB
>> All steps to be performed in vm001 

Enable SQL Agent 

```sh 
[root@vm001 ~]# /opt/mssql/bin/mssql-conf set sqlagent.enabled true
SQL Server needs to be restarted in order to apply this setting. Please run
'systemctl restart mssql-server.service'.

[root@vm001 ~]# systemctl restart mssql-server

```

Create a SQL Agent Job 

Connect to local MS SQL 
`mssql-cli -Usa -P'Pa$$w0rd2019' -Slocalhost`

Create Sample DB 
`master> create database TestDB_DailyJob`

Verify Sample Database
`master> select name,create_date from sys.databases`

Change to msdb 
` master> use "msdb" `

Add SQL Agent Job 
` msdb> EXEC dbo.sp_add_job @job_name = N'Daily Backup for TestDB' `

Add SQL Job Steps
>> You may want to enable Multiline (F3)

```sh 
msdb> exec sp_add_jobstep
@job_name =  N'Daily Backup for TestDB', @step_name = N'Backup database', @subsystem = N'TSQL',
@command = N'backup database TestDB_DailyJob to disk = N''/var/opt/mssql/data/TestDB_DailyJob.bak'' with noformat, noinit, name = ''TestDB-full'', skip, norewind, nounload, stats = 10', 
@retry_attempts = 5, @retry_interval = 5;
go
```

Add SQL Agent Daily Schedule 
```sh 
msdb> exec dbo.sp_add_schedule 
        @schedule_name = N'Daily Backup for TestDB', 
        @freq_type = 4, 
        @freq_interval = 1, 
        @active_start_time = 235000;
```

Attach the job to a Schedule 
```sh 
msdb> exec sp_attach_schedule 
      @job_name = N'Daily Backup for TestDB', 
      @schedule_name = N'Daily Backup for TestDB'; 
      go 
```

Add the schedule to local server
```sh 
msdb> exec dbo.sp_add_jobserver 
      @job_name = N'Daily Backup for TestDB', 
      @server_name = N'(LOCAL)'; 
      go 
```

Start the SQL job
```sh
msdb> exec dbo.sp_start_job N'Daily Backup for TestDB'; 
      go 
```

Show Job Lits
```sh 
msdb> select * from sysjobschedules; 
      go 

msdb> select job_id,name from sysjobs;
      go 

```

Use SSMS to verify the job under SQL Agent 

END