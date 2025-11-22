-- ex7.sql
USE telecom;

--------------------------------------------------
-- View 1: Customer sales summary
--------------------------------------------------

CREATE VIEW CustomerSalesSummary AS
SELECT
    c.customerID,
    u.fullName,
    COUNT(s.saleID)       AS numSales,
    COALESCE(SUM(s.grandTotal), 0) AS totalSpent
FROM CustomerProfile c
JOIN User u       ON c.customerID = u.userID
LEFT JOIN Sale s  ON s.customerID = c.customerID
GROUP BY c.customerID, u.fullName;

-- Query using View 1
SELECT *
FROM CustomerSalesSummary
ORDER BY totalSpent DESC
LIMIT 10;


--------------------------------------------------
-- View 2: Store inventory by status
--------------------------------------------------

CREATE VIEW StoreInventoryView AS
SELECT
    l.storeID,
    l.storeName,
    i.status,
    COUNT(*) AS numDevices
FROM Location l
JOIN Inventory i ON l.storeID = i.storeID
GROUP BY l.storeID, l.storeName, i.status;

-- Query using View 2
SELECT *
FROM StoreInventoryView
ORDER BY storeName, status
LIMIT 10;


--------------------------------------------------
-- Test updatability: try modifying the views
--------------------------------------------------

-- Attempt 1: insert into CustomerSalesSummary
INSERT INTO CustomerSalesSummary (customerID, fullName, numSales, totalSpent)
VALUES ('dummy-id', 'Dummy User', 1, 100.00);

-- Attempt 2: insert into StoreInventoryView
INSERT INTO StoreInventoryView (storeID, storeName, status, numDevices)
VALUES ('dummy-store', 'Dummy Store', 'IN_STOCK', 10);
