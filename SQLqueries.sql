/* =====================================================
   AMAZON SALES ANALYTICS – BIGQUERY PROJECT
   Author: Megha K A
   ===================================================== */


/* ================================
   1. Total Revenue
   ================================ */
SELECT 
 SUM(Amount) AS total_revenue
FROM `my-project-new-453500.sales_project.amazon_sales`;


/* ================================
   2. Total Orders
   ================================ */

SELECT
 COUNT(*) AS total_orders
FROM `my-project-new-453500.sales_project.amazon_sales`;


/* ================================
   3. Monthly Sales Trend
   ================================ */
SELECT
 FORMAT_DATE('%Y-%m',DATE(Date)) AS month,
 SUM(Amount) AS monthly_revenue
FROM `my-project-new-453500.sales_project.amazon_sales`
GROUP BY month
ORDER BY month;


/* ================================
   4. Revenue by Category
   ================================ */

SELECT
 Category,
 SUM(Amount) AS revenue
FROM `my-project-new-453500.sales_project.amazon_sales`
GROUP BY Category
ORDER BY revenue DESC;


/* ================================
   5. B2B vs B2C Revenue
   ================================ */
SELECT
 B2B,
 SUM(Amount) AS revenue
FROM `my-project-new-453500.sales_project.amazon_sales`
GROUP BY B2B;


/* ================================
   6. Create Summary Table
   ================================ */

CREATE OR REPLACE TABLE
 `my-project-new-453500.sales_project.sales_summary` AS

SELECT
 FORMAT_DATE('%Y-%m',DATE(Date)) AS month,
 Category,
 SUM(Amount) AS revenue,
 COUNT(*) AS total_orders
FROM `my-project-new-453500.sales_project.amazon_sales`
GROUP BY month,Category;


/* ================================
   7. Create Dashboard View
   ================================ */

CREATE OR REPLACE VIEW
`my-project-new-453500.sales_project.sales_dashboard_view` AS 

SELECT
 PARSE_DATE('%Y-%m',month) AS month,
 SUM(revenue) AS total_revenue,
 SUM(total_orders) AS total_orders
FROM `my-project-new-453500.sales_project.sales_summary`
GROUP BY month
ORDER BY month;
