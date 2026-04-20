# Bellabeat Case Study
Data analysis case study on FitBit fitness tracker data using SQL, Python, and Tableu

## 1. Ask phase

### Business Task
To gain insight into how customers are using smart devices to help guide Bellabeat's marketing strategy

### Stakeholder
Urška Sršen: Co-founder & Chief Creative Officer  
Sando Mur: Co-founder & Executive Team Member  
Marketing Analytics Team: Primary user of data to get marketing insight

### SMART Question
What is the average daily step count and hour of sleep for smart device user within 31 day period and how Bellabeat can use this data to promote better lifestyle habit through Bellabeat app?

## 2. Prepare phase

### Data source  
'Fitbit Fitness Tracker Data' are used, which was available on Kaggle by Mobius. This dataset contain personal fitness tracker data from thirty fitbit users.

### ROCCC Analysis  
Reliable: Low due to small sample size (30 users)  
Original: Low as data is obtained from third party survey (Amazon Mechanical Turk)  
Comprehensive: Medium due to lack demographic data (age/gender)  
Current: Low. Data is from 2016 and may be unrelevant for present times  
Cited: High as data is well-documented in Kaggle and is publicly available (public domain CC0)

### Data Organization  
The data is stored in 18 CSV files. For this analysis, I will be focusing on:
1. dailySteps_merged
2. sleepDay_merged

## 3. Process phase  

### Tools  
SQL (BigQuery): Data cleaning, transformation and merging  
Excel: Initial data upload and schema verification  

### Data cleaning & transformation  
To prepare the data for further analysis, I performed the following steps:  
1. Format Standardization: Converted date columns from String to Date for time-based data
2. Duplicate removal: Identified 3 suplicate entries in `sleepDay` table and removed them
3. Null removal: Removed 0 entry in `dailySteps` table
4. Data Merging: Joined `cleaned_step` and `cleaned_sleep` tables on `Id` and `Date` to create dataset for further correlation analysis

### Troubleshooting  
Challenge: Encountered a parsing error when uploading sleepDay_merged.csv due to non-ISO date formatting (MM/DD/YYYY AM/PM)  
Resolution: Manually defined the schema as STRING during upload to bypass auto-detection errors, followed by PARSE_TIMESTAMP in SQL to standardize the data for analysis.

#### View the full cleaning logic here [Data Cleaning](./scripts/cleaning_data.sql) 

## 4. Analyze phase  
 
In this phase, I used SQL to create new metrics that would reveal the relationship between physical exertion and restorative sleep.

#### Query shows:  
1. Activity Tier: Used a `CASE` statement to bucket users into three tiers: Sedentary, Active, and Highly Active.
Finding: I found that the users in the Active Tier (5k - 10k steps) achieved the most stable balance of high activity and high sleep efficiency.

2. Weekly trend: I implemented a custom DayNumSort using a `CASE` statement to force a Monday-start (Mon=1, Sun=7).
Finding: This revealed that while Sunday has the highest TotalTimeInBed, it consistently shows the lowest SleepEfficiency. This suggests that users are attempting to "repay" sleep debt, but with low-quality results.

3. Sleep Efficiency: I used the `SAFE_DIVIDE` function to calculate sleep efficiency which is the ratio of actual restorative sleep to the total time committed to being in bed.
Finding: Users that are in Active Tier (5k - 10k steps) enjoys more quality and efficient sleep.

#### View full analysis here [Data Analysis](./scripts/analysis_data.sql)  

## 5. Share phase  

In the final phase of this project, I translated technical findings into an interactive business dashboard. The goal was to provide Bellabeat executives with a diagnostic tool to understand user behavior and drive marketing strategy.  
  
#### [Link to Live Dashboard]  

### Key Data Insight:  
  
1. The Activity Tier
Chart: Bar chart of MinutesAwakeinBed based on ActivityTier (Sedentary, Active and Highly Active)
Insight: The Highly Active tier (>10k steps) shows a spike in restlessness (Minutes Awake). This indicates that extreme physical exertion might causes stress that interferes with staying asleep.

2. Weekly Trend
Chart: A dual-axis line chart comparing StepTotal against SleepEfficiency across the week
Insight: Though Saturday shows the highest StepTotal, users spend more TotalTimeInBed with higher Minutes Awake (restlessness) on Sunday to recover, leading to the lowest SleepEfficiency of the week.

3. Optimal Range
Chart: A scatter plot showing StepTotal against SleepEfficiency.
Insight: An Optimal Range between 5000 steps and 10,000 steps (Active Tier) can be identified. While users in this range maintain sleep efficiency, users that took more than 10,000 steps shows diminishing returns. 

## 6. Act phase  

Based on the analysis of user behavior trends, I have developed the following data-driven recommendations for the Bellabeat marketing and product teams:  

1. Shift the Narrative: From "Volume" to "Quality"
The Problem: Users are focused on hitting 10,000 steps, often at the expense of their sleep quality (especially on high-exertion days).

The Act: Update the Bellabeat app to emphasize a "Wellness Sweet Spot." Instead of a hard 10k goal, implement a dynamic target range (e.g., 7.5k–10.5k steps) that promotes the highest sleep efficiency.

2. Solve the "Sunday Paradox"
The Problem: Data reveals that Sunday "catch-up" sleep is low-quality and high-restlessness.

The Act: Launch a "Sunday Wind-Down" feature. The app should send personalized notifications on Sunday evenings encouraging a consistent bedtime and a 30-minute digital detox, rather than allowing users to rely on sleeping in late Monday morning.

3. Targeted Recovery for "Highly Active" Users
The Problem: Users in the 'Highly Active' tier (12k+ steps) show significantly higher wakefulness during the night.

The Act: Implement an Automatic Recovery Trigger. When the app detects a 20% spike over a user’s average daily activity, it should suggest "Active Recovery" content, such as guided stretching or magnesium-focused nutrition tips, to reduce physiological stress before bed.

4. Marketing Re-Positioning
The Problem: There is a clear gap in user knowledge regarding how sedentary days impact sleep latency.

The Act: Create a content marketing campaign titled "The Movement-Sleep Connection." Use the dashboard insights to show potential customers how Bellabeat products don't just track steps—they help you "Unlock Better Rest."
