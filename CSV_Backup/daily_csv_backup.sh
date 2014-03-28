#!/bin/bash

VERTICA_HOST="verticaproxy.xxx.com"
TABLE_NAME="/data/backups/vertica/script/csv_backup_tablename.conf"
TODAY=`date '+%d%m%Y_%H%M%S'`
VERTICA_DB="enterprise_datawarehouse"
VERTICA_USER="etluser"
VERTICA_PWD="*******"
LOG=/data/backups/vertica/script/logs/daily_csv_backup_`date '+%d%m%Y_%H%M%S'`.log
BACKUP_DIR=/data/backups/vertica/csv_backup

set -o pipefail
export EMAIL="Vertica Backups <Your email here>"

echo "`date '+%c'` : Starting csv Backup..." >> $LOG 2>&1

while read line
do
    echo "`date '+%c'` : Starting csv Backup for $line ..." >> $LOG 2>&1
    /opt/vertica/bin/vsql -h $VERTICA_HOST -U $VERTICA_USER -w $VERTICA_PWD -d $VERTICA_DB -P footer -A -F $'\t' -c "select * from  $line" | gzip -c > $BACKUP_DIR/$line"_"$TODAY.txt.gz 2>/var/tmp/verticabackup.log
    rc=$?
    #gzip $BACKUP_DIR/$line"_"$TODAY.txt
    echo "$line has been successfully backed up !!" >> $LOG 2>&1
done <"$TABLE_NAME"
echo "CSV Backup Completed Successfully !!">> $LOG 2>&1
echo $LOG
echo -e "Daily csv backup completed successfully!!\nrc=$rc\n\nSent from $0 on `hostname`" | mutt -s "CSV Backup completed !!"   <your email here > -a $LOG
