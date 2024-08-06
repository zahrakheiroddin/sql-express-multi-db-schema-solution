USE Database2;

CREATE TABLE HR.Employees (
    EmployeeID INT PRIMARY KEY,
    EmployeeName NVARCHAR(100),
    Department NVARCHAR(50)
);

CREATE TABLE Finance.Payments (
    PaymentID INT PRIMARY KEY,
    OrderID INT,
    PaymentDate DATETIME,
    Amount DECIMAL(18, 2)
);