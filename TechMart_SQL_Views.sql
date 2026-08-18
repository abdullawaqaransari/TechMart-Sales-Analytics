---View 1: Customer Revenue

USE TechMartIndiaDB;
GO

CREATE VIEW vw_CustomerRevenue
AS
SELECT
    C.CustomerID,
    C.CustomerName,
    SUM(OD.Quantity * P.SelingPrice) AS Total_Revenue
FROM Customers AS C
INNER JOIN Orders AS O
ON C.CustomerID = O.CustomerID
INNER JOIN OrderDetails AS OD
ON O.OrderID = OD.OrderID
INNER JOIN Product AS P
ON OD.ProductID = P.ProductID
GROUP BY
    C.CustomerID,
    C.CustomerName;
GO

SELECT *
FROM vw_CustomerRevenue;

---View 2: Product Revenue

CREATE VIEW vw_ProductRevenue
AS
SELECT
    P.ProductID,
    P.ProductName,
    C.CategoryName,
    SUM(OD.Quantity) AS Total_Quantity_Sold,
    SUM(OD.Quantity * P.SelingPrice) AS Total_Revenue
FROM Product AS P
INNER JOIN Categories AS C
    ON P.CategoryID = C.CategoryID
INNER JOIN OrderDetails AS OD
    ON P.ProductID = OD.ProductID
GROUP BY
    P.ProductID,
    P.ProductName,
    C.CategoryName;
GO

SELECT *
FROM vw_ProductRevenue;

--- View 3: Category Revenue

CREATE VIEW vw_CategoryRevenue
AS
SELECT
    C.CategoryID,
    C.CategoryName,
    COUNT(DISTINCT P.ProductID) AS Total_Products,
    SUM(OD.Quantity) AS Total_Quantity_Sold,
    SUM(OD.Quantity * P.SelingPrice) AS Total_Revenue,
    SUM(OD.Quantity * (P.SelingPrice - P.CostPrice)) AS Total_Profit
FROM Categories AS C
INNER JOIN Product AS P
    ON C.CategoryID = P.CategoryID
INNER JOIN OrderDetails AS OD
    ON P.ProductID = OD.ProductID
GROUP BY
    C.CategoryID,
    C.CategoryName;
GO

SELECT * FROM vw_CategoryRevenue;

---View 4: Employee Performance

CREATE VIEW vw_EmployeePerformance
AS
SELECT
    E.EmployeeID,
    E.EmployeeName,
    COUNT(DISTINCT O.OrderID) AS Total_Orders,
    SUM(OD.Quantity) AS Total_Quantity_Sold,
    SUM(OD.Quantity * P.SelingPrice) AS Total_Revenue,
    SUM(OD.Quantity * (P.SelingPrice - P.CostPrice)) AS Total_Profit
FROM Employees AS E
INNER JOIN Orders AS O
    ON E.EmployeeID = O.EmployeeID
INNER JOIN OrderDetails AS OD
    ON O.OrderID = OD.OrderID
INNER JOIN Product AS P
    ON OD.ProductID = P.ProductID
GROUP BY
    E.EmployeeID,
    E.EmployeeName;
GO

SELECT * FROM vw_EmployeePerformance;

---View 5: Monthly Revenue

CREATE VIEW vw_MonthlyRevenue
AS
SELECT
    YEAR(O.OrderDate) AS Order_Year,
    MONTH(O.OrderDate) AS Order_Month,
    DATENAME(MONTH, O.OrderDate) AS Month_Name,
    COUNT(DISTINCT O.OrderID) AS Total_Orders,
    SUM(OD.Quantity) AS Total_Products_Sold,
    SUM(OD.Quantity * P.SelingPrice) AS Total_Revenue,
    SUM(OD.Quantity * (P.SelingPrice - P.CostPrice)) AS Total_Profit
FROM Orders AS O
INNER JOIN OrderDetails AS OD
    ON O.OrderID = OD.OrderID
INNER JOIN Product AS P
    ON OD.ProductID = P.ProductID
GROUP BY
    YEAR(O.OrderDate),
    MONTH(O.OrderDate),
    DATENAME(MONTH, O.OrderDate);
GO

SELECT * FROM vw_MonthlyRevenue;
