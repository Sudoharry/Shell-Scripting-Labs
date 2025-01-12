# EC2 Manager Script

The EC2 Manager Script is a dynamic tool for managing AWS EC2 instances using the AWS CLI. The script allows you to:

- **Create EC2 instances** with a custom configuration.
- **SSH into EC2 instances** without the need to manually look up the public IP.
- **Terminate EC2 instances** and cleanly remove associated resources.

This script is written in Bash and interacts with AWS services to automate EC2 instance lifecycle management, making it a convenient tool for managing EC2 instances in various environments.

## Features

- **Create EC2 Instances**: Launch a new EC2 instance with the specified configuration.
- **SSH into EC2 Instances**: SSH into an existing EC2 instance using the private key.
- **Terminate EC2 Instances**: Cleanly terminate an EC2 instance and delete any associated resources.
- **Configuration**: Easy configuration of AWS region, AMI, key pairs, and security groups.

## Prerequisites

Before using this script, ensure the following are set up:

### 1. AWS CLI

Install and configure AWS CLI with your AWS credentials. To configure AWS CLI, run:

```bash
aws configure
```


Here is the updated and comprehensive `README.md` file with all the requested information added:

```markdown
# EC2 Manager Script

The EC2 Manager Script is a dynamic tool for managing AWS EC2 instances using the AWS CLI. The script allows you to:

- **Create EC2 instances** with a custom configuration.
- **SSH into EC2 instances** without the need to manually look up the public IP.
- **Terminate EC2 instances** and cleanly remove associated resources.

This script is written in Bash and interacts with AWS services to automate EC2 instance lifecycle management, making it a convenient tool for managing EC2 instances in various environments.

## Features

- **Create EC2 Instances**: Launch a new EC2 instance with the specified configuration.
- **SSH into EC2 Instances**: SSH into an existing EC2 instance using the private key.
- **Terminate EC2 Instances**: Cleanly terminate an EC2 instance and delete any associated resources.
- **Configuration**: Easy configuration of AWS region, AMI, key pairs, and security groups.

## Prerequisites

Before using this script, ensure the following are set up:

### 1. AWS CLI

Install and configure AWS CLI with your AWS credentials. To configure AWS CLI, run:

```bash
aws configure
```

You will be prompted to enter your AWS Access Key ID, Secret Access Key, default region, and output format. Ensure you have the required IAM permissions for interacting with EC2 instances (see Permissions section below).

### 2. Private Key File (.pem)

You need the private key file that corresponds to the EC2 key pair used for SSH access. This key is required to SSH into the EC2 instance.

### 3. Security Group

The EC2 instance should be associated with a Security Group that allows SSH access (on port 22).

### 4. IAM Permissions

Ensure that your AWS user has the following IAM permissions:

- `ec2:RunInstances`
- `ec2:DescribeInstances`
- `ec2:TerminateInstances`
- `ec2:DescribeSecurityGroups`

## Setup

### 1. Clone the Repository

Clone the repository to your local machine:

```bash
git clone https://github.com/Sudoharry/Shell-Scripting-Labs/tree/main/AWS-Manager.git
cd ec2-manager
```

### 2. Edit the Script Configuration

Open the `ec2_manager.sh` script and configure the following variables:

#### AWS Region
Set the AWS region where the EC2 instance will be created (e.g., `us-east-1`).

```bash
REGION="your-region"  # Example: us-east-1
```

#### AMI ID
Specify the Amazon Machine Image (AMI) ID to use when launching the EC2 instance. You can find the AMI ID in the AWS Console.

```bash
AMI_ID="ami-12345678"  # Replace with your desired AMI ID
```

#### Key Pair Name
Set the key pair name for SSH access to the instance. The private key corresponding to this key pair should be available.

```bash
KEY_NAME="your-key-name"  # Replace with your key pair name
```

#### Private Key Path
Provide the path to your private key file (`.pem`), which will be used for SSH access.

```bash
KEY_PATH="path-to-your-private-key.pem"  # Replace with your key file path
```

#### Security Group ID
Set the Security Group ID that allows SSH access (port 22). If you don't have one, you can create a new Security Group in AWS.

```bash
SECURITY_GROUP="your-security-group-id"  # Replace with your security group ID
```

### 3. Set Permissions for Key File

The private key file must have the correct permissions to ensure secure access. Run the following command to set the permissions:

```bash
chmod 400 path-to-your-private-key.pem
```

## Usage

### 1. Make the Script Executable

After configuring the script, make it executable:

```bash
chmod +x ec2_manager.sh
```

### 2. Run the Script

To run the script, use the following command:

```bash
./ec2_manager.sh
```

The script will present a menu with the following options:

1. **Create a new EC2 instance**.
2. **SSH into an existing EC2 instance**.
3. **Terminate an existing EC2 instance**.

### 3. Create a New EC2 Instance

If you choose **option 1**, the script will:

- Launch a new EC2 instance with the specified configuration.
- Output the instance ID and public IP of the newly created EC2 instance.
- Save the instance details in a file (`instance_details.txt`) for future use.

### 4. SSH into an EC2 Instance

If you choose **option 2**, the script will:

- Read the instance details from the `instance_details.txt` file (instance ID, public IP).
- SSH into the EC2 instance using the private key.

### 5. Terminate an EC2 Instance

If you choose **option 3**, the script will:

- Terminate the EC2 instance specified in the `instance_details.txt` file.
- Clean up the instance details after termination.

## Example Workflow

1. **Set Permissions for Key File**:

```bash
chmod 400 /path/to/your-key.pem
```

2. **Run the Script**:

```bash
./ec2_manager.sh
```

3. **Select an Option** from the menu:

   - **Option 1**: Create a new EC2 instance.
   - **Option 2**: SSH into the EC2 instance.
   - **Option 3**: Terminate the EC2 instance.

4. Follow the on-screen prompts for each action.

## Notes

- Ensure that the AWS CLI is configured with valid AWS credentials.
- The script assumes that SSH access is allowed on port 22 in the instance's Security Group.
- The following usernames are commonly used for SSH:
  - **Amazon Linux** or **Amazon Linux 2**: `ec2-user`
  - **Ubuntu**: `ubuntu`
  - For other AMIs, the username may vary. You may need to check the documentation for the specific AMI you're using.
- You will need to manually configure or change the private key file permissions using `chmod 400`.


## Troubleshooting

If you encounter any issues with SSH access, make sure that:

- The EC2 instance is running and the Security Group allows inbound traffic on port 22.
- You are using the correct private key and username.
- The instance is not in a "stopped" or "terminated" state.

If the instance fails to create or terminate, check the AWS Console for additional logs or error messages.

## Contributing

Feel free to fork this repository, make improvements, and submit pull requests. If you find any bugs or have suggestions for new features, please open an issue.

---
*Developed with care by [ Harendra Barot] (https://github.com/Sudoharry)*
```

This version includes all the details you requested, such as the AWS CLI configuration, the private key setup, IAM permissions, repository setup, usage instructions, and troubleshooting tips. It should now be a complete guide for setting up and using the EC2 Manager script.
