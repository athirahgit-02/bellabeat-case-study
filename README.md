# bellabeat-case-study
Data analysis case study on FitBit fitness tracker data using SQL, Python, and Tableu

1. Ask phase

#Business Task
To gain insight into how customers are using smart devices to help guide Bellabeat's marketing strategy

#Stakeholder
Urška Sršen: Co-founder & Chief Creative Officer
Sando Mur: Co-founder & Executive Team Member
Marketing Analytics Team: Primary user of data to get marketing insight

#SMART Question
What is the average daily step count and hour of sleep for smart device user within 31 day period and how Bellabeat can use this data to promote better lifestyle habit through Bellabeat app?

2. Prepare phase

Data source: 'Fitbit Fitness Tracker Data' are used, which was available on Kaggle by Mobius. This dataset contain personal fitness tracker data from thirty fitbit users.

ROCCC Analysis
Reliable: Low due to small sample size (30 users)
Original: Low as data is obtained from third party survey (Amazon Mechanical Turk)
Comprehensive: Medium due to lack demographic data (age/gender)
Current: Low. Data is from 2016 and may be unrelevant for present times
Cited: High as data is well-documented in Kaggle and is publicly available (public domain CC0)

Data Organization
The data is stored in 18 CSV files. For this analysis, I will be focusing on:
1. dailySteps_merged
2. sleepDay_merged
