USE retail_project;

-- q1 Retrive all the sales made on "2022/11/05"

select *
from retail_sales
where sale_date = "2022-11-05";

-- q2 Retrive all the transictions where categories is "Clothing" and quantity sold is more than 3 in the month of nov-2022
select count(*)
from retail_sales
where category = "Clothing"
	and 
    sale_date >= "2022-11-01" and sale_date < "2022-12-01"
    and 
    quantiy = "4";
    
-- q3 Total sales for wach category
select category,
	count(*) as Total_orders,
	sum(total_sale) as Total_sales
	
from retail_sales
group by category;

-- q4 Average age of customers who buy products from beauty category

select gender, round(avg(age)), category
from retail_sales
where category = "Beauty"
group by gender, category;

-- q5 All the transaction where total sales is greater than 1000

select *
from retail_sales
where total_sale>1000;

-- q6 Total number of transiction made by each gender in each category

select category, gender, count(*) as total_tansiction
from retail_sales
group by category, gender
order by 1;

-- q7 Calculate average sales each month, Find best selling month each year

select year, month, sales from
 (
	select year(sale_date) as year,
		monthname(sale_date) as month,
		avg(total_sale) as sales,
		rank() over(partition by year(sale_date)order by avg(total_sale) desc) as ranks
	from retail_sales
	group by 1,2) as t1
where ranks = 1 ;

-- q8 top 5 customers based on total sales

select customer_id as customers, sum(total_sale) sales
from retail_sales
group by 1
order by 2 desc
limit 5;

-- q9 find number of unique customers who purchased item from each category

select category, count(distinct customer_id) as uniqie_customer
from retail_sales
group by 1;

-- q10 Create shifts lime morning afternoon and evening and check orders

with hourly_sales
as
(
select *, 
	case
		when hour(sale_time) < 12 then "Morning"
		when hour(sale_time) between 12 and 17 then "After_noon"
		else "Evening"
	end as shift
from retail_sales
)
select shift, count(total_sale)
from hourly_sales
group by shift

-- End of project