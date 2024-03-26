--
-- View "V_WORK_DAY"
--
CREATE OR REPLACE FORCE EDITIONABLE VIEW "WKSP_DEMO"."V_WORK_DAY" ("LOG_USER", "LOG_DATE", "MIN_START_TIMESTAMP", "MAX_STOP_TIMESTAMP", "LOG_TAG") DEFAULT COLLATION "USING_NLS_COMP"  AS 
  SELECT  
    v.log_user,  
    v.log_date,  
    min(v.start_timestamp) as min_start_timestamp,  
    max(v.stop_timestamp) as max_stop_timestamp,   
    -- max(v.stop_timestamp) - min(v.start_timestamp) as delta_work,   
    v.log_tag  
FROM  
    v_work_data v  
    where log_tag = 'WORK_START'  
    group by v.log_user,  
    v.log_date,   
    v.log_tag
/