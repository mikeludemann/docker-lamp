FROM ubuntu:18.04
MAINTAINER Mike Ludemann <mike-ludemann@hotmail.de>

# Setup for environment
ENV DEBIAN_FRONTEND noninteractive

# Updating all sources
RUN apt-get update -y

# Upgrade all sources
RUN apt-get upgrade -y

# Installing the server (http(s))
RUN apt-get install -y apache2

# Installing DBMS (mysql)
RUN apt-get install -y mysql-client mysql-server

# Setting and Options for mysql

## First: Remove existing databases (Pre-install)
RUN rm -rf /var/lib/mysql 

## Second: ...

# Installing PHP (Version 7.X)
RUN apt-get install -y libapache2-mod-php7.2 php7.2 php7.2-mysql php-xml php7.0-mcrypt php-cgi php-cli php-curl php-gd php-imagick php-imap php-pear

# Setting and Options for PHP

## First: Environment variables for configuration (Setting - Parameter)

# Installing additional packages
RUN apt-get install -y git svn pwgen zip unzip wget curl 

# Installing supervisord
RUN apt-get install -y supervisor
RUN mkdir -p /var/log/supervisor

# Installing ssh (Packages)
RUN apt-get install -y openssh-server openssh-client passwd
RUN mkdir -p /var/run/sshd

# Configuration and scripts for external command 
# ...

# Adding complete directory into server environment
ADD . /var/www/html/

# Setting Ports
EXPOSE 22 8080 8443

# Final command
CMD []