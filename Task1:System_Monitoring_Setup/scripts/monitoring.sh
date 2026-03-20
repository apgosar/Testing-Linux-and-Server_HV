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
