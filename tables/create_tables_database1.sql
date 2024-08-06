USE Database1;

CREATE TABLE Sales.Orders (
    OrderID INT PRIMARY KEY,
    OrderDate DATETIME,
    CustomerID INT
);

CREATE TABLE Inventory.Products (
    ProductID INT PRIMARY KEY,
    ProductName NVARCHAR(100),
    Quantity INT
);