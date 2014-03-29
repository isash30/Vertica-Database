#!/usr/bin/python
import pyodbc
import datetime
import time


cnxn = pyodbc.connect('DSN=LV_Vertica')
now = datetime.date.today()
cursor_tables = cnxn.cursor()
cursor_insert = cnxn.cursor()

while 1:
	cursor_insert.execute("insert into vertica_audit.epoch_verification SELECT current_timestamp ,last_good_epoch, current_epoch, ahm_epoch, wos_row_count, ros_row_count, wos_used_bytes, ros_used_bytes from system")
	cnxn.commit()
	print "Done"
	time.sleep(5)
