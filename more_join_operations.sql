-- Give year of 'Citizen Kane'.
SELECT yr FROM movie
WHERE title = 'Citizen Kane'

-- List all of the Star Trek movies, include the id, 
-- title and yr (all of these movies include the words Star Trek in the title). Order results by year.

SELECT id, title, yr FROM movie
WHERE title LIKE '%Star Trek%'
ORDER BY yr

-- What id number does the actor 'Glenn Close' have?

SELECT id FROM actor
WHERE name = 'Glenn Close'

-- What is the id of the film 'Casablanca'

SELECT id FROM movie
WHERE title = 'Casablanca'

-- Obtain the cast list for 'Casablanca'.

SELECT name
  FROM casting, actor
  WHERE movieid=(SELECT id 
             FROM movie 
             WHERE title='Casablanca')
    AND actorid=actor.id


-- Obtain the cast list for the film 'Alien'

SELECT name
  FROM movie, casting, actor
  WHERE title='Alien'
    AND movieid=movie.id
    AND actorid=actor.id
    
--   List the films in which 'Harrison Ford' has appeared

SELECT title FROM movie, casting, actor
WHERE name = 'Harrison Ford'
AND movieid = movie.id
AND actorid = actor.id

-- List the films where 'Harrison Ford' has appeared - but not in the starring role.

SELECT title FROM movie, casting, actor
WHERE name = 'Harrison Ford' AND ord != 1
AND movieid = movie.id
AND actorid = actor.id

-- List the films together with the leading star for all 1962 films.

SELECT title, name FROM movie, casting, actor
WHERE name = 'Harrison Ford' AND ord = 1
AND movieid = movie.id
AND actorid = actor.id

-- Which were the busiest years for 'Rock Hudson', show the year
-- and the number of movies he made each year for any year in which he made more than 2 movies

SELECT yr,COUNT(title) FROM
  movie JOIN casting ON movie.id=movieid
        JOIN actor   ON actorid=actor.id
WHERE name='Doris Day'
GROUP BY yr
HAVING COUNT(title) > 1

-- List the film title and the leading actor for all of the films 'Julie Andrews' played in.

SELECT title, name
  FROM movie, casting, actor
  WHERE movieid=movie.id
    AND actorid=actor.id
    AND ord=1
    AND movieid IN
    (SELECT movieid FROM casting, actor
     WHERE actorid=actor.id
     AND name='Julie Andrews')
;

-- Obtain a list, in alphabetical order, of actors who've had at least 15 starring roles.

SELECT name FROM casting
JOIN actor
ON actorid = actor.id
WHERE ord = 1
GROUP BY name
HAVING COUNT(movieid) >= 15

-- List the films released in the year 1978 ordered by the number of actors in the cast, then by title.

SELECT title, COUNT(actorid)
  FROM casting,movie                
  WHERE yr=1978
        AND movieid=movie.id
  GROUP BY title
  ORDER BY 2 DESC, title
;

-- List all the people who have worked with 'Art Garfunkel'.

SELECT DISTINCT d.name
FROM actor d JOIN casting a ON (a.actorid=d.id)
   JOIN casting b ON (a.movieid=b.movieid)
   JOIN actor c ON (b.actorid=c.id 
                AND c.name='Art Garfunkel')
  WHERE d.id!=c.id


