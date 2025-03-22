--dont need to capitalize keywords but thats best practice
SELECT first_name, last_name from actor; --semicoln represents the end of a query

--selecting 3 variables from a table (customer table) 599 rows, we can also select distinct to remove duplicates
SELECT first_name, last_name, email from customer;

--select distinct from the color table
SELECT * FROM film; --here we can see all the columns inside this table

--how many different release years do we have inside this database
SELECT DISTINCT release_year FROM film; -- everything was released in 2006

--can also run this
SELECT DISTINCT(release_year) FROM film;

SELECT DISTINCT rental_rate FROM film; -- thres three distinct rates

--use what you learned to get distinct rating types 
SELECT DISTINCT rating from film; --here are the unique ratings

--SELECT COUNT returns the amount of entires in the data, like the len function in python
SELECT COUNT(rating) from film; --we are calling count on distinct name

SELECT COUNT(*)FROM payment; --count the number of rows in all the columns

SELECT COUNT(amount) FROM payment; -- same exact result

--this function needs parenthesis, becuase otherwise it will think trying to call count on DISTINCT a col that doesnt exist
SELECT COUNT(DISTINCT(amount)) FROM payment; -- what is the actual number of distinct amounts being payed

--select column1, column2, from table, where

--logical operators AND, OR, NOT
SELECT * FROM customer;

SELECT * FROM customer 
WHERE first_name = 'Jared'; -- one guy first name jared all information

SELECT * FROM payment --payment datetime stamp, order by that to see oldest and most recent
WHERE amount != 0.00 -- five most recent payments where amount does not equal 0
ORDER BY payment_date DESC
LIMIT 5;

SELECT COUNT(*) FROM film 
WHERE rental_rate > 4 AND replacement_cost >= 19.99 
AND rating ='R'; --where applies to all conditionals can keep linking together


--or logical operator 
SELECT * FROM film --all movies not rated R
WHERE rating != 'R' or rating = 'PG-13';

--a customer forgot thier wallet at our store and we need to find their emial to inform them thier name is nancy thomas
SELECT email --only taking the email of Nancy Thomas
FROM customer
WHERE first_name = 'Nancy' AND last_name = 'Thomas';

--a customer wants to know about the movie outlaw hankie is aobut 
SELECT description FROM film
WHERE title = 'Outlaw Hanky';

--a customer is late on thier movie return get phone number for customer who lives at the address
SELECT phone FROM address -- can have a col with the same name as the table
WHERE address = '259 Ipoh Drive';

--ORDER BY, alphabetical or string based columns
SELECT first_name FROM customer
ORDER BY first_name;

--explore the customer table
SELECT * FROM customer
ORDER BY store_id DESC, first_name DESC; --so first it orders by store id and within that it sorts the alphabetically descending
--can also update store_id to desc to get the second store first
--can also order by columns not selected, logically it makes sense to order by a selected column though

--the limit command allows the number of rows retuned in a query
--limit goes at the very bottom of a command or request