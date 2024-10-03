CREATE DATABASE SalesAnalysis;
USE SalesAnalysis;
-- Create Customers Table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    ContactEmail VARCHAR(100),
    PhoneNumber VARCHAR(10),
    City VARCHAR(50)
);


-- Insert Sample Data into Customers
INSERT INTO Customers (CustomerID, CustomerName, ContactEmail, PhoneNumber, City) VALUES
(1, 'John Doe', 'john@example.com', '1233657896', 'New York'),
(2, 'Jane Smith', 'jane@example.com', '5554535678', 'Los Angeles'),
(3, 'Alice Johnson', 'alice@example.com', '5558978765', 'Chicago'),
(4, 'Bob Brown', 'bob@example.com', '5552344321', 'Houston'),
(5, 'Charlie Davis', 'charlie@example.com', '5553456789', 'Phoenix'),
(6, 'Eve White', 'eve@example.com', '5557862468', 'Philadelphia'),
(7, 'Frank Black', 'frank@example.com', '5555681357', 'San Antonio'),
(8, 'Grace Green', 'grace@example.com', '5550982468', 'San Diego'),
(9, 'Hannah Blue', 'hannah@example.com', '5552341359', 'Dallas'),
(10, 'Ivy Pink', 'ivy@example.com', '5552349876', 'San Jose');

-- Create Products Table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    UnitPrice DECIMAL(10,2),
    StockQuantity INT,
    ProductCategory VARCHAR(50)
);

-- Insert Sample Data into Products
INSERT INTO Products (ProductID, ProductName, UnitPrice, StockQuantity, ProductCategory) VALUES
(1, 'Laptop', 999.99, 50, 'Electronics'),
(2, 'Smartphone', 699.99, 100, 'Electronics'),
(3, 'Tablet', 299.99, 75, 'Electronics'),
(4, 'Headphones', 149.99, 200, 'Accessories'),
(5, 'Smartwatch', 249.99, 150, 'Wearables'),
(6, 'Printer', 199.99, 30, 'Electronics'),
(7, 'Desk Chair', 89.99, 40, 'Furniture'),
(8, 'Gaming Mouse', 59.99, 60, 'Accessories'),
(9, 'External Hard Drive', 129.99, 25, 'Storage'),
(10, 'Monitor', 249.99, 20, 'Electronics');

-- Create Salesperson Table
CREATE TABLE Salesperson (
    SalespersonID INT PRIMARY KEY,
    SalespersonName VARCHAR(100),
    Region VARCHAR(50),
    PhoneNumber VARCHAR(15),
    Email VARCHAR(100)
);

-- Insert Sample Data into Salesperson
INSERT INTO Salesperson (SalespersonID, SalespersonName, Region, PhoneNumber, Email) VALUES
(1, 'James White', 'North', '555-0001', 'james@example.com'),
(2, 'Linda Green', 'South', '555-0002', 'linda@example.com'),
(3, 'Robert Brown', 'East', '555-0003', 'robert@example.com'),
(4, 'Emily Black', 'West', '555-0004', 'emily@example.com');



-- Create Orders Table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    OrderStatus VARCHAR(50),
    SalespersonID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (SalespersonID) REFERENCES Salesperson(SalespersonID)
);

-- Insert Sample Data into Orders
INSERT INTO Orders (OrderID, CustomerID, OrderDate, OrderStatus, SalespersonID) VALUES
(1, 1, '2023-08-20', 'Shipped', 1),
(2, 2, '2023-08-22', 'Delivered', 2),
(3, 3, '2023-08-25', 'Processing', 3),
(4, 4, '2023-08-28', 'Shipped', 4),
(5, 5, '2023-09-01', 'Delivered', 1),
(6, 6, '2023-09-03', 'Processing', 2),
(7, 7, '2023-09-05', 'Delivered', 3),
(8, 8, '2023-09-07', 'Shipped', 4),
(9, 9, '2023-09-09', 'Cancelled', 1),
(10, 10, '2023-09-10', 'Processing', 2);

-- Create OrderDetails Table
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    TotalAmount DECIMAL(10,2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Insert Sample Data into OrderDetails
INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity, TotalAmount) VALUES
(1, 1, 1, 1, 999.99),
(2, 1, 4, 2, 299.98),
(3, 2, 2, 1, 699.99),
(4, 3, 3, 1, 299.99),
(5, 4, 5, 1, 249.99),
(6, 5, 1, 1, 999.99),
(7, 6, 6, 1, 199.99),
(8, 7, 2, 2, 1399.98),
(9, 8, 8, 2, 119.98),
(10, 9, 9, 1, 129.99);

-- fetch all cutomers
SELECT * FROM Customers;

-- fetch all Products
SELECT * FROM Products;

-- fetch all orders
SELECT * FROM Orders;

-- fetch all OrderDetails
SELECT * FROM OrderDetails;

-- fetch all Salesperson
SELECT * FROM Salesperson;

