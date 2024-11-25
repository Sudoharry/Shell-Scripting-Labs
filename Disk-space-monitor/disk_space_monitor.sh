#!/bin/bash

# Configuration
THRESHOLD=80                     # Disk usage percentage threshold
TEMP_DIR="/tmp"                  # Directory to clean up
RETENTION_DAYS=7                 # Number of days to retain files
LOG_FILE="/var/log/disk_monitor.log"  # Log file location
ALERT_EMAIL="harendrabarot19@gmail.com"  # Email address for notifications (leave empty to disable)

# Create log file directory if it doesn't exist
mkdir -p "$(dirname "$LOG_FILE")"

# Get current disk usage percentage
DISK_USAGE=$(df "$TEMP_DIR" | tail -1 | awk '{print $5}' | sed 's/%//')

# Log disk usage
echo "$(date): Current disk usage: $DISK_USAGE%" >> "$LOG_FILE"

# Check if disk usage exceeds the threshold
if [ "$DISK_USAGE" -ge "$THRESHOLD" ]; then
  echo "$(date): Disk usage critical: $DISK_USAGE%" >> "$LOG_FILE"
  
  # Send alert email if configured
  if [ -n "$ALERT_EMAIL" ]; then
    echo "Disk usage is at $DISK_USAGE% on $(hostname)" | mail -s "Disk Usage Alert" "$ALERT_EMAIL"
    echo "$(date): Email alert sent to $ALERT_EMAIL" >> "$LOG_FILE"
  fi

  # Perform cleanup
  echo "$(date): Performing cleanup in $TEMP_DIR" >> "$LOG_FILE"
  find "$TEMP_DIR" -type f -mtime +"$RETENTION_DAYS" -exec rm -f {} \; -exec echo "Deleted: {}" >> "$LOG_FILE" \;

  # Log cleanup completion
  echo "$(date): Cleanup completed in $TEMP_DIR" >> "$LOG_FILE"

else
  echo "$(date): Disk usage is below threshold. No cleanup performed." >> "$LOG_FILE"
fi

# End script
exit 0

