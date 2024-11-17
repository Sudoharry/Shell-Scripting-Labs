#!/bin/bash
#
## This script will put some load on the system to see if the dashboard picks up the performance metrics.
# Install stress tool (if not installed)
sudo apt install -y stress

# CPU load test (using 4 cores for 60 seconds)
stress --cpu 4 --timeout 60 &

# Memory load test (1GB for 60 seconds)
stress --vm 2 --vm-bytes 512M --timeout 60 &

# Disk load test (using 1GB for 60 seconds)
dd if=/dev/zero of=/tmp/testfile bs=1M count=1024 oflag=dsync &

echo "Stress tests running. Check the Netdata dashboard to monitor the load."