-- Fetch a Specific Customer by ID
SELECT * FROM Customers WHERE CustomerID = 1;
-- Fetch Products in a Specific Category
SELECT * FROM Products WHERE ProductCategory = 'Electronics';

-- Fetch Orders by a Specific Customer
SELECT * FROM Orders WHERE CustomerID = 1;

 -- Fetch Orders with a Specific Status
 SELECT * FROM Orders WHERE OrderStatus = 'Delivered';

-- Fetch Order Details for a Specific Order
SELECT * FROM OrderDetails WHERE OrderID = 1;

-- Fetch Total Amount for Each Order
SELECT OrderID, SUM(TotalAmount) AS TotalAmount FROM OrderDetails
GROUP BY OrderID;

-- Fetch Total Quantity Sold for Each Product
SELECT ProductID, SUM(Quantity) AS TotalQuantitySold
FROM OrderDetails
GROUP BY ProductID;
-- Fetch Customers from a Specific City
SELECT * FROM Customers WHERE City = 'New York';

--  Fetch Products that Are Out of Stock
SELECT * FROM Products WHERE StockQuantity = 0;
 -- Fetch Salespersons by Region
 SELECT * FROM Salesperson WHERE Region = 'North';
 
--   Fetch Orders and Join with Customers
  SELECT O.OrderID, C.CustomerName, O.OrderDate, O.OrderStatus
FROM Orders O
JOIN Customers C ON O.CustomerID = C.CustomerID;
-- Fetch Orders and Join with Order Details
SELECT O.OrderID, OD.ProductID, OD.Quantity, OD.TotalAmount
FROM Orders O
JOIN OrderDetails OD ON O.OrderID = OD.OrderID;
-- Fetch Total Orders Placed by Each Customer
SELECT C.CustomerName, COUNT(O.OrderID) AS TotalOrders
FROM Customers C
LEFT JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerName;

--  Fetch Total Sales for Each Product
SELECT P.ProductName, SUM(OD.TotalAmount) AS TotalSales
FROM Products P
JOIN OrderDetails OD ON P.ProductID = OD.ProductID
GROUP BY P.ProductName;

-- Fetch Sales by Each Salesperson
SELECT S.SalespersonName, SUM(OD.TotalAmount) AS TotalSales
FROM Salesperson S
JOIN Orders O ON S.SalespersonID = O.SalespersonID
JOIN OrderDetails OD ON O.OrderID = OD.OrderID
GROUP BY S.SalespersonName;
-- Fetch Products with No Sales (Unsold Products)
SELECT P.ProductID, P.ProductName, P.UnitPrice
FROM Products P
LEFT JOIN OrderDetails OD ON P.ProductID = OD.ProductID
WHERE OD.ProductID IS NULL;
--  Fetch Orders by Date Range
SELECT * FROM Orders WHERE OrderDate BETWEEN '2023-08-01' AND '2023-09-30';

-- Fetch Customers and Their Latest Order Date
SELECT C.CustomerName, MAX(O.OrderDate) AS LatestOrderDate
FROM Customers C
LEFT JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerName;

--  Fetch Products Below a Certain Price
SELECT * FROM Products WHERE UnitPrice < 100;

--  Fetch Average Order Amount
SELECT AVG(TotalAmount) AS AverageOrderAmount
FROM OrderDetails;
-- Fetch Count of Orders by Status
SELECT OrderStatus, COUNT(*) AS OrderCount
FROM Orders
GROUP BY OrderStatus;

--  Fetch Products with Sales Information
SELECT P.ProductID, P.ProductName, SUM(OD.Quantity) AS TotalQuantitySold, SUM(OD.TotalAmount) AS TotalSales
FROM Products P
LEFT JOIN OrderDetails OD ON P.ProductID = OD.ProductID
GROUP BY P.ProductID, P.ProductName;
--  Fetch Customers with No Orders
SELECT C.CustomerName
FROM Customers C
LEFT JOIN Orders O ON C.CustomerID = O.CustomerID
WHERE O.OrderID IS NULL;
-- Fetch Order Details Along with Product Names
SELECT OD.OrderID, P.ProductName, OD.Quantity, OD.TotalAmount
FROM OrderDetails OD
JOIN Products P ON OD.ProductID = P.ProductID;
-- Fetch Salesperson Performance Metrics
SELECT S.SalespersonName, COUNT(O.OrderID) AS TotalOrders, SUM(OD.TotalAmount) AS TotalSales
FROM Salesperson S
LEFT JOIN Orders O ON S.SalespersonID = O.SalespersonID
LEFT JOIN OrderDetails OD ON O.OrderID = OD.OrderID
GROUP BY S.SalespersonName;

--  Count Total Customers
SELECT COUNT(*) AS TotalCustomers
FROM Customers;
--  Count Total Products
SELECT COUNT(*) AS TotalProducts
FROM Products;
-- Count Total Orders
SELECT COUNT(*) AS TotalOrders
FROM Orders;
-- Count Total Order Details (Items Ordered)

