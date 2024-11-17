# Simple Monitoring with Netdata

This project will guide you through setting up a basic monitoring dashboard using **Netdata**, a real-time performance and health monitoring tool for systems and applications. The goal is to help you understand how to monitor the health of a system and how to set up a simple monitoring dashboard to track system metrics like CPU, memory, and disk I/O.

## Table of Contents
- [Project Overview](#project-overview)
- [Prerequisites](#prerequisites)
- [Step 1: Install Netdata](#step-1-install-netdata)
- [Step 2: Configure Netdata to Monitor Basic System Metrics](#step-2-configure-netdata-to-monitor-basic-system-metrics)
- [Step 3: Access the Netdata Dashboard](#step-3-access-the-netdata-dashboard)
- [Step 4: Customize the Netdata Dashboard](#step-4-customize-the-netdata-dashboard)
- [Step 5: Set Up Alerts for Specific Metrics](#step-5-set-up-alerts-for-specific-metrics)
- [Step 6: Automate the Setup and Testing with Shell Scripts](#step-6-automate-the-setup-and-testing-with-shell-scripts)
- [Step 7: Test the Monitoring Setup](#step-7-test-the-monitoring-setup)
- [Conclusion](#conclusion)

## Project Overview

The goal of this project is to help you learn the basics of monitoring by setting up a basic monitoring dashboard using **Netdata**. Netdata will monitor system metrics such as:
- CPU usage
- Memory usage
- Disk I/O

Additionally, you'll learn how to set up alerts and automate the setup and testing process with shell scripts.

## Prerequisites

To get started with this project, you need:
- A **Linux** machine (Ubuntu, CentOS, etc.)
- A basic understanding of how to use the terminal
- **Root or sudo** privileges on the machine
- **curl** and **bash** installed on your system

## Step 1: Install Netdata

1. **Install dependencies** (if not already installed):
   ```bash
   sudo apt update
   sudo apt install -y curl

### 1.2 Install Netdata:
Run the following command to install Netdata on your system:

bash <(curl -Ss https://my-netdata.io/kickstart.sh)
### 1.3 Start and enable Netdata:
After the installation completes, start and enable the Netdata service:

sudo systemctl start netdata
sudo systemctl enable netdata
### 1.4 Verify Installation:
Visit http://<your-server-ip>:19999 in your web browser. You should see the Netdata dashboard displaying system metrics.

## Step 2: Configure Netdata to Monitor Basic System Metrics
Netdata comes pre-configured to monitor basic system metrics like:

- CPU usage
- Memory usage
- Disk I/O
- Network activity
You can customize these configurations by editing the Netdata configuration files. For example, to change the port Netdata listens on, edit the netdata.conf file:
sudo nano /etc/netdata/netdata.conf

## Step 3: Access the Netdata Dashboard
Once the Netdata service is running, access the dashboard in a web browser:

arduino 
http://<your-server-ip>:19999
![system-from-ip-19999](https://github.com/user-attachments/assets/0aa9878e-3691-4632-9551-200b63364139)
![Data-base-from-ip-19999](https://github.com/user-attachments/assets/4a825be6-4aae-45fe-8252-4f595613f8a2)

The dashboard will show real-time data on various system metrics like CPU, memory, disk I/O, and more.

## Step 4: Customize the Netdata Dashboard
You can customize the Netdata dashboard by:

- Adding new charts
- Modifying existing ones
- Adjusting how the data is collected
- To add or modify a chart, edit the appropriate plugin configurations under /etc/netdata.

## Step 5: Set Up Alerts for Specific Metrics
Netdata allows you to set up alerts to notify you when a metric exceeds a certain threshold. For example, you can create an alert to notify you if CPU usage exceeds 80%.

**Example:** Set up CPU usage alert
Create a new alert configuration file:

sudo nano /etc/netdata/health.d/cpu_usage.conf
Add the following configuration:
check system.cpu
  on: system.cpu
  warn: $this > 80
  crit: $this > 90
  info: CPU usage over 80% is warning, over 90% is critical

Restart Netdata to apply the changes:

sudo systemctl restart netdata
Now, Netdata will send an alert when the CPU usage exceeds the specified thresholds.

## Step 6: Automate the Setup and Testing with Shell Scripts
You can automate the installation, testing, and cleanup processes using shell scripts. Below are the scripts provided in this project:

setup.sh - Install Netdata
This script installs Netdata on a fresh system.


#!/bin/bash

# Install dependencies
sudo apt update
sudo apt install -y curl

# Install Netdata
bash <(curl -Ss https://my-netdata.io/kickstart.sh)

# Start and enable Netdata service
sudo systemctl start netdata
sudo systemctl enable netdata

echo "Netdata installed and running. Access the dashboard at http://<your-server-ip>:19999"
test_dashboard.sh - Put Load on the System
This script will use the stress tool to simulate CPU and memory load, which will allow you to see how Netdata tracks system resources.


#!/bin/bash

# Install stress tool
sudo apt install -y stress

# Put load on CPU and memory
stress --cpu 4 --vm 2 --vm-bytes 256M --timeout 60s

echo "Stress test completed. Check Netdata dashboard for updated metrics."
cleanup.sh - Remove Netdata
This script removes Netdata and cleans up your system.


#!/bin/bash

# Stop and disable Netdata service
sudo systemctl stop netdata
sudo systemctl disable netdata

# Remove Netdata
sudo apt remove --purge -y netdata
sudo rm -rf /etc/netdata

echo "Netdata has been removed from the system."
Step 7: Test the Monitoring Setup
Run the setup.sh script:


bash setup.sh
Access the Netdata dashboard: Go to http://<your-server-ip>:19999 to check that everything is working.

Run the test_dashboard.sh script:



bash test_dashboard.sh
Check the dashboard again to see the increased load.

Clean up: Run the cleanup.sh script to remove Netdata:

bash cleanup.sh
