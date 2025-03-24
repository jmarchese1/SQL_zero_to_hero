--joins practice

-- as is executed at the very end of a query, it doesnt work in the rest of the query
SELECT COUNT(amount) as num_transactions
FROM payment;


SELECT customer_id, SUM(amount) AS total_spent FROM payment
GROUP BY customer_id
--cannot do: HAVING total_spent > 100, because the alias is assigned at the end
HAVING SUM(amount) > 100
ORDER BY SUM(amount) DESC; 

--another example of aliases assigned at the end, cant filter or compare on it
SELECT customer_id, amount AS new_name
FROM payment


--inner join easiest join type
--joins allow us to combine multiple tables together
WHERE amount > 2;

--inner join means shared in both tables, grab the rows that are in both tables
--SELECT * FROM Registrations
--INNER JOIN Logins
--ON Registrations.name = Logins.name;

--looking for matches that exist in both cols, essentialy what were saying is these two cols are the 
--same thing take everything from this table and add it to the matching person in the other table
--for example we would probably use customer id or id numbers instead of names because there are duplicates

--joining two tables together with the same customer_id
--first_name is unique so dont need to specify
--the inner join will only brige customers that are in payment and table
SELECT payment_id, payment.customer_id, first_name --if its not a unique col need to say table.feature to specify the correct one
FROM payment
INNER JOIN customer ON payment.customer_id = customer.customer_id; --the order doesnt matter here because the venn diagram is symetrical in an inner join

--outter joins takes data only present In one table, full outter join
--simpliest outter join

--grab everything from both tables, whether or not they are absent in one or another 
--missing values get filled in with NULL
SELECT * FROM payment
FULL OUTER JOIN customer ON customer.customer_id = payment.customer_id
WHERE payment.payment_id IS NULL OR customer.customer_id IS NULL;
--only grab things unique to table a or unique to table b
--theres no nas here, adding in a where statement after the join
--this is how to create the exact opposite of an inner join

--all payments need to be associated with payments, all customers should have purchased something
SELECT * FROM customer
FULL OUTER JOIN payment
ON customer.customer_id = payment.customer_id --make sures theres no unique information
WHERE customer.customer_id IS NULL  
OR payment.payment_id IS NULL; --theres no results meaning our set up is compliant with the rules of the system

SELECT COUNT(DISTINCT customer_id) FROM customer;

--left outer join
--take everything from table a the intersection and not in table b
--can be shortened to left join as syntax
--the order matters with left outer join 
--can make results unique to table A with a where statement where tableb.id is null

--left outer join, joining film and inventory
SELECT film.film_id, title, inventory_id
FROM film 
LEFT JOIN inventory ON
inventory.film_id = film.film_id
WHERE inventory.film_id IS null; --this is showing a film id, the title and that its not in the inventory
--because film is on the left (its in the from statement)
--we will only see films that are in films and inventory

--right join is the same thing as a left join execpt the tables are switched
--really never need to use a right join if you just change the table order of left joins
--table in from is on the left, table after inner join or outer join is on the right


--UNION 
--merge tables 

--join challenges 
--california sales tax laws have changed and we need to alert our customers through 
--what are the emails of the customers who live in california 
SELECT district, email from customer
INNER JOIN address 
ON address.address_id = customer.address_id
WHERE district = 'California';

--customer and address connect on address on id and we filter by california

--get a list of all the moives with Nick Wahlberg has been in
--need to inner join three tables
SELECT title, first_name, last_name 
--gathering the information in select from here:
FROM film_actor
INNER JOIN actor
ON actor.actor_id = film_actor.actor_id
INNER JOIN film 
ON film.film_id = film_actor.film_id
----three tables to get all of the information but they all connect easily
WHERE first_name = 'Nick' AND last_name = 'Wahlberg'; --filtering for the specific actors name
