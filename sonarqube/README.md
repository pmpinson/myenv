# AWS infos

image : Amazon Linux AMI 2014.09.2 (HVM) - ami-146e2a7c

volume :
* 8g : sonarqube (system), autoterminate
* 6g : sonarqube-backup

dns : ** **

exposed traffic only http on **9000** and **9002**

by default server not available

# init

use init.sh script

wget https://raw.githubusercontent.com/pmpinson/myenv/master/sonarqube/init.sh && chmod u+x init.sh && sh init.sh

# containers

## docker ui tool

`docker run -d --name dev-dockerui -p 9000:9000 --privileged -v /var/run/docker.sock:/var/run/docker.sock dockerui/dockerui`

access to application by [http://xxx:9000](http://xxx:9000)

by default container is not available

## mysql server

`docker run -d --name dev-sonarqube-mysql -p 9001:3306 -e MYSQL_ROOT_PASSWORD=$$$$ -e MYSQL_DATABASE=sonarqube -v /data/mysql:/var/lib/mysql --restart=always mysql`

access locally only

`docker run -it --link dev-sonarqube-mysql:mysql --rm mysql sh -c 'exec mysql -h"$MYSQL_PORT_3306_TCP_ADDR" -P"$MYSQL_PORT_3306_TCP_PORT" -uroot -p"$MYSQL_ENV_MYSQL_ROOT_PASSWORD"'`

## sonarqube server

build the image [here](https://github.com/pmpinson/dockerfile/tree/master/sonarqube)

`docker run -d --name dev-sonarqube-server -p 9002:9000 --link dev-sonarqube-mysql:db -v /data/sonarqube/conf:/app/conf -v /data/sonarqube/logs:/app/logs -v /data/sonarqube/plugins:/app/plugins -v /data/sonarqube/jdbc-driver:/app/jdbc-driver --restart=always pmpinson/sonarqube`

access to application by [http://xxx:9002](http://xxx:9002)
