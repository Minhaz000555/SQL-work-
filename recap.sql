			-- connect to the database

USE world;

/*Syntax tip: Sequence for the clauses
SELECT FROM
WHERE
ORDER BY
LIMIT
*/

SELECT * FROM city
ORDER BY Population DESC
LIMIT 1;

#Min and Max functions

SELECT MIN(Population),MAX(Population) FROM city;

#Counting values in a column

SELECT COUNT(ID) FROM city;

#Creating a variable

SELECT COUNT(ID) AS num_cities FROM city;

#Selecting specific columns with a condition

SELECT * FROM country; 

SELECT Population,LifeExpectancy FROM country
WHERE code = 'ARG';




# Finding strings starting with a specific value
SELECT * FROM city 
WHERE Name LIKE '%f%';


# Filter by values

SELECT * FROM city 
WHERE Population > 2000000;

# Using a range of values 

SELECT * FROM city 
WHERE Population > 500000 AND Population < 1000000 ;

#or function

SELECT * FROM city 
WHERE District = 'Oran' OR Population < 1000000 ;

#between function
SELECT * FROM city 
WHERE Population BETWEEN 500000 AND 1000000 ;




