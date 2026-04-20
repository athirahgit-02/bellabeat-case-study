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

### Goal  
To identify trends in Fitbit user behavior and determine the optimal balance between physical activity and restorative sleep  

#### Insight 1  
Hypothesis: Does reaching "Highly Active" tier (10k+ steps) lead to better sleep quality?  
Finding: Users in the highest activity tier recorded the highest Minutes Awake and a noticeable drop in Sleep Efficiency %  
Explaination: Extreme physical output without proper "wind-down" periods appears to cause feeling restlessness  

#### Insight 2  
Hypothesis: How does behavior shift across a standard 7-day week?  
Finding: Saturday is the peak day for activity (highest step count), while Sunday consistently shows the highest duration of sleep  
Explaination: The body compensates for Saturday's high-intensity output with a restorative "Sunday Reset  

#### Insight 3  
Hypothesis: Is there a perfect balance for activity that allows for maximum sleep quality?  
Finding: 'Optimal Range' for activity lies between 5000 and 8000 steps  
Explaination: Within this range, users achieved their highest sleep efficiency scores. Beyond this threshold, efficiency drops as wakefulness begins to increase  

#### View full analysis here [Data Analysis](./scripts/analysis_data.sql)  

## 5. Share phase  

In the final phase of this project, I translated technical findings into an interactive business dashboard. The goal was to provide Bellabeat executives with a diagnostic tool to understand user behavior and drive marketing strategy.  

### Interactive Dashboard  
The final dashboard was designed with a "Narrative Sidebar" to provide context alongside the visual evidence. It includes dynamic filters for User ID and Date Ranges, allowing for both macro-trends and individual-persona deep dives.  
#### [Link to Live Dashboard]  

### Key Data Insight  
During the sharing phase, I focused on three primary "Stories" discovered in the data:  
1. The High-Exertion Friction:
Data: 'Highly Active' users ( >12k steps) see a 15% spike in nighttime wakefulness.
Message: Our most active customers are at the highest risk for poor sleep, creating a niche for recovery-focused premium content

2. Sunday Reset:
Data: Sunday has the highest 'Time in Bed' but the lowest 'Sleep Efficiency
Message: More sleep volume $\neq$ Higher sleep quality. This identifies a business opportunity to market "Weekend Consistency" features.

3. Optimum Range: 
Data: A cluster analysis shows peak sleep performance between 7.5k and 10.5k steps.
Message: Generic "10,000 Step" goal may be counterproductive for sleep-focused users. We should pivot toward personalized performance ranges.

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
