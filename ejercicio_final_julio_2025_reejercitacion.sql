SELECT actor.last_name AS APELLIDOACTOR,
actor.first_name AS NOMBREACTOR,
(
SELECT COUNT(DISTINCT c.category_id) FROM actor a
JOIN film_actor fa ON fa.actor_id = a.actor_id
JOIN film_category fc ON fc.film_id = fa.film_id
JOIN category c ON c.category_id = fc.category_id
WHERE actor.actor_id = fa.actor_id
) AS CANTIDADDECATS,
(
SELECT c.name FROM actor a
JOIN film_actor fa ON fa.actor_id = a.actor_id
JOIN film_category fc ON fc.film_id = fa.film_id
JOIN category c ON c.category_id = fc.category_id
JOIN inventory i ON i.film_id = fc.film_id
JOIN rental r ON r.inventory_id = i.inventory_id
WHERE a.actor_id = actor.actor_id
GROUP BY c.category_id
ORDER BY COUNT(r.rental_id) DESC
LIMIT 1
) AS CATMAYOR,
(
SELECT COUNT(*) FROM rental r
JOIN inventory i ON i.inventory_id = r.inventory_id
JOIN film_category fc ON fc.film_id = i.film_id
JOIN film_actor fa ON fa.film_id = fc.film_id
JOIN category c ON c.category_id = fc.category_id
JOIN actor a ON a.actor_id = fa.actor_id
WHERE a.actor_id = actor.actor_id AND c.name = CATMAYOR
) AS CANTIDAD
FROM actor
ORDER BY CANTIDAD ASC;