USE FiveGuysCellular;

INSERT INTO Location (storeName, street, city, province, postalCode, callAddress)
VALUES ('Downtown London Store', '123 King Street', 'London', 'ON', 'N6A1A1', '519-555-0101');

SELECT * FROM Location;

INSERT INTO Location (storeName, street, city, province, postalCode, callAddress)
SELECT 
    CONCAT(province, ' Regional HQ'),
    '100 Corporate Blvd',
    city,
    province,
    CONCAT(LEFT(province,2), '0000'),
    NULL
FROM (
    SELECT province, MIN(city) AS city
    FROM Location
    GROUP BY province
) AS provs;

SELECT * FROM Location;

INSERT INTO Location (storeName, street, city, province, postalCode, callAddress)
SELECT 
    CONCAT(city, ' Analyst Office'),
    '200 Data Drive',
    city,
    province,
    CONCAT(LEFT(postalCode,3), '9ZZ'),
    '1-800-555-ANALYST'
FROM Location
GROUP BY city, province
HAVING COUNT(*) > 1;

SELECT * FROM Location;
