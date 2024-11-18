#!/bin/bash

# Define Colors
GREEN="\033[0;32m"
RED="\033[0;31m"
BLUE="\033[0;34m"
NC="\033[0m" # No Color

# Log file for script actions
LOG_FILE="devops_script.log"

# Logging function
log_action() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> $LOG_FILE
}

# Function to check if a command exists
check_command() {
    if ! command -v "$1" &> /dev/null; then
        echo -e "${RED}Error: $1 is not installed. Please install it to proceed.${NC}"
        log_action "Error: $1 is not installed."
        return 1
    fi
    return 0
}

# Function to list AWS services
list_aws_services() {
    echo -e "${BLUE}Currently using AWS Services:${NC}"
    services=("ec2" "s3" "lambda" "rds" "dynamodb" "cloudwatch" "ecs" "sqs" "sns" "iam")
    for service in "${services[@]}"; do
        if aws "$service" help &> /dev/null; then
            echo -e "${GREEN}- $service: Active${NC}"
        else
            echo -e "${RED}- $service: Not Active${NC}"
            log_action "AWS service $service is not active."
        fi
    done
}

# Function to check system utilization
check_system_utilization() {
    echo -e "${BLUE}\nSystem Utilization:${NC}"
    cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk -F',' '{print 100 - $4 "%"}')
    free_memory=$(free -m | awk '/^Mem/ {print $4 " MB"}')
    free_disk=$(df -h / | awk 'NR==2 {print $4}')
    
    if [[ -z "$cpu_usage" || -z "$free_memory" || -z "$free_disk" ]]; then
        echo -e "${RED}Error: Failed to retrieve system utilization metrics.${NC}"
        log_action "Error: Failed to retrieve system utilization metrics."
    else
        echo "CPU Utilization: $cpu_usage"
        echo "Free Memory: $free_memory"
        echo "Free Disk Space: $free_disk"
        log_action "Retrieved system utilization metrics."
    fi
}

# Function to list EC2 instances
list_ec2_instances() {
    check_command "aws" || return 1
    echo -e "${BLUE}\nList of EC2 Instances:${NC}"
    if ! aws ec2 describe-instances --query 'Reservations[*].Instances[*].[InstanceId,State.Name]' --output text; then
        echo -e "${RED}Error: Failed to retrieve EC2 instances. Ensure AWS CLI is configured.${NC}"
        log_action "Error: Failed to retrieve EC2 instances."
    fi
}

# Function to list S3 buckets
list_s3_buckets() {
    check_command "aws" || return 1
    echo -e "${BLUE}\nList of S3 Buckets:${NC}"
    if ! aws s3 ls | awk '{print "- " $3}'; then
        echo -e "${RED}Error: Failed to retrieve S3 buckets.${NC}"
        log_action "Error: Failed to retrieve S3 buckets."
    fi
}

# Function to deploy a Docker container
deploy_docker_container() {
    check_command "docker" || return 1
    read -p "Enter image name to deploy: " image_name
    if docker run -d --name devops_container "$image_name"; then
        echo -e "${GREEN}Docker container deployed with image: $image_name${NC}"
        log_action "Deployed Docker container with image: $image_name."
    else
        echo -e "${RED}Error: Failed to deploy Docker container with image: $image_name.${NC}"
        log_action "Error: Failed to deploy Docker container with image: $image_name."
    fi
}

# Function to display Kubernetes pods
list_kubernetes_pods() {
    check_command "kubectl" || return 1
    echo -e "${BLUE}\nList of Kubernetes Pods:${NC}"
    if ! kubectl get pods; then
        echo -e "${RED}Error: Failed to retrieve Kubernetes pods.${NC}"
        log_action "Error: Failed to retrieve Kubernetes pods."
    fi
}

# Function to deploy a Kubernetes application
deploy_kubernetes_app() {
    check_command "kubectl" || return 1
    read -p "Enter deployment file path: " file_path
    if [[ ! -f $file_path ]]; then
        echo -e "${RED}Error: File $file_path does not exist.${NC}"
        log_action "Error: Kubernetes deployment file $file_path not found."
        return 1
    fi
    if kubectl apply -f "$file_path"; then
        echo -e "${GREEN}Kubernetes application deployed from $file_path${NC}"
        log_action "Deployed Kubernetes application from $file_path."
    else
        echo -e "${RED}Error: Failed to deploy Kubernetes application.${NC}"
        log_action "Error: Failed to deploy Kubernetes application from $file_path."
    fi
}

# Function to create a new S3 bucket
create_s3_bucket() {
    check_command "aws" || return 1
    read -p "Enter bucket name: " bucket_name
    if aws s3 mb "s3://$bucket_name"; then
        echo -e "${GREEN}S3 bucket $bucket_name created.${NC}"
        log_action "Created S3 bucket $bucket_name."
    else
        echo -e "${RED}Error: Failed to create S3 bucket $bucket_name.${NC}"
        log_action "Error: Failed to create S3 bucket $bucket_name."
    fi
}

# Main menu function
main_menu() {
    while true; do
        echo -e "\n${BLUE}Select a task to perform:${NC}"
        echo "1) List all AWS services currently in use"
        echo "2) Check system utilization (CPU, Memory, Disk)"
        echo "3) List EC2 Instances"
        echo "4) List S3 Buckets"
        echo "5) Deploy Docker Container"
        echo "6) List Kubernetes Pods"
        echo "7) Deploy Kubernetes Application"
        echo "8) Create S3 Bucket"
        echo "9) Exit"
        read -p "Enter your choice: " choice

        case $choice in
            1) list_aws_services ;;
            2) check_system_utilization ;;
            3) list_ec2_instances ;;
            4) list_s3_buckets ;;
            5) deploy_docker_container ;;
            6) list_kubernetes_pods ;;
            7) deploy_kubernetes_app ;;
            8) create_s3_bucket ;;
            9) echo -e "${GREEN}Exiting...${NC}"; log_action "Script exited by user."; exit ;;
            *) echo -e "${RED}Invalid choice. Please try again.${NC}" ;;
        esac
    done
}

# Run the main menu
log_action "Script execution started."
main_menu
