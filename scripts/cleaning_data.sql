/* 
Project: Bellabeat Fitness Data Analysis  
Process: Data cleaning, Type Conversion & Table Joining  
Author: Athirah Asri  
Date: April 2026  
*/

-- Step 2: Checking for duplicate and remove them from daily_steps and sleep_day
SELECT -- Checking duplicate for daily_steps
    Id, 
    ActivityDay, 
    StepTotal, 
    COUNT(*) as duplicate_count
FROM `bellabeat_data.daily_steps_raw`
GROUP BY Id, ActivityDay, StepTotal
HAVING COUNT(*) > 1;

SELECT -- Checking duplicate for sleep_day
    Id, 
    SleepDay, 
    TotalMinutesAsleep, 
    COUNT(*) as duplicate_count
FROM `bellabeat_data.sleep_day_raw`
GROUP BY Id, SleepDay, TotalMinutesAsleep
HAVING COUNT(*) > 1;

CREATE OR REPLACE TABLE `bellabeat_data.cleaned_sleep` AS -- New table with removed duplicate from sleep_day
SELECT DISTINCT *
FROM `bellabeat_data.sleep_day_raw`;

-- Step 3: Checking and removing Null
SELECT 
  StepTotal,
  COUNT(*) as frequency
FROM `bellabeat_data.daily_steps_raw`
WHERE StepTotal < 100 -- Looking for very low values
GROUP BY StepTotal
ORDER BY StepTotal ASC;

SELECT 
    COUNT(*) AS total_logged_days,
    COUNTIF(StepTotal = 0) AS zero_step_days,
    ROUND((COUNTIF(StepTotal = 0) / COUNT(*)) * 100, 2) AS percent_of_data_as_zero
FROM `bellabeat_data.daily_steps_raw`;

CREATE OR REPLACE TABLE `bellabeat_data.cleaned_step` AS
SELECT *
FROM `bellabeat_data.daily_steps_raw`
WHERE StepTotal > 0; -- Removing the 8% non-wear noise

SELECT 
    COUNTIF(TotalMinutesAsleep = 0) AS zero_sleep_days,
FROM `bellabeat_data.sleep_day_raw`;
