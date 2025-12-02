-- Ejercicio examen final
-- De cada pelicula en el listado deberá indicar:
-- - NOMBRE DE LA PELICULA
-- - CANTIDAD DE ACTORES QUE ACTUAN
-- - CANTIDAD TOTAL DE ALQUILERES QUE SE REALIZARON DE ESA PELICULA
-- - CANTIDAD DE ALQUILERES NO DEVUELTOS DE ESA PELICULA

-- HACER UNA SOLA CONSULTA, NO USAR VARIABLES NI TABLAS TEMPORALES
-- El estado de los datos de ejemplo es uno de los posibles estados,
-- la consulta debe funcionar correctamente cualquiera sean los datos.

-- --------------------------------------------------------------------------------------------------------------------

SELECT film.title AS NOMBRE_PELI,
(
SELECT COUNT(*) from actor
JOIN film_actor fa ON fa.actor_id = actor.actor_id
WHERE fa.film_id = film.film_id
) AS CANT_ACTORES,
(
SELECT COUNT(*) FROM inventory
JOIN rental r ON r.inventory_id = inventory.inventory_id
WHERE inventory.film_id = film.film_id
) AS CANT_ALQUILERES,
(
SELECT COUNT(*) FROM inventory
JOIN rental r ON r.inventory_id = inventory.inventory_id
WHERE inventory.film_id = film.film_id AND r.return_date IS NULL
) AS CANT_NO_DEV
FROM film
GROUP BY film.film_id, film.title
ORDER BY film.title;