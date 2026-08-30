USE netflix_analytics;

DROP TABLE IF EXISTS cohort_retention_matrix;

CREATE TABLE cohort_retention_matrix AS
WITH user_cohorts AS (
    SELECT user_id, signup_cohort_month AS cohort_month FROM dim_users
),
monthly_activity AS (
    SELECT DISTINCT w.user_id, uc.cohort_month,
           DATE_FORMAT(STR_TO_DATE(CAST(w.date_id AS CHAR), '%Y%m%d'), '%Y-%m') AS watch_month
    FROM fact_watch_events w JOIN user_cohorts uc ON w.user_id = uc.user_id
),
activity_with_offset AS (
    SELECT user_id, cohort_month, TIMESTAMPDIFF(MONTH,
           STR_TO_DATE(CONCAT(cohort_month,'-01'),'%Y-%m-%d'),
           STR_TO_DATE(CONCAT(watch_month,'-01'),'%Y-%m-%d')) AS month_number
    FROM monthly_activity
),
cohort_sizes AS (
    SELECT cohort_month, COUNT(*) AS users_in_cohort FROM user_cohorts GROUP BY cohort_month
),
active AS (
    SELECT cohort_month, month_number, COUNT(DISTINCT user_id) AS active_users
    FROM activity_with_offset WHERE month_number BETWEEN 0 AND 6
    GROUP BY cohort_month, month_number
)
SELECT a.cohort_month, c.users_in_cohort, a.month_number, a.active_users,
       ROUND(a.active_users / c.users_in_cohort * 100, 1) AS retention_pct
FROM active a JOIN cohort_sizes c USING (cohort_month)
ORDER BY a.cohort_month, a.month_number;
