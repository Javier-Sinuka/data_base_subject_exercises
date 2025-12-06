SELECT * FROM film;
SELECT * FROM inventory;

-- ****************************** INNER JOIN ***************************
SELECT title ,inventory_id FROM film
JOIN inventory
ON film.film_id = inventory.film_id;

SELECT title ,inventory_id FROM inventory
JOIN film
ON inventory.film_id = film.film_id;

SELECT customer.first_name, inventory.film_id FROM rental
JOIN customer ON rental.rental_id = customer.customer_id
JOIN inventory ON rental.rental_id = inventory.inventory_id;

SELECT customer.first_name, inventory.film_id, film.title FROM rental
JOIN customer ON rental.customer_id = customer.customer_id
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id;

-- ****************************** LEFT/RIGHT JOIN ***************************


SELECT title ,inventory_id FROM film
LEFT JOIN inventory
ON film.film_id = inventory.film_id;





