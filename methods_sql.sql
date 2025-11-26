-- ****************************** BASIC SELECT ***************************

SELECT title FROM film;

SELECT film_id, title FROM film;

-- ****************************** BASIC DISTINCT ***************************
  
SELECT DISTINCT city FROM city;

-- ****************************** BASIC WHERE (IMPORTANT) ***************************

SELECT film_id, title FROM film WHERE (film_id>=1 && film_id<=10);

-- ****************************** BASIC ORDER BY ***************************

SELECT * FROM film ORDER BY rental_rate;

SELECT * FROM film ORDER BY length;

SELECT * FROM film ORDER BY rental_duration ASC; -- ASCENDENTE

SELECT * FROM film ORDER BY rental_duration DESC; -- DESCENDENTE

-- ****************************** MERGE TO HERE (ALL) ***************************

SELECT * FROM actor
WHERE first_name='JOE' 
ORDER BY last_update DESC;

SELECT * FROM film
WHERE rental_duration=5
ORDER BY length DESC;

SELECT * FROM film
WHERE rental_duration=5
ORDER BY length ASC;

-- ****************************** BASIC LIKE ***************************

SELECT * FROM film WHERE title LIKE '%R%'; -- Trae desde 'title' lo que contenga una R (si importar lo que tenga adelante o atras)

SELECT * FROM film WHERE title LIKE '%ICE' ORDER BY rental_duration ASC;

-- ****************************** BASIC NOT, AND, OR ***************************

SELECT * FROM film WHERE NOT title LIKE '%R%'; -- USO DE NOT-> Trae desde 'title' lo que NO contenga una R (si importar lo que tenga adelante o atras)

SELECT * FROM film WHERE NOT title LIKE '%R%' AND rental_duration=6; -- USO DE AND-> Trae desde 'title' lo que NO contenga una R y que su RENTAL_DURATION sea igual a 6

SELECT * FROM film WHERE NOT title LIKE '%R%' OR rental_duration=6; -- USO DE OR-> Trae desde 'title' lo que NO contenga una R o que su RENTAL_DURATION sea igual a 6 (no se excluyen entre si)

-- ****************************** BASIC NULL ***************************

SELECT * FROM film WHERE original_language_id IS NULL;

SELECT * FROM film WHERE original_language_id IS NOT NULL;

-- ****************************** BASIC MIN-MAX ***************************

SELECT MAX(rental_rate) FROM film; -- No podemos obtener mas datos (a priori)

SELECT MIN(rental_rate) FROM film;

-- ****************************** BASIC COUNT, SUM, AVG ***************************

SELECT COUNT(*) FROM film WHERE rental_duration=6; -- CUENTA LA CANTIDAD DE LOS ELEMENTOS DE LA COLUMNA CUMPLEN CON EL REQUISITO

SELECT COUNT(*) FROM film WHERE rental_duration>=6;

SELECT SUM(rental_rate) FROM film WHERE rental_rate>=1; -- SUMA LA COLUMNA SELECCIONADA, CON LOS REQUISITOS REQUERIDOS

SELECT SUM(length) FROM film WHERE length>=70 AND length<=100;

SELECT AVG(length) FROM film; -- DEVUELVE UN PROMEDIO DE LA COLUMNA SELECCIONADA

SELECT AVG(rental_duration) FROM film WHERE rental_rate >= 2;

-- ****************************** BASIC IN ***************************

SELECT * FROM film WHERE title IN ('ACADEMY DINOSAUR', 'ace goldfinger');

-- ****************************** BASIC BETWEEN ***************************

SELECT * FROM film WHERE rental_rate BETWEEN 2.5 AND 4 ORDER BY rental_duration ASC;

-- ****************************** BASIC AS - CONCAT ***************************

SELECT title AS 'TITULO' FROM film;

SELECT CONCAT('Nombre Film: ', title) AS 'NOMBRE PELICULA' FROM film; -- Uso mas generico los dos juntos

-- ****************************** BASIC GROUP BY ***************************

SELECT MAX(rental_duration) FROM film GROUP BY rental_duration ORDER BY rental_duration ASC;

SELECT MAX(rental_rate) FROM film GROUP BY rental_rate ORDER BY rental_rate ASC;

SELECT category_id, COUNT(*) FROM film_category GROUP BY category_id;

SELECT rating, AVG(length) FROM film GROUP BY rating;

SELECT city_id, COUNT(*) FROM address GROUP BY city_id;




