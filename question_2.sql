/*
 * 2. Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?
 */
SELECT
	food_category,
	price_value,
	price_unit,
	payroll_year,
	average_price,
	round(avg(average_wages), 2)  AS avg_wages,
	floor(avg(average_wages)/average_price) AS avg_purchasing_power
FROM t_barbora_maskova_project_sql_primary_final
WHERE 1=1
	AND payroll_year IN (2006, 2018)
	AND food_category IN ('Mléko polotučné pasterované', 'Chléb konzumní kmínový')
GROUP BY food_category, payroll_year;