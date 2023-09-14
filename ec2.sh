#!/bin/bash

names=("web" "mongodb" "catalog" "cart" "user" "mysql" "rabmq" "ship" "redis" "payment" "dispatch")
insta_type=""
domain_n=learndevops.uno
imageid=ami-03265a0778a880afb
security_group=sg-07eac0a2eb62d0655

for i in "${names[@]}"
do 
     if [[ $i == "mongodb" || $i == "mysql" ]]
     then
        insta_type="t2.small"
     else
        inst_type="t2.micro"
     fi
     echo "$i instance created"
     ip_add=$(aws ec2 run-instances --image-id $imageid --count 1 --instance-type t2.micro  --security-group-ids $security_group)
     echo "crteated $i instance:$ip_add"

     aws route53 change-resource-record-sets --hosted-zone-id Z1037665238BF3QDUCKFN --change-batch '
     {
              
                 "Changes": [ {
                             "Action": "CREATE",
                            "ResourceRecordSet": {
                                "Name": "'$i.$domain_n'",
                                    "Type": "A",
                                     "TTL": 300,
                                  "ResourceRecords": [{"Value": "'$ip_add'"}]
                            }}]
      }
      '
 
 done