FROM mcr.microsoft.com/mssql/server

LABEL version="1.0"
LABEL description="Extension of the mcr.microsoft.com/mssql/server docker image to support initdb scripts"
LABEL maintainer="ModernWeb"

HEALTHCHECK --interval=30s --timeout=5s --start-period=30s --retries=3 CMD "sqlcmd -U sa -P ${SA_PASSWORD} -Q 'SELECT 1;' &> /dev/null"

VOLUME /docker-entrypoint-initdb.d
EXPOSE 1433

ENV PATH $PATH:/opt/mssql-tools/bin

COPY docker-entrypoint.sh /usr/local/bin/
COPY docker-entrypoint-initdb.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]
