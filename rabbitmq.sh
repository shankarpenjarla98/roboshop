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

curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash

curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash

yum install rabbitmq-server -y 

systemctl enable rabbitmq-server 

systemctl start rabbitmq-server 

rabbitmqctl add_user roboshop roboshop123

rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"