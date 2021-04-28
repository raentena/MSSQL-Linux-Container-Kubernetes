# SQL Server Full-Text Search
>> Perform all steps on vm001

Install SQL Server Full-Text Search.

```sh 
[vm001@vm001 ~]# yum install mssql-server-fts -y 

[vm001@vm001 ~]# systemctl restart mssql-server

```

Test to run Full-Text Search

```sh 

[root@vm001 ~]# mssql-cli -S localhost -U SA
Password:

# connect to test database
use SampleDB;
go
Changed database context to 'SampleDB2'.

# this is the sample table for test
select * from dbo.Sample_Table; 
go

S_Id       P_Name        C_Name         D_Desc
---------- ------------- -------------- --------------------------------------------------
00001      CentOS        Linux          This is the Community Enterprise Operating System.
00002      RedHat        Linux          RedHat Enterprise Linux.
00003      Debian        Linux          Debian GNU Linux.
00004      Ubuntu        Linux          Ubuntu is based on the Debian architecture.
00005      Windows       Microsoft      Microsoft Windows

(5 rows affected)

# create fulltext catalog named [Sample_TBCat]
create fulltext catalog Sample_TBCat;
go

# create unique index to [Number] column named [UIDoc]
create unique index UIDoc on Sample_Table(Number);
go

# create fulltext index on [Sample_TBCat] catalog
create fulltext index on Sample_Table(P_Name,D_Desc)
key index UIDoc on Sample_TBCat;
go


# test to run full-text search
select * from dbo.Sample_Table where contains((P_Name,D_Desc),'Enterprise');
go
Number     P_Name         Last_Name    D_Desc
---------- -------------- ------------ --------------------------------------------------
00001      CentOS         Linux        This is the Community Enterprise Operating System.
00002      RedHat         Linux        RedHat Enterprise Linux.

(2 rows affected)

# test to run full-text search
select * from dbo.Sample_Table where freetext((D_Desc),'GNU or architecture');
go

Number     P_Name       Last_Name     D_Desc
---------- ------------ ------------- --------------------------------------------------
00003      Debian       Linux         Debian GNU Linux.
00004      Ubuntu       Linux         Ubuntu is based on the Debian architecture.

(2 rows affected)



```
