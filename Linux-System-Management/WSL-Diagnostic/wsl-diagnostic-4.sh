#!/bin/bash

# WSL Performance Diagnostic Script with Enhanced Features
# Author: Harendra Barot
# Version: 4.0
# Date: $(date +"%Y-%m-%d")

# Color Definitions
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Thresholds
CPU_THRESHOLD=80
MEMORY_THRESHOLD=90
LOG_FILE="wsl_diagnostics_$(date +%Y%m%d_%H%M%S).log"

# Function to display system uptime
check_uptime() {
  echo -e "${CYAN}System Uptime:${NC}" | tee -a $LOG_FILE
  uptime | tee -a $LOG_FILE
  echo -e "${BLUE}--------------------${NC}" | tee -a $LOG_FILE
}

# Function to check CPU usage
check_cpu_usage() {
  echo -e "${CYAN}Top 5 CPU-Consuming Processes:${NC}" | tee -a $LOG_FILE
  ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -n 6 | tee -a $LOG_FILE

  HIGH_CPU_PROCESSES=$(ps -eo pid,comm,%cpu --sort=-%cpu | awk -v threshold=$CPU_THRESHOLD '$3 > threshold')
  if [[ ! -z "$HIGH_CPU_PROCESSES" ]]; then
    echo -e "${RED}Processes exceeding ${CPU_THRESHOLD}% CPU usage:${NC}" | tee -a $LOG_FILE
    echo "$HIGH_CPU_PROCESSES" | tee -a $LOG_FILE
  fi
  echo -e "${BLUE}--------------------${NC}" | tee -a $LOG_FILE
}

# Function to check memory usage
check_memory_usage() {
  echo -e "${CYAN}Top 5 Memory-Consuming Processes:${NC}" | tee -a $LOG_FILE
  ps -eo pid,comm,%cpu,%mem --sort=-%mem | head -n 6 | tee -a $LOG_FILE

  HIGH_MEM_PROCESSES=$(ps -eo pid,comm,%mem --sort=-%mem | awk -v threshold=$MEMORY_THRESHOLD '$3 > threshold')
  if [[ ! -z "$HIGH_MEM_PROCESSES" ]]; then
    echo -e "${RED}Processes exceeding ${MEMORY_THRESHOLD}% memory usage:${NC}" | tee -a $LOG_FILE
    echo "$HIGH_MEM_PROCESSES" | tee -a $LOG_FILE
  fi
  echo -e "${BLUE}--------------------${NC}" | tee -a $LOG_FILE
}

# Function to check overall resource usage
check_overall_usage() {
  echo -e "${CYAN}Overall Resource Usage:${NC}" | tee -a $LOG_FILE
  echo -e "${YELLOW}CPU Usage:${NC}" | tee -a $LOG_FILE
  top -bn1 | grep "Cpu(s)" | tee -a $LOG_FILE
  echo -e "${YELLOW}Memory Usage:${NC}" | tee -a $LOG_FILE
  free -h | tee -a $LOG_FILE
  echo -e "${BLUE}--------------------${NC}" | tee -a $LOG_FILE
}

# Function to analyze disk usage
check_disk_usage() {
  echo -e "${CYAN}Disk Usage Analysis:${NC}" | tee -a $LOG_FILE
  df -h | grep -E '^/mnt|^Filesystem' | tee -a $LOG_FILE
  echo -e "${CYAN}Inode Usage:${NC}" | tee -a $LOG_FILE
  df -ih | grep -E '^/mnt|^Filesystem' | tee -a $LOG_FILE
  echo -e "${BLUE}--------------------${NC}" | tee -a $LOG_FILE
}

# Function to check zombie processes
check_zombie_processes() {
  echo -e "${CYAN}Zombie Processes (if any):${NC}" | tee -a $LOG_FILE
  ZOMBIES=$(ps aux | awk '{if ($8=="Z") print $0}')
  if [[ -z "$ZOMBIES" ]]; then
    echo -e "${GREEN}No zombie processes found.${NC}" | tee -a $LOG_FILE
  else
    echo -e "${RED}Zombie Processes:${NC}" | tee -a $LOG_FILE
    echo "$ZOMBIES" | tee -a $LOG_FILE
  fi
  echo -e "${BLUE}--------------------${NC}" | tee -a $LOG_FILE
}

# Function to check network latency
check_network_latency() {
  echo -e "${CYAN}Network Latency Check:${NC}" | tee -a $LOG_FILE
  ping -c 4 google.com | tee -a $LOG_FILE
  echo -e "${BLUE}--------------------${NC}" | tee -a $LOG_FILE
}

# Function to check active network connections
check_network_connections() {
  echo -e "${CYAN}Active Network Connections:${NC}" | tee -a $LOG_FILE
  CONNECTIONS=$(netstat -an | grep ESTABLISHED | wc -l)
  echo -e "${YELLOW}Established Connections:${NC} $CONNECTIONS" | tee -a $LOG_FILE
  echo -e "${BLUE}--------------------${NC}" | tee -a $LOG_FILE
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
  check_network_latency
  check_network_connections
  
  echo -e "${GREEN}Diagnostics Complete. Results saved to $LOG_FILE.${NC}"
}

# Execute the main function
run_diagnostics
