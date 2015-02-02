#!/bin/sh

# mount jenkins-backup volume
sudo mkdir -p /data
sudo mount /dev/xvdb /data
sudo sh -c '(sudo cat /etc/fstab ; echo "/dev/xvdb       /data   ext4    defaults,nofail 0   0") > /etc/fstab.new'
sudo mv /etc/fstab /etc/fstab.origin
sudo mv /etc/fstab.new /etc/fstab

# install docker
sudo yum install -y docker
sudo service docker start

# build jenkins image
sudo wget https://raw.githubusercontent.com/pmpinson/dockerfile/master/jenkins/1.580.2/Dockerfile
sudo docker build --tag=pmpinson/jenkins:1.580.2 .
docker build --tag=pmpinson/jenkins .

# launch jenkins
sudo docker run -d --name dev-jenkins-server -p 9004:8080 -v /data/jenkins:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock pmpinson/jenkins
