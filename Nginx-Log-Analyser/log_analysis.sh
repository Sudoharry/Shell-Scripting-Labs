#!/bin/bash
#
## Author: Harendra Barot
## Version: 1.0
## Date: 2024-11-16
## Description: A script to analyze Nginx access logs and provide insights such as top IPs, paths, status codes, and user agents.

LOG_FILE="access.log"

if [ ! -f "$LOG_FILE" ]; then
    echo "Log file '$LOG_FILE' not found!"
        exit 1
        fi

        echo "Choose a method for analysis:"
        echo "1. Use AWK"
        echo "2. Use grep/sed/cut"
        read -p "Enter your choice (1 or 2): " METHOD

        if [[ "$METHOD" != "1" && "$METHOD" != "2" ]]; then
            echo "Invalid choice! Exiting."
                exit 1
                fi

                echo ""

       # Function to analyze top 5 IP addresses
         analyze_ips() {
           echo "Top 5 IP addresses with the most requests:"
         if [ "$METHOD" == "1" ]; then
         awk '{print $1}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -5 | awk '{print $2 " - " $1 " requests"}'
            else
       grep -oE '^[0-9.]+' "$LOG_FILE" | sort | uniq -c | sort -nr | head -5 | awk '{print $2 " - " $1 " requests"}'
         fi
            echo ""
       }
       # Function to analyze top 5 most requested paths
         analyze_paths() {
           echo "Top 5 most requested paths:"
         if [ "$METHOD" == "1" ]; then
          awk '{print $7}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -5 | awk '{print $2 " - " $1 " requests"}'
         else
          grep -oE '"[A-Z]+ ([^ ]+)' "$LOG_FILE" | awk '{print $2}' | sort | uniq -c | sort -nr | head -5 | awk '{print $2 " - " $1 " requests"}'
         fi
           echo ""
        }

      # Function to analyze top 5 response status codes
          analyze_status_codes() {
     	    echo "Top 5 response status codes:"
	    if [ "$METHOD" == "1" ]; then
                                                                                                        awk '{print $9}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -5 | awk '{print $2 " - " $1 " requests"}'
                                                                                                            else
                                                                                                                    awk '{print $9}' "$LOG_FILE" | grep -oE '[0-9]+' | sort | uniq -c | sort -nr | head -5 | awk '{print $2 " - " $1 " requests"}'
                                                                                                                        fi
                                                                                                                            echo ""
                                                                                                                            }

                                                                                                                            # Function to analyze top 5 user agents
                                                                                                                            analyze_user_agents() {
    															    echo "Top 5 user agents:"
                                                                                                                            if [ "$METHOD" == "1" ]; then
                                                                                                                            awk -F'"' '{print $6}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -5 | awk '{print $2 " - " $1 " requests"}'
                                                                                                                             else
                                                                                                                            grep -oE '"[^"]+"$' "$LOG_FILE" | sed 's/^"//' | sort | uniq -c | sort -nr | head -5 | awk '{print $2 " - " $1 " requests"}'
                                                                                                                             fi
                                                                                                                              echo ""
                                                                                                                            }
                                                                                                                            # Run all analyses

     analyze_ips
     analyze_paths
     analyze_status_codes
     analyze_user_agents
