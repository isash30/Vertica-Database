#!/usr/bin/python
import pyodbc
import datetime
import time

cnxn = pyodbc.connect('DSN=LV_Vertica')
now = datetime.date.today()
cursor_tables = cnxn.cursor()
sql="select epoch_timestamp,last_good_epoch, current_epoch, ahm_epoch, wos_row_count, ros_row_count, wos_used_bytes, ros_used_bytes from vertica_audit.epoch_verification where epoch_timestamp = (select max(epoch_timestamp) from vertica_audit.epoch_verification);"

print sql

while 1:
        pass
        for row in cursor_tables.execute(sql) :

                if row.last_good_epoch - row.current_epoch >= 500 :
                        print "Alert epoch failing behind"
                else :
                        print "Nothing to worry !!"
        time.sleep(10)
        #cnxn.close()

