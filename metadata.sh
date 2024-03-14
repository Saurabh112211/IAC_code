#!/bin/bash


if ! command -v aws &> /dev/null; then
    echo "AWS CLI is not installed. Please install it first."
    exit 1
fi

#Retrieve instance metadata and format as JSON 
instance_metadata=$(aws ec2 describe-instances --instance-id $(curl -s http://18.233.152.140/latest/meta-data/instance-id) --query 'Reservations[0].Instances[0]' --output json)

#Check if the AWS CLI command was successful 
if [ $? -eq 0 ]; then
    # Print the JSON output
    echo "$instance_metadata"
else
    echo "Failed to retrieve instance metadata."
fi