--advanced SQL topics
--Timestamps and EXTRACT
--Math functions
--string queries
--sub-query
--self-join

--time stamps and extract functionality, these functions are more useful when creating our own database
--time - contains only time 
--date - contains only a date
--timestamp - contains a mix of both

--functions
--TIMEZONE
--NOW
--TIMEOFDAY
--CURRENT_TIME
--CURRENT_DATE

SHOW TIMEZONE; --current timezone

SELECT NOW(); --timestamp information for right now
SELECT TIMEOFDAY(); --str format
SELECT CURRENT_TIME; --time with time zone
SELECT CURRENT_DATE; --just the date

--EXTRACT allows extracting a sub component of a date value
--EXTRACT(YEAR FROM date_col)
--AGE calulates and returns  thr current age of a given timestamp, how long has the timestamp been there
--TO_CHAR converts data types to text, lets of different usecases

--can extract year, month, quarter, etc
SELECT EXTRACT(QUARTER FROM payment_date) AS Q
FROM payment;

SELECT AGE(payment_date)
FROM payment;

SELECT TO_CHAR(payment_date, 'mm/dd/YYYY') -- foward slashes we chose
FROM payment;

--european date
SELECT TO_CHAR(payment_date, 'dd-mm-YYYY')
FROM payment;

--Timestamp challenge tasks
--during which months did payments occur
SELECT DISTINCT(TO_CHAR(payment_date, 'MONTH')) AS payment_month
FROM payment
--dont need to use extact for this query

--how many payments occured on a Monday
SELECT COUNT(*)
FROM payment
WHERE EXTRACT(dow FROM payment_date) = 1; --dow is day of week, 0 is sunday

--mathematical operations in SQL
--documentation addition, subtraction, multiplication, division, sq root, cube root
--can use this to perform math on two cols to get custom cols
SELECT * FROM film;

--what percentage of the replacement_cost is a rental_rate
SELECT ROUND(rental_rate/replacement_cost, 4) * 100 as percent_cost
FROM film;

--multiplication of cols
SELECT 0.1 * replacement_cost as deposit_from_film
FROM film;

--string functions and operators 
--like and ilike wildcard operators
SELECT * FROM customer;

--simple function call operating on text data
SELECT first_name, length(first_name) 
FROM customer
ORDER BY length(first_name) DESC;

--string concatenation
SELECT upper(first_name) || ' ' || upper(last_name) as full_name
FROM customer;

--create an email for them, first letter, last name, company email address
SELECT LOWER(LEFT(first_name, 1)) || LOWER(last_name) || '@gmail.com' as customer_email
FROM customer;

SELECT * FROM customer;
--can use left and right functions to grab certian letters from strings

--sub query, how to use the exist function in conjunction with it
--filter on another query in parenthesis in a WHERE clause and the EXISTS function

--lets return filmd with a higher rental rate than the average rental rate
SELECT title, rental_rate
FROM film 
WHERE rental_rate > (SELECT AVG(rental_rate) FROM film); --if sub query has multiple values need to use in operator


--grab film titles between may 29 and may 30 2005
--need to add the film id to the table
SELECT film_id, title FROM film
WHERE film_id IN (SELECT inventory.film_id FROM rental
INNER JOIN inventory ON inventory.inventory_id = rental.inventory_id
WHERE return_date BETWEEN '2005-05-29' AND '2005-05-30') --isince its exclusive dont need to refrenece a table
ORDER BY title;

--select first name and last name from customer table
--first and last name of people with one payment > 11 dollars
SELECT first_name, last_name 
FROM customer AS c
WHERE EXISTS --can also add a not in front of exists
(SELECT * FROM payment as p
WHERE p.customer_id = c.customer_id
AND amount > 11);


--self joins, its neccesary to use an alias
--find all pairs of films that have the same length
SELECT title, length FROM film
WHERE length = 117;

SELECT f1.title, f2.title, f1.length
FROM film as f1 
INNER JOIN film as f2 ON
f1.film_id != f2.film_id
AND f1.length = f2.length;
