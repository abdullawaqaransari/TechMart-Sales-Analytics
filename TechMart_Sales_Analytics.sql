---Show all customers.(Use only the Customers table.)
SELECT * FROM Customers

---Show only:CustomerName,City
SELECT CustomerName,City FROM Customers

---Show customers who belong to:Delhi
SELECT * FROM Customers
WHERE City = 'Delhi'

---Show customers who are Female
SELECT * FROM Customers
WHERE Gender = 'F'

---Show customers who registered after 2025-07-01
SELECT * FROM Customers
WHERE RegistrationDate > '2025-07-01'

---Show customers from Uttar Pradesh OR Delhi.
SELECT *
FROM Customers
WHERE State IN ('Delhi', 'Uttar Pradesh')

--Show customers NOT from Delhi
SELECT * FROM Customers
WHERE City != 'Delhi'

---Sort customers by CustomerName,Ascending.
SELECT * FROM Customers
ORDER BY CustomerName

---Sort customers by RegistrationDate Newest first.
SELECT * FROM Customers
ORDER BY RegistrationDate DESC

---Show only the first 10 customers.
SELECT TOP 10 * FROM Customers
ORDER BY CustomerName

---Show all customers whose name starts with 'A'.
SELECT * FROM Customers
WHERE CustomerName LIKE 'A%'

---Show all customers whose name ends with 'a'.
SELECT * FROM Customers
WHERE CustomerName LIKE '%a'

---Show all customers whose city contains "pur".
SELECT * FROM Customers
WHERE City LIKE '%pur%'

---Show customers who registered between 2025-05-01 and 2025-09-30.
SELECT * FROM Customers
WHERE RegistrationDate BETWEEN '2025-05-01' AND '2025-09-30'

---Show customers from Delhi, Maharashtra, and Gujarat using only one condition.
SELECT * FROM Customers
WHERE State IN ('Delhi','Maharashtra','Gujarat')

---Show all distinct states.
SELECT DISTINCT State 
FROM Customers

---Count the total number of customers.
SELECT COUNT(*) AS Total_customers
FROM Customers

---Count the number of female customers.
SELECT COUNT(*) AS TotalFemale_customers
FROM Customers
WHERE Gender = 'F'

---Show the latest registered customer.
SELECT TOP 1 * FROM Customers
ORDER BY RegistrationDate DESC

---Show the oldest registered customer.
SELECT TOP 1 * FROM Customers
ORDER BY RegistrationDate ASC

---Show the total number of customers in each state.
SELECT State,COUNT(*) AS Total_customers
FROM Customers
GROUP BY State 

---Show the number of male and female customers.
SELECT COUNT(*) AS Total_customers,Gender
FROM Customers
GROUP BY Gender

