this project present the use of docker to build development environnement with docker containers.

my environnement use
* ubuntu 14 for dev purpose
* some aws computer for dev tools like sonar

# sonarqube

deploy on aws

dns : ** **

exposed traffic only http on **9000** and **9002**

by default server not available

## docker ui tool

`docker run -d --name dev-dockerui -p 9000:9000 --privileged -v /var/run/docker.sock:/var/run/docker.sock dockerui/dockerui`

access to application by [http://xxx:9000](http://xxx:9000)

by default container is not available

## mysql server

`docker run -d --name dev-sonarqube-mysql -p 9001:3306 -e MYSQL_ROOT_PASSWORD=$$$$ -e MYSQL_DATABASE=sonarqube mysql`

access locally only

`docker run -it --link dev-sonarqube-mysql:mysql --rm mysql sh -c 'exec mysql -h"$MYSQL_PORT_3306_TCP_ADDR" -P"$MYSQL_PORT_3306_TCP_PORT" -uroot -p"$MYSQL_ENV_MYSQL_ROOT_PASSWORD"'`

## sonarqube server

`docker run -d --name dev-sonarqube-server -p 9002:9000 --link dev-sonarqube-mysql:db pmpinson/sonarqube`

access to application by [http://xxx:9002](http://xxx:9002)

# jenkins

deploy on aws

dns : ** **

exposed traffic only http on **9003** and **9004**

by default server not available

## docker ui tool

`docker run -d --name dev-dockerui -p 9003:9000 --privileged -v /var/run/docker.sock:/var/run/docker.sock dockerui/dockerui`

access to application by [http://xxx:9003](http://xxx:9000)

by default container is not available

## jenkins server

build the image [here](../dockerfile/jenkins)

`docker run -d --name dev-jenkins-server -p 9004:8080 -v /data/jenkins:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock pmpinson/jenkins`

access to application by [http://xxx:9004](http://xxx:9002)
