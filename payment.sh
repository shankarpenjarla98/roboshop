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

yum install python36 gcc python3-devel -y

useradd roboshop

mkdir /app 

curl -L -o /tmp/payment.zip https://roboshop-builds.s3.amazonaws.com/payment.zip

cd /app 

unzip /tmp/payment.zip

cd /app 

pip3.6 install -r requirements.txt

cp /home/centos/roboshop/payment.service /etc/systemd/system/payment.service

systemctl daemon-reload

systemctl enable payment 

systemctl start payment

