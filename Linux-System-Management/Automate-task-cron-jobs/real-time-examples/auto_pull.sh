#!/bin/bash

# Define the directory of the project
PROJECT_DIR="/home/harry_barot19/Shell-scripting-realtime-projects/Linux-System-Management/Automate-task-cron-jobs/real-time-examples"

# Slack Webhook URL for sending notifications
  # Pull the latest changes from the repository
SLACK_WEBHOOK_URL="https://hooks.slack.com/services/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"

# Send Slack notification function
send_slack_notification() {
  local message=$1
  curl -X POST -H 'Content-type: application/json' --data "{\"text\":\"$message\"}" $SLACK_WEBHOOK_URL
}

# Navigate to the project directory
if [ -d "$PROJECT_DIR" ]; then
  cd "$PROJECT_DIR" || { 
    echo "Failed to change directory to $PROJECT_DIR"; 
    send_slack_notification "Error: Failed to change directory to $PROJECT_DIR"; 
    exit 1; 
  }
else
  echo "Project directory does not exist: $PROJECT_DIR"
  send_slack_notification "Error: Project directory does not exist: $PROJECT_DIR"
  exit 1
fi

# Check for any changes in the local repository
if git status | grep -q "Your branch is up to date"; then
  echo "The repository is already up-to-date."
  send_slack_notification "The repository is already up-to-date."
else
  echo "Fetching the latest changes..."
  git fetch

  # Pull the latest changes from the repository
  git pull origin $(git branch --show-current)
  
  if [ $? -eq 0 ]; then
    echo "Successfully pulled the latest changes."
    send_slack_notification "Successfully pulled the latest changes from the repository."
  else
    echo "Failed to pull the changes. Check for conflicts or network issues."
    send_slack_notification "Error: Failed to pull the changes. Check for conflicts or network issues."
    exit 1
  fi
fi
