# Custom MSSQL 2019 Docker Build
FROM mcr.microsoft.com/mssql/server

# Set Default ENV for mssql-tool bin path, password and SQL edition 
ENV ACCEPT_EULA Y
ENV SA_PASSWORD Pa55w0rd2019
ENV MSSQL_ID Evaluation
ENV MSSQLTOOLS_ROOT /opt/mssql-tools
ENV PATH "$MSSQLTOOLS_ROOT/bin:$PATH"

# Switch to root user for access to apt-get install
USER root

# Install curl program 
RUN  apt-get -y update  && apt-get install -y curl 

# Create app directory
RUN mkdir -p /seed
WORKDIR /seed

# copy all run script 
COPY . .

# Download Bak file
RUN wget https://github.com/Microsoft/sql-server-samples/releases/download/wide-world-importers-v1.0/WideWorldImporters-Full.bak

# Grant permissions for the post config script to be executable
RUN  chmod +x /seed/post_config.sh

# Change to directory /var/opt/mssql/ and copy mssql.conf to startup
WORKDIR /var/opt/mssql
COPY ./mssql.conf .

#Swich back to /seed 
WORKDIR /seed

# Switch back to mssql user and run the entrypoint script
USER mssql

# Starting point for container
ENTRYPOINT /bin/bash ./entrypoint.sh