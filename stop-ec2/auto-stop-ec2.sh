#!/bin/bash

# Set AWS credentials (if not set globally)
export AWS_DEFAULT_REGION="ap-south-1"

# List all running EC2 instance IDs
RUNNING_INSTANCES=$(aws ec2 describe-instances --query "Reservations[?Instances[0].State.Name=='running'].Instances[0].InstanceId" --output text)

# Check if there are any running instances
if [ -z "$RUNNING_INSTANCES" ]; then
    echo "No running EC2 instances found."
    exit 1
fi

echo "Running EC2 instances: $RUNNING_INSTANCES"

# Stop all running EC2 instances
aws ec2 stop-instances --instance-ids $RUNNING_INSTANCES

echo "Stopping the following EC2 instances: $RUNNING_INSTANCES"
