#!/bin/bash

# WSL Performance Diagnostic Script
# Author: Harendra Barot
#Version: 1.0
# Date: $(date +"%Y-%m-%d")

echo "===================="
echo "WSL Performance Diagnostic Script"
echo "===================="

# Display system uptime
echo "System Uptime:"
uptime
echo "--------------------"

# Check CPU and Memory Usage
echo "Top 5 CPU-Consuming Processes:"
ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -n 6
echo "--------------------"

echo "Top 5 Memory-Consuming Processes:"
ps -eo pid,comm,%cpu,%mem --sort=-%mem | head -n 6
echo "--------------------"

# Check overall CPU and Memory usage
echo "Overall Resource Usage:"
top -bn1 | grep "Cpu(s)"
free -h
echo "--------------------"

# Disk Usage Analysis
echo "Disk Usage Analysis:"
df -h | grep -E '^/mnt|^Filesystem'
echo "--------------------"

# Check for Zombie Processes
echo "Zombie Processes (if any):"
ps aux | awk '{if ($8=="Z") print $0}'
echo "--------------------"

# Check for Network Issues
echo "Active Network Connections:"
netstat -an | grep ESTABLISHED | wc -l
echo "--------------------"

echo "Diagnostics Complete. Review the above details to identify resource bottlenecks."
