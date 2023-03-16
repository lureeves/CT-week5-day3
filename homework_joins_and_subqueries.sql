				-- Question 1 --
-- List all customers who live in Texas (use JOINs)
SELECT c.first_name, c.last_name,  a.district
FROM customer c
JOIN address a
ON c.address_id = a.address_id
WHERE district = 'Texas';
--first_name|last_name|district|
------------+---------+--------+
--Jennifer  |Davis    |Texas   |
--Richard   |Mccrary  |Texas   |
--Bryan     |Hardison |Texas   |
--Ian       |Still    |Texas   |
--Kim       |Cruz     |Texas   |


							  -- Question 2 --
-- List all payments of more than $7.00 with the customer’s first and last name
SELECT c.first_name, c.last_name, p.amount
FROM customer c
JOIN payment p
ON c.customer_id = p.customer_id
WHERE amount > 7
--first_name|last_name  |amount|
------------+-----------+------+
--Peter     |Menard     |  7.99|
--Peter     |Menard     |  7.99|
--Peter     |Menard     |  7.99|
--Douglas   |Graf       |  8.99|
--Ryan      |Salisbury  |  8.99|
--Ryan      |Salisbury  |  8.99|


							  -- Question 3 --
-- Show all customer names who have made over $175 in payments (usesubqueries)
SELECT first_name, last_name
FROM customer
WHERE customer_id IN (
	SELECT customer_id 
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount) > 175
)
--first_name|last_name|
------------+---------+
--Rhonda    |Kennedy  |
--Clara     |Shaw     |
--Eleanor   |Hunt     |
--Marion    |Snyder   |
--Tommy     |Collazo  |
--Karl      |Seal     |
	


					     -- Question 4 --
-- List all customers that live in Argentina (use the city table)
SELECT *
FROM customer
WHERE address_id IN(
	SELECT address_id
	FROM address
	WHERE city_id IN (
		SELECT city_id
		FROM city
		WHERE country_id = (
			SELECT country_id
			FROM country 
			WHERE country = 'Argentina'
		)
	)
);
--customer_id|store_id|first_name|last_name|
-------------+--------+----------+---------+
--        331|       1|Eric      |Robert   |
--        219|       2|Willie    |Howell   |
--         89|       1|Julia     |Flores   |
--        243|       1|Lydia     |Burke    |
--        530|       2|Darryl    |Ashcraft |
--        107|       1|Florence  |Woods    |
--        445|       1|Micheal   |Forman   |



						 -- Question 5 --
-- Show all the film categories with their count in descending order
SELECT fc.category_id, name, COUNT(fc.category_id)
FROM category c
JOIN film_category fc
ON c.category_id = fc.category_id
JOIN film f 
ON f.film_id = fc.film_id
GROUP BY fc.category_id, name
ORDER BY COUNT(fc.category_id) DESC
--category_id|name       |count|
-------------+-----------+-----+
--         15|Sports     |   74|
--          9|Foreign    |   73|
--          8|Family     |   69|
--          6|Documentary|   68|
--          2|Animation  |   66|
--          1|Action     |   64|



					-- Question 6 --
-- What film had the most actors in it (show film info)?
SELECT title, description, COUNT(actor_id) AS num_actors
FROM film_actor fa
JOIN film f
ON fa.film_id = f.film_id
GROUP BY title, description
ORDER BY COUNT(actor_id) DESC
LIMIT 1;
--title           |description                                                                      |num_actors|
------------------+---------------------------------------------------------------------------------+----------+
--Lambs Cincinatti|A Insightful Story of a Man And a Feminist who must Fight a Composer in Australia|        15|



			  -- Question 7 --
-- Which actor has been in the least movies?
SELECT first_name, last_name, COUNT(last_name) AS movies_in
FROM actor a
JOIN film_actor fa
ON a.actor_id = fa.actor_id
GROUP BY first_name, last_name
ORDER BY movies_in
LIMIT 1
--first_name|last_name|movies_in|
------------+---------+---------+
--Emily     |Dee      |       14|



		   -- Question 8 --
-- Which country has the most cities?
SELECT country, COUNT(city) AS city_count
FROM city ci
JOIN country co
ON  ci.country_id = co.country_id
GROUP BY co.country
ORDER BY city_count DESC
LIMIT 1;
--country|city_count|
---------+----------+
--India  |        60|



		   -- Question 9 --
-- List the actors who have been in between 20 and 25 films.
SELECT first_name, last_name, COUNT(last_name) AS movies_in
FROM actor a
JOIN film_actor fa
ON a.actor_id = fa.actor_id
GROUP BY first_name, last_name
HAVING COUNT(last_name) BETWEEN 20 AND 25
ORDER BY movies_in
--first_name |last_name  |movies_in|
-------------+-----------+---------+
--Bette      |Nicholson  |       20|
--Christopher|Berry      |       20|
--Rita       |Reynolds   |       20|
--Thora      |Temple     |       20|





