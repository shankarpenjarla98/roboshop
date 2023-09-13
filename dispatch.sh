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

yum install golang -y

useradd roboshop

mkdir /app 

curl -L -o /tmp/dispatch.zip https://roboshop-builds.s3.amazonaws.com/dispatch.zip

cd /app 

unzip /tmp/dispatch.zip

cd /app 

go mod init dispatch

go get

go build

cp /home/centos/roboshop/dispatch.service /etc/systemd/system/dispatch.service

systemctl daemon-reload

systemctl enable dispatch 

systemctl start dispatch

