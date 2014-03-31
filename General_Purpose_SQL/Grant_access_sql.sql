/*************************************************************************************************************************
Author :- Saswata Sengupta
Description :- SQL to generate grant statement

**************************************************************************************************************************/

select 'grant select on txns.' || table_name || ' to readonly;' from tables where table_schema = 'txns';
