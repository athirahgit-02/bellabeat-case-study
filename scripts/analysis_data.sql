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
Potential Recommendation: Implement a dynamic "Cooldown" notification (eg. recommending guided breathing to lower heart rate)
*/  

-- =========================================================================
-- Insight 2: Weekly Usage Pattern
-- Purpose: Determine which days users are most active vs. most rested.
-- =========================================================================

SELECT 
    FORMAT_DATE('%A', ActivityDate) AS day_of_week,
    EXTRACT(DAYOFWEEK FROM ActivityDate) AS day_num,
    ROUND(AVG(StepTotal), 0) AS avg_steps,
    ROUND(AVG(TotalMinutesAsleep), 0) AS avg_minutes_asleep
FROM `bellabeat_data.combined_step_sleep`
GROUP BY day_of_week, day_num 
ORDER BY day_num;

/* Observation: Saturday peaks in activity, Sunday peaks in sleep. 
Potential Recommendation: Market "Sunday Reset" notifications to encourage recovery (eg. suggesting low impact activities)
*/  

-- ====================================================================================
-- Insight 3: Activity Threshold  
-- Purpose: Identify the 'Optimal Range' where steps maximize sleep efficiency.  
-- ====================================================================================  

SELECT 
    CASE 
        WHEN StepTotal < 5000 THEN '1. Under-Active'
        WHEN StepTotal BETWEEN 5000 AND 8000 THEN '2. Moderate (Sweet Spot)'
        WHEN StepTotal BETWEEN 8001 AND 12000 THEN '3. High Activity'
        ELSE '4. Extreme Activity'
    END AS activity_level,
    ROUND(AVG((TotalMinutesAsleep / TotalTimeInBed) * 100), 2) AS avg_efficiency_pct,
    ROUND(AVG(TotalMinutesAsleep), 0) AS avg_minutes_asleep
FROM `bellabeat_data.combined_step_sleep`
GROUP BY activity_level
ORDER BY activity_level;

/* Observation: Users in the 'Moderate' zone (5k-8k steps) show the highest efficiency. 
Once users cross the 10k-12k threshold, efficiency drops and wakefulness increases.
Potential Recommendation: Pivoting from a 'More is Better' messaging strategy to an 'Optimal Balance' strategy (warning users when they might be pushing into the 
'Over-Stimulation Zone' that compromises recovery.
*/  
