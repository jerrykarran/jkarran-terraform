#!/bin/bash
# created by Jerry Karran - LUIT-Red-Team-2023

# perform linux update
sudo yum update -y

# install Apache Web Server
sudo yum install -y httpd

# start the Apache Web Server
sudo systemctl start httpd


# enable it to start on boot
sudo systemctl enable httpd

cd /var/www/html

echo '<center><h1>Welcome to LUIT - Team <font color="red">Red</font></h1></center>' | sudo tee index.html