SELECT COUNT(*) AS TotalOrderDetails
FROM OrderDetails;
--  Count Total Salespersons
SELECT COUNT(*) AS TotalSalespersons
FROM Salesperson;
--  Count Orders by Status
SELECT OrderStatus, COUNT(*) AS OrderCount
FROM Orders
GROUP BY OrderStatus;
-- Count Total Products Sold

SELECT SUM(Quantity) AS TotalProductsSold
FROM OrderDetails;
--  Count Total Orders by Each Customer

SELECT C.CustomerName, COUNT(O.OrderID) AS TotalOrders
FROM Customers C
LEFT JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerName;
--  Count Total Orders by Each Salesperson

SELECT S.SalespersonName, COUNT(O.OrderID) AS TotalOrders
FROM Salesperson S
LEFT JOIN Orders O ON S.SalespersonID = O.SalespersonID
GROUP BY S.SalespersonName;
--  Count Total Orders Placed in a Specific Month
SELECT COUNT(*) AS TotalOrdersInSeptember
FROM Orders
WHERE OrderDate BETWEEN '2023-09-01' AND '2023-09-30';
--  Count Total Products in Each Category

SELECT ProductCategory, COUNT(*) AS TotalProducts
FROM Products
GROUP BY ProductCategory;
--  Count Customers by City
SELECT City, COUNT(*) AS TotalCustomers
FROM Customers
GROUP BY City;
-- Count Total Unsold Products
SELECT COUNT(*) AS TotalUnsoldProducts
FROM Products P
LEFT JOIN OrderDetails OD ON P.ProductID = OD.ProductID
WHERE OD.ProductID IS NULL;

--  Count Sales Amount by Product

SELECT P.ProductName, SUM(OD.TotalAmount) AS TotalSales
FROM Products P
JOIN OrderDetails OD ON P.ProductID = OD.ProductID
GROUP BY P.ProductName;
--  Count Total Order Details Per Order
SELECT O.OrderID, COUNT(OD.OrderDetailID) AS TotalItems
FROM Orders O
LEFT JOIN OrderDetails OD ON O.OrderID = OD.OrderID
GROUP BY O.OrderID;
--  Count Sales by Region for Each Salesperson

SELECT S.Region, COUNT(O.OrderID) AS TotalOrders
FROM Salesperson S
LEFT JOIN Orders O ON S.SalespersonID = O.SalespersonID
GROUP BY S.Region;
--  Count Unique Products Sold in Orders
SELECT COUNT(DISTINCT OD.ProductID) AS UniqueProductsSold
FROM OrderDetails OD;
--  Count Total Orders and Total Amount per Salesperson
SELECT S.SalespersonName, COUNT(O.OrderID) AS TotalOrders, SUM(OD.TotalAmount) AS TotalSales
FROM Salesperson S
LEFT JOIN Orders O ON S.SalespersonID = O.SalespersonID
LEFT JOIN OrderDetails OD ON O.OrderID = OD.OrderID
GROUP BY S.SalespersonName;
--  Count Average Number of Items Per Order
SELECT AVG(ItemCount) AS AverageItemsPerOrder
FROM (
    SELECT COUNT(OD.OrderDetailID) AS ItemCount
    FROM OrderDetails OD
    GROUP BY OD.OrderID
) AS OrderCounts;

-- Top 5 Products by Total Sales
SELECT P.ProductName, SUM(OD.TotalAmount) AS TotalSales
FROM Products P
JOIN OrderDetails OD ON P.ProductID = OD.ProductID
GROUP BY P.ProductName
ORDER BY TotalSales DESC
LIMIT 5;
-- Top 5 Customers by Total Orders

SELECT C.CustomerName, COUNT(O.OrderID) AS TotalOrders
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerName
ORDER BY TotalOrders DESC
LIMIT 5;
-- Top 5 Salespersons by Total Sales
SELECT S.SalespersonName, SUM(OD.TotalAmount) AS TotalSales
FROM Salesperson S
JOIN Orders O ON S.SalespersonID = O.SalespersonID
JOIN OrderDetails OD ON O.OrderID = OD.OrderID
GROUP BY S.SalespersonName
ORDER BY TotalSales DESC
LIMIT 5;
-- Top 5 Days with the Highest Number of Orders

SELECT DATE(OrderDate) AS OrderDay, COUNT(OrderID) AS TotalOrders
FROM Orders
GROUP BY OrderDay
ORDER BY TotalOrders DESC
LIMIT 5;
-- Top 5 Categories by Total Sales

SELECT ProductCategory, SUM(OD.TotalAmount) AS TotalSales
FROM Products P
JOIN OrderDetails OD ON P.ProductID = OD.ProductID
GROUP BY ProductCategory
ORDER BY TotalSales DESC
LIMIT 5;

