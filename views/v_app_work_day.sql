--
-- View "V_APP_WORK_DAY"
--
CREATE OR REPLACE FORCE EDITIONABLE VIEW "WKSP_DEMO"."V_APP_WORK_DAY" ("LOG_USER", "LOG_DATE", "MIN_START_TIMESTAMP", "MAX_STOP_TIMESTAMP", "LOG_TAG") DEFAULT COLLATION "USING_NLS_COMP"  AS 
  SELECT
        v.log_user,
        v.log_date,
        MIN(v.start_timestamp) AS min_start_timestamp,
        MAX(v.stop_timestamp)  AS max_stop_timestamp,
        v.log_tag
    FROM
        v_app_work_record v
    WHERE
        log_tag = 'START'
    GROUP BY
        v.log_user,
        v.log_date,
        v.log_tag
/