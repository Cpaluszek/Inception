FROM debian:buster

# Update and Upgrade packages | -y to accept everything
RUN apt-get update -y
RUN apt-get upgrade -y

# Install nginx
RUN apt-get install -y nginx

# Install openssl
RUN apt-get install -y openssl

# Generate SSL Key and certificate
RUN openssl req -x509 -newkey rsa:2048 -nodes -subj /C=FR -keyout /etc/ssl/cpalusze.42.fr.key -out /etc/ssl/cpalusze.42.fr.crt

# # NGINX conf file
COPY /conf/nginx.conf /etc/nginx/sites-available/cpalusze.42.fr.conf
# # RUN rm /etc/nginx/sites-enabled/cpalusze.42.fr.conf
RUN ln -s /etc/nginx/sites-available/cpalusze.42.fr.conf /etc/nginx/sites-enabled/cpalusze.42.fr.conf

# Install DUMB-INIT
# dumb-init runs as PID 1, acting like a simple init system.
# It launches a single process and then proxies all received signals to a session rooted at that child process.
RUN apt-get install -y dumb-init

EXPOSE 443

# CMD command will be passed as argument to ENTRYPOINT
ENTRYPOINT ["/usr/bin/dumb-init", "--"]

# -g flag -> set global directive or variables
# daemon off directive -> NGINX stay in the foreground
CMD ["nginx", "-g", "daemon off;"]
