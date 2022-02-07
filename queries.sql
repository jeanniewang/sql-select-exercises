/******************************************************************************\
* AppAcademy JS/Py Online Week 10 - "Solving the SQL Menagerie"
*
*** Directions *****************************************************************
*
* Phase 1: create a 'travel' database and follow the directions to pipe your
* seed file into this database.
*
* Phases 2, 3, 4 & Bonus - add your queries to this file - the directions for
* each query is listed in a separate block comment below.
*
\******************************************************************************/

-- connect to the correct database - 'travel'
\echo 
-- CREATE DATABASE travel;
\c travel
\echo ============== CONNECT TO TRAVEL DATABASE ===============================
-- < ./cities_and_airports.sql

-- -- disable pagination
\pset pager off
\echo
select * from cities limit 10;

\echo  Phase 2: Write basic SELECT statements. Retrieve rows from a table using SELECT ... FROM SQL statements.
\echo
\echo ========= Problem 2.1 ====================================================
\echo Write a SQL query that returns the city, state, and estimated population in
\echo     2018 from the "cities" table.

SELECT city, state, population_estimate_2018 FROM cities;

\echo ========= Problem 2.2 ====================================================
\echo
\echo      Write a SQL query that returns all of the airport names contained in the
\echo     "airports" table.

SELECT name FROM airports;

\echo Phase 3: Add WHERE clauses 
\echo Select specific rows from a table using WHERE and common operators.
\echo ========= Problem 3.1 ====================================================
\echo


\echo 3.1) Write a SQL query that uses a WHERE clause to get the estimated population
\echo     in 2018 of the city of San Diego.

SELECT population_estimate_2018 FROM cities WHERE city='San Diego';

\echo ========= Problem 3.2 ====================================================
\echo

\echo     Write a SQL query that uses a WHERE clause to get the city, state, and
\echo     estimated population in 2018 of cities in this list:
\echo      Phoenix, Jacksonville, Charlotte, Nashville.
\echo
SELECT city, state, population_estimate_2018 FROM cities WHERE city in ('San Diego', 'Jacksonville', 'Charlotte', 'Nashville');

\echo ========= Problem 3.3 ====================================================
\echo     Write a SQL query that uses a WHERE clause to get the cities with an
\echo     estimated 2018 population between 800,000 and 900,000 people. Show the
\echo     city, state, and estimated population in 2018 columns.
\echo

SELECT city, state, population_estimate_2018 FROM cities WHERE population_estimate_2018 BETWEEN 800000 AND 900000;  

\echo ========= Problem 3.4 ====================================================
\echo     Write a SQL query that uses a WHERE clause to get the names of the cities
\echo     that had an estimated population in 2018 of at least 1 million people (or
\echo     1,000,000 people).

SELECT city, state, population_estimate_2018
FROM cities WHERE population_estimate_2018 > 1000000;

\echo ========= Problem 3.5 ====================================================
\echo     Write a SQL query to get the city and estimated population in 2018 in
\echo     number of millions (i.e. without zeroes at the end: 1 million), and that
\echo     uses a WHERE clause to return only the cities in Texas.

SELECT city, ROUND(population_estimate_2018/1000000.0) AS population_estimate_2018
FROM cities WHERE state='Texas';

\echo ========= Problem 3.6 ====================================================
\echo     Write a SQL query
\echo     that uses a WHERE clause to get the city, state, and estimated population
\echo     in 2018 of cities that are NOT in the following states:
\echo     New York, California, Texas.

SELECT city, state, population_estimate_2018 FROM cities WHERE state NOT IN ('New York', 'California', 'Texas');

\echo ========= Problem 3.7 ====================================================
\echo     Write a SQL query that uses a WHERE clause with the LIKE operator to get
\echo     the city, state, and estimated population in 2018 of cities that start with
\echo     the letter "S".
\echo     (Note: See the PostgreSQL doc on Pattern Matching for more information.)

SELECT city, state, population_estimate_2018 FROM cities WHERE city LIKE 'S%';

\echo ========= Problem 3.8 ====================================================
\echo     Write a SQL query that uses a WHERE clause to find the cities with either a
\echo     land area of over 400 square miles OR a population over 2 million people
\echo     (or 2,000,000 people). Show the city name, the land area, and the estimated
\echo     population in 2018.

SELECT city, land_area_sq_mi_2016, population_estimate_2018 FROM cities WHERE land_area_sq_mi_2016 > 400 OR population_estimate_2018 > 2000000;

\echo ========= Problem 3.9 ====================================================
\echo     Write a SQL query that uses a WHERE clause to find the cities with either a
\echo     land area of over 400 square miles OR a population over 2 million people
\echo     (or 2,000,000 people) but not the cities that have both. Show the city
\echo     name, the land area, and the estimated population in 2018.

SELECT city, land_area_sq_mi_2016, population_estimate_2018 FROM cities 
WHERE (land_area_sq_mi_2016 > 400 OR population_estimate_2018 > 2000000) 
AND NOT (land_area_sq_mi_2016 > 400 AND population_estimate_2018 > 2000000);

