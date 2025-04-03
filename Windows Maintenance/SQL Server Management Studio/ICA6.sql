/* Author: Ameilia Merhair
Date: 14th November 2024. 
Course: INFT 1105
Description: In-Class Activity #7
*/

/* Question 1: 
Use the NOT IN clause and a subquery to create a list of all 
composers who do not have any records in the songs table. 
Include only the composer name column in your result, 
but give this column an appropriate name.*/

SELECT ComposerName AS "Composers Not In Song Table"
FROM Composer
WHERE ComposerName NOT IN (
    SELECT ComposerName
    FROM Song
);

/* Question 2: 
List songs and cost that are higher than the average cost, order by song names. 
Hint: You will need to use a subquery.*/
SELECT SongName, cost AS Cost
FROM Song
WHERE Cost > (
    SELECT AVG(Cost)
    FROM Song
)
ORDER BY SongName;

/* Question 3:
a) Use a JOIN and a subquey to display artist name, song name, and cost. 
b) Do the same thing but only use a JOIN. */

SELECT
    a.ArtistName, 
    s.SongName, 
    s.Cost
FROM Artist a
JOIN Song s ON a.ArtistID = s.ArtistID
WHERE a.ArtistName IN (
    SELECT ArtistName
    FROM Artist
)
ORDER BY a.ArtistName;

SELECT
    a.ArtistName, 
    s.SongName, 
    s.Cost
FROM Artist a
JOIN Song s
ON a.ArtistID = s.ArtistID
ORDER BY a.ArtistName; 