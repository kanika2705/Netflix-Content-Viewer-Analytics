CREATE DATABASE IF NOT EXISTS netflix_analytics;
USE netflix_analytics;

DROP TABLE IF EXISTS cohort_retention_matrix, fact_watch_events, fact_subscriptions, fact_payments, dim_date, dim_plans, dim_titles, dim_users, raw_watch_events, raw_subscriptions, raw_payments, raw_plans, raw_titles, raw_users, raw_date;

CREATE TABLE raw_date (
 date_id VARCHAR(32), full_date VARCHAR(32), year VARCHAR(16), quarter VARCHAR(16), month VARCHAR(16), month_name VARCHAR(64), day VARCHAR(16), day_of_week VARCHAR(32), is_weekend VARCHAR(16), week_of_year VARCHAR(16)
);

CREATE TABLE raw_users (
 user_id VARCHAR(32), full_name VARCHAR(255), email VARCHAR(255), signup_date VARCHAR(32),
 country VARCHAR(128), age VARCHAR(32), age_group VARCHAR(64), gender VARCHAR(64),
 acquisition_channel VARCHAR(128), signup_cohort_month VARCHAR(32), engagement_segment VARCHAR(64),
 days_since_last_watch VARCHAR(32), total_watch_sessions VARCHAR(32)
);
CREATE TABLE raw_titles (
 movie_id VARCHAR(32), title VARCHAR(255), genre VARCHAR(128), language VARCHAR(128),
 content_type VARCHAR(64), release_year VARCHAR(32), runtime_minutes VARCHAR(32), imdb_rating VARCHAR(32), budget_tier VARCHAR(64)
);
CREATE TABLE raw_plans (
 plan_id VARCHAR(32), plan_name VARCHAR(128), monthly_price VARCHAR(64), video_quality VARCHAR(64)
);
CREATE TABLE raw_subscriptions (
 subscription_id VARCHAR(32), user_id VARCHAR(32), plan_id VARCHAR(32),
 start_date_id VARCHAR(32), end_date_id VARCHAR(32), status VARCHAR(64), cancellation_reason VARCHAR(255), duration_days VARCHAR(32)
);
CREATE TABLE raw_payments (
 payment_id VARCHAR(32), subscription_id VARCHAR(32), user_id VARCHAR(32), date_id VARCHAR(32),
 amount VARCHAR(64), payment_status VARCHAR(64), payment_method VARCHAR(64)
);
CREATE TABLE raw_watch_events (
 event_id VARCHAR(32), user_id VARCHAR(32), movie_id VARCHAR(32), date_id VARCHAR(32),
 device_type VARCHAR(64), watch_minutes VARCHAR(64), completion_pct VARCHAR(64), is_completed VARCHAR(16), rating_given VARCHAR(32)
);
