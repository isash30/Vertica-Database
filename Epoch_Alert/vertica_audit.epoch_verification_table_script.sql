CREATE TABLE vertica_audit.epoch_verification
(
   epoch_timestamp   TimestampTz,
   last_good_epoch   INTEGER,
   current_epoch     INTEGER,
   ahm_epoch         INTEGER,
   wos_row_count     INTEGER,
   ros_row_count     INTEGER,
   wos_used_bytes    INTEGER,
   ros_used_bytes    INTEGER
);
