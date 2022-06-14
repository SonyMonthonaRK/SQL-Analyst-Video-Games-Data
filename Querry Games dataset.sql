SELECT *
FROM game_sales
ORDER BY games_sold DESC
LIMIT 10;

SELECT
    COUNT(*)
FROM game_sales AS g
LEFT JOIN reviews AS r
    USING(game)
WHERE critic_score IS NULL AND user_score IS NULL

SELECT
    year,
    ROUND(AVG(critic_score), 2) AS avg_critic_score
FROM game_sales 
LEFT JOIN reviews
    USING(game)
GROUP BY year
ORDER BY avg_critic_score DESC
LIMIT 10;

SELECT
    year,
    ROUND(AVG(critic_score), 2) AS avg_critic_score,
    COUNT(g.game) AS num_games
FROM game_sales AS g
INNER JOIN reviews AS r
    USING(game)
GROUP BY year
HAVING COUNT(g.game) > 4
ORDER BY avg_critic_score DESC
LIMIT 10;

SELECT
    year,
    avg_critic_score
FROM top_critic_years
EXCEPT
SELECT
    year,
    avg_critic_score
FROM top_critic_years_more_than_four_games;

SELECT
    year,
    ROUND(AVG(user_score), 2) AS avg_user_score,
    COUNT(g.game) AS num_games
FROM game_sales AS g
INNER JOIN reviews AS r
    USING(game)
GROUP BY year
HAVING COUNT(g.game) > 4
ORDER BY avg_user_score DESC
LIMIT 10;

SELECT 
    year
FROM top_critic_years_more_than_four_games
INTERSECT
SELECT 
    year 
FROM top_user_years_more_than_four_games
ORDER BY year

SELECT
    year,
    SUM(games_sold) AS total_games_sold
FROM game_sales
WHERE year IN (SELECT 
                    year
                FROM top_critic_years_more_than_four_games
                INTERSECT
                SELECT 
                    year 
                FROM top_user_years_more_than_four_games
                )
GROUP BY year
ORDER BY total_games_sold DESC;