--
-- View "V_APP_WORK_WORK"
--
CREATE OR REPLACE FORCE EDITIONABLE VIEW "WKSP_DEMO"."V_APP_WORK_WORK" ("LOG_USER", "LOG_DATE", "START_TIMESTAMP", "STOP_TIMESTAMP", "DELTA_WORK", "LOG_TAG", "LOG_KEY") DEFAULT COLLATION "USING_NLS_COMP"  AS 
  SELECT 
    v.log_user, 
    v.log_date, 
    v.start_timestamp, 
    v.stop_timestamp, 
    v.stop_timestamp - v.start_timestamp AS delta_work, 
    v.log_tag, 
    v.log_key 
FROM 
    v_app_work_record v 
WHERE 
        log_tag = 'START'
/