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


