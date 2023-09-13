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

curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>$logfile

validate $? "NPM NODESOURCE SETUP"

yum install nodejs -y &>>$logfile

validate $? "installation of nodejs"

useradd roboshop &>>$logfile

valiadte $? "creation of user"

mkdir /app &>>$logfile

validate $? "creation of app directory"

curl -o /tmp/catalogue.zip https://roboshop-builds.s3.amazonaws.com/catalogue.zip  &>>$logfile

validate $? "downloading app code is"

cd /app  &>>$logfile

unzip /tmp/catalogue.zip &>>$logfile

validate $? "unzipping the file is"

cd /app &>>$logfile

npm install  &>>$logfile

validate $? "npm installation is"

cp /home/centos/roboshop/catalogue.service /etc/systemd/system/catalogue.service &>>$logfile

systemctl daemon-reload &>>$logfile

validate $? "reloaded is"

systemctl enable catalogue &>>$logfile

validate $? "enabling is"

systemctl start catalogue &>>$logfile

validate $? "starting catalogue is"

cp /home/centos/roboshop/mongo.repo /etc/yum.repos.d/mongo.repo  &>>$logfile

yum install mongodb-org-shell -y &>>logfile

validate $? "installaing mongo-shell is"

mongo --host mongodb.learndevops.uno </app/schema/catalogue.js &>>$logfile