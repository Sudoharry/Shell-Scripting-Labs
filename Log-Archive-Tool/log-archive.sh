#!/bin/bash

# Define the source log directory and destination directory for archives
LOG_DIR=$1
ARCHIVE_DIR="$HOME/log_archives"

# Ensure the archive directory exists
mkdir -p $ARCHIVE_DIR

# Check if the log directory is provided
if [ -z "$LOG_DIR" ]; then
    echo "Please provide the log directory."
    exit 1
fi

# Get the current date and time for the archive name
DATE=$(date "+%Y%m%d_%H%M%S")

# Create a tar.gz archive of the log directory
sudo tar -czf "$ARCHIVE_DIR/logs_archive_$DATE.tar.gz" -C "$LOG_DIR" .

# Log the archiving activity with the timestamp
echo "Archived logs from $LOG_DIR on $DATE" >> "$ARCHIVE_DIR/archive_log.txt"

# Notify the user
echo "Logs from $LOG_DIR have been archived successfully as logs_archive_$DATE.tar.gz"
