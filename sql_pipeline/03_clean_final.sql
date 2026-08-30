USE netflix_analytics;

DROP TABLE IF EXISTS dim_date, dim_plans, dim_titles, dim_users, fact_payments, fact_subscriptions, fact_watch_events;

CREATE TABLE dim_date AS
SELECT CAST(TRIM(date_id) AS UNSIGNED) AS date_id,
       DATE_FORMAT(CASE WHEN TRIM(full_date) LIKE '%/%/%' THEN STR_TO_DATE(TRIM(full_date),'%d/%m/%Y') ELSE STR_TO_DATE(TRIM(full_date),'%Y-%m-%d') END,'%Y-%m-%d') AS full_date,
       CAST(TRIM(year) AS UNSIGNED) AS year, CAST(TRIM(quarter) AS UNSIGNED) AS quarter,
       CAST(TRIM(month) AS UNSIGNED) AS month, TRIM(month_name) AS month_name, CAST(TRIM(day) AS UNSIGNED) AS day,
       TRIM(day_of_week) AS day_of_week, CAST(TRIM(is_weekend) AS UNSIGNED) AS is_weekend, CAST(TRIM(week_of_year) AS UNSIGNED) AS week_of_year
FROM raw_date AS r
GROUP BY r.date_id, r.full_date, r.year, r.quarter, r.month, r.month_name, r.day, r.day_of_week, r.is_weekend, r.week_of_year;

CREATE TABLE dim_plans AS
SELECT CAST(TRIM(plan_id) AS UNSIGNED) AS plan_id, TRIM(plan_name) AS plan_name,
       CAST(TRIM(monthly_price) AS DECIMAL(10,1)) AS monthly_price, TRIM(video_quality) AS video_quality
FROM raw_plans AS r
GROUP BY r.plan_id, r.plan_name, r.monthly_price, r.video_quality;

CREATE TABLE dim_titles AS
SELECT CAST(TRIM(movie_id) AS UNSIGNED) AS movie_id, TRIM(title) AS title,
       CASE LOWER(TRIM(genre))
 WHEN 'fantasy' THEN 'Fantasy'
 WHEN 'reality' THEN 'Reality'
 WHEN 'drama' THEN 'Drama'
 WHEN 'sci-fi' THEN 'Sci-fi'
 WHEN 'comedy' THEN 'Comedy'
 WHEN 'action' THEN 'Action'
 WHEN 'documentary' THEN 'Documentary'
 WHEN 'romance' THEN 'Romance'
 WHEN 'thriller' THEN 'Thriller'
 WHEN 'horror' THEN 'Horror'
 WHEN 'crime' THEN 'Crime'
 WHEN 'animation' THEN 'Animation'
 ELSE TRIM(genre) END AS genre, CASE LOWER(TRIM(language))
 WHEN 'hindi' THEN 'Hindi'
 WHEN 'spanish' THEN 'Spanish'
 WHEN 'french' THEN 'French'
 WHEN 'english' THEN 'English'
 WHEN 'japanese' THEN 'Japanese'
 WHEN 'korean' THEN 'Korean'
 WHEN 'german' THEN 'German'
 ELSE TRIM(language) END AS language, CASE LOWER(TRIM(content_type))
 WHEN 'series' THEN 'Series'
 WHEN 'movie' THEN 'Movie'
 ELSE TRIM(content_type) END AS content_type,
       CAST(TRIM(release_year) AS UNSIGNED) AS release_year, CAST(TRIM(runtime_minutes) AS UNSIGNED) AS runtime_minutes,
       CAST(TRIM(imdb_rating) AS DECIMAL(3,1)) AS imdb_rating, CASE LOWER(TRIM(budget_tier))
 WHEN 'high' THEN 'High'
 WHEN 'low' THEN 'Low'
 WHEN 'blockbuster' THEN 'Blockbuster'
 WHEN 'mid' THEN 'Mid'
 ELSE TRIM(budget_tier) END AS budget_tier
FROM raw_titles AS r
GROUP BY r.movie_id, r.title, r.genre, r.language, r.content_type, r.release_year, r.runtime_minutes, r.imdb_rating, r.budget_tier;

