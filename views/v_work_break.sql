--
-- View "V_WORK_BREAK"
--
CREATE OR REPLACE FORCE EDITIONABLE VIEW "WKSP_DEMO"."V_WORK_BREAK" ("LOG_USER", "LOG_DATE", "START_TIMESTAMP", "STOP_TIMESTAMP", "DELTA_BREAK", "LOG_TAG", "LOG_KEY", "RECOVER_BREAK_FLAG") DEFAULT COLLATION "USING_NLS_COMP"  AS 
  SELECT  
    v.log_user,  
    v.log_date,  
    v.start_timestamp,  
    v.stop_timestamp,  
    v.stop_timestamp - v.start_timestamp AS delta_break,  
    v.log_tag,  
    v.log_key,   
    case  
    when   
     extract (day  from (v.stop_timestamp - v.start_timestamp ))   = 0 and  
     extract (hour from (v.stop_timestamp - v.start_timestamp ))   = 0 and  
     extract (minute from (v.stop_timestamp - v.start_timestamp ))   < 15   
     THEN  
     0  
     else   
     1  
     end   
     as recover_break_flag  
FROM  
    v_work_data v  
WHERE  
        log_tag = 'WORK_STOP'  
        and    v.start_timestamp != v.stop_timestamp  
    AND EXISTS (  
        SELECT  
            1  
        FROM  
            v_work_day i  
        WHERE  
                v.log_user = i.log_user  
            AND v.start_timestamp BETWEEN i.min_start_timestamp AND i.max_stop_timestamp  
            AND v.stop_timestamp BETWEEN i.min_start_timestamp AND i.max_stop_timestamp  
    )
/