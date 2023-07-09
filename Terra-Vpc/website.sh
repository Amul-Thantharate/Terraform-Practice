#!/bin/bash
apt-get update -y 
git clone https://github.com/safak/youtube.git
apt-get install -y nginx
cp -r youtube/* /var/www/html/
systemctl start nginx 
systemctl enable nginx


