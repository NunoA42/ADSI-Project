CREATE NONCLUSTERED INDEX IDX_New_town
ON ShortPricePaidData2025 (town, Old_New);

CREATE NONCLUSTERED INDEX IDX_Covering
ON ShortPricePaidData2025 (town, Old_New) 
INCLUDE (locality, price);

CREATE NONCLUSTERED INDEX IDX_Filtered_London_NewProperties
ON ShortPricePaidData2025 (locality)
INCLUDE (price)
WHERE town = 'London' AND Old_New = 'Y';

GO

DROP INDEX IDX_New_town ON ShortPricePaidData2025;
DROP INDEX IDX_Covering ON ShortPricePaidData2025;
DROP INDEX IDX_Filtered_London_NewProperties ON ShortPricePaidData2025;
