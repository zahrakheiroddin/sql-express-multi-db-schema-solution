USE Database2;

INSERT INTO HR.Employees (EmployeeID, EmployeeName, Department)
VALUES (1, 'Alice Smith', 'Sales'), (2, 'Bob Johnson', 'Finance');

INSERT INTO Finance.Payments (PaymentID, OrderID, PaymentDate, Amount)
VALUES (1, 1, '2024-08-02', 150.00), (2, 2, '2024-08-03', 200.00);