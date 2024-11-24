# PIAT-DASHBOARD
![PIAT](https://github.com/user-attachments/assets/39b07b55-f87d-4887-926c-2bace970df42)

## Project Definition
**PIAT-DASHBOARD** is a versatile Bash-based utility script designed for DevOps engineers. It streamlines AWS management, Docker container deployment, Kubernetes application handling, and system utilization monitoring.

---
## PIAT Workflow
![PIAT-WORKFLOW](https://github.com/user-attachments/assets/e14b24c9-2c6d-45f2-8899-7594782d9edf)

## Features
- **AWS Management**: List active services, EC2 instances, and S3 buckets.  
- **System Monitoring**: View CPU, memory, and disk utilization metrics.  
- **Docker Integration**: Deploy Docker containers with ease.  
- **Kubernetes Support**: Manage Kubernetes pods and deploy applications.  
- **S3 Operations**: Create and manage S3 buckets.  
- **Logging**: Maintain logs for script actions.  

---

## Installation
**1. Ensure the required dependencies are installed:**  
   - `AWS CLI`
   - `Docker`
   - `Kubectl`

**2. Clone the repository:**
   ```bash
   git clone https://github.com/your-repo/piat-dashboard.git
   cd piat-dashboard
**3. Make the script executable:**
- chmod 700 piat-dashboard.sh

## Usage:
-  ./piat.sh

### Options
1) List AWS Services: Shows currently active AWS services.
--
2) Check System Utilization: Displays CPU, memory, and disk usage.
--
3) List EC2 Instances: Retrieves details of all EC2 instances.
--
4) List S3 Buckets: Displays all S3 buckets in your AWS account.
--
5) Deploy Docker Container: Deploys a container using a specified Docker image.
--
6) List Kubernetes Pods: Lists all pods in the current Kubernetes context.
--
7) Deploy Kubernetes Application: Deploys an application using a Kubernetes YAML file.
---
8) Create S3 Bucket: Creates a new S3 bucket in your AWS account.
--
9) Exit: Terminates the script.

---
## Logs

- All actions performed by the script are logged to devops_script.log for auditing and debugging purposes.

##   Future Enhancements
- Add dynamic retrieval of AWS services.
- Include error notifications via email.
- Modularize functions for better scalability.
- Add task scheduling integration with cron.

## OUTPUT
![1](https://github.com/user-attachments/assets/81a75a76-9535-4f11-8c08-b77236b2e0e2)



