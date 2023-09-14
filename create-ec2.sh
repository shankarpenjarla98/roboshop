#!/bin/bash

names=("web" "mongodb" "catalogue" "redis" "user" "cart" "mysql" "shipping" "rabbitmq" "payment" "dispatch")
instance_type=""
image_id=ami-03265a0778a880afb
sec_grp_id=sg-07eac0a2eb62d0655

#if mysql or mongodb instance type should be t2.small
for i in "${names[@]}"
do 
    if [[ $i == "mongodb" || $i == "mysql"  ]]
    then
       instance_type="t2.small"
    else
       instance_type="t2.micro"
     fi
  echo "creating $i instance"
  aws ec2 run-instances --image-id $image_id   --instance-type $instance_type --security-group-ids $sec_grp_id --tag-specifications "ResouceType=instance,Tags=[{key=Name,Value=$i}]"
done