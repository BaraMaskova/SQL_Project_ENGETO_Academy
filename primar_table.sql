-- tabulka na prumerne mzdy
CREATE OR REPLACE TABLE  average_wages
SELECT
    cp.payroll_year,
    round(avg(cp.value)) AS average_wages,
    cpib.name AS industry_branch
FROM czechia_payroll cp
JOIN czechia_payroll_industry_branch cpib
    ON cp.industry_branch_code = cpib.code
WHERE cp.value_type_code = 5958
    AND cp.calculation_code = 200
    AND cp.industry_branch_code IS NOT NULL
    AND cp.payroll_year BETWEEN 2006 AND 2018
GROUP BY cp.payroll_year, industry_branch
ORDER BY cp.payroll_year, industry_branch_code;

-- tabulka na prumerne ceny potravin
CREATE OR REPLACE TABLE average_price
SELECT
    cpc.name AS food_category,
    cpc.price_value,
    cpc.price_unit,
    round(AVG(cp.value), 2) AS average_price,
    YEAR(cp.date_from) AS `year`
FROM
    czechia_price cp
JOIN
    czechia_price_category cpc
    ON cp.category_code = cpc.code
GROUP BY
	`year`, food_category, cpc.price_value, cpc.price_unit;

SELECT *
FROM average_price ap

--  spojeni tabulek cen a mezd
CREATE OR REPLACE TABLE t_barbora_maskova_project_sql_primary_final
SELECT
	ap.food_category,
	ap.price_value,
	ap.price_unit,
	ap.average_price,
	aw.payroll_year,
	aw.average_wages,
	aw.industry_branch
FROM average_price ap
JOIN average_wages aw
     ON ap.`year` = aw.payroll_year
ORDER BY aw.payroll_year, aw.industry_branch;

SELECT *
FROM t_barbora_maskova_project_sql_primary_final