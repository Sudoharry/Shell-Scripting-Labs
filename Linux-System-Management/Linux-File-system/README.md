# Linux Basics for DevOps Engineers

This guide provides an overview of essential Linux concepts and commands to help you get started with understanding and using the Linux operating system effectively. 

---

## **1. File System Hierarchy**

Understanding the structure of the Linux file system is crucial for navigating and managing files. Below are key directories and their purposes:

- `/` (**root**): The top-level directory in the Linux file system.
- `/home`: Contains user-specific data and files.
- `/etc`: Stores system configuration files.
- `/var`: Holds variable data like logs, spool files, and databases.
- `/bin` and `/usr/bin`: Contain essential binaries (system commands and utilities).
- `/tmp`: Stores temporary files, typically cleared on reboot.

---

## **2. Navigation Commands**

Master basic commands to navigate through the Linux file system:

```bash
pwd       # Print the current working directory
ls        # List files and directories
cd /path  # Change directory
```

---

## **3. Working with Files**

Learn the following commands to create, view, and edit files:

### **Create Files**
```bash
touch filename     # Create a new empty file
```

### **View File Content**
```bash
cat filename       # Display the content of a file
```

### **Edit Files**
```bash
nano filename      # Edit a file using the nano editor
vim filename       # Edit a file using the vim editor (if you are comfortable)
```

### **Copy, Move, and Delete Files**
```bash
cp source dest     # Copy files from source to destination
mv source dest     # Move or rename files
rm filename        # Delete a file
```

---

## **4. File Permissions**

Linux permissions control access to files and directories. Permissions are categorized into:
- **Owner**: The user who owns the file.
- **Group**: A group of users with shared access.
- **Others**: All other users.

### **Permission Levels**
- **Read** (r)
- **Write** (w)
- **Execute** (x)

### **Change Permissions**
```bash
chmod 755 filename  # Set permissions (owner: read, write, execute; others: read and execute)
```

### **Change Ownership**
```bash
chown user:group filename  # Change ownership of a file
```

---

## **Next Steps**
- Understand the structure and purpose of directories.
- Experiment with file and directory operations.
- Learn the basics of file permissions and ownership.

### Additional Resources
- [Linux Command Line Basics](https://linuxcommand.org/)
- [GNU Bash Reference Manual](https://www.gnu.org/software/bash/manual/)

---

