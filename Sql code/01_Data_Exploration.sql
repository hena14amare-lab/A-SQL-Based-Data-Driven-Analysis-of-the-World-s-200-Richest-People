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


/* Check total records*/ 
SELECT COUNT(*) AS total_records
FROM billionaires;

/* Preview 10 billionaire records */ 

SELECT *
FROM billionaires
LIMIT 10;

/*Identify missing records*/

SELECT
    SUM(CASE WHEN serial_number IS NULL THEN 1 ELSE 0 END) AS missing_serial,
    SUM(CASE WHEN rank IS NULL THEN 1 ELSE 0 END) AS missing_rank,
    SUM(CASE WHEN name IS NULL THEN 1 ELSE 0 END) AS missing_name,
    SUM(CASE WHEN age IS NULL THEN 1 ELSE 0 END) AS missing_age,
    SUM(CASE WHEN country IS NULL THEN 1 ELSE 0 END) AS missing_country,
    SUM(CASE WHEN networth_billion IS NULL THEN 1 ELSE 0 END) AS missing_networth,
    SUM(CASE WHEN industry IS NULL THEN 1 ELSE 0 END) AS missing_industry
FROM billionaires;


/*Identify duplicate records*/

SELECT
    serial_number,
    COUNT(*) AS duplicate_count
FROM billionaires
GROUP BY serial_number
HAVING COUNT(*) > 1;

/* Explore countries represented*/

SELECT
    COUNT(DISTINCT country) AS total_countries
FROM billionaires;

/* Explore industries represented*/

SELECT
    COUNT(DISTINCT industry) AS total_industries
FROM billionaires;
