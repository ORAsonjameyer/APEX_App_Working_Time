--
-- View "V_WORK_WORK"
--
CREATE OR REPLACE FORCE EDITIONABLE VIEW "WKSP_DEMO"."V_WORK_WORK" ("LOG_USER", "LOG_DATE", "START_TIMESTAMP", "STOP_TIMESTAMP", "DELTA_WORK", "LOG_TAG", "LOG_KEY") DEFAULT COLLATION "USING_NLS_COMP"  AS 
  SELECT  
    v.log_user,  
    v.log_date,  
    v.start_timestamp,  
    v.stop_timestamp,  
    --case when v.start_timestamp=v.stop_timestamp then localtimestamp else v.stop_timestamp end as stop_timestamp,  
    v.stop_timestamp - v.start_timestamp AS delta_work,  
    --case when v.start_timestamp=v.stop_timestamp then localtimestamp else v.stop_timestamp end - v.start_timestamp AS delta_work,  
    v.log_tag,  
    v.log_key  
FROM  
    v_work_data v  
WHERE  
        log_tag = 'WORK_START'
/