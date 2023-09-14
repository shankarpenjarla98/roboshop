#!/bin/bash

names=("web" "mongodb" "catalogue" "redis" "user" "cart" "mysql" "shipping" "rabbitmq" "payment" "dispatch")

for i in "${names[@]}"
do 
echo "NAME:$i"
done