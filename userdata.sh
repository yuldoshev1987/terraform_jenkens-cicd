#!/bin/bash
yum update -y
yum install httpd -y
service httpd start
chkconfig httpd on
echo "<html><body><h1>Hi there, this is web server developed by Rustam</h1></body></html>" > /var/www/html/index.html