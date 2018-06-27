#!/bin/bash


SITENAME=wordpress
TITLE=docker-wordpress
HOST=localhost
PORT=8080

URL=http://$HOST:$PORT/$WPPATH/
DOCUMENTROOT=/var/www/html
WPPATH=$DOCUMENTROOT/$SITENAME

cd /home/wp
# mysqladmin -u root password test
mysql < wordpress-createdb.sql ; exit 0
unzip -q /home/wp/wordpress.zip

/bin/rm -rf $WPPATH ; exit 0
mv wordpress $WPPATH ; exit 0

cd $DOCUMENTROOT

chown -R www-data:www-data $DOCUMENTROOT
touch $WPPATH/.htaccess
chmod 660 $WPPATH/.htaccess
cp $WPPATH/wp-config-sample.php $WPPATH/wp-config.php
mkdir $WPPATH/wp-content/upgrade
chown -R wp $WPPATH
chgrp -R www-data $WPPATH
chmod g+w $WPPATH/wp-content
chmod -R g+w $WPPATH/wp-content/themes
chmod -R g+w $WPPATH/wp-content/plugins
chmod -R g+w $WPPATH/wp-content/upgrade
chmod -R g+w $WPPATH/wp-content/languages

cd $WPPATH
# wp core install --allow-root --url=$URL --title=$TITLE --admin_user=root --admin_email=test@example.com
