USE Database1;

CREATE VIEW AllOrdersAndPayments AS
SELECT o.OrderID, o.OrderDate, p.PaymentDate, p.Amount
FROM Sales.Orders o
JOIN [Server2].[Database2].[Finance].Payments p ON o.OrderID = p.OrderID;