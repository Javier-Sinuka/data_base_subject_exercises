-- Implemente una consulta sobre la base de datos “Sakila” que retorne un listado donde por cada actor de la tabla 'actor' lo siguiente:
-- El listado tendrá las siguientes columnas:
-- - Nombre y apellido del actor
-- - la película de las que protagonizó ese actor que más recaudó
-- - el monto total que recaudó en todas sus películas
-- - cuantos actores recaudaron (en total) más que él
-- El estado actual de los datos es uno de los posibles estados, la consulta debe funcionar
-- correctamente cualquiera sea el estado de los datos, puede que sea necesario modificar
-- los datos para probar diferentes posibilidades.

-- SELECT actor.first_name AS NOMBRE,
-- actor.last_name AS APELLIDO,
-- (
-- SELECT f.title FROM film f
-- JOIN film_actor fa ON fa.film_id = f.film_id
-- JOIN inventory i ON i.film_id = fa.film_id
-- JOIN rental r ON r.inventory_id = i.inventory_id
-- JOIN payment p ON p.rental_id = r.rental_id
-- WHERE fa.actor_id = actor.actor_id
-- GROUP BY f.title
-- ORDER BY SUM(p.amount) DESC
-- LIMIT 1
-- ) AS PELI_MAS_RECAUDO,
-- (
-- SELECT SUM(p.amount) AS SUMA
-- FROM film f
-- JOIN film_actor fa ON fa.film_id = f.film_id
-- JOIN inventory i ON i.film_id = fa.film_id
-- JOIN rental r ON r.inventory_id = i.inventory_id
-- JOIN payment p ON p.rental_id = r.rental_id
-- WHERE fa.actor_id = actor.actor_id
-- ) AS MONTO_TOTAL_PELIS
-- FROM actor;

-- CON MI SOLUCION NO PUDE LLEGAR A CONSEGUIR EL TOTAL DE ACTORES QUE RECAUDARON MAS QUE EL
-- LA RESPUESTA DE ABAJO LO HACE, PERO ES LA RESPUESTA DE GPT, ME MAREA Y NO QUIERO APRENDERLA (MANANA SE RINDE WACHOOOO)
-- EXITOS PARA MI YO DEL FUTURO JAJA ESPERO ESTE REPOSITORIO DESAPAREZCA, PARA QUE SEPAMOS QUE SE APROBO

SELECT  x.NOMBRE,
        x.APELLIDO,
        x.MONTO_TOTAL_PELIS,
        (
          SELECT COUNT(*)
          FROM (
            SELECT fa2.actor_id,
                   SUM(p2.amount) AS total_amount
            FROM film f2
            JOIN film_actor fa2 ON fa2.film_id = f2.film_id
            JOIN inventory i2   ON i2.film_id = fa2.film_id
            JOIN rental r2      ON r2.inventory_id = i2.inventory_id
            JOIN payment p2     ON p2.rental_id = r2.rental_id
            GROUP BY fa2.actor_id
          ) t2
          WHERE t2.total_amount > x.MONTO_TOTAL_PELIS
        ) AS MAS_QUE_EL
FROM (
    SELECT actor.first_name AS NOMBRE,
           actor.last_name  AS APELLIDO,
           (
             SELECT SUM(p.amount)
             FROM film f
             JOIN film_actor fa ON fa.film_id = f.film_id
             JOIN inventory i   ON i.film_id = fa.film_id
             JOIN rental r      ON r.inventory_id = i.inventory_id
             JOIN payment p     ON p.rental_id = r.rental_id
             WHERE fa.actor_id = actor.actor_id
           ) AS MONTO_TOTAL_PELIS
    FROM actor
) x;
