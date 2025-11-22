
USE telecom;


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

SELECT *
FROM CustomerSalesSummary
ORDER BY totalSpent DESC
LIMIT 10;



CREATE VIEW StoreInventoryView AS
SELECT
    l.storeID,
    l.storeName,
    i.status,
    COUNT(*) AS numDevices
FROM Location l
JOIN Inventory i ON l.storeID = i.storeID
GROUP BY l.storeID, l.storeName, i.status;

SELECT *
FROM StoreInventoryView
ORDER BY storeName, status
LIMIT 10;

INSERT INTO CustomerSalesSummary (customerID, fullName, numSales, totalSpent)
VALUES ('dummy-id', 'Dummy User', 1, 100.00);

INSERT INTO StoreInventoryView (storeID, storeName, status, numDevices)
VALUES ('dummy-store', 'Dummy Store', 'IN_STOCK', 10);
