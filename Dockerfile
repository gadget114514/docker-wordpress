FROM ubuntu:18.04
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y supervisor
RUN mkdir -p /var/log/supervisor; exit 0
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf


RUN apt-get install -y apt-utils unzip
RUN apt-get install -y mysql-server mysql-client
RUN apt-get install -y apache2
RUN apt-get install -y php7.2-cli php7.2-mysql
RUN apt-get install -y redis-server redis-tools
RUN apt-get install -y php-mbstring php7.2-curl php-gd php-xml php php7.2-cgi libapache2-mod-php php7.2-common php-pear php7.2-redis

# FASTCGI
# RUN apt-get install -y php7.2-fpm php7.2-apcu

RUN mkdir -p /var/run/mysqld; exit 0
RUN mkdir -p /var/lib/mysql; exit 0
RUN chown -R mysql:mysql /var/run/mysqld
RUN chown -R mysql:mysql /var/lib/mysql
RUN usermod -d /var/lib/mysql mysql
COPY my.cnf /etc/mysql/my.cnf
#RUN mysql_secure_installation -p test1234 -D
#RUN sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf

RUN mkdir -p /var/lib/redis; exit 0


RUN a2enmod rewrite
RUN apt-get install -y curl build-essential

# FASTCGI
# RUN apt-get install libapache2-mod-fcgid
# RUN a2enmod proxy_fcgi setenvif
# RUN a2enconf php7.2-fpm


RUN useradd -u 1100 -G www-data -m -s /bin/bash wp

ADD node-setup.sh /home/wp/node-setup.sh
RUN bash /home/wp/node-setup.sh
RUN apt-get install -y nodejs 

RUN npm install npm@latest -g
RUN npm install -g forever

RUN apt-get install -y telnet vim

COPY wp-cli.phar /usr/local/bin/wp
RUN chmod +x /usr/local/bin/wp

COPY wordpress.zip  /home/wp/wordpress.zip
COPY wordpress-setup.sh /home/wp/wordpress-setup.sh
COPY db-setup.sh /home/wp/db-setup.sh
RUN chmod a+x /home/wp/wordpress-setup.sh
RUN chmod a+x /home/wp/db-setup.sh
COPY wordpress-createdb.sql /home/wp/wordpress-createdb.sql

# FASTCGI configuration files
# COPY fpm-www.conf /etc/php/7.2/fpm/pool.d/www.conf
# COPY apache2.conf /etc/apache2/apache2.conf

COPY redis.conf /etc/redis/redis.conf


COPY index.html /var/www/html/index.html
# convenient for debug
COPY info.php /var/www/html/info.php
# expose ports
EXPOSE 3306
EXPOSE 6379
# 
#RUN mysql_install_db --datadir=/var/lib/mysql --user=mysql

EXPOSE 80
CMD ["/usr/bin/supervisord"]

