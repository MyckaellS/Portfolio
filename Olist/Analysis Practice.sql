-- This statement displays and orders product categories by their revenue. The min, max, and avg visualizes the skew of the distribution.
SELECT 
  p.product_category_name, 
  SUM(oi.price) AS `revenue`, 
  SUM(oi.freight_value) AS `shipping_costs`,
  MIN(oi.price) AS `revenue_min`,
  MAX(oi.price) AS `revenue_max`,
  AVG(oi.price) AS `revenue_avg`
FROM OList.products AS p
  RIGHT JOIN `OList.order_items` AS oi
    ON p.product_id = oi.product_id
GROUP BY 
  p.product_category_name
ORDER BY 
  2 DESC, 3 DESC;




-- These statements find the rate of growth (for the month) for each category
-- This first statment creates a month and year column to base the growth rates on
WITH `monthly_CTE` AS
(
  SELECT 
    p.product_category_name, 
    SUM(oi.price) AS `revenue`,
    EXTRACT(MONTH FROM o.order_purchase_timestamp) AS `month`,
    EXTRACT(YEAR FROM o.order_purchase_timestamp) AS `year`,
  FROM OList.products AS p
    JOIN `OList.order_items` AS oi
      ON p.product_id = oi.product_id
    JOIN `OList.orders` AS o
     ON oi.order_id = o.order_id
  WHERE 
    p.product_category_name is not null
  GROUP BY 
    1, 3, 4
  ORDER BY 
    1, 4, 3 
),
-- This statement lags the revenue to provide a column to calculate the growth rate on
growth_rate_CTE AS 
(
  SELECT 
    product_category_name,
    month, 
    year,
    revenue,
    LAG(revenue) OVER(PARTITION BY product_category_name ORDER BY year,month) AS `last_month_sale`,
  FROM 
    monthly_CTE
),
-- This statement compares the current and previous monthly revenues to determine a growth rate for the month
growth_monthly_CTE AS
( 
  SELECT 
    product_category_name,
    month, 
    year,
    revenue,
    ROUND((revenue-`last_month_sale`)/`last_month_sale`*100,2) AS `monthly_growth_rate`
  FROM 
    growth_rate_CTE
)

-- This statement shows the growth rate for the last year and is ordered by the highest growth rate first
SELECT
  product_category_name,
  year,
  ROUND(AVG(`monthly_growth_rate`),2) AS `annual_growth_rate`
FROM 
  growth_monthly_CTE
GROUP BY 
  1,2
HAVING 
  `annual_growth_rate` IS NOT NULL AND year = 2018
ORDER BY 
  3 DESC;

-- This statement can be used to view more detailed information by month. It simply calls the monthly CTE
-- SELECT * FROM growth_monthly_CTE;




-- This is the start or a linear regression to estimate sales in the future
-- This statement gathers all the basic info needed for ln reg calculation such as time (x) daily sales (y) and groups them into categories
WITH `ln_reg1_CTE` AS
(
  SELECT
    DATE(o.order_purchase_timestamp) AS `date`,
    CAST(DATE_DIFF(DATE(o.order_purchase_timestamp),'2017-01-01',DAY) AS INT) AS `days`,
    p.product_category_name AS `category`,
    SUM(oi.price) AS `sales`
  FROM
    `OList.orders` AS o
    JOIN `OList.order_items` AS oi 
      ON o.order_id = oi.order_id
    JOIN `OList.products` AS p
      ON oi.product_id = p.product_id
  WHERE
    DATE(o.order_purchase_timestamp) BETWEEN '2017-01-01' AND '2018-06-30'
  GROUP BY
    1, 2, 3
  ORDER BY
    1 ASC
),

-- This statement calculates a simple linear regression to get the slope and intercept of every category
ln_reg2_CTE AS
(
  SELECT
    category,
    --Slope calcutlation 
    (COUNT(*)*SUM(days*sales)-SUM(days)*SUM(sales))/
    (COUNT(*)*SUM(days*days)-SUM(days)*SUM(days)) AS `slope`,
    --Interception
    (SUM(sales)-
      ((COUNT(*)*SUM(days*sales)-SUM(days)*SUM(sales))/
      (COUNT(*)*SUM(days*days)-SUM(days)*SUM(days))) *
      SUM(days))/COUNT(*) AS `intercept`
  FROM 
    ln_reg1_CTE
  GROUP BY
    category
)

-- This statement allows for us to view forcasted sales. The amount shown is cumulative since 2018-06-30.
-- Ex: ten_years column will display all sales between 2018-06-30 and 2028-06-30
SELECT
  category,
  (slope*913 + intercept) AS next_year,
  (slope*2373 + intercept) AS five_years,
  (slope*4163 + intercept) AS ten_years
FROM
  ln_reg2_CTE
ORDER BY
  -- Here we can sort by what the goal is. Long term goals can be viewed with the ten_years column. Immediate goals be viewed with the next year column
  4 ASC




-- Product Recommendations

-- 1. Health and Beauty is the best seller currently. Increase current volume for these products for a quick return.
-- 2. Although presents are not far behind in current sales, they are forecasted to overtake as the number 1 seller. Acquire more diverse sellers to expand the variety for future revenue.
-- 3. Most electronics not generate any revenue in the future. Accessories are the primary source of revenue for that general category.
-- 4. Most transactions are below the average. Encourage promotions such as BOGO to increase the likelihood of purchasing more items and returning.