CREATE TABLE dim_users AS
SELECT CAST(TRIM(user_id) AS UNSIGNED) AS user_id, TRIM(full_name) AS full_name, TRIM(email) AS email,
       DATE_FORMAT(CASE WHEN TRIM(signup_date) LIKE '%/%/%' THEN STR_TO_DATE(TRIM(signup_date),'%d/%m/%Y') ELSE STR_TO_DATE(TRIM(signup_date),'%Y-%m-%d') END,'%Y-%m-%d') AS signup_date,
       CASE LOWER(TRIM(country))
 WHEN 'united states' THEN 'United States'
 WHEN 'india' THEN 'India'
 WHEN 'brazil' THEN 'Brazil'
 WHEN 'united kingdom' THEN 'United Kingdom'
 WHEN 'canada' THEN 'Canada'
 WHEN 'germany' THEN 'Germany'
 WHEN 'australia' THEN 'Australia'
 WHEN 'uae' THEN 'UAE'
 WHEN 'france' THEN 'France'
 WHEN 'singapore' THEN 'Singapore'
 WHEN 'unknown' THEN 'Unknown'
 ELSE TRIM(country) END AS country, CAST(TRIM(age) AS UNSIGNED) AS age, CASE LOWER(TRIM(age_group))
 WHEN '35-44' THEN '35-44'
 WHEN '45-54' THEN '45-54'
 WHEN '25-34' THEN '25-34'
 WHEN '18-24' THEN '18-24'
 WHEN 'teen' THEN 'Teen'
 WHEN '55+' THEN '55+'
 ELSE TRIM(age_group) END AS age_group, CASE LOWER(TRIM(gender))
 WHEN 'male' THEN 'Male'
 WHEN 'female' THEN 'Female'
 WHEN 'other' THEN 'Other'
 ELSE TRIM(gender) END AS gender,
       CASE LOWER(TRIM(acquisition_channel))
 WHEN 'email campaign' THEN 'Email Campaign'
 WHEN 'organic search' THEN 'Organic Search'
 WHEN 'direct' THEN 'Direct'
 WHEN 'referral' THEN 'Referral'
 WHEN 'paid social' THEN 'Paid Social'
 WHEN 'affiliate' THEN 'Affiliate'
 ELSE TRIM(acquisition_channel) END AS acquisition_channel, TRIM(signup_cohort_month) AS signup_cohort_month, CASE LOWER(TRIM(engagement_segment))
 WHEN 'power user' THEN 'Power User'
 WHEN 'active' THEN 'Active'
 WHEN 'at risk' THEN 'At Risk'
 WHEN 'dormant' THEN 'Dormant'
 ELSE TRIM(engagement_segment) END AS engagement_segment,
       CAST(TRIM(days_since_last_watch) AS UNSIGNED) AS days_since_last_watch, CAST(TRIM(total_watch_sessions) AS UNSIGNED) AS total_watch_sessions
FROM raw_users AS r
GROUP BY r.user_id, r.full_name, r.email, r.signup_date, r.country, r.age, r.age_group, r.gender, r.acquisition_channel, r.signup_cohort_month, r.engagement_segment, r.days_since_last_watch, r.total_watch_sessions;

CREATE TABLE fact_payments AS
SELECT CAST(TRIM(payment_id) AS UNSIGNED) AS payment_id, CAST(TRIM(subscription_id) AS UNSIGNED) AS subscription_id,
       CAST(TRIM(user_id) AS UNSIGNED) AS user_id, CAST(TRIM(date_id) AS UNSIGNED) AS date_id,
       CAST(TRIM(amount) AS DECIMAL(10,1)) AS amount, CASE LOWER(TRIM(payment_status))
 WHEN 'success' THEN 'Success'
 WHEN 'refunded' THEN 'Refunded'
 WHEN 'failed' THEN 'Failed'
 ELSE TRIM(payment_status) END AS payment_status, CASE LOWER(TRIM(payment_method))
 WHEN 'upi' THEN 'UPI'
 WHEN 'wallet' THEN 'Wallet'
 WHEN 'debit card' THEN 'Debit Card'
 WHEN 'credit card' THEN 'Credit Card'
 WHEN 'paypal' THEN 'PayPal'
 ELSE TRIM(payment_method) END AS payment_method
FROM raw_payments AS r
GROUP BY r.payment_id, r.subscription_id, r.user_id, r.date_id, r.amount, r.payment_status, r.payment_method;

CREATE TABLE fact_subscriptions AS
SELECT CAST(TRIM(subscription_id) AS UNSIGNED) AS subscription_id, CAST(TRIM(user_id) AS UNSIGNED) AS user_id,
       CAST(TRIM(plan_id) AS UNSIGNED) AS plan_id, CAST(TRIM(start_date_id) AS UNSIGNED) AS start_date_id,
       CAST(TRIM(end_date_id) AS UNSIGNED) AS end_date_id, CASE LOWER(TRIM(status))
 WHEN 'active' THEN 'Active'
 WHEN 'cancelled' THEN 'Cancelled'
 WHEN 'xpired' THEN 'xpired'
 WHEN 'expired' THEN 'Expired'
 WHEN 'ctive' THEN 'ctive'
 WHEN 'ancelled' THEN 'ancelled'
 ELSE TRIM(status) END AS status,
       NULLIF(TRIM(cancellation_reason),'') AS cancellation_reason, CAST(TRIM(duration_days) AS UNSIGNED) AS duration_days
FROM raw_subscriptions AS r
GROUP BY r.subscription_id, r.user_id, r.plan_id, r.start_date_id, r.end_date_id, r.status, r.cancellation_reason, r.duration_days;

CREATE TABLE fact_watch_events AS
SELECT CAST(TRIM(event_id) AS UNSIGNED) AS event_id, CAST(TRIM(user_id) AS UNSIGNED) AS user_id,
       CAST(TRIM(movie_id) AS UNSIGNED) AS movie_id, CAST(TRIM(date_id) AS UNSIGNED) AS date_id,
       CASE LOWER(TRIM(device_type))
 WHEN 'smart tv' THEN 'Smart TV'
 WHEN 'laptop' THEN 'Laptop'
 WHEN 'web browser' THEN 'Web Browser'
 WHEN 'mobile' THEN 'Mobile'
 WHEN 'tablet' THEN 'Tablet'
 WHEN 'gaming console' THEN 'Gaming Console'
 ELSE TRIM(device_type) END AS device_type, CAST(TRIM(watch_minutes) AS DECIMAL(10,1)) AS watch_minutes,
       CAST(TRIM(completion_pct) AS DECIMAL(10,1)) AS completion_pct, CAST(TRIM(is_completed) AS UNSIGNED) AS is_completed,
       NULLIF(TRIM(rating_given),'') AS rating_given
FROM raw_watch_events AS r
GROUP BY r.event_id, r.user_id, r.movie_id, r.date_id, r.device_type, r.watch_minutes, r.completion_pct, r.is_completed, r.rating_given;

