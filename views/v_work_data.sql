--
-- View "V_WORK_DATA"
--
CREATE OR REPLACE FORCE EDITIONABLE VIEW "WKSP_DEMO"."V_WORK_DATA" ("LOG_USER", "LOG_DATE", "START_TIMESTAMP", "STOP_TIMESTAMP", "LOG_TAG", "LOG_KEY") DEFAULT COLLATION "USING_NLS_COMP"  AS 
  SELECT  
    log_user,  
    trunc(log_timestamp) AS log_date,  
    log_timestamp        AS start_timestamp,  
    /*FIRST_VALUE(log_timestamp)  
    OVER(PARTITION BY log_user  
         ORDER BY  
             log_timestamp DESC  
        ROWS 1 PRECEDING  
    )                    AS stop_timestamp, */ 
case when     log_timestamp        = 
    FIRST_VALUE(log_timestamp)  
    OVER(PARTITION BY log_user  
         ORDER BY  
             log_timestamp DESC  
        ROWS 1 PRECEDING  
    )                     
     
    then localtimestamp 
    else  
     
    FIRST_VALUE(log_timestamp)  
    OVER(PARTITION BY log_user  
         ORDER BY  
             log_timestamp DESC  
        ROWS 1 PRECEDING  
    )     end                
     
    AS stop_timestamp, 
 
    log_tag,  
    id                   AS log_key  
FROM  
    t_work_data  
-- where log_tag = 'WORK_START'  
ORDER BY  
    log_timestamp
/