# Netflix Content & Viewer Analytics Dashboard

An interactive Power BI dashboard built to analyze Netflix-style content, viewer behavior, engagement, subscriptions, and user demographics.

## 📊 Project Overview

This project transforms streaming data into an interactive analytics dashboard using Microsoft Power BI.

The dashboard provides insights into:
- User demographics and geographic distribution
- Viewer engagement and watch activity
- Subscription plans and subscription behavior
- Content performance
- Payment and revenue-related metrics
- User acquisition and engagement segments
- Cohort-based user retention

## 🛠️ Tech Stack

- **Power BI** – Data modeling, DAX measures, visualizations and dashboard development
- **Power Query** – Data cleaning and transformation
- **CSV Dataset** – Source data

## 📈 Dashboard Features

### User Analytics
- Total Users
- User distribution by country
- Age and age-group analysis
- Gender distribution
- Acquisition channel analysis
- Engagement segmentation

### Content Analytics
- Content performance
- Title-level viewing analysis
- Genre/content trends
- Viewer engagement patterns

### Subscription & Payment Analytics
- Subscription plan distribution
- Subscription trends
- Payment analysis
- Revenue-related KPIs

### Retention & Cohort Analysis
- Signup cohort analysis
- Cohort-based retention
- User activity across subsequent periods
- Retention patterns across different signup cohorts

## 🔄 Data Preparation

The raw CSV data was cleaned and transformed using Power Query before being used in the Power BI data model.

Key preparation steps included:
- Data type standardization
- Handling missing values
- Creating analytical columns
- Preparing date and cohort fields
- Structuring tables for dashboard analysis

## 📐 Data Modeling

The project uses a relational Power BI data model consisting of dimension and fact-style tables for users, titles, plans, dates, subscriptions, payments and watch events.

Relationships between the tables enable cross-filtering and interactive analysis across dashboard pages.

## 💡 Key Business Questions

The dashboard is designed to answer questions such as:

- How many users are actively engaging with the platform?
- Which countries and demographics contribute the most users?
- Which acquisition channels perform best?
- Which subscription plans are most popular?
- Which content attracts the highest engagement?
- How does viewer engagement vary across user segments?
- How well are users retained after signup?
- Which signup cohorts demonstrate stronger retention?

## 🎯 Skills Demonstrated

- Power BI Dashboard Development
- Power Query / Data Transformation
- Data Modeling
- DAX
- KPI Development
- Cohort & Retention Analysis
- Interactive Data Visualization
- Business Analytics

## 📁 Project Structure

```text
Netflix-Content-Viewer-Analytics/
│
├── Netflix_Content_Viewer_Analytics.pbix
├── README.md
└── data/
    └── CSV datasets
```

## 🚀 Future Improvements

- Add more advanced retention metrics
- Introduce predictive churn analysis
- Add automated data refresh
- Expand content recommendation analysis
- Incorporate additional streaming KPIs
