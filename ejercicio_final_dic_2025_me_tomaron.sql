SELECT actor.first_name AS NOMBRE,
actor. last_name AS APELLIDO,
(
SELECT COUNT(*) FROM actor a
JOIN film_actor fa ON fa.actor_id = a.actor_id
JOIN film_category fc ON fc.film_id = fa.film_id
JOIN category c ON c.category_id = fc.category_id
WHERE a.actor_id = actor.actor_id AND c.name = 'Horror'
) AS CANT_HORROR,
(
SELECT COUNT(*) FROM actor a
JOIN film_actor fa ON fa.actor_id = a.actor_id
JOIN film_category fc ON fc.film_id = fa.film_id
JOIN category c ON c.category_id = fc.category_id
WHERE a.actor_id = actor.actor_id AND c.name = 'Action'
) AS CANT_ACTION,
(
SELECT AVG(p.amount) FROM film_actor fa
JOIN inventory i ON i.film_id = fa.film_id
JOIN rental r ON r.inventory_id = i.inventory_id
JOIN payment p ON p.rental_id = r.rental_id
WHERE fa.actor_id = actor.actor_id
) AS PROMEDIO_PELI,
(
SELECT COUNT(*) FROM actor a
JOIN film_actor fa ON fa.actor_id = a.actor_id
JOIN film_category fc ON fc.film_id = fa.film_id
WHERE a.actor_id = actor.actor_id
) AS CANTIDAD_PEL
FROM actor
GROUP BY actor.actor_id
HAVING CANT_ACTION >= 2 AND CANT_HORROR >= 3
ORDER BY CANTIDAD_PEL DESC;
