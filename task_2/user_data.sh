#!/bin/bash
sudo yum -y update
sudo amazon-linux-extras enable nginx1
sudo yum -y install nginx
MYIP=`curl http://169.254.169.254/latest/meta-data/local-ipv4`
echo "<h2>Nginx WebServer with internal AWS IP - $MYIP</h2><br>External file script powered by Terraform from Turkey" > /usr/share/nginx/html/index.html
sudo service nginx start
sudo serivce nginx enable
