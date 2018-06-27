# docker-wordpress

This is docker-wordpress not using docker-compose;

There are a lot of docker-wordpress solution using docker-compose.
But i want to use single docker image containing necessory components overall.
So i build up this package.

- Using compontents
	- ubuntu 18.04
	- mysql
	- wordpress
	- apache2
	- fcgi (optional)
	- php7.2
	- node
	- redis
	- supervisord (invokes daemons)

notice: mysql has no password;  in /etc/mysql/my.cnf, skip-grant-tables is written to skip database password authentication.


- Clone
	- mkdir work
	- cd work
        - cloning here 

notice: work/root directory will contain the databases persistent data;

- Download wordpress.zip and put to this directory as wordpress.zip.
  
  copy wordpress-downloaded.zip wordpress.zip

- Make
	- make build (to build image) 
	- make run (to run)
	- make initdb (to setup (once))
	- make init (to setup (once))

        make init setup databases;

- Rewrite wp-config.php
	- docker exec -it [id] /bin/bash
	- vi /var/www/html/wordpress/wp-config.php

```
                 - databasename : wordpress
		   define('DB_NAME', 'wordpress')
                 - user : root
		   define('DB_USER', 'root')
                 - password : empty string
		   define('DB_PASSWORD', '')
```		 

- Check php working
	- http://localhost:8888/info.php
- Access to the installed wordpress
	- http://localhost:8888/wordpress/


- Error in executing mysqld

If you have errors running mysqld in privileged container like this "/usr/sbin/mysqld: error while loading shared libraries: libaio.so.1: cannot open shared object file: Permission denied" , then do the following steps:


Search and remove all mysql installation from host machine. You can search mysql packages as 

```
 sudo ln -s /etc/apparmor.d/usr.sbin.mysqld /etc/apparmor.d/disable/
 sudo apparmor_parser -R /etc/apparmor.d/usr.sbin.mysqld
 sudo /etc/init.d/apparmor restart
 sudo aa-status #Should not have mysql here
```

After the above steps, try to re-start mysql-server in docker container
