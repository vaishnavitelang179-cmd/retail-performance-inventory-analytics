
select
p.product_category,
SUM(s.units) AS total_units,
SUM(s.units * p.product_price) AS revenue,
    SUM(s.units * (p.product_price - p.product_cost)) AS profit
FROM sales s
JOIN products p
    ON s.product_id = p.product_id
GROUP BY p.product_category
ORDER BY revenue DESC;

select
p.product_category,
SUM(s.units) AS total_units,
SUM(s.units * p.product_price) as revenue,
SUM(s.units * (p.product_price - p.product_cost)) AS profit,
round(
sum(s.units *(p.product_price - p.product_cost))
/nullif(sum(s.units * p.product_price),0) *100,
2
) as profit_margin
from sales s
join products p
on s.product_id = p.product_id
group by p.product_category
order by profit_margin desc;

with product_sales as (
select
p.product_name,
p.product_category,
SUM(s.units) as total_units,
SUM(s.units * p.Product_price) as revenue,
SUM(s.units * (p.product_price - p.product_cost)) as profit
from sales s
join products p
on s.product_id = p.product_id
group by 
p.product_name,
p.product_category
)
select 
product_name,
product_category,
total_units,
round(revenue, 2) as revenue,
round(profit, 2) as profit,
rank() over (
partition by product_category
order by revenue desc
) as category_revenue_rank
from product_sales
order by product_category, category_revenue_rank;

with store_sales as (
select
s.store_id,
sum(s.units) as total_units,
sum(s.units * p.product_price) as revenue,
sum(s.units * (p.product_price - p.product_cost)) as profit
from sales s
join products p
on s.product_id = p.product_id
group by s.store_id
),
store_inventory as (
select
store_id,
count(*) as total_products,
count(*) filter (where stock_on_hand = 0 ) as out_of_stock_products
from inventory
group by store_id
)
select
st.store_name,
st.store_city,
ss.total_units,
round(ss.revenue, 2) as revenue,
round(ss.profit, 2) as profit,
si.total_products,
si.out_of_stock_products,
round(
si.out_of_stock_products::numeric
/ nullif(si.total_products, 0)* 100,
2
 ) AS stockout_rate
FROM store_sales ss
JOIN stores st
    ON ss.store_id = st.store_id
JOIN store_inventory si
    ON ss.store_id = si.store_id
ORDER BY stockout_rate DESC, revenue DESC;

WITH product_sales AS (
    SELECT
        product_id,
        SUM(units) AS total_units_sold
    FROM sales
    GROUP BY product_id
),

product_inventory AS (
    SELECT
        product_id,
        SUM(stock_on_hand) AS total_stock,
        COUNT(*) FILTER (WHERE stock_on_hand = 0) AS stockout_stores
    FROM inventory
    GROUP BY product_id
)

SELECT
    p.product_name,
    p.product_category,
    ps.total_units_sold,
    pi.total_stock,
    pi.stockout_stores,
    ROUND(
        pi.total_stock / NULLIF(ps.total_units_sold / 21.0, 0),
        2
    ) AS stock_coverage_months
FROM products p
JOIN product_sales ps
    ON p.product_id = ps.product_id
JOIN product_inventory pi
    ON p.product_id = pi.product_id
ORDER BY stock_coverage_months ASC;


WITH store_sales AS (
    SELECT
        s.store_id,
        SUM(s.units) AS total_units,
        SUM(s.units * p.product_price) AS revenue,
        SUM(s.units * (p.product_price - p.product_cost)) AS profit
    FROM sales s
    JOIN products p
        ON s.product_id = p.product_id
    GROUP BY s.store_id
),

store_inventory AS (
    SELECT
        store_id,
        COUNT(*) AS total_products,
        COUNT(*) FILTER (WHERE stock_on_hand = 0) AS out_of_stock_products
    FROM inventory
    GROUP BY store_id
)

SELECT
    st.store_name,
    st.store_city,
    ROUND(ss.revenue, 2) AS revenue,
    ROUND(ss.profit, 2) AS profit,
    si.out_of_stock_products,
    ROUND(
        si.out_of_stock_products::NUMERIC
        / NULLIF(si.total_products, 0) * 100,
        2
    ) AS stockout_rate
FROM store_sales ss
JOIN stores st
    ON ss.store_id = st.store_id
JOIN store_inventory si
    ON ss.store_id = si.store_id
ORDER BY
    stockout_rate DESC,
    revenue DESC;
