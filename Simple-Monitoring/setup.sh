#!/bin/bash
#
## This script should automate the installation of Netdata on a fresh Linux system. Here's an example of how you coulde write it
#
# Update package lists
sudo apt update -y

# Install dependencies
sudo apt install -y curl

# Install Netdata
bash <(curl -Ss https://my-netdata.io/kickstart.sh)

# Start Netdata service
sudo systemctl start netdata

# Enable Netdata to start on boot
sudo systemctl enable netdata

echo "Netdata installation completed."

