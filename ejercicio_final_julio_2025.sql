-- SELECT 
--     actor.first_name AS 'APELLIDOACTOR',
--     actor.last_name  AS 'NOMBREACTOR',
--     COUNT(DISTINCT category.name) AS 'CANTIDADDECATS',
--     -- Categoría más realizada por el actor
--     (
--         SELECT c.name
--         FROM film f
--         JOIN film_category fc ON fc.film_id = f.film_id
--         JOIN film_actor fa    ON fa.film_id = fc.film_id
--         JOIN category c       ON c.category_id = fc.category_id
--         WHERE fa.actor_id = actor.actor_id
--         GROUP BY c.category_id
--         ORDER BY COUNT(*) DESC
--         LIMIT 1
--     ) AS CATMAYOR,
--     -- Cantidad de alquileres de ESA categoría
--     (
--         SELECT COUNT(*)
--         FROM rental r
--         JOIN inventory inv  ON inv.inventory_id = r.inventory_id 
--         JOIN film fi        ON fi.film_id = inv.film_id
--         JOIN film_category fi_c ON fi_c.film_id = fi.film_id
--         JOIN category cat   ON cat.category_id = fi_c.category_id
--         WHERE cat.name = (
--             SELECT c.name
--             FROM film f
--             JOIN film_category fc ON fc.film_id = f.film_id
--             JOIN film_actor fa    ON fa.film_id = fc.film_id
--             JOIN category c       ON c.category_id = fc.category_id
--             WHERE fa.actor_id = actor.actor_id
--             GROUP BY c.category_id
--             ORDER BY COUNT(*) DESC
--             LIMIT 1
--         )
--     ) AS CANTIDAD
-- FROM film
-- JOIN film_category ON film_category.film_id = film.film_id
-- JOIN film_actor    ON film_actor.film_id = film_category.film_id
-- JOIN actor         ON actor.actor_id = film_actor.actor_id
-- JOIN category      ON category.category_id = film_category.category_id
-- GROUP BY actor.actor_id;


SELECT
    a.last_name  AS APELLIDOACTOR,
    a.first_name AS NOMBREACTOR,

    -- Cantidad de categorías DIFERENTES en las que actuó
    (
        SELECT COUNT(DISTINCT c.category_id)
        FROM film_actor fa
        JOIN film_category fc ON fc.film_id = fa.film_id
        JOIN category c       ON c.category_id = fc.category_id
        WHERE fa.actor_id = a.actor_id
    ) AS CANTIDADDECATS,

    -- Categoría con MÁS alquileres de películas de ese actor
    (
        SELECT c.name
        FROM film_actor fa
        JOIN film f          ON f.film_id = fa.film_id
        JOIN film_category fc ON fc.film_id = f.film_id
        JOIN category c      ON c.category_id = fc.category_id
        LEFT JOIN inventory i ON i.film_id = f.film_id
        LEFT JOIN rental r    ON r.inventory_id = i.inventory_id
        WHERE fa.actor_id = a.actor_id
        GROUP BY c.category_id, c.name
        ORDER BY COUNT(r.rental_id) DESC, c.name
        LIMIT 1
    ) AS CATMAYOR,

    -- Cantidad de alquileres de películas en ESA categoría (la que más alquila)
    COALESCE(
        (
            SELECT COUNT(r.rental_id)
            FROM film_actor fa
            JOIN film f          ON f.film_id = fa.film_id
            JOIN film_category fc ON fc.film_id = f.film_id
            JOIN category c      ON c.category_id = fc.category_id
            LEFT JOIN inventory i ON i.film_id = f.film_id
            LEFT JOIN rental r    ON r.inventory_id = i.inventory_id
            WHERE fa.actor_id = a.actor_id
            GROUP BY c.category_id
            ORDER BY COUNT(r.rental_id) DESC, c.category_id
            LIMIT 1
        ),
        0
    ) AS CANTIDAD

FROM actor a
ORDER BY CANTIDAD ASC, APELLIDOACTOR, NOMBREACTOR;



