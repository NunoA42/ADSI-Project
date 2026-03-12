USE Project_DB;
GO

CREATE PARTITION FUNCTION pf_county (VARCHAR(60))
AS RANGE LEFT
FOR VALUES ('C', 'D', 'F', 'H', 'L', 'N', 'P', 'S', 'T');
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
    city            VARCHAR(60),
    district        VARCHAR(60),
    county          VARCHAR(60)
) ON ps_county(county);

-- Load the 2025 Price Paid data into the appropriate county-level partitions
INSERT INTO ShortPricePaidData2025_Partitioned (
    transaction_id, price, transfer_date, postcode,
    property_type, old_new, paon, street,
    locality, city, district, county
)
SELECT
    transaction_id, price, transfer_date, postcode,
    property_type, old_new, paon, street,
    locality, city, district, county
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
