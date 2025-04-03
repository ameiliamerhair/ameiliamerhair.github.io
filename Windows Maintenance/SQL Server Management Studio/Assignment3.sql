/*	Author: Ameilia Merhair
	Date:	November 8th, 2024.
	Edited:	November 18th, 2024.
	Class:	INFT-1105
	Descrption:
	Introduction to Databases - Assignment 3.
*/

/* Question 1: 
Create an SQL statement that adds yourself and your favourite actor to the Players table.  
Use your real first and last names, your real dob, and use your studentID as the regNumber.  
Make yourself active and use a playerID of your own choice. Make up the information for the favourite actor. 
*/
INSERT INTO players VALUES (1300, 100991995, 'Merhair', 'Ameilia', 1,CONVERT(DATETIME, '2006-11-08', 102));
INSERT INTO players VALUES (1301, 103032006, 'Sandler', 'Adam', 1, CONVERT(DATETIME, '1966-09-09', 102));

/* Question 2:
Create an SQL statement that change your professor’s (whom is a player in the database) dob to be June 27, 1998. */
DELETE FROM players
WHERE playerID = 1332;
INSERT INTO players VALUES (1332,71157,'Short','Jennifer', 1,CONVERT(DATETIME, '1998-06-27',102));

/* Question 3:
Create a statement that adds both yourself, your favourite actor, and your professor to the team called “Noobs” making yourself active and your professor not active.  
Choose a jersey number for yourself and your favourite actor, and use the number 16 for your prof. This must be done in one insert statement, not separate ones. 
Create a query to display all data from the players table where the first name is Jennifer. */
INSERT INTO teams VALUES (1, 'Noobs', 1, 'Green');
INSERT INTO rosters VALUES	(1300, 1, 1, 08),
							(1301, 1, 1, 09),
							(1332, 1, 0, 16);
SELECT * FROM players
WHERE firstname = 'Jennifer';

/* Question 4: 
Create a query that outputs the team roster for all active teams in the league. 
Include the player names (last name then first name concatenated together with a space in between)
, jersey number, and team name in each row, further sorted by last name, then by first name. */
SELECT 
    CONCAT(p.lastName, ' ', p.firstName) AS PlayerName,
    r.jerseynumber AS JerseyNumber,
    t.teamname AS TeamName
FROM 
    rosters r
JOIN 
    players p ON r.playerid = p.playerid
JOIN
    teams t ON r.teamid = t.teamid
WHERE 
    t.isactive = 1
ORDER BY 
    p.lastname, p.firstname

/* Question 5:
Create a query that outputs the league schedule (game number, date, both team names, and location name) for all future games, or games not yet played.  
Sort the output in ascending chronological order.  Use JOIN and not sub-queries. */
SELECT 
    g.gameid AS GameNumber,
    g.gamedatetime AS GameDate,
    ht.teamname AS HomeTeam,
    vt.teamname AS VisitTeam,
    l.locationName
FROM 
    games g
INNER JOIN 
    teams ht ON g.hometeam = ht.teamid
INNER JOIN 
    teams vt ON g.visitteam = vt.teamid
INNER JOIN 
    locations l ON g.locationid = l.locationid
WHERE 
    g.gamedatetime > GETDATE() OR g.isplayed = 0
ORDER BY 
    g.gamedatetime ASC;

/* Question 6:
Repeat Question 5, but use sub-queries to obtain the team names, rather than JOINS.  
You may still use JOINS for other output if required.  
Note: you should obtain the exact same output in Q5 and Q6. */
SELECT 
    g.gameid AS GameNumber,
    g.gamedatetime AS GameDate,
    (SELECT teamname FROM teams WHERE teamid = g.hometeam) AS HomeTeam,
    (SELECT teamname FROM teams WHERE teamid = g.visitteam) AS VisitTeam,
    l.locationName
	FROM 
		games g
	JOIN 
		locations l ON g.locationid = l.locationid
	WHERE 
		g.gamedatetime > GETDATE() OR g.Isplayed = 0
	ORDER BY 
		g.gamedatetime ASC;

/* Question 7:
Take the statement from either Q5 or Q6 and store it in the database as a view, called vwFutureGames.  
Then create a query that uses the view to output the exact same results, including sorting. */
CREATE VIEW vwFutureGames AS
SELECT 
    g.gameid AS GameNumber,
    g.gamedatetime AS GameDate,
    (SELECT teamname FROM teams WHERE teamid = g.hometeam) AS HomeTeam,
    (SELECT teamname FROM teams WHERE teamid = g.visitteam) AS VisitTeam,
    l.locationName
FROM 
    games g
JOIN 
    locations l ON g.locationid = l.locationid
WHERE 
    g.gamedatetime > GETDATE() OR g.Isplayed = 0;

SELECT * FROM vwFutureGames
ORDER BY GameDate ASC;

/* Question 8: 
Create a query that outputs the names of the soccer fields (locations) in the database that have never been assigned a game within the league.  
You may NOT use JOINS or Sub-Queries in the main statement, but you may use a sub-query to obtain the names afterwards.
*/
SELECT locationname AS LocationName
FROM locations
WHERE locationid NOT IN (SELECT locationid FROM games);

/* Question 9: 
Repeat Question 8 using JOINS and NOT set operators. */
SELECT l.locationName AS LocationName
FROM locations l
LEFT JOIN games g ON l.locationid = g.locationid
WHERE g.locationid IS NULL;

/* Question 10:
Create a query that outputs the number of games each team has played as the home team and how many games they have played as the away team as of today.  
You may assume that the isPlayed field is up to date. */
SELECT 
    t.teamid AS TeamID,
    t.teamname AS TeamName,
    ISNULL(home.gamesPlayed, 0) AS HomeGames,
    ISNULL(away.gamesPlayed, 0) AS AwayGames
FROM 
    teams t
LEFT JOIN 
    (SELECT hometeam, COUNT(*) AS gamesPlayed 
     FROM games 
     WHERE isPlayed = 1 
     GROUP BY hometeam) AS home 
ON t.teamid = home.hometeam
LEFT JOIN 
    (SELECT visitteam, COUNT(*) AS gamesPlayed 
     FROM games 
     WHERE isPlayed = 1 
     GROUP BY visitteam) AS away 
ON t.teamid = away.visitteam
ORDER BY 
    t.teamid;