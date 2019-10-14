FROM mcr.microsoft.com/mssql/server

LABEL version="1.0"
LABEL description="Extension of the mcr.microsoft.com/mssql/server docker image to support initdb scripts"
LABEL maintainer="ModernWeb"

# Install SqlPackage - https://docs.microsoft.com/en-us/sql/tools/sqlpackage
RUN apt-get update && apt-get install unzip
RUN wget -q --show-progress -O sqlpackage.zip https://go.microsoft.com/fwlink/?linkid=2102978
RUN unzip -qo sqlpackage.zip -d /opt/sqlpackage && chmod +x /opt/sqlpackage/sqlpackage

ENV PATH $PATH:/opt/mssql-tools/bin:/opt/sqlpackage

VOLUME /docker-entrypoint-initdb.d
EXPOSE 1433
HEALTHCHECK --interval=30s --timeout=5s --start-period=30s --retries=3 CMD "sqlcmd -U sa -P ${SA_PASSWORD} -Q 'SELECT 1;' &> /dev/null"

COPY docker-entrypoint.sh /usr/local/bin/
COPY docker-entrypoint-initdb.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]
