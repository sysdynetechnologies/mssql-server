# mssql-server

This image is an extension of the official [mcr.microsoft.com/mssql/server](https://hub.docker.com/_/microsoft-mssql-server) Docker image

It adds functionality to initialize a fresh instance. When a container is started for the first time, it will execute any files with extensions `.sh` or `.sql` that are found in `/docker-entrypoint-initdb.d`. Files will be executed in alphabetical order. You can easily populate your SQL Server services by mounting scripts into that directory and provide custom images with contributed data.

## Running this image

* From Docker Hub

```
docker run -p 1433:1433 --name mssql -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=Strong(!)Password' -v $PWD/initdb.d:/docker-entrypoint-initdb.d -d modernweb/mssql-server
```

* From this repo using docker-compose:

```bash
docker-compose up -d --build
```

_NOTE: You can adjust `.env` values to your needs._

## Additional information:

 * Linux-based mssql-docker [git repo](https://github.com/microsoft/mssql-docker/tree/master/linux)
 * Running [SQL Server on Linux](https://docs.microsoft.com/en-us/sql/linux/) on top of an Ubuntu 16.04 base image.
 * Make sure that the .sh files have UNIX-style (LF) line endings. Depending on your platform and Git configuration, Git may change them to Windows-style (CR+LF). In this case, the container won't start, and you may see a non-informative error message like: 
 ```
 standard_init_linux.go:195: exec user process caused "no such file or directory"'.
```
