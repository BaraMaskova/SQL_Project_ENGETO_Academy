/*
 * 3. Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší procentuální meziroční nárůst)?
 */
-- Pohled: Cenový trend potravin (2006 - 2018)
CREATE OR REPLACE VIEW v_barbora_maskova_food_price_trend AS
SELECT
    food_category,
    price_value,
    price_unit,
    payroll_year AS older_year,
    newer_year,
    older_price,
    newer_price,
    newer_price - older_price AS price_difference,
    round((newer_price - older_price) / older_price * 100, 2) AS price_diff_percentage,
    CASE
        WHEN newer_price > older_price THEN 'UP'
        ELSE 'DOWN'
    END AS price_trend
FROM (
    SELECT
        food_category,
        price_value,
        price_unit,
        payroll_year,
        lead(payroll_year) OVER (PARTITION BY food_category ORDER BY payroll_year) AS newer_year,
        average_price AS older_price,
        lead(average_price) OVER (PARTITION BY food_category ORDER BY payroll_year) AS newer_price
    FROM t_barbora_maskova_project_sql_primary_final
) AS subquery
WHERE payroll_year <> newer_year
ORDER BY food_category, payroll_year;

SELECT * FROM v_barbora_maskova_food_price_trend
ORDER BY price_diff_percentage DESC;

SELECT * FROM v_barbora_maskova_food_price_trend
ORDER BY price_diff_percentage;

-- Průměrný meziroční nárůst/pokles cen potravin (2006 - 2018)
SELECT
	older_year AS year_from,
	max(newer_year) AS year_to,
	food_category,
	round(avg(price_diff_percentage), 1) AS avg_annual_price_growth_in_percentage -- průměrný roční růst cen v procentech
FROM v_barbora_maskova_food_price_trend
GROUP BY food_category
ORDER BY avg_annual_price_growth_in_percentage;