sudo -i


# mount sonarqube-backup volume
mount /dev/xvdb /data
cp /etc/fstab /etc/fstab.origin
(cat /etc/fstab ; echo "/dev/xvdb       /data   ext4    defaults,nofail 0   0") > /etc/fstab

# install docker
yum install -y docker
service docker start

# build sonarqube image
wget https://raw.githubusercontent.com/pmpinson/dockerfile/master/sonarqube/5.0/Dockerfile
docker build --tag=pmpinson/sonarqube:5.0 . && docker build --tag=pmpinson/sonarqube .

# launch mysqlcontainer
#-p 9001:3306
docker run -d --name dev-sonarqube-mysql -e MYSQL_ROOT_PASSWORD=$$$$ -e MYSQL_DATABASE=sonarqube mysql

# launch sonarqube
docker run -d --name dev-sonarqube-server -p 9002:9000 --link dev-sonarqube-mysql:db pmpinson/sonarqube

exit
