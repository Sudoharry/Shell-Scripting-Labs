#!/bin/bash

# Variables
REGION="ap-south-1" # e.g., us-east-1
AMI_ID="ami-053b12d3152c0cc71" # Replace with the AMI ID for your region
KEY_NAME="mumbaiKeyPair" # Replace with your key pair name
KEY_PATH="/home/harry/Harendra/AWS/mumbaiKeyPair.pem" # Path to the private key
SECURITY_GROUP="sg-0208cdca6828e458a" # Replace with your security group ID

# Color codes for readability
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Instance types list
INSTANCE_TYPES=("t2.micro" "t2.small" "t2.medium" "m5.large" "m5.xlarge" "c5.large")

# Functions
create_instance() {
    read -p "Enter a name for the EC2 instance: " TAG_NAME

    echo -e "${CYAN}Select an instance type:${NC}"
    select INSTANCE_TYPE in "${INSTANCE_TYPES[@]}"; do
        if [[ -n "$INSTANCE_TYPE" ]]; then
            echo -e "${GREEN}You selected: $INSTANCE_TYPE${NC}"
            break
        else
            echo -e "${RED}Invalid choice, please select a valid instance type.${NC}"
        fi
    done

    echo -e "${YELLOW}Creating a new EC2 instance...${NC}"
    INSTANCE_ID=$(aws ec2 run-instances \
        --region "$REGION" \
        --image-id "$AMI_ID" \
        --instance-type "$INSTANCE_TYPE" \
        --key-name "$KEY_NAME" \
        --security-group-ids "$SECURITY_GROUP" \
        --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$TAG_NAME}]" \
        --query "Instances[0].InstanceId" \
        --output text)

    echo -e "${GREEN}Instance created with ID: $INSTANCE_ID${NC}"

    echo -e "${YELLOW}Waiting for the instance to be in a running state...${NC}"
    aws ec2 wait instance-running --instance-ids "$INSTANCE_ID" --region "$REGION"

    PUBLIC_IP=$(aws ec2 describe-instances \
        --region "$REGION" \
        --instance-ids "$INSTANCE_ID" \
        --query "Reservations[0].Instances[0].PublicIpAddress" \
        --output text)

    echo -e "${GREEN}Instance is running. Public IP: $PUBLIC_IP${NC}"
    echo "$INSTANCE_ID $PUBLIC_IP" >> instance_details.txt
}

list_instances() {
    echo -e "${YELLOW}Listing all EC2 instances in region $REGION...${NC}"
    aws ec2 describe-instances \
        --region "$REGION" \
        --query "Reservations[*].Instances[*].{InstanceID:InstanceId,State:State.Name,PublicIP:PublicIpAddress,Name:Tags[?Key=='Name'].Value|[0]}" \
        --output table
}

terminate_instance() {
    echo -e "${YELLOW}Listing all instances:${NC}"
    list_instances

    read -p "Enter the Instance ID to terminate: " INSTANCE_ID
    read -p "Are you sure you want to terminate instance $INSTANCE_ID? (yes/no): " CONFIRM

    if [[ "$CONFIRM" == "yes" ]]; then
        echo -e "${YELLOW}Terminating instance $INSTANCE_ID...${NC}"
        aws ec2 terminate-instances --instance-ids "$INSTANCE_ID" --region "$REGION"

        echo -e "${YELLOW}Waiting for the instance to terminate...${NC}"
        aws ec2 wait instance-terminated --instance-ids "$INSTANCE_ID" --region "$REGION"

        echo -e "${GREEN}Instance $INSTANCE_ID terminated.${NC}"
    else
        echo -e "${RED}Termination canceled.${NC}"
    fi
}

terminate_all_instances() {
    echo -e "${YELLOW}Listing all running instances:${NC}"
    RUNNING_INSTANCES=$(aws ec2 describe-instances \
        --region "$REGION" \
        --filters Name=instance-state-name,Values=running \
        --query "Reservations[*].Instances[*].InstanceId" \
        --output text)

    if [[ -z "$RUNNING_INSTANCES" ]]; then
        echo -e "${RED}No running instances found.${NC}"
        return
    fi

    echo -e "${YELLOW}The following instances will be terminated:${NC}"
    echo "$RUNNING_INSTANCES"

    read -p "Are you sure you want to terminate all running instances? (yes/no): " CONFIRM
    if [[ "$CONFIRM" == "yes" ]]; then
        echo -e "${YELLOW}Terminating all running instances...${NC}"
        aws ec2 terminate-instances --instance-ids $RUNNING_INSTANCES --region "$REGION"

        echo -e "${YELLOW}Waiting for all instances to terminate...${NC}"
        for INSTANCE in $RUNNING_INSTANCES; do
            aws ec2 wait instance-terminated --instance-ids "$INSTANCE" --region "$REGION"
        done

        echo -e "${GREEN}All running instances terminated.${NC}"
    else
        echo -e "${RED}Termination of all instances canceled.${NC}"
    fi
}

