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

notice: work/root directory will contain the databases;

- Download wordpress.zip and put to this directory as wordpress.zip.
  
  copy wordpress-downloaded.zip wordpress.zip

- Make
	- make build (to build image) 
	- make run (to run)
	- make init (to setup (once))

        make init setup databases;

- Rewrite wp-config.php
        - docker exec -it [id] /bin/bash
	- vi /var/www/html/wordpress/wp-config.php

```
                 - databasename : wordpress
		 - define('DB_NAME', 'wordpress')
                 - user : root
		 - define('DB_USER', 'root')
                 - password : empty string
		 - define('DB_PASSWORD', '')
```		 

- Access to the installed wordpress
	http://localhost:8888/wordpress/
