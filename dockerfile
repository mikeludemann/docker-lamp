FROM ubuntu:18.04
LABEL Mike Ludemann "mike-ludemann@hotmail.de"
LABEL version="1.0"

# Setup for environment
ENV CREATE 2018-10-31
ENV DEBIAN_FRONTEND noninteractive

# Updating all sources
RUN apt-get update -y

# Upgrade all sources
RUN apt-get upgrade -y

# Installing the server (http(s))
RUN apt-get install -y apache2

# Installing DBMS (mysql)
RUN apt-get install -y mysql-client mysql-server

# Installing PHP (Version 7.X)
RUN apt-get install -y libapache2-mod-php7.2 php7.2 php7.2-mysql php-xml php7.0-mcrypt php-cgi php-cli php-curl php-gd php-imagick php-imap php-pear

# Installing additional packages
RUN apt-get install -y git svn pwgen zip unzip wget curl 

# Installing supervisord
RUN apt-get install -y supervisor
RUN mkdir -p /var/log/supervisor

# Installing ssh (Packages)
RUN apt-get install -y openssh-server openssh-client passwd
RUN mkdir -p /var/run/sshd

# Adding complete directory into server environment
ADD . /var/www/html/
# COPY . /var/www/html/

# Setting and Options - LAMP

## First: Auto-Start for apache2 and mod_rewrite
RUN update-rc.d apache2 defaults
RUN a2enmod rewrite
RUN /etc/init.d/apache2 restart

## Second: Environment variables for configuration (Setting - Parameter)
ENV PHP_UPLOAD_MAX_FILESIZE 20M
ENV PHP_POST_MAX_SIZE 20M

## Third: Auto-Start for mysql & Remove existing databases (Pre-install)
RUN update-rc.d mysql defaults
RUN rm -rf /var/lib/mysql 

# Setting Ports
EXPOSE 22 8080 8443

# Setting entrypoint
# ENTRYPOINT [ "executable" ]

# Final command
CMD ["/bin/bash"]