ssh_instance() {
    echo -e "${YELLOW}Listing all EC2 instances for SSH connection...${NC}"
    list_instances

    # Prompt user to choose an instance to SSH into
    read -p "Enter the Instance ID or Public IP to SSH into: " CHOICE

    # Fetch the Public IP using Instance ID (if the user entered the instance ID)
    if [[ $CHOICE =~ ^i- ]]; then
        PUBLIC_IP=$(aws ec2 describe-instances \
            --region "$REGION" \
            --instance-ids "$CHOICE" \
            --query "Reservations[0].Instances[0].PublicIpAddress" \
            --output text)
    else
        PUBLIC_IP=$CHOICE
    fi

    if [[ -z "$PUBLIC_IP" ]]; then
        echo -e "${RED}Invalid Instance ID or Public IP.${NC}"
        return
    fi

    echo -e "${CYAN}Connecting to instance at $PUBLIC_IP...${NC}"
    ssh -i "$KEY_PATH" "ubuntu@$PUBLIC_IP"
}

list_eks_clusters() {
    echo -e "${YELLOW}Listing all EKS clusters in region $REGION...${NC}"
    aws eks list-clusters --region "$REGION" --output table
}

create_s3_bucket() {
    read -p "Enter the name of the new S3 bucket: " BUCKET_NAME
    echo -e "${YELLOW}Creating S3 bucket $BUCKET_NAME in region $REGION...${NC}"
    aws s3api create-bucket --bucket "$BUCKET_NAME" --region "$REGION" --create-bucket-configuration LocationConstraint="$REGION"
    echo -e "${GREEN}Bucket $BUCKET_NAME created successfully.${NC}"
}

list_s3_buckets() {
    echo -e "${YELLOW}Listing all S3 buckets...${NC}"
    aws s3api list-buckets --query "Buckets[].Name" --output table
}

delete_s3_bucket() {
    read -p "Enter the name of the S3 bucket to delete: " BUCKET_NAME
    read -p "Are you sure you want to delete the bucket $BUCKET_NAME? (yes/no): " CONFIRMATION

    if [[ "$CONFIRMATION" == "yes" ]]; then
        echo -e "${YELLOW}Deleting S3 bucket $BUCKET_NAME...${NC}"
        aws s3api delete-bucket --bucket "$BUCKET_NAME" --region "$REGION"
        echo -e "${GREEN}Bucket $BUCKET_NAME deleted successfully.${NC}"
    else
        echo -e "${RED}Bucket deletion canceled.${NC}"
    fi
}

# Menu Loop
while true; do
    echo -e "${CYAN}Choose an option:${NC}"
    echo -e "1. Create a new EC2 instance"
    echo -e "2. List all EC2 instances"
    echo -e "3. Terminate a specific EC2 instance"
    echo -e "4. SSH into an EC2 instance"
    echo -e "5. List all EKS clusters"
    echo -e "6. Create a new S3 bucket"
    echo -e "7. List all S3 buckets"
    echo -e "8. Delete an S3 bucket"
    echo -e "9. Terminate all running EC2 instances"
    echo -e "10. Exit"
    read -p "Enter your choice: " CHOICE

    case $CHOICE in
        1)
            create_instance
            ;;
        2)
            list_instances
            ;;
        3)
            terminate_instance
            ;;
        4)
            ssh_instance
            ;;
        5)
            list_eks_clusters
            ;;
        6)
            create_s3_bucket
            ;;
        7)
            list_s3_buckets
            ;;
        8)
            delete_s3_bucket
            ;;
        9)
            terminate_all_instances
            ;;
        10)
            echo -e "${CYAN}Exiting...${NC}"
            exit 0
            ;;
        *)
            echo -e "${RED}Invalid choice. Please try again.${NC}"
            ;;
    esac
done
