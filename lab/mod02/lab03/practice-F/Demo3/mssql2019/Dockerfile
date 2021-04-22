FROM mcr.microsoft.com/mssql/server

# Switch to root user for access to apt-get install
USER root

# Install node/npm
RUN apt-get -y update  && \
        apt-get install -y curl && \ 
        apt-get install -y wget

# Create app directory
RUN mkdir -p /seed

WORKDIR /seed

# Set ENV for mssql-tool bin path 
ENV ACCEPT_EULA=Y
ENV SA_PASSWORD=Pa55w0rd2019

ENV MSSQLTOOLS_ROOT /opt/mssql-tools
ENV PATH "$MSSQLTOOLS_ROOT/bin:$PATH"

# copy all run script 
COPY . /seed

RUN wget https://github.com/Microsoft/sql-server-samples/releases/download/wide-world-importers-v1.0/WideWorldImporters-Full.bak

# Grant permissions for the import-data script to be executable
RUN chmod +x /seed/import-data.sh

# Switch back to mssql user and run the entrypoint script
USER mssql

ENTRYPOINT /bin/bash ./entrypoint.sh

CMD ["/opt/mssql/bin/sqlservr "]
