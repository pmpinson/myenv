#!/bin/sh

sudo -i


# mount jenkins-backup volume
mount /dev/xvdb /data
cp /etc/fstab /etc/fstab.origin
(cat /etc/fstab ; echo "/dev/xvdb       /data   ext4    defaults,nofail 0   0") > /etc/fstab

# install docker
yum install -y docker
service docker start

# build jenkins image
wget https://raw.githubusercontent.com/pmpinson/dockerfile/master/jenkins/1.580.2/Dockerfile
docker build --tag=pmpinson/jenkins:1.580.2 . && docker build --tag=pmpinson/jenkins .

# launch jenkins
docker run -d --name dev-jenkins-server -p 9004:8080 -v /data/jenkins:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock pmpinson/jenkins

exit
