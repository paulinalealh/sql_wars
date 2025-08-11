-- Data Cleaning 

SELECT *
FROM world_wars; 

CREATE TABLE wars
LIKE world_wars; 

SELECT *
FROM wars; 

INSERT INTO wars
SELECT *
FROM world_wars;

#Renaming columns 

ALTER TABLE wars
RENAME COLUMN `War or conflicts` TO war;

ALTER TABLE wars
RENAME COLUMN `Start Date` TO start_date;

ALTER TABLE wars
RENAME COLUMN `End Date` TO end_date;

ALTER TABLE wars
RENAME COLUMN Duration TO duration;

SELECT *
FROM wars; 

#Removing duplicates 
WITH dup_cte AS(
	SELECT *,
	ROW_NUMBER() OVER(
		PARTITION BY war, start_date, end_date, duration) AS row_num
		FROM wars
)
SELECT *
FROM dup_cte
WHERE row_num > 1;

#No duplicates
#Standardizing Data

SELECT *
FROM wars;

SELECT *
FROM wars
WHERE war LIKE '%â€“%';

UPDATE wars
SET war = REPLACE(war, 'â€“', '-');

UPDATE wars
SET war = REPLACE(war, 'PetÃ©n', 'Petén');

UPDATE wars
SET war = REPLACE(war, 'AraucanÃ­a', 'Araucanía');

SELECT *
FROM wars
WHERE war LIKE '%(%)%'; 

UPDATE wars 
SET war = REPLACE(war, 'Years of Lead (Italy)', 'Years of Lead - Italy');

SELECT *
FROM wars; 

UPDATE wars
SET war = REGEXP_REPLACE(war, ' *\\([^)]*\\)', '');

SELECT *
FROM wars
WHERE war REGEXP '[0-9]';

UPDATE wars 
SET war = REPLACE(war,'Byzantine-Sasanian War of 572-591', 'Byzantine-Sasanian War');

UPDATE wars 
SET war = REPLACE(war,'Sino-Vietnamese conflicts 1979-1990', 'Sino-Vietnamese conflicts');

SELECT * 
FROM wars; 

SELECT * 
FROM wars
WHERE start_date LIKE '%BC%'; 

DELETE FROM wars
WHERE start_date LIKE '%BC%';

SELECT *
FROM wars
WHERE end_date LIKE '%*Ongoing*%';

UPDATE wars
SET end_date = NULL
WHERE end_date LIKE '%*Ongoing*%';

SELECT *
FROM wars;

SELECT *
FROM wars
WHERE start_date LIKE 'June 827'; 

UPDATE wars
SET start_date = REPLACE (start_date, 'June 827', '01/06/827');

SELECT * 
FROM WARS 
WHERE start_date LIKE '%May 1991%';

UPDATE wars
SET start_date = REPLACE (start_date, 'May 1991[nb 1]', '01/05/1991');

SELECT * 
FROM wars
WHERE start_date LIKE '01/05/1991'
OR start_date LIKE '01/06/827'; 

SELECT *
FROM wars
WHERE start_date NOT LIKE '%/%/%';

UPDATE wars
SET start_date = STR_TO_DATE(start_date, '%m/%d/%Y')
WHERE start_date IS NOT NULL;

SELECT * 
FROM wars; 

SELECT *
FROM wars
WHERE end_date NOT LIKE '%/%/%';

UPDATE wars
SET end_date = '08/01/902'
WHERE end_date = 'August 902';

UPDATE wars
SET end_date = '01/19/1826'
WHERE end_date = '1821 or 1826';

UPDATE wars
SET end_date = NULL
WHERE end_date = 'Ongoing';

SELECT * 
FROM wars; 

UPDATE wars
SET end_date = STR_TO_DATE(end_date, '%m/%d/%Y')
WHERE end_date IS NOT NULL;

SHOW COLUMNS 
FROM wars; 

ALTER TABLE wars MODIFY start_date DATE;
ALTER TABLE wars MODIFY end_date DATE;

SELECT *
FROM wars;

SELECT *, DATEDIFF(end_date, start_date) AS duration_days,
  ROUND(DATEDIFF(end_date, start_date) / 365.25, 1) AS duration_years
FROM wars; 

ALTER TABLE wars
ADD COLUMN duration_days INT,
ADD COLUMN duration_years DECIMAL(5,2);

UPDATE wars
SET 
  duration_days = DATEDIFF(end_date, start_date),
  duration_years = ROUND(DATEDIFF(end_date, start_date) / 365.25, 2);

SELECT *
FROM wars;

ALTER TABLE wars
DROP COLUMN duration; 

#Adding an index, just in case
ALTER TABLE wars
ADD COLUMN id INT NOT NULL AUTO_INCREMENT PRIMARY KEY FIRST;

SELECT *
FROM wars; 

ALTER TABLE wars
ADD COLUMN days INT;

SELECT duration_days, duration_years, (duration_years- FLOOR(duration_years)) AS decimal_part
FROM wars; 

SELECT duration_days, duration_years, ROUND(((duration_years- FLOOR(duration_years))*365.25),0) AS days
FROM wars; 

SELECT *
FROM wars; 

UPDATE wars
SET days = ROUND(((duration_years- FLOOR(duration_years))*365.25),0)
WHERE days IS NULL; 

UPDATE wars
SET duration_years = FLOOR(duration_years)
WHERE duration_years IS NOT NULL; 

SELECT *
FROM wars;

ALTER TABLE wars MODIFY duration_years INT;

ALTER TABLE wars
RENAME COLUMN duration_years TO years;

ALTER TABLE wars
RENAME COLUMN duration_days TO total_days;

SELECT *
FROM wars;







 








