/*
 * Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?
 */
SELECT * FROM v_barbora_maskova_wages_growth_trend_by_sector_and_year;
SELECT * FROM v_barbora_maskova_food_price_trend;

-- Pohled: Průměrná mzda v letech 2006 - 2018 (průměr mzdy ze všech odvětví dohromady)
CREATE OR REPLACE VIEW v_barbora_maskova_avg_wages_2006_2018 AS
SELECT
	payroll_year,
	round(avg(average_wages)) AS average_wages
FROM t_barbora_maskova_project_sql_primary_final
GROUP BY payroll_year;

SELECT * FROM v_barbora_maskova_avg_wages_2006_2018;

-- Pohled: Trend vývoje růstu mezd v letech 2006 - 2018
CREATE OR REPLACE VIEW v_barbora_maskova_avg_wages_trend_diff_2006_2018 AS
WITH WagesTrend AS (
    SELECT
        payroll_year AS older_year,
        lead(payroll_year) OVER (ORDER BY payroll_year) AS newer_year,
        average_wages AS older_wages,
        lead(average_wages) OVER (ORDER BY payroll_year) AS newer_wages,
        round((lead(average_wages) OVER (ORDER BY payroll_year) - average_wages) / average_wages * 100, 1) AS avg_wages_diff_percentage
    FROM v_barbora_maskova_avg_wages_2006_2018
)
SELECT *
FROM WagesTrend
WHERE older_year <> newer_year;

SELECT * FROM v_barbora_maskova_avg_wages_trend_diff_2006_2018;

-- Pohled: Půměrné ceny potravin v letech 2006 - 2018
CREATE OR REPLACE VIEW v_barbora_maskova_avg_food_price_by_year AS
SELECT
	DISTINCT food_category,
	price_value AS value,
	price_unit AS unit,
	payroll_year AS `year`,
	average_price
FROM t_barbora_maskova_project_sql_primary_final
ORDER BY food_category;

SELECT * FROM v_barbora_maskova_avg_food_price_by_year;


-- Pohled: Půměrné ceny potravin v letech 2006 - 2018 (průměr ze všech kategorií dohromady)
CREATE OR REPLACE VIEW v_barbora_maskova_avg_food_price_2006_2018 AS
SELECT
	`year`,
	round(avg(average_price), 1) AS avg_food_price
FROM v_barbora_maskova_avg_food_price_by_year
GROUP BY `year`;

SELECT * FROM v_barbora_maskova_avg_food_price_2006_2018;


-- Pohled: Trend vývoje růstu cen potravin v letech 2006 - 2018
CREATE OR REPLACE VIEW v_barbora_maskova_avg_food_price_trend_diff_2006_2018 AS
WITH FoodPrices AS (
    SELECT
        `year` AS older_year,
        lead(`year`) OVER (ORDER BY `year`) AS newer_year,
        avg_food_price AS older_price,
        lead(avg_food_price) OVER (ORDER BY `year`) AS newer_price,
        lead(avg_food_price) OVER (ORDER BY `year`) - avg_food_price AS avg_price_diff,
        round((lead(avg_food_price) OVER (ORDER BY `year`) - avg_food_price) / avg_food_price * 100, 1) AS avg_price_diff_percentage
    FROM v_barbora_maskova_avg_food_price_2006_2018
)
SELECT *
FROM FoodPrices
WHERE older_year <> newer_year;

SELECT * FROM v_barbora_maskova_avg_food_price_trend_diff_2006_2018;
SELECT * FROM v_barbora_maskova_avg_wages_trend_diff_2006_2018;

-- Pohled: Porovnání meziročního růstu cen a mezd
CREATE OR REPLACE VIEW v_barbora_maskova_yoy_growth_prices_and_wages_comparison AS
SELECT
	fop.older_year,
	wa.newer_year,
	fop.avg_price_diff_percentage,
	wa.avg_wages_diff_percentage,
	fop.avg_price_diff_percentage - wa.avg_wages_diff_percentage AS price_wages_diff
FROM v_barbora_maskova_avg_food_price_trend_diff_2006_2018 AS fop
JOIN v_barbora_maskova_avg_wages_trend_diff_2006_2018 AS wa
	ON wa.older_year = fop.older_year
ORDER BY fop.avg_price_diff_percentage DESC;

SELECT * FROM v_barbora_maskova_yoy_growth_prices_and_wages_comparison
ORDER BY price_wages_diff DESC;