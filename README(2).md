# Netflix Analytics — MySQL & Power BI

## Project Overview

An end-to-end analytics project using a synthetic Netflix-style dataset. The project demonstrates how raw data can be loaded into MySQL, cleaned and transformed using SQL, structured into analytical tables, and then visualized through an interactive Power BI dashboard.

## Project Pipeline

**Raw Data → MySQL Staging → SQL Cleaning & Transformation → Analytical Tables → Power BI Dashboard**

## Dataset

The dataset is **synthetic Netflix-style data created for portfolio/educational purposes**. It contains interconnected data covering:

- Users
- Titles / movies
- Subscription plans
- Subscriptions
- Payments
- Watch events
- Dates
- Cohort retention

The data is designed to simulate a streaming-platform analytics environment.

## Technologies Used

- **MySQL** — data loading, cleaning, transformation, and analytical table creation
- **SQL** — data standardization, type conversion, duplicate handling, derived fields, and cohort analysis
- **Power BI** — interactive dashboard and business analytics
- **CSV** — raw and processed data storage

## SQL Workflow

### 1. Database & Schema Setup

`01_schema.sql` creates the `netflix_analytics` database and the required raw and analytical tables.

### 2. Raw Data Loading

`02_load_raw.sql` loads the synthetic raw records into MySQL staging tables.

### 3. Data Cleaning & Transformation

`03_clean.sql` transforms the raw staging data into analytical tables.

The SQL pipeline includes operations such as:

- Trimming and standardizing text fields
- Converting data types
- Parsing inconsistent date formats
- Handling missing values
- Removing duplicate records
- Standardizing categorical values
- Creating derived analytical fields
- Structuring fact and dimension tables

### 4. Cohort Retention Analysis

`04_cohort_retention.sql` creates a cohort-retention matrix to analyze user retention over time.

## Data Model

The cleaned MySQL layer contains:

### Dimension Tables
- `dim_users`
- `dim_titles`
- `dim_plans`
- `dim_date`

### Fact Tables
- `fact_watch_events`
- `fact_subscriptions`
- `fact_payments`

### Analytical Table
- `cohort_retention_matrix`

This structure separates descriptive entities from transactional/event data and makes the data suitable for downstream BI analysis.

## Power BI Dashboard

The processed datasets are used to build an interactive Power BI dashboard for analyzing areas such as:

- User and viewer behavior
- Content performance
- Subscription trends
- Payment activity
- Engagement
- Customer retention
- Cohort performance

The dashboard is designed to turn the cleaned analytical data into business-oriented insights rather than simply displaying raw records.

## Repository Structure

```text
Netflix-Analytics-SQL-PowerBI/
│
├── README.md
│
├── SQL/
│   ├── 01_schema.sql
│   ├── 02_load_raw.sql
│   ├── 03_clean.sql
│   └── 04_cohort_retention.sql
│
├── Data/
│   ├── raw/
│   └── cleaned/
│
└── PowerBI/
    └── Netflix_Analytics.pbix
```

## How to Run

1. Open MySQL Workbench.
2. Run `01_schema.sql`.
3. Run `02_load_raw.sql`.
4. Run `03_clean.sql`.
5. Run `04_cohort_retention.sql`.
6. Use the cleaned analytical datasets for Power BI analysis.

## Key Learning Outcomes

This project demonstrates practical experience with:

- Relational data modeling
- SQL-based data cleaning
- Data transformation
- Fact and dimension table design
- Analytical SQL
- Cohort retention analysis
- Preparing data for BI tools
- Power BI dashboard development

## Note

This is a portfolio/educational project using synthetic data. It is not affiliated with Netflix and does not use Netflix's proprietary data.
