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

cp mongo.repo /etc/yum.repos.d/mongo.repo &>>$logfile

validate $? "mongo.repo setup"

yum install mongodb-org -y &>>$logfile

validate $? "mongodb-installation"

systemctl enable mongod &>>$logfile

validate $? "enabling of mongod"

systemctl start mongod &>>$logfile

validate $? "restarted the mongod"

sed -i 's/127.0.0.1/0.0.0.0/'  /etc/mongod.conf &>>$logfile

validate $? "port changed"

systemctl restart mongod &>>$logfile

validate $? "restarted the mongod"