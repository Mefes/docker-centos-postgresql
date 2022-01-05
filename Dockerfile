FROM centos:latest
LABEL FullName="Vladimir Kadochnikov" 
LABEL Email="vova.kadoch1995@gmail.com "
RUN yum -y update; yum clean all
RUN yum -y install sudo epel-release; yum clean all
RUN yum install -y pwgen; yum clean all
RUN sudo dnf install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-8-x86_64/pgdg-redhat-repo-latest.noarch.rpm
RUN sudo dnf -qy module disable postgresql
RUN sudo dnf install -y postgresql14-server
COPY postgresql-14-setup /usr/pgsql-14/bin/postgresql-14-setup
COPY start_postgres.sh /start_postgres.sh
RUN sed -i 's/.*requiretty$/#Defaults requiretty/' /etc/sudoers
RUN chown -R postgres.postgres /var/lib/pgsql
RUN chmod +x /bin/postgresql-14-setup
RUN /usr/pgsql-14/bin/postgresql-14-setup initdb
COPY postgresql.conf /var/lib/pgsql/data/postgresql.conf
RUN chown -v postgres.postgres /var/lib/pgsql/data/postgresql.conf
RUN echo "host    all             all             0.0.0.0/0               md5" >> /var/lib/pgsql/data/pg_hba.conf
# RUN pg_ctl reload
# RUN sudo systemctl enable postgresql-14.service
# RUN sudo service postgresql-14 start 
VOLUME ["/var/lib/pgsql"]
EXPOSE 5432
# COPY init.sql /docker-entrypoint-initdb.d/
CMD ["/bin/bash", "/start_postgres.sh"]