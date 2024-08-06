USE Database1;

INSERT INTO Sales.Orders (OrderID, OrderDate, CustomerID)
VALUES (1, '2024-08-01', 101), (2, '2024-08-02', 102);

INSERT INTO Inventory.Products (ProductID, ProductName, Quantity)
VALUES (1, 'Product A', 100), (2, 'Product B', 200);