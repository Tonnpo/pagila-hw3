/*
 * List the first and last names of all actors who:
 * 1. have appeared in at least one movie in the "Children" category,
 * 2. but that have never appeared in any movie in the "Horror" category.
 */
SELECT DISTINCT first_name, last_name
FROM actor
JOIN film_actor USING (actor_id)
JOIN film USING (film_id)
JOIN film_category USING (film_id)
JOIN category USING (category_id)
WHERE actor_id IN (
    SELECT a2.actor_id
    FROM actor a1
    JOIN film_actor USING (actor_id)
    JOIN film USING (film_id)
    JOIN film_category USING (film_id)
    JOIN category USING (category_id)
    RIGHT JOIN actor a2 ON a1.actor_id = a2.actor_id AND name = 'Horror'
    WHERE a1.actor_id IS NULL
) AND name = 'Children'
ORDER BY last_name;
