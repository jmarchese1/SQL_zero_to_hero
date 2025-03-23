
--what are the customer ids of the first ten customers who ever created a payment
SELECT customer_id FROM payment
ORDER BY payment_date ASC --ASC for completeness
LIMIT 10;

--a customer wants to quickly rent a video they can watch
--over thier lunch time, what are the 5 shortest movies
SELECT title, length --length is a key word, but here it is used as a col name
FROM film
ORDER BY length ASC
LIMIT 10; 

--bonus question, if previous customer can watch any movie 50 mins or less in 
--run time how many options does she have 
SELECT COUNT(*) FROM film
WHERE length <= 50; --37 moive options

SELECT COUNT(*) FROM payment -- number of payments not between 8 and 9 dollars
WHERE amount NOT BETWEEN 8 AND 9
;

--with timestamp imformation its simialar to range in python to but not thorugh
--beacuase the setting 2007-02-15 means it goes up to the first second of that day
--but noting else so to include the 14th we need to go out to the 15th
SELECT * FROM payment
WHERE payment_date BETWEEN '2007-02-01' AND '2007-02-15';

--in creates a list of options to check insetad of writing a bunch of or statements
SELECT COUNT(*) FROM payment
WHERE amount NOT IN (0.99, 1.98, 1.99)
;

--one john and one julie
SELECT * FROM customer
WHERE first_name IN ('John', 'Jake', 'Julie');

--the like operator allows us to perfrom pattern matching 
--against string data with wild card operators

--% is a wildcard character for all names that begin with a capital A

--so LIKE 'A%' means it starts with A, 

--Where value LIKE '_her%' , starts with a character and then has her and then anything after it 
--underscore is the amount of characters to fill in

--SQL works with regex as well
SELECT *
FROM customer
WHERE first_name LIKE 'J%' AND last_name LIKE 'S%'; --like is case sensitive

--ILIKE is not case sensitive 
SELECT *
FROM customer
WHERE first_name ILIKE 'j%' AND last_name ILIKE 's%';

--anywhere in text
SELECT *
FROM customer
WHERE first_name ILIKE '%her%'; --this returns any one who has er anywhere in thier first name, the sequence of characters before or after can be 0

--percent sign for  along sequence of characters, _ for a single character replacement
SELECT *
FROM customer 
WHERE first_name LIKE 'A%' AND last_name NOT LIKE 'B%'
ORDER BY last_name;

--how may payment transactions were greater than 5 dollars?
SELECT COUNT(amount)
FROM payment
WHERE amount > 5.00;

SELECT COUNT(*) FROM actor
WHERE first_name ILIKE 'P%'; --gets all the names that start with P

--how many unique districts are our customers from?
SELECT COUNT (DISTINCT district) FROM address
;

--retrive list of names of distinct districts from the previous question
SELECT DISTINCT district FROM address; --just remove count 

--how many films have a rating of r and a replacement cost between $5 and $15 
SELECT COUNT(*) FROM film
WHERE rating = 'R' AND replacement_cost BETWEEN 5.00 AND 15.00;

--how many films have the word Truman in the title 
SELECT COUNT(*)
FROM film
WHERE title ILIKE '%truman%';

--now we are going to a more professional level queries

--group by statements
--aggregate functions 
--apply functions to better understand how data is distributed per category

--most common aggregate functions:
--AVG(), COUNT() retuns the number of rows, ROUND(), MIN(), MAX()

--simple calls like this doesnt make sense to call another col
SELECT MAX(replacement_cost), MIN(replacement_cost) FROM film; --min and max function, can call on any col

--round works just like python
SELECT ROUND(AVG(replacement_cost), 4) --lots of significant digits
FROM film;

SELECT SUM(replacement_cost) -- the sum equals the average * 1000 so it makes sense
FROM film;

--group by allows to aggregare columns for a sub category
--we can group by multiple cols and can choose the order to group by
--Where statement should not make a refrence to the aggregation result
--we use the having statement to filter on those results
-- whatever ordered by should be referenced in the select statement

--simplist group by possible
SELECT customer_id FROM payment
GROUP BY customer_id --round about way to get distinct customer id's
ORDER BY customer_id
; -- each customer id has multiple entries, rental id can be joined to the actual film column


--every customers id total purchases
SELECT customer_id, COUNT(amount) as total_purchases FROM payment
GROUP BY customer_id
ORDER BY COUNT(amount) DESC;

--group by two things
SELECT customer_id, staff_id, SUM(amount) FROM payment
GROUP BY staff_id, customer_id
ORDER BY SUM(amount);

--group by a date needs a specialized function to convert timestamp to a date
SELECT DATE(payment_date), SUM(amount) FROM payment
GROUP BY DATE(payment_date)
ORDER BY SUM(amount) DESC; --days we are making the least money  or most


--group by challenge tasks
--how many payments did each staff member handle
SELECT staff_id, COUNT(amount) FROM payment
GROUP BY staff_id;
--staff member two would get the bonus

--average returns many signifcant digits can use round to solve this
--what is the average replacement cost per movie rating
SELECT rating, ROUND(AVG(replacement_cost), 2) as average_cost FROM film
GROUP BY rating
ORDER BY rating DESC;

--top 5 customers by customer ids based on total expenditure
SELECT customer_id, SUM(amount) as total_expenditure FROM payment
GROUP BY customer_id
ORDER BY SUM(amount) DESC 
LIMIT 5;

--having clause comes after a groupby call 
-- if we want to filter on the aggregate function we must use having because those happen after where is executed
-- having only used for aggregate result of group by
SELECT customer_id, SUM(amount) FROM payment
GROUP BY customer_id
HAVING SUM(amount) > 100;


SELECT store_id, COUNT(*) FROM customer
GROUP BY store_id
HAVING COUNT(*) > 300;

--having challenge
--find customers with 40 or more transaction payments
SELECT customer_id, COUNT(amount) FROM payment
GROUP BY customer_id
HAVING COUNT(amount) >= 40
ORDER BY COUNT(amount) DESC; --order by goes after having

 --what are the customer ids of customers who have 
SELECT customer_id, SUM(amount) FROM payment
WHERE staff_id = 2
GROUP BY customer_id
HAVING SUM(amount) > 100;


--3 questions 

SELECT customer_id, SUM(amount) FROM payment
WHERE staff_id = 2
GROUP BY customer_id
HAVING SUM(amount) >= 110;

--how many films begin with the letter j>
SELECT COUNT(title) FROM film
WHERE title LIKE 'J%';

SELECT * FROM customer;
--what customer has the highest customer id number whose name starts with an E
--and has an address id lower than 500

SELECT first_name, last_name FROM customer
WHERE first_name LIKE 'E%' AND address_id < 500
ORDER BY customer_id DESC
LIMIT 1;