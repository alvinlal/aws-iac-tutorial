#!/bin/bash

# nestjs-app
# AMI user-data for creating pre-baked ami for running nestjs applications

echo "UPDATING DEPS"
yum update -y

echo "INSTALLING NGINX VERSION 1.22.1"
amazon-linux-extras enable nginx1
yum -y install nginx-1.22.1
systemctl start nginx
systemctl enable nginx

echo "INSTALLING GIT"
yum install -y git

echo "INSTALLING NODE VERSION 16"
curl --silent --location https://rpm.nodesource.com/setup_16.x | bash -
yum -y install nodejs

echo "INSTALLING NESTJS CLI"
npm install -g @nestjs/cli

echo "INSTALLING PM2 VERSION 5.2.2"
npm install pm2@5.2.2 -g
pm2 startup 


echo "INSTALLING CODEDEPLOY AGENT"
yum install -y ruby
wget https://aws-codedeploy-ap-south-1.s3.ap-south-1.amazonaws.com/latest/install 
chmod +x ./install
./install auto
rm install
service codedeploy-agent start
