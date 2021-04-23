FROM ubuntu:latest

MAINTAINER Sandhy Sanjaya <sandhysanjaya0110@gmail.com>

CMD ["/sbin/my_init"]

ENV    DEBIAN_FRONTEND noninteractive

# utf-8
ENV LANG       en_US.UTF-8
ENV LC_ALL     en_US.UTF-8

RUN locale-gen en_US.UTF-8
RUN apt-get update
RUN apt-get install software-properties-common -y
RUN add-apt-repository ppa:ondrej/php
RUN apt-get -y --force-yes update && apt-get -y --force-yes install \
						wget  \
						sqlite3  \
						curl  \
						imagemagick \
					 	apache2 \
					 	apache2-doc \
					 	apache2-utils \
						php7.3 \
						php7.3-xml \
						php7.3-cli \
						php7.3-dev \
						php7.3-cgi \
						php7.3-curl \
						php7.3-gd \
						php7.3-mysql \
						php7.3-mbstring \
						php7.3-mcrypt \
						php7.3-memcache \
						php7.3-memcached \
						php7.3-json \
						php7.3-pgsql \
						php7.3-sqlite3 \
						php7.3-tidy \
						git \
						unzip \
						libapache2-mod-php \
						php7.3-pear \
						php7.3-zip
RUN a2dismod mpm_event
RUN a2enmod mpm_prefork \
			rewrite \
			alias

# Update php.ini
RUN sed -i "s/short_open_tag = Off/short_open_tag = On/" /etc/php/7.3/apache2/php.ini
RUN sed -i "s/error_reporting = .*$/error_reporting = E_ERROR | E_WARNING | E_PARSE/" /etc/php/7.3/apache2/php.ini

# install composer
RUN cd /tmp && curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer

# Apache Env
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid
ENV APACHE_RUN_DIR /var/run/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
RUN ln -sf /dev/stdout /var/log/apache2/access.log
RUN ln -sf /dev/stderr /var/log/apache2/error.log
RUN mkdir -p $APACHE_RUN_DIR $APACHE_LOCK_DIR $APACHE_LOG_DIR

# Expose apache.
EXPOSE 80

# Copy repo dari www ke folder html container chown directory
ADD www /var/www/html

# Set user dan group
RUN usermod -u 1000 www-data
ADD apache-config.conf /etc/apache2/sites-enabled/000-default.conf

#Jalankan apache
CMD /usr/sbin/apache2ctl -D FOREGROUND
