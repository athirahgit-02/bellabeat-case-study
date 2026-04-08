/* 
Project: Bellabeat Fitness Data Analysis  
Process: Data cleaning, Type Conversion & Table Joining  
Author: Athirah Asri  
Date: April 2026  
*/

-- Step 1: Schema Standarization 
CREATE OR REPLACE TABLE `bellabeat_data.cleaned_step` AS
SELECT 
    CAST(Id AS STRING) AS Id, -- Ensure ID is a String
    ActivityDay AS ActivityDate,
    StepTotal
FROM `bellabeat_data.daily_step_raw`;

CREATE OR REPLACE TABLE `bellabeat_data.cleaned_sleep` AS
SELECT 
    Id,
    -- Converting the messy string into a clean DATE
    EXTRACT(DATE FROM PARSE_TIMESTAMP('%m/%d/%Y %I:%M:%S %p', SleepDay)) AS SleepDate,
    TotalMinutesAsleep,
    TotalTimeInBed
FROM `bellabeat_data.sleep_day_raw`;

-- Step 2: Checking and removing Null
SELECT 
  StepTotal,
  COUNT(*) as frequency
FROM `bellabeat_data.cleaned_step`
WHERE StepTotal < 100 -- Looking for very low values
GROUP BY StepTotal
ORDER BY StepTotal ASC;

SELECT 
    COUNT(*) AS total_logged_days,
    COUNTIF(StepTotal = 0) AS zero_step_days,
    ROUND((COUNTIF(StepTotal = 0) / COUNT(*)) * 100, 2) AS percent_of_data_as_zero
FROM `bellabeat_data.cleaned_step`;

CREATE VIEW `bellabeat_data.v_cleaned_step` AS
SELECT *
FROM `bellabeat_data.cleaned_step`
WHERE StepTotal > 0; -- Removing the 8% non-wear noise

SELECT 
    COUNTIF(TotalMinutesAsleep = 0) AS zero_sleep_days,
FROM `bellabeat_data.cleaned_sleep`;

-- Step 2: Checking for duplicate entries
SELECT
    Id, 
    ActivityDate, 
    StepTotal, 
    COUNT(*) as duplicate_count
FROM `bellabeat_data.cleaned_step`
GROUP BY Id, ActivityDate, StepTotal
HAVING COUNT(*) > 1;

SELECT
    Id, 
    SleepDate, 
    TotalMinutesAsleep, 
    COUNT(*) as duplicate_count
FROM `bellabeat_data.cleaned_sleep`
GROUP BY Id, SleepDate, TotalMinutesAsleep
HAVING COUNT(*) > 1;

CREATE VIEW `bellabeat_data.v_cleaned_sleep` AS
SELECT DISTINCT *  -- Removing 3 duplicate entries 
FROM `bellabeat_data.cleaned_sleep`;

-- Step 4: Joining both cleaned tables
CREATE OR REPLACE TABLE `bellabeat_data.combined_step_sleep` AS
SELECT 
    A.Id,
    A.ActivityDate,
    A.StepTotal,
    S.TotalMinutesAsleep,
    S.TotalTimeInBed,
    -- Custom Metric: Minutes spent awake in bed (Toss & Turn time)
    (S.TotalTimeInBed - S.TotalMinutesAsleep) AS MinutesAwakeInBed
FROM `bellabeat_data.v_cleaned_step` AS A
INNER JOIN `bellabeat_data.v.cleaned_sleep` AS S
    ON A.Id = S.Id 
    AND A.ActivityDate = S.SleepDate;
