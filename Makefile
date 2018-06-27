BASE=/opt/local/src

build:
	- mkdir -p ../root/www
	- mkdir -p ../root/mysql
	- mkdir -p ../root/redis
	docker build -t wp .

run:	
	docker run -d --name wp -v ${BASE}/root/www:/var/www/html -v ${BASE}/root/mysql:/var/lib/mysql -v ${BASE}/root/redis:/var/lib/redis -p 8888:80 --cap-add=NET_ADMIN wp
# docker run -d --name wp -v ${BASE}/root/www:/var/www/html -v ${BASE}/root/mysql:/var/lib/mysql -v ${BASE}/root/redis:/var/lib/redis -p 8888:80 --privileged --cap-add=NET_ADMIN wp

initdb:
	docker exec -it wp /bin/bash /home/wp/db-setup.sh


init:
	docker exec -it wp /bin/bash /home/wp/wordpress-setup.sh


