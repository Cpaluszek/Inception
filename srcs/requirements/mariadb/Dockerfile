FROM debian:buster

ARG DB_USER
ARG DB_DATABASE
ARG DB_USER_PASSWORD
ARG DB_ROOT_PASSWORD

RUN apt-get update -y
RUN apt-get upgrade -y

RUN apt-get install -y mariadb-server

# Give permission to mysql group
RUN mkdir -p /var/run/mysql
RUN chown -R mysql:mysql /var/run/mysql

# Start mysql and create database
RUN service mysql start && mysql -u root -e "CREATE DATABASE IF NOT EXISTS $DB_DATABASE; \
    ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PASSWORD'; \
    GRANT ALL PRIVILEGES ON $DB_DATABASE.* TO '$DB_USER'@'%' IDENTIFIED BY '$DB_USER_PASSWORD'; \
    FLUSH PRIVILEGES;"
    
    # ALTER USER: change authentification characteristics of a databse user
    # GRANT: Grant user permissions to all tables in the database from localhost
    # FLUSH PRIVILEGES: changes take effect immediatly

COPY ./conf/mariadb.conf ./etc/mysql/mariadb.conf.d/50-server.cnf

EXPOSE  3306

RUN apt-get install -y dumb-init

ENTRYPOINT ["/usr/bin/dumb-init", "--"]

CMD ["mysqld", "--bind-address=0.0.0.0"]