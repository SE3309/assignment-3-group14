
Use FiveGuysCellular;
-- M1: Restock stores with low inventory (fewer than 10 IN_STOCK items)
INSERT INTO Inventory (inventoryID, invStatus, dateReceived, dateSold, storeID)
SELECT 
    UUID(),
    'IN_STOCK',
    NOW(),
    '0000-00-00 00:00:00',
    l.storeID
FROM Location l
WHERE l.storeID IN (
    SELECT storeID
    FROM Inventory
    WHERE invStatus = 'IN_STOCK'
    GROUP BY storeID
    HAVING COUNT(*) < 10
);

-- M2: Increase dataAmount for cheaper plans 
UPDATE Plan
SET dataAmount = dataAmount + 10
WHERE planID IN (
    SELECT planID
    FROM (
        SELECT planID
        FROM Plan
        WHERE price < 60
    ) AS t
);

-- M3: Delete employees with no sales and low performance (safe & FK-proof)
DELETE FROM EmployeeProfile
WHERE employeeID IN (
    SELECT employeeID
    FROM (
        SELECT ep.employeeID
        FROM EmployeeProfile ep
        LEFT JOIN Sale s ON ep.employeeID = s.employeeID
        WHERE s.employeeID IS NULL      -- no sales
          AND ep.commission < 50
          AND ep.salary < 45000
    ) AS t
);