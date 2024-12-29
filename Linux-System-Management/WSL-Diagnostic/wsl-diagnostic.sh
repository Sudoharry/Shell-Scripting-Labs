#!/bin/bash

# WSL Performance Diagnostic Script
# Author: Harendra Barot
# Version: 2.0
# Date: $(date +"%Y-%m-%d")

# Function to display system uptime
check_uptime() {
  echo "System Uptime:"
  uptime
  echo "--------------------"
}

# Function to check CPU usage
check_cpu_usage() {
  echo "Top 5 CPU-Consuming Processes:"
  ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -n 6
  echo "--------------------"
}

# Function to check memory usage
check_memory_usage() {
  echo "Top 5 Memory-Consuming Processes:"
  ps -eo pid,comm,%cpu,%mem --sort=-%mem | head -n 6
  echo "--------------------"
}

# Function to display overall resource usage
check_overall_usage() {
  echo "Overall Resource Usage:"
  top -bn1 | grep "Cpu(s)"
  free -h
  echo "--------------------"
}

# Function to analyze disk usage
check_disk_usage() {
  echo "Disk Usage Analysis:"
  df -h | grep -E '^/mnt|^Filesystem'
  echo "--------------------"
}

# Function to check for zombie processes
check_zombie_processes() {
  echo "Zombie Processes (if any):"
  ps aux | awk '{if ($8=="Z") print $0}'
  echo "--------------------"
}

# Function to check network issues
check_network_connections() {
  echo "Active Network Connections:"
  netstat -an | grep ESTABLISHED | wc -l
  echo "--------------------"
}

# Main function to run all diagnostics
run_diagnostics() {
  echo "===================="
  echo "WSL Performance Diagnostic Script"
  echo "===================="
  
  check_uptime
  check_cpu_usage
  check_memory_usage
  check_overall_usage
  check_disk_usage
  check_zombie_processes
  check_network_connections
  
  echo "Diagnostics Complete. Review the above details to identify resource bottlenecks."
}

# Execute the main function
run_diagnostics
