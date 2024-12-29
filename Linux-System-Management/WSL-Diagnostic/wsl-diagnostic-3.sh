#!/bin/bash

# WSL Performance Diagnostic Script
# Author: Harendra Barot
# Date: $(date +"%Y-%m-%d")

# Color Definitions
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Function to display system uptime
check_uptime() {
  echo -e "${CYAN}System Uptime:${NC}"
  uptime
  echo -e "${BLUE}--------------------${NC}"
}

# Function to check CPU usage
check_cpu_usage() {
  echo -e "${CYAN}Top 5 CPU-Consuming Processes:${NC}"
  ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -n 6
  echo -e "${BLUE}--------------------${NC}"
}

# Function to check memory usage
check_memory_usage() {
  echo -e "${CYAN}Top 5 Memory-Consuming Processes:${NC}"
  ps -eo pid,comm,%cpu,%mem --sort=-%mem | head -n 6
  echo -e "${BLUE}--------------------${NC}"
}

# Function to display overall resource usage
check_overall_usage() {
  echo -e "${CYAN}Overall Resource Usage:${NC}"
  echo -e "${YELLOW}CPU Usage:${NC}"
  top -bn1 | grep "Cpu(s)"
  echo -e "${YELLOW}Memory Usage:${NC}"
  free -h
  echo -e "${BLUE}--------------------${NC}"
}

# Function to analyze disk usage
check_disk_usage() {
  echo -e "${CYAN}Disk Usage Analysis:${NC}"
  df -h | grep -E '^/mnt|^Filesystem'
  echo -e "${BLUE}--------------------${NC}"
}

# Function to check for zombie processes
check_zombie_processes() {
  echo -e "${CYAN}Zombie Processes (if any):${NC}"
  ZOMBIES=$(ps aux | awk '{if ($8=="Z") print $0}')
  if [[ -z "$ZOMBIES" ]]; then
    echo -e "${GREEN}No zombie processes found.${NC}"
  else
    echo -e "${RED}Zombie Processes:${NC}"
    echo "$ZOMBIES"
  fi
  echo -e "${BLUE}--------------------${NC}"
}

# Function to check network issues
check_network_connections() {
  echo -e "${CYAN}Active Network Connections:${NC}"
  CONNECTIONS=$(netstat -an | grep ESTABLISHED | wc -l)
  echo -e "${YELLOW}Established Connections: ${NC}$CONNECTIONS"
  echo -e "${BLUE}--------------------${NC}"
}

# Main function to run all diagnostics
run_diagnostics() {
  echo -e "${GREEN}====================${NC}"
  echo -e "${GREEN}WSL Performance Diagnostic Script${NC}"
  echo -e "${GREEN}====================${NC}"
  
  check_uptime
  check_cpu_usage
  check_memory_usage
  check_overall_usage
  check_disk_usage
  check_zombie_processes
  check_network_connections
  
  echo -e "${GREEN}Diagnostics Complete. Review the above details to identify resource bottlenecks.${NC}"
}

# Execute the main function
run_diagnostics
