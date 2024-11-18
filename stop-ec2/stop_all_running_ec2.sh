#!/bin/bash

# Function to stop all running EC2 instances
stop_all_instances() {
    echo "Listing all running EC2 instances..."
    RUNNING_INSTANCES=$(aws ec2 describe-instances --query "Reservations[?Instances[0].State.Name=='running'].Instances[0].InstanceId" --output text)

    if [ -z "$RUNNING_INSTANCES" ]; then
        echo "No running EC2 instances found."
        exit 1
    fi

    echo "Running EC2 instances: $RUNNING_INSTANCES"
    echo "Stopping all running EC2 instances..."
    aws ec2 stop-instances --instance-ids $RUNNING_INSTANCES
    echo "Stopped the following EC2 instances: $RUNNING_INSTANCES"
}

# Function to stop specific EC2 instances by instance ID
stop_specific_instances() {
    INSTANCE_IDS=$1

    if [ -z "$INSTANCE_IDS" ]; then
        echo "Please provide the EC2 instance IDs to stop."
        exit 1
    fi

    echo "Stopping specified EC2 instances: $INSTANCE_IDS"
    aws ec2 stop-instances --instance-ids $INSTANCE_IDS
    echo "Stopped the specified EC2 instances: $INSTANCE_IDS"
}

# Main logic: Choose between stopping all instances or specific ones
echo "Do you want to stop all EC2 instances or specific ones?"
echo "1. Stop all running EC2 instances"
echo "2. Stop specific EC2 instances"

read -p "Enter 1 or 2: " choice

case $choice in
    1)
        stop_all_instances
        ;;
    2)
        read -p "Enter the EC2 instance IDs (comma-separated, e.g., i-12345678,i-23456789): " instance_ids
        stop_specific_instances "$instance_ids"
        ;;
    *)
        echo "Invalid choice. Please choose 1 or 2."
        exit 1
        ;;
esac
