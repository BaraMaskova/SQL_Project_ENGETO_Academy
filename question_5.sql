/*
 * Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce,
 * projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?
 */
-- Pohled: HDP v ČR v letech 2006 - 2018
CREATE OR REPLACE VIEW v_barbora_maskova_gdp_cr_2006_2018 AS
SELECT * FROM t_barbora_maskova_project_sql_secondary_final
WHERE country = 'Czech Republic';

SELECT * FROM v_barbora_maskova_gdp_cr_2006_2018;

-- Pohled: HDP trend - vývoj meziročního trendu HDP v ČR
CREATE OR REPLACE VIEW v_barbora_maskova_yoy_gdp_trend_diff_cr_2006_2018 AS
WITH GDPTrend AS (
	SELECT
		`year` AS older_year,
		lead(`year`) OVER (PARTITION BY country ORDER BY `year`) AS newer_year,
		GDP AS older_gdp,
		lead(GDP) OVER (PARTITION BY country ORDER BY `year`) AS newer_gdp,
		round((lead(GDP) OVER (PARTITION BY country ORDER BY `year`) - GDP) / GDP * 100, 1) AS gdp_diff_percentage
	FROM v_barbora_maskova_gdp_cr_2006_2018
)
SELECT *
FROM GDPTrend
WHERE older_year <> newer_year;

SELECT * FROM v_barbora_maskova_yoy_gdp_trend_diff_cr_2006_2018; -- HDP

SELECT * FROM v_barbora_maskova_avg_food_price_trend_diff_2006_2018; -- ceny
SELECT * FROM v_barbora_maskova_avg_wages_trend_diff_2006_2018; -- mzdy

-- Pohled: Meziroční vývoj cen potravin, mezd a HDP v ČR 2006-2018
CREATE OR REPLACE VIEW v_barbora_maskova_yoy_foodprice_wages_gdp_trend AS
SELECT
	gdp.older_year,
	gdp.newer_year,
	pri.avg_price_diff_percentage AS avg_price_diff_perc,
	wag.avg_wages_diff_percentage AS avg_wages_diff_perc,
	gdp.gdp_diff_percentage AS gdp_diff_perc,
	pri.avg_price_diff_percentage - gdp.gdp_diff_percentage AS price_gdp_diff,
	wag.avg_wages_diff_percentage - gdp.gdp_diff_percentage AS wages_gdp_diff
FROM v_barbora_maskova_yoy_gdp_trend_diff_cr_2006_2018 AS gdp
JOIN v_barbora_maskova_avg_wages_trend_diff_2006_2018 AS wag
	ON wag.older_year = gdp.older_year
JOIN v_barbora_maskova_avg_food_price_trend_diff_2006_2018 AS pri
	ON pri.older_year = gdp.older_year;

SELECT * FROM v_barbora_maskova_yoy_foodprice_wages_gdp_trend;