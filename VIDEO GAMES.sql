select * from vgsales$

--TODAY'S PROJECT IS AN INTERESTING ONE. AS SOMEONE WHO LOVES GAMES, IT'S  WITH GREAT PLEASURE THAT i TACKLE THIS DATASET. 
--LET'S DIVE IN

--FIRST, WE WANT TO FIND THE TOTAL NUMBER OF GAMES WE ARE WORKING WITH
SELECT COUNT(DISTINCT NAME) AS TOTAL_GAMES FROM vgsales$

--NOW, WE WANT TO FIND THE DIFFERENT GAMES SO WE ARE SURE OF OUR DATASET
SELECT DISTINCT NAME FROM vgsales$

--LET'S NOW LOOK AT THE VARIOUS YEARS WE SHALL BE WORKING WITH
SELECT DISTINCT YEAR AS YR FROM vgsales$ WHERE YEAR IS NOT NULL
ORDER BY YR DESC

--OKAY SO WE KNOW FROM ABOVE THAT OUR YEAR RANGES FROM 1980-2020
--LET'S NOW TAKE A LOOK AT THE DIFFERENT PLATFORMS

SELECT DISTINCT PLATFORM AS PLATFORMS FROM vgsales$ WHERE PLATFORM IS NOT NULL
--SO 30 PLATFORMS. GOOD

--LET'S NOW TAKE A LOOK AT THE DIFFERENT GENRES
SELECT DISTINCT GENRE AS GENRE FROM vgsales$
--12 GENRES

--WE NOW WANT TO LOOK AT THE PUBLISHERS
SELECT DISTINCT PUBLISHER AS PUBLISHER FROM vgsales$

--OKAY, SINCE IT'S ALL GOOD NOW, WE CAN START ANALYSING THE DATASET AND ANSWERING SOME IMPORTANT QUESTIONS BUT FIRST, WE CHECK FOR DUPLICATES
WITH GAMES AS (SELECT *, ROW_NUMBER() OVER(PARTITION BY RANK, NAME, PLATFORM, YEAR, GENRE, PUBLISHER ORDER BY NAME) AS ROW_NUM FROM vgsales$)
SELECT * FROM GAMES WHERE ROW_NUM > 1

--THE ABOVE SHOWS THERE AREN'T ANY DUPLICATES AND THEREFORE WE CAN PROCEED

--QUESTIONS
--1. MANAGER WANTS  TO KNOW THE TOTAL SALES ACROSS ALL REGIONS WE HAVE SALES FOR EACH GAME
--2. MANAGER WILL LIKE TO KNOW THE GLOBAL SALES PER GAME GENRE
--3. WHAT IS THE HIGHEST GAME SOLD IN THE EU REGION?
--4. WHAT IS THE SECOND HIGHEST GAME SOLD IN THE EU REGION?
--5. MANAGER IS ASKING US TO FIND THE GLOBAL SALES BY GENRE. WHICH GENRE ARE PEOPLE MORE AND WHICH PLAYERS LIKE THE LEAST
--6. MANAGER WANTS THE TREND OF SALES GLOBALLY
--7. WHAT ARE THE TOP 10 GAMES SOLD GLOBALLY
--8. WHAT ARE THE BOTTOM 10 GAMES GLOBALLY?
--9. FIND THE LEADING GAME PUBLISHER FROM 1980-2020



--ANSWERS
--1. 
SELECT SUM(NA_SALES+EU_SALES+JP_SALES+OTHER_SALES+GLOBAL_SALES) AS TOTAL_SALES FROM vgsales$

--2.
SELECT DISTINCT GENRE, SUM(GLOBAL_SALES) AS SALES FROM vgsales$
GROUP BY GENRE
ORDER BY SALES DESC

--3.
SELECT TOP 1 NAME, MAX(EU_SALES) AS HIGHEST_SOLD FROM vgsales$
GROUP BY NAME
ORDER BY HIGHEST_SOLD DESC

--4.
SELECT TOP 1 NAME, MAX(EU_SALES) AS SECOND_HIGHEST FROM vgsales$
WHERE EU_SALES < (SELECT MAX(EU_SALES) FROM vgsales$) GROUP BY NAME
ORDER BY SECOND_HIGHEST DESC

SELECT * FROM vgsales$

--5A. 
SELECT DISTINCT GENRE, SUM(GLOBAL_SALES) AS SALES FROM vgsales$
GROUP BY GENRE
ORDER BY SALES DESC

--5B.
SELECT DISTINCT GENRE, SUM(GLOBAL_SALES) AS SALES FROM vgsales$
GROUP BY GENRE
ORDER BY SALES ASC

--6.
SELECT DISTINCT YEAR, SUM(GLOBAL_SALES) AS SALES FROM vgsales$
GROUP BY YEAR
ORDER BY SALES DESC

--7. 
SELECT TOP 10 NAME, SUM(GLOBAL_SALES) AS SALES FROM vgsales$
GROUP BY NAME
ORDER BY SALES DESC

--8. 
SELECT TOP 10 NAME, SUM(GLOBAL_SALES) AS SALES FROM vgsales$
GROUP BY NAME
ORDER BY SALES ASC

--9.
SELECT DISTINCT PUBLISHER, COUNT(NAME) AS NUMBER_OF_GAMES FROM vgsales$
GROUP BY PUBLISHER
ORDER BY NUMBER_OF_GAMES DESC

--GREAT OUR SMALL ANALYSIS IN EXCEL IS DONE WE WANT TO VISUALISE THIS NOW IN TABLEAU
--THANK YOU

