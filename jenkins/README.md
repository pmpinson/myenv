# AWS infos

deploy on aws

image : Amazon Linux AMI 2014.09.2 (HVM) - ami-146e2a7c

volume :
* 8g : jenkins (system), autoterminate
* 6g : jenkins-backup

dns : ** **

exposed traffic only http on **9003** and **9004**

by default server not available

# init

use init.sh script

# containers

## docker ui tool

`docker run -d --name dev-dockerui -p 9003:9000 --privileged -v /var/run/docker.sock:/var/run/docker.sock dockerui/dockerui`

access to application by [http://xxx:9003](http://xxx:9000)

by default container is not available

## jenkins server

build the image [here](https://github.com/pmpinson/dockerfile/tree/master/jenkins)

`docker run -d --name dev-jenkins-server -p 9004:8080 -v /data/jenkins:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock pmpinson/jenkins`

access to application by [http://xxx:9004](http://xxx:9002)
