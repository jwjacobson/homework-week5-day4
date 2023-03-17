--Question 1

CREATE OR REPLACE PROCEDURE add_film(title varchar(50), description varchar(100), release_year INT, language_id INT,
rental_duration INT, rental_rate NUMERIC(5,2), length INT, replacement_cost NUMERIC(5,2), rating mpaa_rating)
LANGUAGE plpgsql
AS $$
BEGIN
	INSERT INTO film(title, description, release_year, language_id, rental_duration, rental_rate, length, replacement_cost, rating)
	VALUES(title, description, release_year, language_id, rental_duration, rental_rate, length, replacement_cost, rating);
END;
$$;

--ADD a film
CALL add_film('Tales of GNU', 'Hijinks ensue when a grumpy hacker is takes in a tech-illiterate orphan', 1992, 1, 7, 0.02, 79, 0.0, 'PG')

--CHECK that it's in the database
SELECT *
FROM film
WHERE title LIKE 'Tales%'


--Question 2

--Original query
SELECT count(*)
FROM film_category
JOIN film
ON film_category.film_id = film.film_id
GROUP BY category_id

--Function
CREATE OR REPLACE FUNCTION get_category_count(category_id int)
RETURNS int
LANGUAGE plpgsql
AS $$
		DECLARE category_count int;
BEGIN
	SELECT count(*) INTO category_count
	FROM film_category
	JOIN film
	ON film_category.film_id = film.film_id
	GROUP BY film_category.category_id;
	RETURN category_count;
END;
$$;