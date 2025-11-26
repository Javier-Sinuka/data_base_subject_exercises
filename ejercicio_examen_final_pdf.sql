-- Ejercicio examen final
-- De cada película en el listado deberá indicar:
-- - NOMBRE DE LA PELÍCULA
-- - CANTIDAD DE ACTORES QUE ACTÚAN
-- - CANTIDAD DE ALQUILERES NO DEVUELTOS DE ESA PELÍCULA
-- - PROMEDIO DE RECAUDACION DE TODAS LAS PELICULAS (esta columna tendrá el mismo valor
-- en todas las filas)
-- HACER UNA SOLA CONSULTA, NO USAR VARIABLES NI TABLAS TEMPORALES
-- El estado de los datos de ejemplo es uno de los posibles estados,
-- la consulta debe funcionar correctamente cualquiera sean los datos.

-- --------------------------------------------------------------------------------------------------------------------

-- select film.title, COUNT(*) as cantidad_actores
-- from film
-- join film_actor on film_actor.film_id = film.film_id
-- join actor on actor.actor_id = film_actor.actor_id
-- group by film.film_id;

-- select film.title, COUNT(*) as no_devueltos
-- from film
-- join inventory on inventory.film_id = film.film_id
-- join rental on rental.inventory_id = inventory.inventory_id
-- where rental.return_date is null
-- group by film.film_id
-- order by no_devueltos desc;

-- SELECT AVG(t.recaudacion_por_pelicula) AS promedio_recaudacion
-- FROM (
--     SELECT f.film_id, SUM(p.amount) AS recaudacion_por_pelicula
--     FROM film f
--     JOIN inventory i ON i.film_id = f.film_id
--     JOIN rental r    ON r.inventory_id = i.inventory_id
--     JOIN payment p   ON p.rental_id = r.rental_id
--     GROUP BY f.film_id
-- ) AS t;

SELECT AVG(t.recaudacion_por_pelicula) AS promedio_recaudacion
FROM (
    SELECT f.film_id, SUM(p.amount) AS recaudacion_por_pelicula
    FROM film f
    JOIN inventory i ON i.film_id = f.film_id
    JOIN rental r    ON r.inventory_id = i.inventory_id
    JOIN payment p   ON p.rental_id = r.rental_id
    GROUP BY f.film_id
) AS t;

select film.title, COUNT(*) as cantidad_actores,
(
	select COUNT(*) as no_devueltos
	from film f
	join inventory i on i.film_id = f.film_id
	join rental r on r.inventory_id = i.inventory_id
	where r.return_date is null and i.film_id = film.film_id
) as no_devueltos,
(
SELECT AVG(t.recaudacion_por_pelicula) AS promedio_recaudacion
FROM (
    SELECT f.film_id, SUM(p.amount) AS recaudacion_por_pelicula
    FROM film f
    JOIN inventory i ON i.film_id = f.film_id
    JOIN rental r    ON r.inventory_id = i.inventory_id
    JOIN payment p   ON p.rental_id = r.rental_id
    GROUP BY f.film_id
) AS t
) as promedio
from film
join film_actor on film_actor.film_id = film.film_id
join actor on actor.actor_id = film_actor.actor_id
group by film.film_id
order by film.film_id asc;




