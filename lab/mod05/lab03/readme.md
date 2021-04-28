# BCP : Bulk Copy Program 

# Import a CSV file to MSSQL Linux 

1. SSH to your Linux box (vm001)

2. Copy and paste the following commands into the terminal window. These commands use the **sqlcmd** command-line utility to create a sample database **BcpSampleDB** and a table **TestEmployees** on the local SQL Server instance (localhost). Remember to replace the username and <your_password> as necessary before running the commands.

3. Create the database BcpSampleDB:

`sqlcmd -S localhost -U sa -P <your_password> -Q "CREATE DATABASE BcpSampleDB;"`

4. Create the table TestEmployees in the database BcpSampleDB:

`sqlcmd -S localhost -U sa -P <your_password> -d BcpSampleDB -Q "CREATE TABLE TestEmployees (Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY, Name NVARCHAR(50), Location NVARCHAR(50));"`

5. Create the source data file

    Copy and paste the following command into your terminal window. We use the built-in cat command to create a sample text data file with three records save the file in your home directory as ~/test_data.txt. The fields in the records are delimited by a comma

```sh 
cat > ~/test_data.txt << EOF
1,Jared,Australia
2,Nikita,India
3,Tom,Germany
EOF

```

6. You can verify that the data file was created correctly by running the following command in your terminal window:

```sh 
cat ~/test_data.txt

##Output 
1,Jared,Australia
2,Nikita,India
3,Tom,Germany

```

7. Import data from the source data file

    Copy and paste the following commands into the terminal window. This command uses bcp to connect to the local SQL Server instance (localhost) and import the data from the data file (~/test_data.txt) into the table (TestEmployees) in the database (BcpSampleDB). Remember to replace the username and <your_password> as necessary before running the commands.

    ```sh 
    bcp TestEmployees in ~/test_data.txt -S localhost -U sa -P <your_password> -d BcpSampleDB -c -t  ','
    ```
    -S: specifies the instance of SQL Server to which to connect
    -U: specifies the login ID used to connect to SQL Server
    -P: specifies the password for the login ID
    -d: specifies the database to connect to
    -c: performs operations using a character data type
    -t: specifies the field terminator. We are using comma as the field terminator for the records in our data file

8. Verify the Data

   `sqlcmd -S localhost -d BcpSampleDB -U sa -P <your_password> -I -Q "SELECT * FROM TestEmployees;"`



# Export data with bcp

1. Copy and paste the following commands into the terminal window. These commands use the bcp command-line utility to export data from the table TestEmployees in the database BcpSampleDB to a new data file called ~/test_export.txt. Remember to replace the username and <your_password> as necessary before running the command.

    `bcp TestEmployees out ~/test_export.txt -S localhost -U sa -P <your_password> -d BcpSampleDB -c -t ','`

2. You can verify that the data was exported correctly by running the following command in your terminal window:

    `cat ~/test_export.txt`
