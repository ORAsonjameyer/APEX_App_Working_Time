--
-- View "V_APP_WORK_RECORD"
--
CREATE OR REPLACE FORCE EDITIONABLE VIEW "WKSP_DEMO"."V_APP_WORK_RECORD" ("LOG_USER", "LOG_DATE", "START_TIMESTAMP", "STOP_TIMESTAMP", "LOG_TAG", "LOG_KEY") DEFAULT COLLATION "USING_NLS_COMP"  AS 
  SELECT
        log_user,
        trunc(log_timestamp) AS log_date,
        log_timestamp        AS start_timestamp,
        CASE
            WHEN log_timestamp = FIRST_VALUE(log_timestamp)
                                 OVER(PARTITION BY log_user
                                      ORDER BY
                                          log_timestamp DESC
                ROWS 1 PRECEDING
                                 ) THEN
                localtimestamp
            ELSE
                FIRST_VALUE(log_timestamp)
                OVER(PARTITION BY log_user
                     ORDER BY
                         log_timestamp DESC
                    ROWS 1 PRECEDING
                )
        END                  AS stop_timestamp,
        log_tag,
        id                   AS log_key
    FROM
        app_work_record
/