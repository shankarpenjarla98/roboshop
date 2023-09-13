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

yum install nginx -y

validate $? "installlation of nginx"

systemctl enable nginx

validate $? "Enabling nginx server"

systemctl start nginx

validate $? "starting nginx server"

rm -rf /usr/share/nginx/html/*

validate $? "removed the default html content"

curl -o /tmp/web.zip https://roboshop-builds.s3.amazonaws.com/web.zip

validate $? "downloading the frontend content"

cd /usr/share/nginx/html

validate $? "directing to html content"

unzip /tmp/web.zip

validate $? "unzipping the content"

cp /home/centos/roboshop/roboshop.conf /etc/nginx/default.d/roboshop.conf 

systemctl restart nginx 

validate $? "Restarted the nginx"

