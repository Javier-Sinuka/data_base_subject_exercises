-- Ejercicio examen final
-- De cada actor en el listado deberá indicar:
-- - NOMBRE Y APELLIDO
-- - CANTIDAD DE PELICULAS QUE ACTUO
-- - CANTIDAD TOTAL DE ALQUILERES QUE SE REALIZARON DE SUS PELICULAS
-- - CANTIDAD DE ALQUILERES NO DEVUELTOS DE ESE ACTOR

-- HACER UNA SOLA CONSULTA, NO USAR VARIABLES NI TABLAS TEMPORALES
-- El estado de los datos de ejemplo es uno de los posibles estados,
-- la consulta debe funcionar correctamente cualquiera sean los datos.

-- --------------------------------------------------------------------------------------------------------------------

SELECT actor.first_name AS NOMBRE,
actor.last_name AS APELLIDO
FROM actor
ORDER BY actor.actor_id;

SELECT actor.first_name AS NOMBRE,
actor.last_name AS APELLIDO,
(
SELECT COUNT(*) FROM film_actor
WHERE film_actor.actor_id = actor.actor_id
) AS CANT_PEL_ACTU,
(
SELECT COUNT(*) FROM film
JOIN inventory ON inventory.film_id = film.film_id
JOIN rental ON rental.inventory_id = inventory.inventory_id
JOIN film_actor fa ON fa.film_id = film.film_id
WHERE fa.actor_id = actor.actor_id
) AS CANT_ALQ,
(
SELECT COUNT(*) FROM film
JOIN inventory ON inventory.film_id = film.film_id
JOIN rental ON rental.inventory_id = inventory.inventory_id
JOIN film_actor fa ON fa.film_id = film.film_id
WHERE fa.actor_id = actor.actor_id AND rental.return_date IS NULL
) AS NO_DEVUELTOS
FROM actor
JOIN film_actor ON film_actor.actor_id = actor.actor_id
GROUP BY actor.actor_id
ORDER BY actor.actor_id;