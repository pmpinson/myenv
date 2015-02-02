#!/bin/sh

# mount sonarqube-backup volume
sudo mkdir -p /data
sudo mount /dev/xvdb /data
sudo sh -c '(sudo cat /etc/fstab ; echo "/dev/xvdb       /data   ext4    defaults,nofail 0   0") > /etc/fstab.new'
sudo mv /etc/fstab /etc/fstab.origin
sudo mv /etc/fstab.new /etc/fstab

# install docker
sudo yum install -y docker
sudo service docker start

# build sonarqube image
sudo wget https://raw.githubusercontent.com/pmpinson/dockerfile/master/sonarqube/5.0/Dockerfile
sudo docker build --tag=pmpinson/sonarqube:5.0 .
sudo docker build --tag=pmpinson/sonarqube .

# launch mysqlcontainer
#-p 9001:3306
sudo docker run -d --name dev-sonarqube-mysql -e MYSQL_ROOT_PASSWORD=$$$$ -e MYSQL_DATABASE=sonarqube -v /data/mysql:/var/lib/mysql --restart=always mysql

# launch sonarqube
sudo docker run -d --name dev-sonarqube-server -p 9002:9000 --link dev-sonarqube-mysql:db -v /data/sonarqube/conf:/app/sonarqube/conf -v /data/sonarqube/logs:/app/sonarqube/logs -v /data/sonarqube/plugins:/app/sonarqube/extensions/plugins -v /data/sonarqube/jdbc-driver:/app/sonarqube/extensions/jdbc-driver --restart=always pmpinson/sonarqube
