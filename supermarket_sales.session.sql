CREATE TABLE supermarket_sales (
    invoice_id VARCHAR(255),
    branch CHAR(1),
    city VARCHAR(255),
    customer VARCHAR(255),
    gender VARCHAR(255),
    product_line VARCHAR(255),
    unit_price numeric,
    quantity int,
    tax_5pct numeric,
    total numeric,
    date DATE,
    time TIME,
    payment VARCHAR(255),
    cogs numeric,
    gross_margin numeric,
    gross_income numeric,
    rating numeric
);

alter table supermarket_sales OWNER to postgres

--Compare spending between members and non-members, in different cities

select
    customer,
    avg(total)
from
    supermarket_sales
group by
    customer;
--
select
    city,
    customer,
    avg(total)
from
    supermarket_sales
group by
    customer,
    city
order by
    city;

/*
Takeaways:
Customers who are members spend slightly more on average.
In Naypyitaw, theres virtually no difference 
*/

--Compare total spending on product lines between male and female members at Yangon

SELECT
    product_line,
    AVG(CASE WHEN gender = 'Male' THEN total ELSE NULL END) AS avg_male_spendings,
    AVG(CASE WHEN gender = 'Female' THEN total ELSE NULL END) AS avg_female_spendings,
    AVG(CASE WHEN gender = 'Male' THEN total ELSE NULL END) - 
    AVG(CASE WHEN gender = 'Female' THEN total ELSE NULL END) AS difference_spendings
FROM
    supermarket_sales
WHERE
    city = 'Yangon' AND
    customer = 'Member'
GROUP BY
    product_line
ORDER BY
    product_line ASC;

/*
Takeaways:
Males spend more on food and beverages, sports and travel, and health and beauty.
Females spend more on electronic accessories, fashion accessories, home and lifestyle.
The largest difference is in home and lifestyle.
*/

--Compare average unit price and quantity sold between product lines

SELECT
    product_line,
    avg(unit_price) as average_unit_price,
    avg(quantity) as average_quantity_purchased
FROM
    supermarket_sales
GROUP BY
    product_line

/*
Takeaways:
No significant difference in avg unit price, range from 53-57
Avg quantity purchased ranges from 5-5.7
Fashion accessories have the smallest average quantity purchased
*/

--Identify which products are purchased the most often

select
    product_line,
    count(invoice_id)
from
    supermarket_sales
group by
    product_line
order BY
    count(invoice_id) desc

/*
Takeaways:
Not a large difference, but fashion accessories are the highest with 178, followed by 174 for food and beverages
Health and beauty are purchased the leasat

Fashion accessories are purchased most often but in the least quantity
*/

--Compare ratings by city, product line

select
    city,
    avg(rating)
from
    supermarket_sales
group by
    city
order by
    avg(rating) desc
--
select
    product_line,
    avg(rating)
from
    supermarket_sales
group by
    product_line
order by
    avg(rating) desc

/*
Takeaways
Ratings range from 6.81-7.07 by city
Naypyitaw has the highest followed by Yangon and Mandalay

Ratings range from 6.883-7.11 by product line
Food and beverages are rated highest, with home and lifestyle lowest
*/



--When are different product lines purchased during the day?

select
    product_line,
    avg(time)
from
    supermarket_sales
group by
    product_line

/*
Takeaways:
The average time is around 3:30 pm
Food and beverages are typically bought later, around 3:52
Sports and travel are typically bought earlier, around 3:12
*/



