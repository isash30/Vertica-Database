/***********************************************************************************************************************
Author :- Saswata Sengupta
Description :- Vertica Storage 
***********************************************************************************************************************/

select a.anchor_table_name,a.column_name,a.encodings, sum(a.ros_used_bytes)/1024/1024  as "Table_Size in MB"
from column_storage a 
where a.anchor_table_name in
(
select anchor_table_name from projection_storage
)
group by a.anchor_table_name,a.column_name,a.encodings,a.ros_used_bytes
order by a.ros_used_bytes desc, a.encodings desc
