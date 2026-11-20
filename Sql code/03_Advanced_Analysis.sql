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


/* 1. Identify the 10 oldest billionaires */

SELECT
    name,
    age,
    country,
    industry,
    networth_billion
FROM billionaires
ORDER BY age DESC, networth_billion DESC
LIMIT 10;

/* 2. The country that has the highest average billionaire net worth? */

SELECT
    country,
    COUNT(*) AS billionaire_count,
    ROUND(AVG(networth_billion), 2)
        AS average_net_worth
FROM billionaires
GROUP BY country
ORDER BY average_net_worth DESC
LIMIT 10;

/* 3. The percentage of total wealth that belongs to the top 10 billionaires? */

SELECT
    ROUND(
        SUM(
            CASE
                WHEN rank <= 10
                THEN networth_billion
                ELSE 0
            END
        ) * 100.0 /
        SUM(networth_billion),
        2
    ) AS Top_10_Wealth_Percentage
FROM billionaires;

/* 4. The industry that contributes the greatest combined wealth */

SELECT
    industry,
    COUNT(*) AS billionaire_count,
    ROUND(SUM(networth_billion), 2)
        AS total_net_worth
FROM billionaires
GROUP BY industry
ORDER BY total_net_worth DESC
LIMIT 1;

/* 5.Number of billionaires under 40 */

SELECT
    COUNT(*) AS billionaire_count,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM billionaires),
        2
    ) AS percentage_of_billionaires
FROM billionaires
WHERE age < 40;

/* 6. The wealth difference between the richest and least wealthy billionaires */

SELECT
    MAX(networth_billion)
        AS highest_net_worth_billion,

    MIN(networth_billion)
        AS lowest_net_worth_billion,

    ROUND(
        MAX(networth_billion) -
        MIN(networth_billion),
        2
    ) AS wealth_difference_billion
FROM billionaires;

/* 7. Age group that holds the highest combined wealth */

SELECT
    CASE
        WHEN age < 40 THEN 'Under 40'
        WHEN age BETWEEN 40 AND 49 THEN '40-49'
        WHEN age BETWEEN 50 AND 59 THEN '50-59'
        WHEN age BETWEEN 60 AND 69 THEN '60-69'
        WHEN age BETWEEN 70 AND 79 THEN '70-79'
        ELSE '80 and Above'
    END AS age_group,

    COUNT(*) AS billionaire_count,

    ROUND(SUM(networth_billion), 2)
        AS total_net_worth,

    ROUND(AVG(networth_billion), 2)
        AS average_net_worth

FROM billionaires
GROUP BY age_group
ORDER BY total_net_worth DESC;

/* 8. Average net worth by country */ 

SELECT
    country,
    COUNT(*) AS billionaire_count,
    ROUND(AVG(networth_billion), 2)
        AS average_net_worth
FROM billionaires
GROUP BY country
ORDER BY average_net_worth DESC;

/* 9. Industries that have the highest and lowest average ages */

SELECT
    industry,
    COUNT(*) AS billionaire_count,
    ROUND(AVG(age), 2) AS average_age
FROM billionaires
GROUP BY industry
ORDER BY average_age DESC;

/* 10. Comparing the combined wealth of the top 20 billionaires with the remaining 180 */

SELECT
    CASE
        WHEN rank <= 20 THEN 'Top 20'
        ELSE 'Remaining 180'
    END AS billionaire_group,

    COUNT(*) AS billionaire_count,

    ROUND(SUM(networth_billion), 2)
        AS total_net_worth,

    ROUND(
        SUM(networth_billion) * 100.0 /
        (SELECT SUM(networth_billion)
         FROM billionaires),
        2
    ) AS percentage_of_total_wealth

FROM billionaires
GROUP BY billionaire_group
ORDER BY total_net_worth DESC;



