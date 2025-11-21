-- 1) Find all users created in 2025
USE FiveGuysCellular;
SELECT userID,
       fullName,
       email,
       createDate
FROM User
WHERE createDate >= '2025-01-01
  AND createDate <  2026-01-01';
  
  -- 2) List customers with Gmail addresses
USE FiveGuysCellular;
SELECT u.userID,
       u.fullName,
       u.email
FROM User AS u
WHERE u.email LIKE '%@mail.com';

-- 3) Show all sales of plans over $70 with customer and employee names
SELECT 
    s.saleID,
    s.saleDate,
    s.saleTime,
    s.subtotal,
    s.discount,
    s.taxTotal,
    s.grandTotal,
    
    c.SIN AS customerSIN,
    c.numYearsWithCarrier AS customerYearsWithCompany,
    
    e.salary AS employeeSalary,
    e.commission AS employeeCommission,
    
    r.roleName AS employeeRole
FROM Sale AS s,
     CustomerProfile AS c,
     EmployeeProfile AS e,
     EmployeeRole AS r
WHERE s.customerID = c.customerID
  AND s.employeeID = e.employeeID
  AND e.roleID = r.roleID;
-- 4) For each customer, show how many purchases they made
--    and the total they spent, only for customers who spent over $500.
SELECT 
    p.customerID,
    COUNT(*)            AS numPurchases,
    SUM(s.grandTotal)   AS totalSpent
FROM Sale    AS s,
     Payment AS p
WHERE s.creditCardNumber = p.creditCardNumber
GROUP BY p.customerID
HAVING SUM(s.grandTotal) > 500;
-- 5) Rank all employees by salary (highest to lowest),
--    and also mark which employees earn the maximum salary.v
SELECT 
    e.employeeID,
    e.salary,
    e.commission,
    er.roleName,
    
    CASE 
        WHEN e.salary = (
            SELECT MAX(e2.salary)
            FROM EmployeeProfile AS e2
        ) THEN 'MAX SALARY'
        ELSE ' '
    END AS salaryStatus

FROM EmployeeProfile AS e,
     EmployeeRole      AS er
WHERE e.roleID = er.roleID
ORDER BY e.salary DESC;
-- 6) Locations that currently have at least one inventory record
SELECT 
    l.storeID,
    l.storeName,
    l.street,
    l.city,
    l.province,
    l.postalCode
FROM Location AS l
WHERE EXISTS (
    SELECT 1
    FROM Inventory AS i
    WHERE i.storeID = l.storeID
);
-- 7) Employees whose number of sales is above the average,
--    ranked from highest to lowest sales.

SELECT 
    e.employeeID,
    er.roleName,
    empSales.numSales
FROM EmployeeProfile AS e,
     EmployeeRole    AS er,
     (
        SELECT 
            s.employeeID,
            COUNT(*) AS numSales
        FROM Sale AS s
        GROUP BY s.employeeID
     ) AS empSales
WHERE e.employeeID = empSales.employeeID
  AND e.roleID     = er.roleID
  AND empSales.numSales > (
        SELECT AVG(empSales2.numSales)
        FROM (
            SELECT 
                s2.employeeID,
                COUNT(*) AS numSales
            FROM Sale AS s2
            GROUP BY s2.employeeID
        ) AS empSales2
      )
ORDER BY empSales.numSales DESC;













  
  
  
  
