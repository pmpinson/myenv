# launch jenkins
sudo docker run -d --name dev-jenkins-server -p 9004:8080 -v /data/jenkins:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock --restart=always --add-host=dockerhost:$(ip route | awk '/docker0/ { print $NF }') pmpinson/jenkins
