# Project URL:  https://roadmap.sh/projects/log-archive-tool

## Log Archive Tool - Automated Log Archiving Script

### **Author:** Harendra Barot  

## Overview

The **Log Archive Tool** is a shell script designed to automate the process of archiving server logs. It helps to reduce disk space usage by compressing log files into `.tar.gz` archives, making it easier to manage large log directories. The script records the timestamp of each archive operation, ensuring logs are safely stored and available for future troubleshooting, auditing, or security purposes.

## Features

**1. Archive Logs**
- Compresses the log files from a specified directory into a `.tar.gz` archive.

**2. Timestamped Archives**
- Automatically generates archive filenames with the current date and time, ensuring uniqueness.

**3. Log Tracking**
- Logs every archiving operation with a timestamp in an archive log file, making it easy to track when each archive was created.

**4. Customizable Log Directory**
- The script allows you to specify any log directory (e.g., `/var/log`) to archive.

**5. Flexible Output Location**
- Archives are saved to a user-specified directory (default is `log_archives` in the user's home directory).

---

## Usage

### Prerequisites

- A Linux environment with the following utilities installed:
   - `tar` (for creating compressed archives).
   - `date` (for generating timestamps).
   - `mkdir` (for creating directories).
   - `echo` (for logging the archive activity).

### Running the Script

1. Clone or download the script.
2. Make the script executable:
    ```bash
    chmod 700 log-archive.sh
    ```

3. Execute the script:
    ```bash
    ./log-archive.sh /path/to/log-directory
    ```

   - Replace `/path/to/log-directory` with the actual path to your log directory (e.g., `/var/log`).

   - The script will create an archive in the default location (`~/log_archives`), or you can modify the script to change this location.

---

## Step-by-Step Guide to the Solution

### Step 1: Create the Log Archive Tool Script

Here is the core of the script used to archive your log files:
![log-archieve](https://github.com/user-attachments/assets/40ab3a81-94e7-4af3-a0e0-e7fa22a62c51)
### Run the script:
![run the script](https://github.com/user-attachments/assets/76fbe496-dabb-4a81-8959-fcb44d0ce33f)
### Crontab:
![cron-tab-editor](https://github.com/user-attachments/assets/8f0fee37-91be-4e55-a728-bca2b1867a83)
### Output:
![Log-archive-output](https://github.com/user-attachments/assets/ef7b2891-4a41-4d46-98b0-697114cefe62)




