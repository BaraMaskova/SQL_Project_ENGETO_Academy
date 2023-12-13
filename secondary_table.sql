CREATE OR REPLACE TABLE t_barbora_maskova_project_sql_secondary_final AS
SELECT
	c.country ,
	e.`year` ,
	e.population,
	e.gini ,
	e.GDP
FROM countries c
JOIN economies e
	on c.country = e.country
	WHERE 1=1
		AND c.continent = 'Europe'
		AND e.`year` BETWEEN 2006 AND 2018
ORDER BY c.`country`, e.`year`;

SELECT * FROM t_barbora_maskova_project_SQL_secondary_final
WHERE country = 'Czech Republic';