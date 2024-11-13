#!/bin/bash
#
## Script: server-stats.sh
## Author: Harendra Barot | 13-11-2024 
## Purpose: Analyze and report basic server performance stats.
#
## Function to display CPU usage
    cpu_usage() {
    echo "CPU Usage:"
    mpstat | awk '/all/ {printf "  Total CPU Usage: %.2f%%\n", 100 - $12}'
    }

    # Function to display memory usage
    memory_usage() {
     echo "Memory Usage:"
    free -m | awk 'NR==2{printf "  Used: %sMB  Free: %sMB  (%.2f%%)\n", $3, $4, $3*100/($3+$4)}'
     }

    # Function to display disk usage
      disk_usage() {
        echo "Disk Usage:"
      df -h --total | awk '/total/ {printf "  Used: %s  Free: %s  (%s)\n", $3, $4, $5}'
      }

    # Function to display top 5 processes by CPU usage
       top_cpu_processes() {
        echo "Top 5 Processes by CPU Usage:"
       ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6
      }

     # Function to display top 5 processes by memory usage
        top_memory_processes() {
           echo "Top 5 Processes by Memory Usage:"
        ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 6
       }

     # Stretch goals: OS version, uptime, load average, logged-in users, failed login attempts
        additional_stats() {
           echo "Additional Stats:"
           echo "  OS Version: $(lsb_release -d | cut -f2-)"
           echo "  Uptime: $(uptime -p)"
           echo "  Load Average: $(uptime | awk -F'load average:' '{print $2}')"
           echo "  Logged-in Users: $(who | wc -l)"
           echo "  Failed Login Attempts: $(grep 'Failed password' /var/log/auth.log | wc -l)"
        }

      # Main function to call all others
         main() {
          echo "Server Performance Stats"
          echo "========================="
        cpu_usage
        memory_usage
        disk_usage
         echo
        top_cpu_processes
         echo
        top_memory_processes
         echo
        additional_stats
 	}

       main

