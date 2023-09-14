#!/bin/bash

names=("web" "mongodb" "catalog" "cart" "user" "mysql" "rabmq" "ship" "redis" "payment" "dispatch")
insta_type=""

for i in "${names[@]}"
do 
 if [ [ $i == "mongodb" || $i == "mysql"]]
 then
     insta_type="t2.small"
 else
     inst_type="t2.micro"
 echo "$i instance created"
  aws ec2 run-instances --image-id ami-03265a0778a880afb --count 1 --instance-type t2.micro  --security-group-ids sg-07eac0a2eb62d0655
 
     
