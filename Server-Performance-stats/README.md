server-stats.sh - Server Performance Analyzer
---
Author: Harendra Barot
---
**Project page URL:** 
This project is available at:
- https://roadmap.sh/projects/server-stats
---
Overview
server-stats.sh is a shell script designed to analyze basic server performance statistics. It provides detailed insights into system resource usage, top processes, and additional system information to help with debugging and performance monitoring.
---
Features
---
**1. CPU Usage**
- Displays the total CPU usage percentage.

**2. Memory Usage**
- Reports used and free memory, along with percentages.

**3. Disk Usage**- Shows used and free disk space, including percentages.

**4. Top Processes**

   **Lists the top 5 processes by:**
   
-  CPU usage.
  -  Memory usage.
  -  
**5. Additional Stats (Stretch Goals)**
- OS version.
- Uptime.
- Load average.
- Number of logged-in users.
- Failed login attempts.

**Usage**
**Prerequisites**
- A Linux environment with the following utilities installed:
   - mpstat (from sysstat package).
   - awk.
   - ps.
   - df.
  - lsb_release (optional for OS version).
    
**Running the Script**
 1) Clone or download the script.
 2) Make the script executable:
    Command :**chmod 700 server-stats.sh**
 3) Execute the script:
    Command :**./server-stats.sh**
    
    **Script:**
    ![Script-inout](https://github.com/user-attachments/assets/0e4b9c63-d827-445e-abd0-0047c493259b)
    **Output:**
   ![Output carbon](https://github.com/user-attachments/assets/50f98db3-9163-4477-b5c1-cea7813c33a3)

