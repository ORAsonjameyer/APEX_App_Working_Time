--
-- View "V_WORK_REP"
--
CREATE OR REPLACE FORCE EDITIONABLE VIEW "WKSP_DEMO"."V_WORK_REP" ("LOG_USER", "LOG_DATE", "MIN_START_WORK", "MAX_END_WORK", "NUM_WORK", "DELTA_WORK", "NUM_BREAK", "DELTA_BREAK", "DELTA_BREAK_ALL", "NUM_BREAK_ALL", "RECORD_SUMMARY", "ISSUE_FOUND", "WORK_CLASS", "WORK_LAG", "WORK_GREATER6", "BREAK_DURATION") DEFAULT COLLATION "USING_NLS_COMP"  AS 
  SELECT  
    d.log_user,  
    d.log_date,  
    d.min_start_timestamp AS min_start_work,  
    d.max_stop_timestamp  AS max_end_work,  
    (select count(1) from v_work_work w where w.log_user = d.log_user and d.log_date = w.log_date) as num_work,   
     (  
        SELECT  
            numtodsinterval(SUM(CAST((stop_timestamp AT TIME ZONE 'Zulu') AS DATE) - CAST((start_timestamp AT TIME ZONE 'Zulu') AS DATE  
            )),  
                            'DAY')  
        FROM  
            v_work_work w  
        WHERE  
                d.log_user = w.log_user  
              
            AND d.log_date = w.log_date  
    )                     AS delta_work,  
    (  
        SELECT  
            COUNT(1)  
        FROM  
            v_work_break b  
        WHERE  
                d.log_user = b.log_user  
            AND b.recover_break_flag = 1  
            AND d.log_date = b.log_date  
    )                     AS num_break,  
    (  
        SELECT  
            numtodsinterval(SUM(CAST((stop_timestamp AT TIME ZONE 'Zulu') AS DATE) - CAST((start_timestamp AT TIME ZONE 'Zulu') AS DATE  
            )),  
                            'DAY')  
        FROM  
            v_work_break b  
        WHERE  
                d.log_user = b.log_user  
            AND b.recover_break_flag = 1  
            AND d.log_date = b.log_date  
    )                     AS delta_break,  
    (  
        SELECT  
            numtodsinterval(SUM(CAST((stop_timestamp AT TIME ZONE 'Zulu') AS DATE) - CAST((start_timestamp AT TIME ZONE 'Zulu') AS DATE  
            )),  
                            'DAY')  
        FROM  
            v_work_break b  
        WHERE  
                d.log_user = b.log_user  
            AND d.log_date = b.log_date  
    )                     AS delta_break_all,  
    (  
        SELECT  
            COUNT(1)  
        FROM  
            v_work_break b  
        WHERE  
                d.log_user = b.log_user  
            AND d.log_date = b.log_date  
    )                     AS num_break_all,  
    p_work_helper.f_check_summary(p_log_user => d.log_user, p_log_date => d.log_date) AS record_summary, 
    p_work_helper.f_check_issue_record(p_log_user => d.log_user, p_log_date => d.log_date) AS issue_found, 
    p_work_helper.f_get_work_class (p_log_user => d.log_user, p_log_date => d.log_date) as work_class,  
    p_work_helper.f_check_work_lag (p_log_user => d.log_user, p_log_date => d.log_date) as work_lag,  
    p_work_helper.f_check_work_greater6(p_log_user => d.log_user, p_log_date => d.log_date) as work_greater6,  
    p_work_helper.f_check_break_duration(p_log_user => d.log_user, p_log_date => d.log_date) as break_duration  
FROM  
    v_work_day d
/