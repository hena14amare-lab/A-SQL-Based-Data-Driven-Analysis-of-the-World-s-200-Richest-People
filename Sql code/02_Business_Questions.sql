CREATE TABLE billionaires (
    serial_number INTEGER PRIMARY KEY,
    rank INTEGER,
    name TEXT,
    age INTEGER,
    country TEXT,
    networth_billion REAL,
    industry TEXT
);

INSERT INTO billionaires (
    serial_number,
    rank,
    name,
    age,
    country,
    networth_billion,
    industry
)
SELECT
    serial_number,
    rank,
    name,
    age,
    country,
    networth_billion,
    industry
FROM temp_billionaires;


/* 1. Retrieve the 20 richest billionaires */

SELECT
    rank,
    name,
    age,
    country,
    industry,
    networth_billion
FROM billionaires
ORDER BY networth_billion DESC
LIMIT 20;


/* 2. Identify the five youngest billionaires */ 

SELECT
    name,
    age,
    country,
    industry,
    networth_billion
FROM billionaires
ORDER BY age ASC, networth_billion DESC
LIMIT 5;

/* 3. Calculate average age and average net worth */ 

SELECT
    ROUND(AVG(age), 2) AS average_age,
    ROUND(AVG(networth_billion), 2)
        AS average_net_worth
FROM billionaires;


/* 4. Identify the five most represented countries */

SELECT
    country,
    COUNT(*) AS billionaire_count
FROM billionaires
GROUP BY country
ORDER BY billionaire_count DESC, country ASC
LIMIT 5;

/* 5. Calculate combined net worth by country */

SELECT
    country,
    COUNT(*) AS billionaire_count,
    ROUND(SUM(networth_billion), 2)
        AS total_net_worth
FROM billionaires
GROUP BY country
ORDER BY total_net_worth DESC;

/* 6. Identify the five industries with the highest number of billionaires */

SELECT
    industry,
    COUNT(*) AS billionaire_count,
    ROUND(SUM(networth_billion), 2)
        AS total_net_worth
FROM billionaires
GROUP BY industry
ORDER BY billionaire_count DESC, total_net_worth DESC
LIMIT 5;


/* 7. Find countries with at least five billionaires */ 

SELECT
    country,
    COUNT(*) AS billionaire_count
FROM billionaires
GROUP BY country
HAVING COUNT(*) >= 5
ORDER BY billionaire_count DESC;

/* 8. Calculate the total wealth of billionaires younger than 50 */

SELECT
    COUNT(*) AS billionaire_count,
    ROUND(SUM(networth_billion), 2)
        AS total_net_worth
FROM billionaires
WHERE age < 50;

/* 9. Identify billionaires whose net worth exceeds the overall average */

SELECT
    name,
    age,
    country,
    industry,
    networth_billion
FROM billionaires
WHERE networth_billion >
    (
        SELECT AVG(networth_billion)
        FROM billionaires
    )
ORDER BY networth_billion DESC;

/* 10. Identify the industry with the highest average net worth */

SELECT
    industry,
    COUNT(*) AS billionaire_count,
    ROUND(AVG(networth_billion), 2)
        AS average_net_worth
FROM billionaires
GROUP BY industry
ORDER BY average_net_worth DESC
LIMIT 1;
