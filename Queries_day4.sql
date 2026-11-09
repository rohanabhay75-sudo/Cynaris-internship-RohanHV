use internship_day1;
-- NON Correlated Sub Query
-- Find sales Greater than average sales
select sale_id,customer_name,amount from sales where amount> (select avg(amount) from sales);
-- Correlated Sub Query
-- Find the top Performing sales person in each region
select sale_id,customer_name,amount,region from sales s1 where amount = (select max(s2.amount) from sales s2 where s2.region=s1.region);
-- Convert nested subquery into CTE
with average_sales as (select avg(amount) as avg_amount from sales)
select sale_id,customer_name,amount,region from sales where amount>(select avg_amount from average_sales);
-- Chain Two CTE 
with regional_sales as (select city,sum(amount) as total_sales from sales group by city),
average_regional_sales as (select avg(total_sales) as avg_sales from regional_sales)
select * from regional_sales where total_sales >(select avg_sales from average_regional_sales);