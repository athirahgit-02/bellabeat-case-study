/* PROJECT: Bellabeat User Behavior Analysis
PHASE: Exploratory Data Analysis (EDA)
PURPOSE: Identifying correlations between physical activity, sleep efficiency, and weekly trends.
*/  

-- Insight 1: The Activity-Sleep Correlation  
-- Hypothesis: Users with higher daily steps achieve longer sleep duration.  

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
