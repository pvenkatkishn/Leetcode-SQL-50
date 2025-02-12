Table: Products

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| product_id    | int     |
| new_price     | int     |
| change_date   | date    |
+---------------+---------+
(product_id, change_date) is the primary key (combination of columns with unique values) of this table.
Each row of this table indicates that the price of some product was changed to a new price at some date.
 

Write a solution to find the prices of all products on 2019-08-16. Assume the price of all products before any change is 10.

Return the result table in any order.



Solution:
WITH cte as (
    SELECT product_id, MAX(change_date) as maxdate
    FROM products
    WHERE change_date <= "2019-08-16"
    GROUP BY product_id  
)
(SELECT product_id, new_price as price
FROM products
WHERE (product_id, change_date) IN (SELECT product_id, maxdate FROM cte))
UNION
(
SELECT product_id, 10 
FROM products
WHERE change_date > "2019-08-16" and product_id NOT IN (SELECT product_id FROM cte)
GROUP BY product_id )
