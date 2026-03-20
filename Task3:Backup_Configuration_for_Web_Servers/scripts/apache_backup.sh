#!/bin/bash

DATE=$(date +%F)
BACKUP_FILE="/backup/apache_backup_$DATE.tar.gz"
LOG_FILE="/var/log/apache_backup.log"
echo "Backup start: $DATE" >> $LOG_FILE
tar -czf $BACKUP_FILE /etc/apache2 /var/www/html

echo "Backup created: $BACKUP_FILE" >> $LOG_FILE

# Verify
tar -tzf $BACKUP_FILE >> $LOG_FILE
echo "==================== End of backup ====================" >> $LOG_FILE
