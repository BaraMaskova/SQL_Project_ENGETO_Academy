/*
 * 1. Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
 */
-- Pohled: prumer mzdy za rok/odvetvi
CREATE OR REPLACE VIEW v_barbora_maskova_avg_wages_by_sector_and_year AS
SELECT
	industry_branch,
	payroll_year,
	avg(average_wages) AS average_wages
FROM t_barbora_maskova_project_sql_primary_final
GROUP BY industry_branch, payroll_year
ORDER BY industry_branch;

SELECT * FROM v_barbora_maskova_avg_wages_by_sector_and_year;

-- Pohled: Trend růstu mezd podle odvětví a roku
CREATE OR REPLACE VIEW v_barbora_maskova_wages_growth_trend_by_sector_and_year AS
SELECT
    industry_branch,
    older_year,
    newer_year,
    older_wages,
    newer_wages,
    wages_difference,
    wages_difference_percentage,
    wages_trend
FROM (
    SELECT
        industry_branch,
        payroll_year AS older_year,
        lead(payroll_year) OVER (PARTITION BY industry_branch ORDER BY payroll_year) AS newer_year,
        average_wages AS older_wages,
        lead(average_wages) OVER (PARTITION BY industry_branch ORDER BY payroll_year) AS newer_wages,
        lead(average_wages) OVER (PARTITION BY industry_branch ORDER BY payroll_year) - average_wages AS wages_difference,
        round(lead(average_wages) OVER (PARTITION BY industry_branch ORDER BY payroll_year) * 100 / average_wages, 1) - 100 AS wages_difference_percentage,
        CASE
            WHEN lead(average_wages) OVER (PARTITION BY industry_branch ORDER BY payroll_year) > average_wages THEN 'UP'
            ELSE 'DOWN'
        END AS wages_trend
    FROM v_barbora_maskova_avg_wages_by_sector_and_year
) AS subquery
WHERE older_year <> newer_year
ORDER BY industry_branch, older_year;

SELECT * FROM v_barbora_maskova_wages_growth_trend_by_sector_and_year
ORDER BY wages_difference_percentage;