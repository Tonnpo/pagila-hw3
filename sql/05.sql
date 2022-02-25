/*
 * You love the acting in the movie 'AMERICAN CIRCUS' and want to watch other movies with the same actors.
 *
 * Write a SQL query that lists the title of all movies where at least 2 actors were also in 'AMERICAN CIRCUS'.
 *
 * HINT:
 * This can be solved with a self join on the film_actor table.
 */
WITH favorite_actors AS (
    SELECT actor_id
    FROM film
    JOIN film_actor USING (film_id)
    WHERE title='AMERICAN CIRCUS'
)

SELECT DISTINCT title
FROM film
JOIN film_actor fa1 USING (film_id)
JOIN film_actor fa2 ON fa2.film_id = film.film_id AND fa2.actor_id != fa1.actor_id
WHERE fa1.actor_id IN (
    SELECT actor_id FROM favorite_actors
) AND fa2.actor_id IN (
    SELECT actor_id FROM favorite_actors
)
ORDER BY title;
