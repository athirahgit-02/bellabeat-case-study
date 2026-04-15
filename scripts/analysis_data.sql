/* PROJECT: Bellabeat Case Study
PHASE: Exploratory Data Analysis (EDA)
PURPOSE: Identifying correlations between physical activity, sleep efficiency, and weekly trends.
*/  

-- ====================================================================================
-- Insight 1: The Activity-Sleep Correlation  
-- Hypothesis: Users with higher daily steps achieve longer sleep duration.  
-- ====================================================================================

SELECT 
    CASE 
        WHEN StepTotal < 5000 THEN 'Sedentary (<5k)'
        WHEN StepTotal BETWEEN 5000 AND 10000 THEN 'Active (5k-10k)'
        ELSE 'Highly Active (>10k)' 
    END AS activity_level,
    ROUND(AVG(TotalMinutesAsleep), 0) AS avg_minutes_asleep,
    ROUND(AVG(TotalTimeInBed - TotalMinutesAsleep), 0) AS avg_minutes_awake_in_bed,
    COUNT(*) AS sample_size
FROM `bellabeat_data.combined_step_sleep`
GROUP BY activity_level
ORDER BY avg_minutes_asleep DESC;  

/* Observation: Counter-intuitively, 'Highly Active' users show higher minutes awake in bed (avg_awake_mins). 
Potential Recommendation: Investigate 'over-training' alerts for high-step users. 
*/  

-- ====================================================================================
-- Insight 2: Sleep Effieciency  
-- Purpose: Identify the percentage of users falling below the 85% healthy sleep threshold  
-- ====================================================================================  

SELECT 
    Id,
    ROUND(AVG((TotalMinutesAsleep / TotalTimeInBed) * 100), 2) AS avg_efficiency_pct
FROM `bellabeat_data.combined_step_sleep`
GROUP BY Id
HAVING avg_efficiency_pct < 85
ORDER BY avg_efficiency_pct ASC;  

/* Observation: 2 users fall below 85% sleep efficiency. 
Potential Recommendation: Target this segment with breathing or meditation app features.
*/  

-- =========================================================================
-- Insight 3: Weekly Usage Pattern
-- Purpose: Determine which days users are most active vs. most rested.
-- =========================================================================

SELECT 
    FORMAT_DATE('%A', ActivityDate) AS day_of_week,
    EXTRACT(DAYOFWEEK FROM ActivityDate) AS day_num,
    ROUND(AVG(StepTotal), 0) AS avg_steps,
    ROUND(AVG(TotalMinutesAsleep), 0) AS avg_sleep
FROM `bellabeat_data.combined_step_sleep`
GROUP BY day_of_week, day_num
ORDER BY day_num;

/* Observation: Saturday peaks in activity, Sunday peaks in sleep. 
Potential Recommendation: Market "Sunday Reset" notifications to encourage recovery. 
*/
