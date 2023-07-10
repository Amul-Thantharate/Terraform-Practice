#!/bin/bash

yum update -y 
yum install git -y 
yum install httpd -y 

mkdir /home/ec2-user/cryptex-app
cd /home/ec2-user/cryptex-app
git clone https://github.com/codewithsadee/cryptex.git
cd cryptex
mv * /var/www/html/
cd /var/www/html

systemctl start httpd
systemctl enable httpd