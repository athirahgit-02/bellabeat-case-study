/* PROJECT: Bellabeat Case Study
PHASE: Exploratory Data Analysis (EDA)
PURPOSE: Identifying correlations between physical activity, sleep efficiency, and weekly trends.
*/  

CREATE VIEW `bellabeat_data.v_bellabeat_master_analysis` AS
SELECT 
    Id,
    ActivityDate,
    StepTotal,
    TotalMinutesAsleep,
    TotalTimeInBed,
    MinutesAwakeInBed,
    
    -- 1. Logic (For Activity Tier Insight)
    CASE 
      WHEN StepTotal < 5000 THEN '1. Sedentary (<5k steps)'
      WHEN StepTotal BETWEEN 5000 AND 10000 THEN '2. Active (5k - 10k steps)'
      WHEN StepTotal > 10000 THEN '3. Highly Active (>10k steps)'
    END AS ActivityTier,

    -- 2. Calculations (For Efficiency and Awake Insights)
    SAFE_DIVIDE(TotalMinutesAsleep, TotalTimeInBed) AS SleepEfficiency,

    -- 3. Temporal Logic (Monday-Start Index)
    FORMAT_DATE('%A', ActivityDate) AS DayOfWeek,
    CASE 
      WHEN FORMAT_DATE('%w', ActivityDate) = '0' THEN 7 
      ELSE CAST(FORMAT_DATE('%w', ActivityDate) AS INT64) 
    END AS DayNumSort -- Mon=1, Tue=2 ... Sun=7 
FROM `bellabeat_data.combined_step_sleep`
