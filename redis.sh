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

yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y

validate $? "installing redis"

yum module enable redis:remi-6.2 -y

yum install redis -y 

sed -i 's/127.0.0.1/0.0.0.0/g' /etc/redis.conf /etc/redis/redis.conf

systemctl enable redis

systemctl start redis