---Show the earliest registration date.(Hint: Don't use TOP.)
SELECT MIN(RegistrationDate) AS EarliestRegistration 
FROM Customers

---Show the latest registration date.(Hint: Don't use TOP.)
SELECT MAX(RegistrationDate)AS LatestRegistration
FROM Customers

---Show only those states that have more than 5 customers.(Hint: You'll use a new clause.)
SELECT State,COUNT(*) AS Total_customers
FROM Customers
GROUP BY State
HAVING COUNT(*) > 5

/*Write a query to show:OrderID CustomerName OrderDate
Use:Orders Customers */

SELECT O.OrderID,
        C.CustomerName,
        O.OrderDate
        
FROM Orders AS O
INNER JOIN Customers AS C
ON O.CustomerID = C.CustomerID
        

/*Show:OrderID,EmployeeName,OrderDate
Use:OrdersEmployees */

SELECT O.OrderID,E.EmployeeName,
        O.OrderDate
FROM Orders AS O
INNER JOIN Employees AS E
ON O.EmployeeID = E.EmployeeID

/*Show:OrderID,CustomerName,EmployeeName,OrderDate

Use:Orders Customers Employees */

SELECT O.OrderID,
        C.CustomerName,
        E.EmployeeName,
        O.OrderDate
FROM Orders AS O
INNER JOIN Customers AS C 
ON O.CustomerID = C.CustomerID
INNER JOIN Employees AS E
ON O.EmployeeID = E.EmployeeID



/*Show:OrderID,CustomerName,ProductName,Quantity

Tables:Orders,Customers,OrderDetails,Product */

SELECT O.OrderID,
    C.CustomerName,
    P.ProductName,
    OD.Quantity
FROM Orders AS O
INNER JOIN Customers AS C
ON O.CustomerID = C.CustomerID
INNER JOIN OrderDetails AS OD
ON O.OrderID = OD.OrderID
INNER JOIN Product AS P
ON OD.ProductID = P.ProductID


/*This is your first real business question.

Show:CustomerName,ProductName,Quantity,SellingPrice
Tables:Customers,Orders,OrderDetails,Product */

SELECT C.CustomerName,
        P.ProductName,
        OD.Quantity,
        P.SelingPrice
FROM Customers AS C
INNER JOIN Orders AS O 
ON C.CustomerID = O.CustomerID
INNER JOIN OrderDetails AS OD
ON O.OrderID = OD.OrderID
INNER JOIN Product AS P
ON P.ProductID = OD.ProductID

/*Show the Top 5 customers who generated the highest revenue.
Use:Customers,Orders,OrderDetails,Product */
 
 SELECT TOP 5
 C.CustomerName,
 SUM(OD.Quantity * P.SelingPrice) AS Total_Revenue
FROM Orders AS O
INNER JOIN Customers AS C
ON O.CustomerID = C.CustomerID
INNER JOIN OrderDetails AS OD
ON OD.OrderID = O.OrderID
INNER JOIN Product AS P
ON P.ProductID = OD.ProductID
GROUP BY C.CustomerName
ORDER BY Total_Revenue DESC

---30 BUSINESS QUESTIONS FOR PROJECT INSIGHTS----

---Show the total revenue.

SELECT SUM(OD.Quantity * P.SelingPrice) AS Total_revenue
FROM OrderDetails AS OD
INNER JOIN Product AS P
ON OD.ProductID = P.ProductID

---Show the total profit.

SELECT SUM(OD.Quantity * (P.SelingPrice - P.CostPrice)) AS Total_profit
FROM OrderDetails AS OD
INNER JOIN Product AS P
ON OD.ProductID = P.ProductID

---Show total number of orders.

SELECT COUNT(*) AS Total_Orders
FROM Orders

---Show total number of customers.

SELECT COUNT(*) AS Total_customers
FROM Customers

---Show total products sold.

SELECT SUM(Quantity) AS Total_productsold
FROM OrderDetails

---Level 2 (Category Analysis)

---Revenue by Category

SELECT 
CG.CategoryName,
SUM(OD.Quantity * P.SelingPrice) AS Total_revenue
FROM OrderDetails AS OD
INNER JOIN Product AS P
ON OD.ProductID = P.ProductID
INNER JOIN Categories AS CG
ON CG.CategoryID = P.CategoryID
GROUP BY CategoryName

---Profit by Category

SELECT CG.CategoryName,
SUM(OD.Quantity * (P.SelingPrice - P.CostPrice)) AS Total_profit
FROM OrderDetails AS OD
INNER JOIN Product AS P
ON OD.ProductID = P.ProductID
INNER JOIN Categories AS CG
ON CG.CategoryID = P.CategoryID
GROUP BY CategoryName

---Top Category

SELECT TOP 1 
CG.CategoryName,
SUM(OD.Quantity * P.SelingPrice) AS Total_revenue
FROM OrderDetails AS OD
INNER JOIN Product AS P
ON OD.ProductID = P.ProductID
INNER JOIN Categories AS CG
ON CG.CategoryID = P.CategoryID
GROUP BY CategoryName
ORDER BY Total_revenue DESC

---Least Selling Category

SELECT TOP 1
CG.CategoryName,
SUM(OD.Quantity) AS Least_selling
FROM OrderDetails AS OD
INNER JOIN Product AS P
ON OD.ProductID = P.ProductID
INNER JOIN Categories AS CG
ON CG.CategoryID = P.CategoryID
GROUP BY CategoryName
ORDER BY Least_selling ASC


---Number of Products in each Category

SELECT CG.CategoryName,
COUNT(*) AS Total_products
FROM Product AS P
INNER JOIN Categories AS CG
ON P.CategoryID = CG.CategoryID
GROUP BY CategoryName

---Level 3 (Product Analysis)

---Which products generated the highest revenue?

SELECT
    P.ProductName,
    C.CategoryName,
    SUM(OD.Quantity * P.SelingPrice) AS Total_Revenue
FROM Orders AS O
JOIN OrderDetails AS OD
    ON O.OrderID = OD.OrderID
JOIN Product AS P
    ON OD.ProductID = P.ProductID
JOIN Categories C
    ON P.CategoryID = C.CategoryID
GROUP BY
  P.ProductName,
  C.CategoryName
ORDER BY Total_Revenue DESC;

---Top 10 Products by Revenue

SELECT TOP 10
P.ProductName,
SUM(OD.Quantity * P.SelingPrice) AS Total_revenue
FROM Product AS P
INNER JOIN OrderDetails AS OD
ON P.ProductID = OD.ProductID
GROUP BY ProductName
ORDER BY Total_revenue DESC

---Bottom 10 Products
SELECT TOP 10
P.ProductName,
SUM(OD.Quantity * P.SelingPrice) AS Bottom_product
FROM Product AS P
INNER JOIN OrderDetails AS OD
ON P.ProductID = OD.ProductID
GROUP BY ProductName
ORDER BY Bottom_product ASC

---Most Sold Product

SELECT 
P.ProductName,
SUM(Quantity) AS Total_product_sold
FROM Product AS P
INNER JOIN OrderDetails AS OD
ON P.ProductID = OD.ProductID
GROUP BY ProductName
ORDER BY Total_product_sold DESC

---Least Sold Product

SELECT 
P.ProductName,
SUM(Quantity) AS Total_product_sold
FROM Product AS P
INNER JOIN OrderDetails AS OD
ON P.ProductID = OD.ProductID
GROUP BY ProductName
ORDER BY Total_product_sold ASC

---Products Never Sold 

SELECT 
P.ProductName
FROM Product AS P
LEFT JOIN OrderDetails AS OD
ON P.ProductID = OD.ProductID
WHERE OD.ProductID IS NULL


---Level 4 (Customer Analysis)

---Top 10 Customers by Revenue

SELECT TOP 10
    C.CustomerName,
    SUM(OD.Quantity * P.SelingPrice) AS Total_Revenue
FROM Orders AS O
INNER JOIN Customers AS C
ON O.CustomerID = C.CustomerID
INNER JOIN OrderDetails AS OD
ON OD.OrderID = O.OrderID
INNER JOIN Product AS P
ON P.ProductID = OD.ProductID
GROUP BY C.CustomerName
ORDER BY Total_Revenue DESC;

---Customers with No Orders ⭐

SELECT 
C.CustomerName
FROM Customers AS C
LEFT JOIN Orders AS O
ON C.CustomerID = O.CustomerID
WHERE O.CustomerID IS NULL

---Average Revenue per Customer
SELECT C.CustomerName,
SUM(OD.Quantity * P.SelingPrice) / COUNT(DISTINCT O.OrderID) AS Avg_revenue
FROM Orders AS O
INNER JOIN Customers AS C
ON O.CustomerID = C.CustomerID
INNER JOIN OrderDetails AS OD 
ON OD.OrderID = O.OrderID
INNER JOIN Product AS P
ON P.ProductID = OD.ProductID
GROUP BY C.CustomerName

---Highest Spending Customer
SELECT TOP 1
C.CustomerName,
SUM(OD.Quantity * P.SelingPrice) AS Total_revenue
FROM Orders AS O
INNER JOIN Customers AS C
ON O.CustomerID = C.CustomerID
INNER JOIN OrderDetails AS OD 
ON OD.OrderID = O.OrderID
INNER JOIN Product AS P
ON P.ProductID = OD.ProductID
GROUP BY C.CustomerName
ORDER BY Total_revenue DESC

---Repeat Customers

SELECT 
C.CustomerName,
COUNT(OrderID) AS Total_orders
FROM Orders AS O
INNER JOIN Customers AS C
ON O.CustomerID = C.CustomerID
GROUP BY C.CustomerName
HAVING COUNT(OrderID) > 1

---Level 5 (Employee Analysis)

---Revenue by Employee
SELECT
E.EmployeeName,
SUM(OD.Quantity * P.SelingPrice) AS Total_revenue
FROM Orders AS O
INNER JOIN Employees AS E
ON O.EmployeeID = E.EmployeeID
INNER JOIN OrderDetails AS OD
ON OD.OrderID = O.OrderID
INNER JOIN Product AS P
ON P.ProductID = OD.ProductID
GROUP BY E.EmployeeName

---Orders Handled by Employee
SELECT 
E.EmployeeName,
COUNT(OrderID) AS Total_Orders
FROM Orders AS O
INNER JOIN Employees AS E
ON O.EmployeeID = E.EmployeeID
GROUP BY E.EmployeeName

---Best Performing Employee
SELECT TOP 1
E.EmployeeName,
SUM(OD.Quantity * P.SelingPrice) AS Highest_revenue
FROM Orders AS O
INNER JOIN Employees AS E
ON O.EmployeeID = E.EmployeeID
INNER JOIN OrderDetails AS OD
ON OD.OrderID = O.OrderID
INNER JOIN Product AS P
ON P.ProductID = OD.ProductID
GROUP BY E.EmployeeName
ORDER BY Highest_revenue DESC

---Employee with No Orders
SELECT 
E.EmployeeName
FROM Employees AS E
LEFT JOIN Orders AS O 
ON O.EmployeeID = E.EmployeeID
WHERE O.CustomerID IS NULL

---Average Revenue per Employee

SELECT 
E.EmployeeName,
SUM(OD.Quantity * P.SelingPrice) / COUNT(DISTINCT O.OrderID) AS Avg_revenue
FROM Orders AS O
INNER JOIN Employees AS E
ON O.EmployeeID = E.EmployeeID
INNER JOIN OrderDetails AS OD
ON OD.OrderID = O.OrderID
INNER JOIN Product AS P
ON P.ProductID = OD.ProductID
GROUP BY E.EmployeeName

---Level 6 (Time Analysis)

---Monthly Revenue
SELECT 
YEAR(O.OrderDate) AS Order_year,
MONTH(O.OrderDate) AS Order_month,
DATENAME (MONTH,O.OrderDate) AS Month_name,
SUM(OD.Quantity * P.SelingPrice) AS Total_revenue
FROM Orders AS O
INNER JOIN OrderDetails AS OD
ON O.OrderID = OD.OrderID
INNER JOIN Product AS P
ON P.ProductID = OD.ProductID
GROUP BY YEAR(O.OrderDate),
        MONTH(O.OrderDate),
        DATENAME(MONTH,O.OrderDate)
ORDER BY YEAR(O.OrderDate),
        MONTH(O.OrderDate)

---Quarterly Revenue
SELECT 
 DATEPART (QUARTER,O.OrderDate)AS Quarterly_order,
SUM(OD.Quantity * P.SelingPrice) AS Total_revenue
FROM Orders AS O
INNER JOIN OrderDetails AS OD
ON O.OrderID = OD.OrderID
INNER JOIN Product AS P
ON P.ProductID = OD.ProductID
GROUP BY  DATEPART (QUARTER,O.OrderDate)
ORDER BY Quarterly_order

---Yearly Revenue
SELECT 
YEAR(O.OrderDate) AS Order_year,
SUM(OD.Quantity * P.SelingPrice) AS Total_revenue
FROM Orders AS O
INNER JOIN OrderDetails AS OD
ON O.OrderID = OD.OrderID
INNER JOIN Product AS P
ON P.ProductID = OD.ProductID
GROUP BY YEAR(O.OrderDate)
ORDER BY YEAR(O.OrderDate)

---Highest Sales Month

SELECT TOP 1
MONTH(O.OrderDate) AS Order_month,
DATENAME (MONTH,O.OrderDate) AS Month_name,
SUM(OD.Quantity * P.SelingPrice) AS Total_revenue
FROM Orders AS O
INNER JOIN OrderDetails AS OD
ON O.OrderID = OD.OrderID
INNER JOIN Product AS P
ON P.ProductID = OD.ProductID
GROUP BY MONTH(O.OrderDate),
        DATENAME(MONTH,O.OrderDate)
ORDER BY Total_revenue DESC

---Average Monthly Revenue

SELECT 
MONTH(O.OrderDate) AS Order_month,
DATENAME (MONTH,O.OrderDate) AS Month_name,
SUM(OD.Quantity * P.SelingPrice) / COUNT(DISTINCT O.OrderID) AS Avg_revenue
FROM Orders AS O
INNER JOIN OrderDetails AS OD
ON O.OrderID = OD.OrderID
INNER JOIN Product AS P
ON P.ProductID = OD.ProductID
GROUP BY MONTH(O.OrderDate),
        DATENAME(MONTH,O.OrderDate)
ORDER BY MONTH(O.OrderDate),
         DATENAME(MONTH,O.OrderDate)

