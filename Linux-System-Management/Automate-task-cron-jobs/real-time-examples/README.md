
# Slack-Integrated Git Auto-Pull Script
![image](https://github.com/user-attachments/assets/5b8f4ad5-e581-4be0-813c-702185f17591)

---
This project provides a Bash script to automate Git repository updates while integrating Slack notifications. The script checks for changes in a Git repository, pulls the latest updates, and sends notifications to a designated Slack channel using a webhook.

---

## Features

- **Git Automation**: Automatically fetches and pulls changes from the Git repository.
- **Slack Notifications**: Sends real-time notifications to Slack channels for important updates or errors.
- **Logging**: Creates logs for debugging and tracking script operations.

---

## Prerequisites

1. **Git** installed on your system.
   ```bash
   sudo apt update && sudo apt install git -y
   ```

2. **Curl** installed for sending Slack notifications.
   ```bash
   sudo apt install curl -y
   ```

3. **Slack Incoming Webhook**:
   - Set up an incoming webhook in your Slack workspace.
   - Copy the webhook URL (e.g., `https://hooks.slack.com/services/...`).

4. A valid Git repository.

---

## Setup and Configuration

### 1. Clone or Download the Repository
Place the script in your desired location or clone a repository where this script will operate.

### 2. Modify the Script

- Open the script file and update the following variables:
  ```bash
  PROJECT_DIR="/path/to/your/project"
  SLACK_WEBHOOK_URL="https://hooks.slack.com/services/your/webhook/url"
  LOG_FILE="/tmp/cron_slack_debug.log"
  ```
- Replace `/path/to/your/project` with the actual path to your Git project directory.
- Replace the Slack webhook URL with your actual Slack Incoming Webhook URL.

### 3. Make the Script Executable

Change the script permissions to make it executable:
```bash
chmod +x auto-pull.sh
```

### 4. Test the Script
Run the script manually to ensure it works as expected:
```bash
./auto-pull.sh
```

---

## Automate with Cron Jobs

To run the script periodically, add a cron job:

1. Open the crontab editor:
   ```bash
   crontab -e
   ```

2. Add the following entry to run the script every 5 minutes:
   ```bash
   */5 * * * * /path/to/auto-pull.sh
   ```
   Replace `/path/to/auto-pull.sh` with the full path to your script.

3. Save and exit.

Verify the cron job logs to ensure it executes:
```bash
grep CRON /var/log/syslog
```

---

## Script Breakdown

1. **Directory Verification**:
   Ensures the specified project directory exists. If not, logs an error and sends a Slack notification.

2. **Git Operations**:
   - Checks if the local branch is up-to-date.
   - Fetches and pulls changes from the origin branch.

3. **Slack Notifications**:
   - Sends updates to Slack on success, errors, or no changes.

4. **Logging**:
   All operations are logged to a file (`/tmp/cron_slack_debug.log`) for debugging.

---

## Example Log File Output
```
[2024-12-30 12:00:01] Starting script...
[2024-12-30 12:00:01] Repository is up-to-date.
[2024-12-30 12:00:01] Slack notification sent: Repository is already up-to-date.
[2024-12-30 12:00:01] Script completed.
```
---
![image](https://github.com/user-attachments/assets/fbb4263b-df92-4104-ba22-1f7494a97a2e)

---
## Slack Notifications
---
![image](https://github.com/user-attachments/assets/7c39d923-ddee-4a1c-b400-9ee61a780a22)

---

## Troubleshooting

### Issue: "No Slack Notification Received"
- Verify the Slack webhook URL is correct and active.
- Test the webhook manually:
  ```bash
  curl -X POST -H 'Content-type: application/json' --data '{"text":"Test message"}' https://hooks.slack.com/services/your/webhook/url
  ```

### Issue: "Script Not Executing via Cron"
- Ensure the script has execute permissions.
- Check the cron job logs for errors:
  ```bash
  grep CRON /var/log/syslog
  ```

### Debugging
- Review the log file for errors: `/tmp/cron_slack_debug.log`

---

## Contributions
Feel free to fork this repository and submit pull requests for improvements or additional features.

---

