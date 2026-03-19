DROP DATABASE IF EXISTS Project_DB;
GO

CREATE DATABASE Project_DB;
GO

USE Project_DB;
GO

CREATE TABLE PricePaidData2025 (
    transaction_id VARCHAR(50) PRIMARY KEY,
    price DECIMAL(12,2),
    transfer_date DATETIME,
    postcode CHAR(8),
    property_type CHAR(1),
    old_new CHAR(1),
    duration CHAR(1),
    paon VARCHAR(60),
    saon VARCHAR(60),
    street VARCHAR(60),
    locality VARCHAR(60),
    town VARCHAR(60),
    district VARCHAR(60),
    county VARCHAR(60),
    category CHAR(1),
    record_status CHAR(1)
);

CREATE TABLE PricePaidData2024 (
    transaction_id VARCHAR(50) PRIMARY KEY,
    price DECIMAL(12,2),
    transfer_date DATETIME,
    postcode CHAR(8),
    property_type CHAR(1),
    old_new CHAR(1),
    duration CHAR(1),
    paon VARCHAR(60),
    saon VARCHAR(60),
    street VARCHAR(60),
    locality VARCHAR(60),
    town VARCHAR(60),
    district VARCHAR(60),
    county VARCHAR(60),
    category CHAR(1),
    record_status CHAR(1)
);

-- Load 2025 data
BULK INSERT PricePaidData2025
FROM 'C:\Users\Administrator\Desktop\pp-2025.csv'
WITH (
    FORMAT = 'CSV',
    FIELDTERMINATOR = ',',
    FIELDQUOTE = '"',
    ROWTERMINATOR = '0x0a'
);

-- Load 2024 data
BULK INSERT PricePaidData2024
FROM 'C:\Users\Administrator\Desktop\pp-2024.csv'
WITH (
    FORMAT = 'CSV',
    FIELDTERMINATOR = ',',
    FIELDQUOTE = '"',
    ROWTERMINATOR = '0x0a'
);

CREATE TABLE ShortPricePaidData2025 (
    transaction_id VARCHAR(50) PRIMARY KEY,
    price DECIMAL(12,2),
    transfer_date DATETIME,
    postcode CHAR(8),
    property_type CHAR(1),
    old_new CHAR(1),
    paon VARCHAR(60),
    street VARCHAR(60),
    locality VARCHAR(60),
    town VARCHAR(60),
    district VARCHAR(60),
    county VARCHAR(60)
);

CREATE TABLE ShortPricePaidData2024 (
    transaction_id VARCHAR(50) PRIMARY KEY,
    price DECIMAL(12,2),
    transfer_date DATETIME,
    postcode CHAR(8),
    property_type CHAR(1),
    old_new CHAR(1),
    paon VARCHAR(60),
    street VARCHAR(60),
    locality VARCHAR(60),
    town VARCHAR(60),
    district VARCHAR(60),
    county VARCHAR(60)
);

-- Insert 2025 data into ShortPricePaidData2025 table
INSERT INTO ShortPricePaidData2025 (transaction_id, price, transfer_date, postcode, property_type,
                                    old_new, paon, street, locality, town, district, county)
SELECT 
    transaction_id, price, transfer_date, postcode, property_type, old_new,
    paon, street, locality, town, district, county
FROM PricePaidData2025;

-- Insert 2024 data into ShortPricePaidData2024 table
INSERT INTO ShortPricePaidData2024 (transaction_id, price, transfer_date, postcode, property_type,
                                    old_new, paon, street, locality, town, district, county)
SELECT
    transaction_id, price, transfer_date, postcode, property_type, old_new,
    paon, street, locality, town, district, county
FROM PricePaidData2024;