FROM debian:buster

# Update and Upgrade packages | -y to accept everything
RUN apt-get update -y
RUN apt-get upgrade -y

# Install Curl (Client url)
RUN apt-get install -y curl less

# Install PHP
RUN apt-get install -y php

# Install PHP-FPM (FastCgi process manager)
    # define how NGINX communicate with CGI program (php)
RUN apt-get install -y php-fpm

# Install MYSQL
RUN apt-get install -y php-mysql
# Improved driver
RUN apt-get install -y php-mysqli

# Install mariadb client to connect to the database
RUN apt-get install -y mariadb-client

# DOWNLOAD WP-CLI FROM GITHUB && DEFINE WP-CLI TO EXECUTABLE
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
&&		chmod +x wp-cli.phar \
&&		mv wp-cli.phar /usr/local/bin/wp


# CREATE DIRECTORY TO INSTALL WORDPRESS
RUN mkdir -p /var/www/html/wordpress

# COPY SH FILE IN TMP DIRECTORY
COPY	/tools/launch_wordpress.sh /tmp

# COPY OUR CONF FILE IN OUR CONTAINER
COPY	/tools/www.conf /etc/php/7.3/fpm/pool.d/www.conf

EXPOSE 9000

# Install DUMB-INIT
# dumb-init runs as PID 1, acting like a simple init system.
# It launches a single process and then proxies all received signals to a session rooted at that child process.
RUN apt-get install -y dumb-init

# CMD command will be passed as argument to ENTRYPOINT
ENTRYPOINT ["/usr/bin/dumb-init", "--"]


CMD ["sh", "/tmp/launch_wordpress.sh"]
