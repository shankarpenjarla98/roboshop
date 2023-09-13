#!/bin/bash

userid=$(id -u)
date=$(date)
log_dir=/tmp/
scriptname=$0
logfile=$log_dir-$scriptname-$date.log



if [ $userid -ne 0 ]
then
   echo "please try with root access"
else
   echo "you are now in the root access"
fi

validate(){
    if [ $1 -ne 0 ] 
    then
       echo "$2 ..... failed"
    else
       echo "$2 ...... success"
    fi
}

curl -sL https://rpm.nodesource.com/setup_lts.x | bash

validate $? "npm source is"

yum install nodejs -y

useradd roboshop

mkdir /app

curl -L -o /tmp/user.zip https://roboshop-builds.s3.amazonaws.com/user.zip

cd /app 

unzip /tmp/user.zip

npm install 

cp /home/centos/roboshop/user.service /etc/systemd/system/user.service

systemctl daemon-reload

systemctl enable user 

systemctl start user

cp /home/centos/roboshop/mongo.repo /etc/yum.repos.d/mongo.repo

yum install mongodb-org-shell -y

mongo --host mongodb.learndevops.uno </app/schema/user.js

