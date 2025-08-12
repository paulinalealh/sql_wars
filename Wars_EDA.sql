-- Data Analysis 

SELECT *
FROM wars;

#Longest war: Serbian Ottoman Conflicts with 204747 days
WITH max_duration AS(
	SELECT MAX(total_days) AS max_days
	FROM wars
	WHERE total_days IS NOT NULL
)
SELECT war, total_days
FROM wars, max_duration
WHERE wars.total_days = max_duration.max_days
LIMIT 1; 

#Average war duration: 5593 days 
SELECT AVG(total_days)
FROM wars; 

#Most common year for war initiation: 1904
SELECT YEAR(start_date) AS war_year,
       COUNT(*) AS count_wy
FROM wars
GROUP BY war_year
ORDER BY count_wy DESC
LIMIT 1;

#Earliest wars (month, day) according to the list: 
SELECT war, MONTH(start_date) AS m, DAY(start_date) AS d
FROM wars
ORDER BY m,d ASC
LIMIT 5; 

#Selecting most recent ongoing war
SELECT war, start_date, end_date
FROM wars
WHERE end_date IS NULL
ORDER BY start_date DESC
LIMIT 1;

#Selecting war(s) where both dates are all odd numbers 
SELECT *
FROM wars
WHERE YEAR(start_date) % 2 = 1
	AND MONTH(start_date) % 2 = 1
    AND DAY(start_date) % 2 = 1
    AND YEAR(end_date) % 2 = 1
    AND MONTH(end_date) % 2 = 1
    AND DAY(end_date) % 2 = 1;
    
#Odrering wars by start_date, then alphabetically
SELECT *
FROM wars
ORDER BY start_date, war;

#Least amount of days a war has lasted: 11, Dano-Swedish War
WITH min_duration AS(
	SELECT MIN(total_days) AS min_days
	FROM wars
	WHERE total_days IS NOT NULL
)
SELECT war, total_days
FROM wars, min_duration
WHERE wars.total_days = min_duration.min_days
LIMIT 1; 

#Counting wars by starting month and relationship with ending month
WITH month_extraction AS(
	SELECT MONTH(start_date) AS m_s , MONTH(end_date) AS m_e 
	FROM wars
)
SELECT
	m_s AS month, 
    COUNT(*) AS wars_started, 
    SUM(m_e = m_s) AS same_month_end
FROM month_extraction
GROUP BY m_s
ORDER BY month ASC;



 