\echo ========= Problem 3.10 ===================================================
\echo     Write a SQL query that uses a WHERE clause to find the cities where the
\echo     population has increased by over 200,000 people from 2010 to 2018. Show
\echo     the city name, the estimated population in 2018, and the census population
\echo     in 2010.

SELECT city, population_estimate_2018, population_census_2010 FROM cities WHERE (population_estimate_2018 - population_census_2010) > 200000;


\echo Phase 4: Use a JOIN operation 
\echo Retrieve rows from multiple tables joining on a foreign key.
\echo The "airports" table has a foreign key called city_id that references the id
\echo column in the "cities" table.
\echo
\echo ========= Problem 4.1 ====================================================
\echo
\echo Write a SQL query using an INNER JOIN to join data from the "cities" table
\echo     with data from the "airports" table using the city_id foreign key. Show the
\echo     airport names and city names only.

SELECT name, city from airports INNER JOIN cities ON airports.city_id = cities.id;


\echo ========= Problem 4.2 ====================================================
\echo     Write a SQL query using an INNER JOIN to join data from the "cities" table
\echo     with data from the "airports" table to find out how many airports are in
\echo     New York City using the city name.
\echo     (Note: Use the aggregate function COUNT() to count the number of matching
\echo      rows.)

SELECT COUNT(name) as International_airport, city 
FROM cities INNER JOIN airports ON cities.id = airports.city_id
WHERE name LIKE '%' || 'International' || '%'
GROUP BY city;

SELECT COUNT(name) number_airport
FROM cities INNER JOIN airports ON cities.id = airports.city_id
WHERE city = 'New York' AND name LIKE '%' || 'New York' || '%';

SELECT city, name as airport_name
FROM cities INNER JOIN airports ON cities.id = airports.city_id
WHERE city = 'New York' AND name LIKE '%' || 'New York' || '%';
--------------------------------------------------------------------------------
---- Bonuses:
--------------------------------------------------------------------------------

\echo ========= Problem B.1 ====================================================
\echo

\echo     B.1) Apostrophe: Write a SQL query to get all three ID codes (the Federal
\echo     Aviation Administration (FAA) ID, the International Air Transport
\echo     Association (IATA) ID, and the International Civil Aviation Organization
\echo     (ICAO) ID) from the "airports" table for  "Chicago O' Hare International Airport".
\echo     (Note: You will need to escape the quotation mark in "Chicago O' Hare International Airport".
\echo     See How to include a single quote in a SQL query.)

Select faa_id, iata_id, icao_id, name from airports where name = 'Chicago O''Hare International Airport';

\echo ========= Problem B.2 ====================================================
\echo

\echo     B.2) Formatting Commas: Refactor Phase 2, Query #1 to turn the INT for estimated
\echo     population in 2018 into a character string with commas. (Note: See Data
\echo     Type Formatting Functions)
\echo     * Phase 2, Query #1: Write a SQL query that returns the city, state, and
\echo     estimated population in 2018 from the "cities" table.

Select city, state, TO_CHAR(population_estimate_2018, '9,999,999') population_estimate_2018 from cities;

\echo ========= Problem B.3 ====================================================
\echo

\echo     B.3) Decimals and Rounding: Refactor Phase 3, Query #5 to turn number of
\echo     millions from an integer into a decimal rounded to a precision of two
\echo     decimal places.
\echo     (Note: See Numeric Types and the ROUND function.)
\echo     * Phase 3, Query #5: Write a SQL query to get the city and estimated
\echo       population in 2018 in number of millions (i.e. without zeroes at the
\echo       end: 1 million), and that uses a WHERE clause to return only the cities
\echo       in Texas.



\echo ========= Problem B.4 ====================================================
\echo
/*
B.4) ORDER BY and LIMIT Clauses: Refactor Phase 3, Query #10 to return only one
     city with the biggest population increase from 2010 to 2018. Show the city
     name, the estimated population in 2018, and the census population in 2010
     for that city.
     (Note: You'll do the same calculation as before, but instead of comparing
      it to 200,000, use the ORDER BY Clause with the LIMIT Clause to sort the
      results and grab only the top result.)

     Phase 3, Query #10: Write a SQL query that uses a WHERE clause to find
     the cities where the population has increased by over 200,000 people from
     2010 to 2018. Show the city name, the estimated population in 2018, and
     the census population in 2010.
*/

Select id, city, state,  population_estimate_2018, population_census_2010, 
(population_estimate_2018 - population_census_2010) increase_from_2010_to_2018 
from cities order by increase_from_2010_to_2018 DESC LIMIT 1;

--  https://sqlbolt.com/lesson/select_queries_order_of_execution
-- Once we have the total working set of data, the first-pass WHERE constraints are applied to the individual rows, 
-- and rows that do not satisfy the constraint are discarded. Each of the constraints can only access columns directly
--  from the tables requested in the FROM clause. Aliases in the SELECT part of the query are not accessible in most 
-- databases since they may include expressions dependent on parts of the query that have not yet executed.
Select id, city, state,  population_estimate_2018, population_census_2010, 
(population_estimate_2018 - population_census_2010) as increase_from_2010_to_2018 
from cities WHERE (population_estimate_2018 - population_census_2010) > 200000 order by increase_from_2010_to_2018 DESC;

\echo ========= (done!) ========================================================
