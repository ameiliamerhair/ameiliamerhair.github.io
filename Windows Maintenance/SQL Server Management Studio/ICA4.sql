/*	Author: Ameilia Merhair
	Date: 09th October, 2024.
	Course: INFT-1105-01
	Description: In-Class Activity #4 

a. Create a query that displays first name in uppercase and last name of all players, also 
display in a column each players name but in the order of last name then first name 
separated by a comma and a space using the CONCAT() function. Each field displayed 
should have a field alias. Finally, order by last name.
*/
SELECT 
    UPPER(firstname) AS FirstName,
    lastname AS LastName,
    CONCAT(lastname, ', ', firstname) AS FullName
FROM players
ORDER BY lastname;
/*
b. Create the same query as query “a” above, but instead of using the CONCAT() function, 
find another way to concatenate the last name and first name together with a comma 
and space separating them.
*/
SELECT 
    UPPER(firstname) AS FirstName,
    lastname AS LastName,
    lastname + ', ' + firstname AS FullName
FROM players
ORDER BY lastname;
/*
c. Create a query that will display a player’s first name, registration number and date of 
birth where there is no last name. 
*/
SELECT 
    firstname,
    regnumber,
    dob
FROM players
WHERE lastname ='';
/*
d.  Create a query that displays player first names and the year from the date of birth. Give 
the year column a field alias of “Year”. Filter results to only players with the first name of 
“richard” 
*/
SELECT 
    firstname,
    YEAR(dob) AS Year
FROM players
WHERE firstname = 'richard';
/*
e. Create a query to display the first name, last name, date of birth and the age of each 
player. This new calculated column for ages should be given a field alias of “Age”. Hint: 
Google the DATEDIFF() and GETDATE() functions. The GETDATE() will be used inside the 
DATEDIFF() funcƟon to get the current date. 
*/
SELECT 
    firstname, 
    lastname, 
    dob, 
    DATEDIFF(year, dob, GETDATE()) AS Age 
FROM 
    players;
/*
f. Create a query that displays player first name and last name. Filter to only display players 
with a first name that begins with “j” and a last name with “don” somewhere in the last 
name. Finally, order by player last name.
*/
SELECT 
    firstname,
    lastname
FROM players
WHERE firstname LIKE 'j%'
AND lastname LIKE '%don%'
ORDER BY lastname;
/* Fin. */