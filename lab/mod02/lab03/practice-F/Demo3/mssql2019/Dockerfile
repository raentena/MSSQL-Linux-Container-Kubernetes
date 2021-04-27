# Custom MSSQL 2019 Docker Build
FROM mcr.microsoft.com/mssql/server

# Switch to root user for access to apt-get install
USER root

# Install curl and wget
RUN apt-get -y update  && \
        apt-get install -y curl && \ 
        apt-get install -y wget

# Create app directory
RUN mkdir -p /seed

WORKDIR /seed

# Set ENV for mssql-tool bin path 
ENV ACCEPT_EULA Y
ENV SA_PASSWORD Pa55w0rd2019
ENV MSSQL_ID Evaluation
ENV MSSQL_AGENT_ENABLED true
ENV MSSQL_MEMORY_LIMIT_MB 2048


ENV MSSQLTOOLS_ROOT /opt/mssql-tools
ENV PATH "$MSSQLTOOLS_ROOT/bin:$PATH"

# copy all run script 
COPY . /seed

# Download Bak file
RUN wget https://github.com/Microsoft/sql-server-samples/releases/download/wide-world-importers-v1.0/WideWorldImporters-Full.bak

# Grant permissions for the import-data script to be executable
RUN  mkdir -p /var/opt/mssql && \
         chown 10001:0 /var/opt/mssql && \
         chmod +x /seed/import-data.sh

# Switch back to mssql user and run the entrypoint script
USER mssql

ENTRYPOINT /bin/bash ./entrypoint.sh