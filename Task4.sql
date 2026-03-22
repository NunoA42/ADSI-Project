USE Project_DB;
GO

-- Default -> (Hash Join + Hash Group)
SELECT p24.district,
       p24.avg_price AS avg_2024,
       p25.avg_price AS avg_2025
FROM ( SELECT district, AVG(CAST(price AS BIGINT)) AS avg_price
       FROM ShortPricePaidData2024
       GROUP BY district
     ) p24
JOIN ( SELECT district, AVG(CAST(price AS BIGINT)) AS avg_price
       FROM ShortPricePaidData2025
       GROUP BY district
     ) p25
ON p24.district = p25.district
WHERE p25.avg_price > p24.avg_price;

GO

-- Loop Join + Hash Group
SELECT p24.district,
       p24.avg_price AS avg_2024,
       p25.avg_price AS avg_2025
FROM ( SELECT district, AVG(CAST(price AS BIGINT)) AS avg_price
       FROM ShortPricePaidData2024
       GROUP BY district
     ) p24
JOIN ( SELECT district, AVG(CAST(price AS BIGINT)) AS avg_price
       FROM ShortPricePaidData2025
       GROUP BY district
     ) p25
ON p24.district = p25.district
WHERE p25.avg_price > p24.avg_price
OPTION (LOOP JOIN);

GO

-- Merge Join + Hash Group
SELECT p24.district,
       p24.avg_price AS avg_2024,
       p25.avg_price AS avg_2025
FROM ( SELECT district, AVG(CAST(price AS BIGINT)) AS avg_price
       FROM ShortPricePaidData2024
       GROUP BY district
     ) p24
JOIN ( SELECT district, AVG(CAST(price AS BIGINT)) AS avg_price
       FROM ShortPricePaidData2025
       GROUP BY district
     ) p25
ON p24.district = p25.district
WHERE p25.avg_price > p24.avg_price
OPTION (MERGE JOIN);

GO

-- Hash Join + Order Group
SELECT p24.district,
       p24.avg_price AS avg_2024,
       p25.avg_price AS avg_2025
FROM ( SELECT district, AVG(CAST(price AS BIGINT)) AS avg_price
       FROM ShortPricePaidData2024
       GROUP BY district
     ) p24
JOIN ( SELECT district, AVG(CAST(price AS BIGINT)) AS avg_price
       FROM ShortPricePaidData2025
       GROUP BY district
     ) p25
ON p24.district = p25.district
WHERE p25.avg_price > p24.avg_price
OPTION (HASH JOIN, ORDER GROUP);

GO

-- Loop Join + Order Group
SELECT p24.district,
       p24.avg_price AS avg_2024,
       p25.avg_price AS avg_2025
FROM ( SELECT district, AVG(CAST(price AS BIGINT)) AS avg_price
       FROM ShortPricePaidData2024
       GROUP BY district
     ) p24
JOIN ( SELECT district, AVG(CAST(price AS BIGINT)) AS avg_price
       FROM ShortPricePaidData2025
       GROUP BY district
     ) p25
ON p24.district = p25.district
WHERE p25.avg_price > p24.avg_price
OPTION (LOOP JOIN, ORDER GROUP);

GO

-- Merge Join + Order Group
SELECT p24.district,
       p24.avg_price AS avg_2024,
       p25.avg_price AS avg_2025
FROM ( SELECT district, AVG(CAST(price AS BIGINT)) AS avg_price
       FROM ShortPricePaidData2024
       GROUP BY district
     ) p24
JOIN ( SELECT district, AVG(CAST(price AS BIGINT)) AS avg_price
       FROM ShortPricePaidData2025
       GROUP BY district
     ) p25
ON p24.district = p25.district
WHERE p25.avg_price > p24.avg_price
OPTION (MERGE JOIN, ORDER GROUP);

GO

-- Hash Join + Force Oder
SELECT p24.district,
       p24.avg_price AS avg_2024,
       p25.avg_price AS avg_2025
FROM ( SELECT district, AVG(CAST(price AS BIGINT)) AS avg_price
       FROM ShortPricePaidData2024
       GROUP BY district
     ) p24
JOIN ( SELECT district, AVG(CAST(price AS BIGINT)) AS avg_price
       FROM ShortPricePaidData2025
       GROUP BY district
     ) p25
ON p24.district = p25.district
WHERE p25.avg_price > p24.avg_price
OPTION (HASH JOIN, FORCE ORDER);


-- Loop Join + Force Order
SELECT p24.district,
       p24.avg_price AS avg_2024,
       p25.avg_price AS avg_2025
FROM ( SELECT district, AVG(CAST(price AS BIGINT)) AS avg_price
       FROM ShortPricePaidData2024
       GROUP BY district
     ) p24
JOIN ( SELECT district, AVG(CAST(price AS BIGINT)) AS avg_price
       FROM ShortPricePaidData2025
       GROUP BY district
     ) p25
ON p24.district = p25.district
WHERE p25.avg_price > p24.avg_price
OPTION (LOOP JOIN, FORCE ORDER);

GO

-- Merge Join + Force Order
SELECT p24.district,
       p24.avg_price AS avg_2024,
       p25.avg_price AS avg_2025
FROM ( SELECT district, AVG(CAST(price AS BIGINT)) AS avg_price
       FROM ShortPricePaidData2024
       GROUP BY district
     ) p24
JOIN ( SELECT district, AVG(CAST(price AS BIGINT)) AS avg_price
       FROM ShortPricePaidData2025
       GROUP BY district
     ) p25
ON p24.district = p25.district
WHERE p25.avg_price > p24.avg_price
OPTION (MERGE JOIN, FORCE ORDER);

GO