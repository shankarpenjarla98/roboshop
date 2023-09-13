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

yum install nodejs -y &>>$logfile

validate $? "installation od nodejs is"

useradd roboshop

mkdir /app

curl -L -o /tmp/cart.zip https://roboshop-builds.s3.amazonaws.com/cart.zip

cd /app 

npm install 

cp /home/centos/roboshop/catalogue.service /etc/systemd/system/cart.service

systemctl daemon-reload

systemctl enable cart 

systemctl start cart