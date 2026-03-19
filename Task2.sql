USE Project_DB;
GO

-- Analyze county initial-letter distribution
WITH county_initial_counts AS (
    SELECT
        UPPER(LEFT(LTRIM(county),1)) AS county_initial,
        COUNT(*) AS rows_per_initial
    FROM ShortPricePaidData2025
    GROUP BY UPPER(LEFT(LTRIM(county),1))
),
cumulative_distribution AS (
    SELECT
        county_initial,
        rows_per_initial,
        SUM(rows_per_initial) OVER (ORDER BY county_initial) * 100.0 / SUM(rows_per_initial) OVER () AS cumulative_percentage
    FROM county_initial_counts
)
SELECT
    county_initial,
    rows_per_initial,
    CAST(cumulative_percentage AS DECIMAL(6,2)) AS cumulative_percentage
FROM cumulative_distribution
ORDER BY county_initial;

-- From the results of the previous analysis, we can partition the data in 5 balanced sections (around 20% each):
-- ~20%: B-D (cumulative: 18.71%)
-- ~40%: E-G (cumulative: 40.52%)
-- ~60%: H-M (cumulative: 58.77%)
-- ~80%: N-S (cumulative: 81.45%)
-- 100%: T-Y (cumulative: 100%)
CREATE PARTITION FUNCTION pf_county (VARCHAR(60))
AS RANGE LEFT
FOR VALUES ('E', 'H', 'N', 'T');
GO

CREATE PARTITION SCHEME ps_county
AS PARTITION pf_county
ALL TO ([PRIMARY]);
GO

-- Create the partitioned table structure
CREATE TABLE ShortPricePaidData2025_Partitioned (
    transaction_id  VARCHAR(50),
    price           DECIMAL(12,2),
    transfer_date   DATETIME,
    postcode        CHAR(8),
    property_type   CHAR(1),
    old_new         CHAR(1),
    paon            VARCHAR(60),
    street          VARCHAR(60),
    locality        VARCHAR(60),
    town            VARCHAR(60),
    district        VARCHAR(60),
    county          VARCHAR(60)
) ON ps_county(county);

-- Load the 2025 Price Paid data into the appropriate county-level partitions
INSERT INTO ShortPricePaidData2025_Partitioned (
    transaction_id, price, transfer_date, postcode,
    property_type, old_new, paon, street,
    locality, town, district, county
)
SELECT
    transaction_id, price, transfer_date, postcode,
    property_type, old_new, paon, street,
    locality, town, district, county
FROM ShortPricePaidData2025;

-- Report the number of records contained in each partition 
SELECT
    $PARTITION.pf_county(county) AS partition_number,
    MIN(county) AS min_county,
    MAX(county) AS max_county,
    COUNT(*) AS record_count
FROM ShortPricePaidData2025_Partitioned
GROUP BY $PARTITION.pf_county(county)
ORDER BY partition_number;
