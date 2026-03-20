# Testing Linux and Server Administration

A collection of practical Linux server administration tasks covering **system monitoring**, **user management and access control**, and **web server backup configuration**. Each task includes automation scripts and detailed documentation.

---

## Table of Contents

- [Overview](#overview)
- [Repository Structure](#repository-structure)
- [Task 1: System Monitoring Setup](#task-1-system-monitoring-setup)
- [Task 2: User Management and Access Control](#task-2-user-management-and-access-control)
- [Task 3: Backup Configuration for Web Servers](#task-3-backup-configuration-for-web-servers)
- [Prerequisites](#prerequisites)
- [Usage](#usage)
- [Automating with Cron](#automating-with-cron)
- [Technologies Used](#technologies-used)

---

## Overview

This repository demonstrates core Linux server administration skills through three hands-on tasks:

| Task | Topic | Deliverables |
|------|-------|--------------|
| Task 1 | System Monitoring Setup | `monitoring.sh`, documentation |
| Task 2 | User Management & Access Control | Documentation |
| Task 3 | Backup Configuration for Web Servers | `apache_backup.sh`, `nginx_backup.sh`, logs, backup archives |

---

## Repository Structure

```
Testing-Linux-and-Server_HV/
├── Task1:System_Monitoring_Setup/
│   ├── scripts/
│   │   └── monitoring.sh                        # System health monitoring script
│   └── Testing_Linux_Server_Task1_AnkurGosar.docx
│
├── Task2:User_Management_and_Access_Control/
│   └── Testing_Linux_Server_Task2_AnkurGosar.docx
│
└── Task3:Backup_Configuration_for_Web_Servers/
    ├── scripts/
    │   ├── apache_backup.sh                     # Apache2 backup script
    │   └── nginx_backup.sh                      # Nginx backup script
    ├── logs/
    │   ├── apache_backup.log                    # Apache backup execution log
    │   └── nginx_backup.log                     # Nginx backup execution log
    └── backups/
        ├── apache_backup_2026-03-20.tar.gz      # Sample Apache backup archive
        └── nginx_backup_2026-03-20.tar.gz       # Sample Nginx backup archive
```

---

## Task 1: System Monitoring Setup

### Description

Sets up automated system health monitoring that captures key performance metrics and logs them to a dedicated log file. The script collects:

- **CPU and memory usage** (via `top`)
- **Disk space utilization** (via `df`)
- **Top running processes** sorted by CPU consumption (via `ps`)

### Script: `monitoring.sh`

```bash
#!/bin/bash

LOG_FILE="/var/log/system_monitoring.log"
date=`date`
separator="=============="
echo "=== ($date) ===" >> $LOG_FILE

echo "===== CPU and Memory Usage: =====" >> $LOG_FILE
top -b -n1 | head -20 >> $LOG_FILE
echo $separator >> $LOG_FILE

echo "Disk Usage:" >> $LOG_FILE
df -h >> $LOG_FILE
echo $separator >> $LOG_FILE

echo "Top Processes:" >> $LOG_FILE
ps aux --sort=%cpu | head -10 >> $LOG_FILE
echo $separator >> $LOG_FILE

echo "=== END OF REPORT ===" >> $LOG_FILE
```

### Output

All metrics are appended to `/var/log/system_monitoring.log` with timestamps so that each run's output is clearly demarcated.

### Running the Script

```bash
# Make the script executable
chmod +x Task1\:System_Monitoring_Setup/scripts/monitoring.sh

# Run manually (requires write access to /var/log/)
sudo bash Task1\:System_Monitoring_Setup/scripts/monitoring.sh

# View the generated log
sudo cat /var/log/system_monitoring.log
```

---

## Task 2: User Management and Access Control

### Description

Covers Linux user and group management best practices on a server, including:

- Creating and managing user accounts
- Configuring group memberships and shared access
- Setting file and directory permissions (`chmod`, `chown`)
- Restricting and granting `sudo` privileges
- Implementing authentication and access control policies

Full details and step-by-step instructions are provided in the accompanying Word document:
📄 `Task2:User_Management_and_Access_Control/Testing_Linux_Server_Task2_AnkurGosar.docx`

### Key Commands Referenced

```bash
# Create a new user
sudo useradd -m -s /bin/bash <username>

# Set a password
sudo passwd <username>

# Add user to a group
sudo usermod -aG <groupname> <username>

# Grant sudo privileges
sudo usermod -aG sudo <username>

# Set file permissions
chmod 750 /path/to/directory
chown <user>:<group> /path/to/file
```

---

## Task 3: Backup Configuration for Web Servers

### Description

Automates backup creation for two common Linux web servers — **Apache2** and **Nginx**. Each script:

1. Creates a **timestamped compressed archive** (`.tar.gz`) of the web server's configuration and web root directories
2. Logs the backup start time and archive path
3. **Verifies** the archive contents after creation
4. Writes a completion marker to the log file

### Script: `apache_backup.sh`

Backs up:
- `/etc/apache2` — Apache2 configuration files
- `/var/www/html` — Web root directory

```bash
#!/bin/bash

DATE=$(date +%F)
BACKUP_FILE="/backup/apache_backup_$DATE.tar.gz"
LOG_FILE="/var/log/apache_backup.log"

echo "Backup start: $DATE" >> $LOG_FILE
tar -czf $BACKUP_FILE /etc/apache2 /var/www/html

echo "Backup created: $BACKUP_FILE" >> $LOG_FILE

# Verify backup contents
tar -tzf $BACKUP_FILE >> $LOG_FILE
echo "==================== End of backup ====================" >> $LOG_FILE
```

### Script: `nginx_backup.sh`

Backs up:
- `/etc/nginx` — Nginx configuration files
- `/usr/share/nginx/html` — Default web root directory

```bash
#!/bin/bash

DATE=$(date +%F)
BACKUP_FILE="/backup/nginx_backup_$DATE.tar.gz"
LOG_FILE="/var/log/nginx_backup.log"

echo "Starting backup: $DATE" >> $LOG_FILE
tar -czf $BACKUP_FILE /etc/nginx /usr/share/nginx/html

echo "Backup created: $BACKUP_FILE" >> $LOG_FILE

# Verify backup contents
tar -tzf $BACKUP_FILE >> $LOG_FILE
echo "==================== End of backup ====================" >> $LOG_FILE
```

### Running the Backup Scripts

```bash
# Create the backup destination directory (if it does not exist)
sudo mkdir -p /backup

# Make the scripts executable
chmod +x Task3\:Backup_Configuration_for_Web_Servers/scripts/apache_backup.sh
chmod +x Task3\:Backup_Configuration_for_Web_Servers/scripts/nginx_backup.sh

# Run Apache backup
sudo bash Task3\:Backup_Configuration_for_Web_Servers/scripts/apache_backup.sh

# Run Nginx backup
sudo bash Task3\:Backup_Configuration_for_Web_Servers/scripts/nginx_backup.sh

# View backup logs
sudo cat /var/log/apache_backup.log
sudo cat /var/log/nginx_backup.log

# List created backups
ls -lh /backup/
```

### Sample Log Output

After a successful run, the log files look like:

```
Backup start: 2026-03-20
Backup created: /backup/apache_backup_2026-03-20.tar.gz
etc/apache2/
etc/apache2/envvars
etc/apache2/conf-enabled/
...
var/www/html/
var/www/html/index.html
==================== End of backup ====================
```

---

## Prerequisites

- A Debian/Ubuntu-based Linux system (the scripts use paths and packages common to these distros)
- **Apache2** installed for `apache_backup.sh` (`sudo apt install apache2`)
- **Nginx** installed for `nginx_backup.sh` (`sudo apt install nginx`)
- `sudo` / root access to write to `/var/log/` and `/backup/`
- Bash shell (`/bin/bash`)

---

## Usage

### Quick Start

```bash
# Clone the repository
git clone https://github.com/apgosar/Testing-Linux-and-Server_HV.git
cd Testing-Linux-and-Server_HV

# Make all scripts executable
chmod +x Task1\:System_Monitoring_Setup/scripts/monitoring.sh
chmod +x Task3\:Backup_Configuration_for_Web_Servers/scripts/apache_backup.sh
chmod +x Task3\:Backup_Configuration_for_Web_Servers/scripts/nginx_backup.sh

# Prepare backup directory
sudo mkdir -p /backup

# Run system monitoring
sudo bash "Task1:System_Monitoring_Setup/scripts/monitoring.sh"

# Run Apache2 backup
sudo bash "Task3:Backup_Configuration_for_Web_Servers/scripts/apache_backup.sh"

# Run Nginx backup
sudo bash "Task3:Backup_Configuration_for_Web_Servers/scripts/nginx_backup.sh"
```

---

## Automating with Cron

Schedule the scripts to run automatically using `cron`. Open the crontab editor with `sudo crontab -e` and add entries like:

```cron
# Run system monitoring every hour
0 * * * * /bin/bash /path/to/Task1:System_Monitoring_Setup/scripts/monitoring.sh

# Run Apache backup every day at 2:00 AM
0 2 * * * /bin/bash /path/to/Task3:Backup_Configuration_for_Web_Servers/scripts/apache_backup.sh

# Run Nginx backup every day at 2:30 AM
30 2 * * * /bin/bash /path/to/Task3:Backup_Configuration_for_Web_Servers/scripts/nginx_backup.sh
```

---

## Technologies Used

| Tool / Technology | Purpose |
|-------------------|---------|
| **Bash** | Shell scripting language for all automation scripts |
| **GNU/Linux (Debian/Ubuntu)** | Target operating system |
| **Apache2** | Web server backed up in Task 3 |
| **Nginx** | Web server backed up in Task 3 |
| `tar` | Creating compressed backup archives |
| `top` | CPU and memory usage reporting |
| `df` | Disk space usage reporting |
| `ps` | Process listing and CPU usage sorting |
| `cron` | Task scheduling for automated execution |
| **Git** | Version control |

---

*Author: Ankur Gosar*
