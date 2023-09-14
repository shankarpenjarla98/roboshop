#!/bin/bash


names=("web" "mongodb" "catalog" "user" "cart" "mysql" "shipping" "redis" "rabbitmq" "payment" "dispatch")
instance_type=" "
imageid=ami-03265a0778a880afb
securityid=sg-07eac0a2eb62d0655
domname=learndevops.uno



for i in "${names[@]}"
do 
   if [[ $i == "mongodb" || $i == "mysql"]]
     then
       instance_type="t2.small"
   else
       instance_type="t2.micro"
   fi
 echo "creating $i instances"
 ipadd=$(aws ec2 run-instances --image-id $imageid --count 1 --instance-type t2.micro  --security-group-ids $securityid  | jq -r '.Instances[0].PrivateIpAddress')
 echo "created $i instances: $ipadd"

 aws route53 change-resource-record-sets --hosted-zone-id Z1037665238BF3QDUCKFN --change-batch '
{
       "Changes": [{
        "Action": "CREATE",
            "ResourceRecordSet": {
                "Name": "'$i.$domname'",
                "Type": "A",
                "TTL": 60,
                "ResourceRecords": [{ "Value": "'$ipadd'"}]
              }}]
                
}
'
done
