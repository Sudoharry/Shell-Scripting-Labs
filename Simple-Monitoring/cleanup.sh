#!/bin/bash
#
## This script will clean up the system by removing the Netdata agent and any associated files.
#
# Stop Netdata service
sudo systemctl stop netdata

# Disable Netdata service
sudo systemctl disable netdata

# Uninstall Netdata
sudo apt remove --purge -y netdata

# Remove Netdata's dependencies
sudo apt autoremove -y

# Clean up files
sudo rm -rf /etc/netdata /var/lib/netdata /var/log/netdata

echo "Netdata removed and system cleaned up."

