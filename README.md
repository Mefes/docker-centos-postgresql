# docker-centos-postgresql

Dockerfile to build PostgreSQL on latest CentOS

Setup
-----

To build the image

    # docker build -t docker-centos-pgsql  .

To run the container
    
    # docker run --name pgsqltest -d -p 5432:5432 -e 'POSTGRES_USER=username' -e 'POSTGRES_PASSWORD=pass' -e 'POSTGRES_DB=testdb' docker-centos-pgsql 
