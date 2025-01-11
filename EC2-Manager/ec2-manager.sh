#!/bin/bash

# Variables
REGION="ap-south-1" # e.g., us-east-1
AMI_ID="ami-053b12d3152c0cc71" # Replace with the AMI ID for your region
INSTANCE_TYPE="t2.micro"
KEY_NAME="mumbaiKeyPair" # Replace with your key pair name
KEY_PATH="/home/Harendra/AWS/mumbaiKeyPair.pem" # Path to the private key
SECURITY_GROUP="sg-0208cdca6828e458a" # Replace with your security group ID

# Color codes for readability
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Functions
create_instance() {
    echo -e "${YELLOW}Creating a new EC2 instance...${NC}"
    INSTANCE_ID=$(aws ec2 run-instances \
        --region "$REGION" \
        --image-id "$AMI_ID" \
        --instance-type "$INSTANCE_TYPE" \
        --key-name "$KEY_NAME" \
        --security-group-ids "$SECURITY_GROUP" \
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
    echo "$INSTANCE_ID $PUBLIC_IP" > instance_details.txt
}

ssh_instance() {
    if [[ ! -f "instance_details.txt" ]]; then
        echo -e "${RED}No instance details found. Please create an instance first.${NC}"
        exit 1
    fi

    INSTANCE_ID=$(awk '{print $1}' instance_details.txt)
    PUBLIC_IP=$(awk '{print $2}' instance_details.txt)

    echo -e "${YELLOW}Connecting to instance $INSTANCE_ID at $PUBLIC_IP...${NC}"
    ssh -i "$KEY_PATH" "ubuntu@$PUBLIC_IP"
}

terminate_instance() {
    if [[ ! -f "instance_details.txt" ]]; then
        echo -e "${RED}No instance details found. Nothing to terminate.${NC}"
        exit 1
    fi

    INSTANCE_ID=$(awk '{print $1}' instance_details.txt)
    echo -e "${YELLOW}Terminating instance $INSTANCE_ID...${NC}"
    
    aws ec2 terminate-instances --instance-ids "$INSTANCE_ID" --region "$REGION"

    echo -e "${YELLOW}Waiting for the instance to terminate...${NC}"
    aws ec2 wait instance-terminated --instance-ids "$INSTANCE_ID" --region "$REGION"

    echo -e "${GREEN}Instance $INSTANCE_ID terminated.${NC}"
    rm -f instance_details.txt
}

list_ec2_instances() {
    echo -e "${YELLOW}Listing all EC2 instances in region $REGION...${NC}"
    aws ec2 describe-instances \
        --region "$REGION" \
        --query "Reservations[*].Instances[*].{InstanceID:InstanceId,State:State.Name,PublicIP:PublicIpAddress}" \
        --output table
}

list_eks_clusters() {
    echo -e "${YELLOW}Listing all EKS clusters in region $REGION...${NC}"
    aws eks list-clusters --region "$REGION" --query "clusters" --output table
}

create_s3_bucket() {
    read -p "Enter the name of the S3 bucket to create: " BUCKET_NAME
    echo -e "${YELLOW}Creating S3 bucket: $BUCKET_NAME...${NC}"
    aws s3 mb "s3://$BUCKET_NAME" --region "$REGION"

    if [[ $? -eq 0 ]]; then
        echo -e "${GREEN}S3 bucket $BUCKET_NAME created successfully.${NC}"
    else
        echo -e "${RED}Failed to create S3 bucket $BUCKET_NAME.${NC}"
    fi
}

list_s3_buckets() {
    echo -e "${YELLOW}Listing all S3 buckets in region $REGION...${NC}"
    aws s3 ls --region "$REGION"
}

delete_s3_bucket() {
    read -p "Enter the name of the S3 bucket to delete: " BUCKET_NAME
    echo -e "${YELLOW}Deleting S3 bucket: $BUCKET_NAME...${NC}"

    # Check if the bucket exists and is accessible
    if aws s3 ls "s3://$BUCKET_NAME" --region "$REGION" > /dev/null 2>&1; then
        # Delete all objects in the bucket first
        echo -e "${YELLOW}Deleting all objects in the bucket $BUCKET_NAME...${NC}"
        aws s3 rm "s3://$BUCKET_NAME" --recursive --region "$REGION"

        # Delete the S3 bucket
        aws s3 rb "s3://$BUCKET_NAME" --force --region "$REGION"
        if [[ $? -eq 0 ]]; then
            echo -e "${GREEN}S3 bucket $BUCKET_NAME deleted successfully.${NC}"
        else
            echo -e "${RED}Failed to delete S3 bucket $BUCKET_NAME.${NC}"
        fi
    else
        echo -e "${RED}S3 bucket $BUCKET_NAME does not exist or is not accessible.${NC}"
    fi
}

# Menu
echo -e "${CYAN}Choose an option:${NC}"
echo -e "1. Create a new EC2 instance"
echo -e "2. SSH into an existing EC2 instance"
echo -e "3. Terminate an existing EC2 instance"
echo -e "4. List all EC2 instances"
echo -e "5. List all EKS clusters"
echo -e "6. Create an S3 bucket"
echo -e "7. List all S3 buckets"
echo -e "8. Delete an S3 bucket"
read -p "Enter your choice: " CHOICE

case $CHOICE in
    1)
        create_instance
        ;;
    2)
        ssh_instance
        ;;
    3)
        terminate_instance
        ;;
    4)
        list_ec2_instances
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
    *)
        echo -e "${RED}Invalid choice. Exiting.${NC}"
        exit 1
        ;;
esac
