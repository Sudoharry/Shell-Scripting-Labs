# Disk Space Monitoring and Cleanup Script

## Overview
This shell script monitors disk usage and ensures your system has adequate free space by cleaning up temporary or unnecessary files. It helps avoid server outages caused by full disks by automating the identification and removal of old or large files.

### Features:
- Monitors disk usage and checks against a configurable threshold.
- Automatically deletes files older than a specified number of days.
- Logs all actions performed during monitoring and cleanup.
- Optionally sends alerts via email when disk usage exceeds the threshold.

---

## Setup Instructions

### Prerequisites
- A Unix-like operating system (Linux/macOS).
- Bash shell.
- Tools required: `df`, `find`, `rm`, and optionally `mail` for notifications.

### Installation
1. Clone this repository:
   ```bash
   git clone https://github.com/Sudoharry/Shell-scripting-realtime-projects/disk-space-monitor.git
   cd disk-space-monitor
