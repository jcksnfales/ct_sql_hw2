-- SQL Joins & Subquery HW

-- 1. List all customers who live in Texas (use joins)
SELECT first_name, last_name, address.district
FROM customer 
INNER JOIN address 
ON customer.address_id = address.address_id
WHERE district LIKE 'Texas';


-- 2. Get all payments above $6.99 with the customer's full name
SELECT amount, customer.first_name, customer.last_name
FROM payment
INNER JOIN customer
ON payment.customer_id = customer.customer_id
WHERE amount > 6.99;


-- 3. Show all customers names who have made payments over $175 (use subqueries)
SELECT first_name, last_name
FROM customer
WHERE customer_id IN (
	SELECT customer_id
	FROM payment 
	WHERE amount > 175
);


-- 4. List all customers that live in Nepal (use the city table)
SELECT first_name, last_name
FROM customer
INNER JOIN address 
ON customer.address_id = address.address_id 
WHERE address.city_id IN (
	SELECT city_id
	FROM city 
	WHERE country_id IN (
		SELECT country_id
		FROM country
		WHERE country LIKE 'Nepal'
	)
);
-- alternatively:
SELECT first_name, last_name
FROM customer
INNER JOIN address 
ON customer.address_id = address.address_id 
INNER JOIN city
ON address.city_id = city.city_id
INNER JOIN country 
ON city.country_id = country.country_id
WHERE country LIKE 'Nepal';


-- 5. Which staff member had the most transactions?
SELECT staff.staff_id, first_name, last_name, COUNT(payment.staff_id)
FROM staff 
INNER JOIN payment 
ON staff.staff_id = payment.staff_id
GROUP BY staff.staff_id;
-- A: Jon Stephens (staff_id 2) had the most transactions with 7,304


-- 6. How many movies of each rating are there?
SELECT rating, COUNT(DISTINCT film_id)
FROM film 
GROUP BY rating;
-- A: There are 209 NC-17 films, 178 G films, 223 PG-13 films, 194 PG films, and 196 R films.


-- 7. Show all customer who have made a single payment above $6.99 (use subqueries)
SELECT first_name, last_name
FROM customer
INNER JOIN payment
ON customer.customer_id = payment.customer_id
WHERE payment_id IN (
	SELECT payment_id
	FROM payment
	WHERE amount > 6.99
);
-- A: Douglas Graf, Mary Smith, Alfredo Mcadams, Peter Menard, and Alvin Deloach have all made at least one payment above $6.99.


-- 8. How many free rentals did our stores give away?
SELECT COUNT(DISTINCT rental.rental_id)
FROM rental 
INNER JOIN payment 
ON rental.rental_id = payment.rental_id
WHERE payment.amount <= 0;
-- A: There were 14,565 rentals given away (i.e. recorded payment for the rental < $0)