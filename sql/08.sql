/*
 * The film 'BUCKET BROTHERHOOD' is your favorite movie, but you're tired of watching it.
 * You want to find something new to watch that is still similar to 'BUCKET BROTHERHOOD'.
 * To find a similar movie, you decide to search the history of movies that other people have rented.
 * Your idea is that if a lot of people have rented both 'BUCKET BROTHERHOOD' and movie X,
 * then movie X must be similar and something you'd like to watch too.
 * Your goal is to create a SQL query that finds movie X.
 * Specifically, write a SQL query that returns all films that have been rented by at least 3 customers who have also rented 'BUCKET BROTHERHOOD'.
 *
 * HINT:
 * This query is very similar to the query from problem 06,
 * but you will have to use joins to connect the rental table to the film table.
 *
 * HINT:
 * If your query is *almost* getting the same results as mine, but off by 1-2 entries, ensure that:
 * 1. You are not including 'BUCKET BROTHERHOOD' in the output.
 * 2. Some customers have rented movies multiple times.
 *    Ensure that you are not counting a customer that has rented a movie twice as 2 separate customers renting the movie.
 *    I did this by using the SELECT DISTINCT clause.
 */
WITH rented_film AS (
    SELECT f2.title
    FROM film f1
    JOIN inventory inv1 ON inv1.film_id = f1.film_id
    JOIN rental r1 ON r1.inventory_id = inv1.inventory_id
    JOIN rental r2 ON r2.customer_id = r1.customer_id
    JOIN inventory inv2 ON inv2.inventory_id = r2.inventory_id
    JOIN film f2 ON f2.film_id = inv2.film_id AND f2.film_id != f1.film_id
    WHERE f1.title = 'BUCKET BROTHERHOOD'
    GROUP BY f2.title, r2.customer_id
)

SELECT title
FROM (
    SELECT title, count(*) AS rental_times
    FROM rented_film
    GROUP BY title
) t
WHERE rental_times >= 3
ORDER BY title;
