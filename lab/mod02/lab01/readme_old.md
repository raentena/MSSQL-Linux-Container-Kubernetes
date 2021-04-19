#  Install SQL Server and create a database on Red Hat

Install SQL Server and create a database on Red Hat

You have 1 Machine: 
- vm001 - installed with RHEL 8.1 

Trace the Public IP address from Azure for vm001 and SSH to vm001

Verify your System for MSSQL installation 

# Step 1 
Verify CPU , RAM , DISK Space , DISK Type ( XFS ) and Network
```sh
vm001#>lscpu

vm001#>free -h

vm001#>df -h 

vm001#>lsblk -f

vm001#>ethtool eth0
```

# Step 2 
Install MSSQL 2019  ( Please use Pa$$w0rd2019 as the SA Password )
```sh
vm001#> yum info mssql-server

vm001#> yum install -y mssql-server

vm001#> /opt/mssql/bin/mssql-conf setup
```

# Step 3 

Verify installation and network 
```sh
vm001#> systemctl status mssql-server 

vm001#> ss -tan 

vm001#> ls -l /var/opt/mssql/

vm001#> ls -l /opt/mssql/ 
```

# Step 4 

Install the SQL Server command-line tools and add the binary to PATH
```sh
vm001#> yum install -y mssql-tools unixODBC-devel

vm001#> echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bash_profile

vm001#> echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc

vm001#> source ~/.bashrc
```

# Step 5
Connect locally

Run sqlcmd with parameters for your SQL Server name (-S), the user name (-U), and the password (-P). In this tutorial, you are connecting locally, so the server name is localhost. The user name is SA and the password is the one you provided for the SA account during setup.

```sh
vm001#> sqlcmd -S localhost -U SA -P 'Pa$$w0rd2019'

1>SELECT @@version
2>GO
```

# Step 6
Create and query data
```sh
# create [SampleDB] database
1> create database SampleDB; 
2> go 

# create a database with parameters
1> create database SampleDB2 
2> on primary (
3> name = 'SampleDB2',
4> filename = '/var/opt/mssql/data/SampleDB2.mdf',
5> size = 5GB,
6> maxsize = unlimited,
7> filegrowth = 10MB
8> )
9> log on (
10> name = 'SampleDB2_log',
11> filename = '/var/opt/mssql/data/SampleDB2_log.ldf',
12> size = 1GB,
13> maxsize = 2GB,
14> filegrowth = 5%
15> )
16> go

# list databases
1> select name,create_date from sys.databases;
2> go

```

# Step 7
Create Tables. 
```sh
# create [Sample_Table] table
1> create table dbo.Sample_Table ( 
2> S_Id nvarchar(10) not null, 
3> P_Name nvarchar(50) not null, 
4> C_Name nvarchar(50) null, 
5> Desc nvarchar(150) not null 
6> ) 
7> go 
```

# Step 8 
Insert Data to Sample_Table 
```sh
1> insert into dbo.Sample_Table ( 
2> S_Id, P_Name, C_Name, Desc 
3> ) 
4> values ( 
5> '00001', 'CentOS', 'Linux', 'This is the Community Enterprise Operating System.' 
6> ) 
7> go 

1> insert into dbo.Sample_Table ( 
2> S_Id, P_Name, C_Name, Desc 
3> ) 
4> values ( 
5> '00002', 'Redhat', 'Linux', 'Redhat Enterprise Linux.' 
6> ) 
7> go 

1> insert into dbo.Sample_Table ( 
2> S_Id, P_Name, C_Name, Desc 
3> ) 
4> values ( 
5> '00003', 'Debian', 'Linux', 'Debian GNU Linux.' 
6> ) 
7> go 

1> insert into dbo.Sample_Table ( 
2> S_Id, P_Name, C_Name, Desc 
3> ) 
4> values ( 
5> '00004', 'Ubuntu', 'Linux', 'Ubuntu is based on Debian GNU.' 
6> ) 
7> go 

1> insert into dbo.Sample_Table ( 
2> S_Id, P_Name, C_Name, Desc 
3> ) 
4> values ( 
5> '00005', 'Windows', 'Microsoft', 'System well know for BSOD.' 
6> ) 
7> go 

```

# Step 9 
Verify Table Data
 
```sh
1> select * from sample_table 
2> go 
```

# Step 10 
Run T-SQL from command line
```sh
vm001#>  sqlcmd -S localhost -U SA  -d 'sampledb' -P 'Pa$$w0rd2019' -Q 'select * from sample_table' 
```

END