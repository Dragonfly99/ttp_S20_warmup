-- Another clever use of SUBQUERIES

-- EXAMPLE: What is the average customer lifetime spending?
-- Does this work?
SELECT AVG(SUM(amount))
FROM payment
GROUP BY customer_id; --NOPE! "ERROR:  aggregate function calls cannot be nested"
--TRY THIS
SELECT AVG(total)
FROM (SELECT SUM(amount) as total 
	  FROM payment 
	  GROUP BY customer_id) as customer_totals; --NICE! 
-- IMPORTANT! NOTICE THE ALIAS AT THE END. THIS IS NECESSARY WHEN THE SUBQUERY
-- IS IN THE FROM CLAUSE

--OR do the above with a CTE:
WITH customer_totals as ( --start of CTE
SELECT SUM(amount) as total 
FROM payment 
GROUP BY customer_id) --end of CTE
SELECT AVG(total)
FROM customer_totals;

-- YOUR TURN: what is the average of the amount of stock each store has in their inventory? (Use inventory table)

-- YOUR TURN: What is the average customer lifetime spending, for each staff member?
-- HINT: you can work off the example

--YOUR TURN: 
--What is the average number of films we have per genre (category)?







--Question 1
WITH store_average AS(
    SELECT store_id as store, COUNT(inventory_id) as stock
    FROM inventory
    Group By store_id) 
SELECT store, AVG(stock)
FROM store_average
GROUP BY store;


--Question 2
WITH lifetime_spending AS(
    SELECT staff_id as staff, SUM(amount) as total
    FROM payment
    Group By staff_id) 
SELECT staff, AVG(total)
FROM lifetime_spending
GROUP BY staff;



--Question 3
WITH genre_average AS(
    SELECT name as genre, COUNT(film_id) as film
    FROM category
    INNER JOIN film_category
    USING (category_id)
    Group By genre) 
SELECT genre, AVG(film)
FROM genre_average
GROUP BY genre;