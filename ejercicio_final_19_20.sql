-- Ejercicio examen final
-- Sobre SAKILA, para cada categoria de peliculas, se liste lo siguiente:
-- - NOMBRE DE LA CATEGORIA
-- - CANTIDAD DE ALQUILERES REALIZADOS DE FILMS DE DICHA CATEGORIA
-- - EL AÑO CON MAYOR CANTIDAD DE ALQUILERES DE DICHA CATEGORIA
-- - PORCENTAJE DE CLIENTES QUE ALQUILARON PELICUCLAS DE DICHA CATEGORIA
-- - PELICULA MAS ALQUILADA DE ESA CATEGORIA

-- HACER UNA SOLA CONSULTA, NO USAR VARIABLES NI TABLAS TEMPORALES
-- El estado de los datos de ejemplo es uno de los posibles estados,
-- la consulta debe funcionar correctamente cualquiera sean los datos.

-- --------------------------------------------------------------------------------------------------------------------

SELECT category.name AS NOMBRE_CAT,
(
SELECT COUNT(*) FROM category c
JOIN film_category fc ON fc.category_id = category.category_id
JOIN film f ON f.film_id = fc.film_id
JOIN inventory i  ON i.film_id = f.film_id
JOIN rental r ON r.inventory_id = i.inventory_id
WHERE category.category_id = c.category_id
) AS ALQUILERES_TOT
FROM category;

-- DEJO ESTA VERSION DE ABAJO PORQUE ESTA BUENA COMO HACE LA CONSULTA, SIN TENER QUE SALIR DIRECTAMENTE DESDE CATEGORY
-- SINO QUE RELACIONA A ESTA TABLA DESDE EL WHERE, CON LA DE FILM CATEGORY
-- SELECT 
--     category.name AS NOMBRE_CAT,
--     (
--         SELECT COUNT(*)
--         FROM film_category fc
--         JOIN inventory i  ON i.film_id = fc.film_id
--         JOIN rental r ON r.inventory_id = i.inventory_id
--         WHERE fc.category_id = category.category_id
--     ) AS ALQUILERES_TOT
-- FROM category;

-- CONSULTA COMPLETA 

SELECT category.name AS NOMBRE_CAT,
(
SELECT COUNT(*) FROM category c
JOIN film_category fc ON fc.category_id = category.category_id
JOIN film f ON f.film_id = fc.film_id
JOIN inventory i  ON i.film_id = f.film_id
JOIN rental r ON r.inventory_id = i.inventory_id
WHERE category.category_id = c.category_id
) AS ALQUILERES_TOT,
(
SELECT YEAR(r.rental_date) FROM rental r
JOIN inventory i ON i.inventory_id = r.inventory_id
JOIN film f ON f.film_id = i.film_id
JOIN film_category fc ON fc.film_id = f.film_id
WHERE fc.category_id = category.category_id
GROUP BY YEAR(r.rental_date)
ORDER BY COUNT(*) DESC
LIMIT 1
) AS ANO_MAYOR_ALQ,
(
SELECT 
((100 * COUNT(DISTINCT r.customer_id))/(SELECT COUNT(*) FROM customer))
FROM film_category fc2
JOIN inventory i2 ON i2.film_id = fc2.film_id
JOIN rental r ON r.inventory_id = i2.inventory_id
WHERE fc2.category_id = category.category_id
) AS PORC_CLIENTES,
(
SELECT f2.title
FROM film_category fc2
JOIN film f2 ON f2.film_id = fc2.film_id
JOIN inventory i2 ON i2.film_id = f2.film_id
JOIN rental r2 ON r2.inventory_id = i2.inventory_id
WHERE fc2.category_id = category.category_id
GROUP BY f2.film_id, f2.title
ORDER BY COUNT(*) DESC
LIMIT 1
) AS PELI_MAS_ALQ
FROM category;


