/*Generar una consulta SQL que genere un registro para cada combinacion film y pais,
La consulta calculará la cantidad de alquileres de ese film realizados por clientes que viven en ese pais. 
Si no hay alquileres de un film realizados por clientes de un pais poner 0 (cero), no se aceptan null. (10pts)
Además, incluir una columna que contenga la cantidad de alquileres no devueltos de ese film por clientes que viven en ese pais.(10pts)
Por último agregar una columna que recupere la cantidad de copias que existen de ese film (este valor se repetirá por cada registro de un mismo film).(10pts)
Ordenar por CANTIDAD_ALQ descendente.(5pts)
El listado debe incluir SOLO los films que tengan en total mas de 20 alquileres combinados con TODOS los paises. (15pts)
El reporte tendra las siguientes columnas:
TITULO_FILM NOMBRE_PAIS CANTIDAD_ALQ NO_DEVUELTOS COPIAS_FILM
*/
-- film->inventory->store->addres->city->country
-- store->customer->address->city->country
SELECT 
    film.title AS TITULO_FILM,
    country.country AS PAIS,
    COUNT(rental.rental_id) AS CANTIDAD_ALQ,
    (
    SELECT COUNT(*) FROM film f
    JOIN inventory i ON i.film_id = f.film_id
    JOIN rental r ON r.inventory_id = i.inventory_id
    WHERE f.film_id = film.film_id AND r.return_date IS NULL
    ) AS NO_DEVUELTOS,
    (
    SELECT COUNT(*)
    FROM inventory i
    WHERE i.film_id = film.film_id
	) AS COPIAS_FILM
FROM film
JOIN inventory      ON inventory.film_id = film.film_id
JOIN rental         ON rental.inventory_id = inventory.inventory_id
JOIN customer       ON customer.customer_id = rental.customer_id
JOIN address        ON address.address_id = customer.address_id
JOIN city           ON city.city_id = address.city_id
JOIN country        ON country.country_id = city.country_id
GROUP BY film.film_id, country.country_id
ORDER BY film.title, country.country;


