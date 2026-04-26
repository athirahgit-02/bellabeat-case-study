# Consumer Behavioral Analysis (Bellabeat/FitBit Dataset)
Data analysis on FitBit fitness tracker data using SQL (BigQuery) and Google Data Studio.

### By Nurul Athirah

## 1. Ask phase

### Business Task
To gain insight into how users are using fitness smart devices to help guide Bellabeat's marketing strategy.

### Stakeholder
Urška Sršen: Co-founder & Chief Creative Officer  
Sando Mur: Co-founder & Executive Team Member  
Marketing Analytics Team: Primary user of data to get marketing insight

### SMART Question
What is the average daily step count, and how does this physical exertion impact sleep quality for fitness tracker users within a 31-day period, and how can Bellabeat use this data to promote better lifestyle habits through the Bellabeat app?

## 2. Prepare phase

### Data source  
'Fitbit Fitness Tracker Data' is used, which was available on Kaggle by Mobius. This dataset contains personal fitness tracker data from 31 FitBit users.

### ROCCC Analysis  
Reliable: Low due to small sample size (31 users)  
Original: Low as data is obtained from a third-party survey (Amazon Mechanical Turk)  
Comprehensive: Medium due to lack of demographic data (age/gender)  
Current: Low. Data is from 2016 and may be irrelevant for the present times  
Cited: High as data is well-documented in Kaggle and is publicly available (public domain CC0)

### Data Organization  
The data is stored in 18 CSV files. For this analysis, I will be focusing on:
1. dailySteps_merged
2. sleepDay_merged

## 3. Process phase  

### Tools  
Excel: Initial data upload and schema verification  
SQL (BigQuery): Data cleaning, transformation, and merging  
Google Data Studio: Data visualisation

### Data cleaning & transformation  
To prepare the data for further analysis, I performed the following steps:  
1. Format Standardization: Converted date columns from String to Date for time-based data
2. Duplicate removal: Identified 3 duplicate entries in the `sleepDay` table and removed them
3. Null removal: Removed 0 entries in the `dailySteps` table
4. Data Merging: Joined `cleaned_step` and `cleaned_sleep` tables on `Id` and `Date` to create a dataset for further correlation analysis

### Troubleshooting  
Challenge: Encountered a parsing error when uploading sleepDay_merged.csv due to non-ISO date formatting (MM/DD/YYYY AM/PM)  
Resolution: Manually defined the schema as STRING during upload to bypass auto-detection errors, followed by PARSE_TIMESTAMP in SQL to standardize the data for analysis.

### View the full cleaning logic here: [Data Cleaning](./scripts/cleaning_data.sql) 

## 4. Analyze phase  
 
In this phase, I used SQL to create new metrics that would reveal the relationship between physical exertion and restorative sleep.

### Query shows:  
1. Activity Tier: Used a `CASE` statement to bucket users into three tiers: Sedentary, Active, and Highly Active. <br> Finding: Users in the Active Tier (5k - 10k steps) achieved the most stable balance of high activity and high sleep efficiency.

4. Weekly trend: I implemented a custom DayNumSort using a `CASE` statement to force a Monday-start (Mon=1, Sun=7). <br> Finding: This revealed that while Sunday has the highest TotalTimeInBed, it consistently shows the lowest SleepEfficiency. This suggests that users are attempting to "repay" sleep debt, but with low-quality results.

5. Sleep Efficiency: I used the `SAFE_DIVIDE` function to calculate sleep efficiency, defined as the ratio of actual restorative sleep to the total time spent in bed. <br> Finding: Users who are in the Active Tier (5k - 10k steps) enjoy higher-quality, more efficient sleep.

### View full analysis here: [Data Analysis](./scripts/analysis_data.sql)  

## 5. Share phase  

In the final phase of this project, I translated technical findings into an interactive business dashboard. The goal was to provide Bellabeat executives with a diagnostic tool to understand user behavior and drive marketing strategy.   

### Key Data Insight:  
  
1. [The Activity Tier](./visuals/activity_tier.png) 
Chart: Bar chart of MinutesAwakeinBed based on ActivityTier (Sedentary, Active and Highly Active) <br> Insight: The Highly Active tier (>10k steps) shows a spike in restlessness (Minutes Awake). This indicates that extreme physical exertion might cause stress that interferes with staying asleep.

2. [Weekly Trend](./visuals/weekly_trend.png)
Chart: A dual-axis line chart comparing StepTotal against SleepEfficiency across the week <br> Insight: Though Saturday shows the highest StepTotal, users spend more TotalTimeInBed with higher Minutes Awake (restlessness) on Sunday to recover, leading to the lowest SleepEfficiency of the week.

3. [Optimum Range](./visuals/optimum_range.png)
Chart: A scatter plot showing StepTotal against SleepEfficiency. <br> Insight: An Optimal Range between 5000 steps and 10,000 steps (Active Tier) can be identified. While users in this range maintain sleep efficiency, users who took more than 10,000 steps show diminishing returns.

### View the interactive dashboard here: [![Bellabeat Dashboard](./visuals/bellabeat_dashboard.png)](https://datastudio.google.com/reporting/7293fea3-546d-42a9-98e6-ead61a90cf50)  

*Click the dashboard image above to explore the interactive version in Data Studio.*

## 6. Act phase  

Based on the analysis of user behavior trends, I have developed the following data-driven recommendations for the Bellabeat marketing and product teams:  

1. Targeted Recovery for "Highly Active" Users <br> Problem: Users in the 'Highly Active' tier show significantly higher wakefulness during the night, indicating that over-exertion leads to interrupted sleep. <br> Action: Implement an app notification that triggers when a user exceeds their 7-day step average by 25% and suggests a cool-down routine to help protect sleep efficiency.

3. Introduce 'Restorative Sundays' <br> Problem: Data reveals low SleepEfficiency on Sundays following high-activity Saturdays (>10k steps). <br> Action: Launch "Restorative Sundays" feature. Instead of encouraging "sleeping in," the app should push low-impact recovery activities (yoga, meditation) to lower cortisol levels before the work week begins.

5. Optimized Goal Settings <br> Problem: Users are focused on hitting 10,000 steps, often at the expense of their sleep quality (especially on high-exertion days). <br> Action: Switch marketing from 'Volume' to 'Quality' to achieve a "Wellness Sweet Spot." Instead of a hard 10k goal, implement a dynamic target range (e.g., 7k – 10k steps) that promotes the highest sleep efficiency.

------
### 📧 Let's Connect!
I am an **Aspiring Data Analyst** with a background in **R&D Engineering**, specializing in turning complex technical measurements into actionable business insights.

* **LinkedIn:** [linkedin.com/in/athirah-asri](https://www.linkedin.com/in/athirah-asri/)
* **Email:** athirahasri02@gmail.com
* **Portfolio Home:** [github.com/athirahgit-02](https://github.com/athirahgit-02)
