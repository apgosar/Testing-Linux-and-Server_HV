#!/bin/bash
DATE=$(date +%F)
BACKUP_FILE="/backup/nginx_backup_$DATE.tar.gz"
LOG_FILE="/var/log/nginx_backup.log"
echo "Starting backup: $DATE" >> $LOG_FILE
tar -czf $BACKUP_FILE /etc/nginx /usr/share/nginx/html

echo "Backup created: $BACKUP_FILE" >> $LOG_FILE

# Verify
tar -tzf $BACKUP_FILE >> $LOG_FILE
echo "==================== End of backup ====================" >> $LOG_FILE
