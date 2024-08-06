# SQL Server Express Multi-Database Schema Solution

This project provides a solution to work around the 10 GB database size limitation in SQL Server Express by partitioning data across multiple databases and schemas.

## Features

- Logical partitioning of data using schemas and databases.
- Seamless querying across multiple databases using views and linked servers.

## Getting Started
To work around the 10 GB size limitation in SQL Server Express, you can use a multiple schema approach to logically partition your data across several databases. Each schema can reside in a different database, with each database remaining under the 10 GB limit. This solution does not require third-party tools and can be implemented entirely within SQL Server.

Solution Outline
Multiple Databases: Create multiple databases, each containing a subset of your data.
Schemas for Logical Grouping: Use schemas within each database to logically organize the data.
Cross-Database Views and Procedures: Use views and stored procedures to create a seamless interface for querying across multiple databases.
Example Implementation
## 1. Create Databases
Create multiple databases, e.g., Database1, Database2, etc. Each database should store a portion of the overall data.

## 2. Organize Data into Schemas
Within each database, create schemas to logically group the tables. For example, in Database1, you might have:
### Prerequisites

- SQL Server Express or any version of SQL Server.
- Basic knowledge of SQL and database administration.

     ```sh
    CREATE SCHEMA Sales;
    CREATE SCHEMA Inventory;

Similarly, in Database2, you can have:

     ```sh
    CREATE SCHEMA HR;
    CREATE SCHEMA Finance;

## 3. Partition Data Across Databases
Distribute your tables across these databases and schemas. For example:

In Database1.Sales, store tables related to sales data.
In Database2.HR, store tables related to human resources data.

## 4. Cross-Database Queries
Create views or stored procedures to allow seamless querying across databases. For example, to combine data from Database1.Sales.Orders and Database2.Finance.Payments, you can create a view in a central database or use a linked server.

Example: Using Linked Servers
Set up a linked server to another SQL Server instance or database:

    ```sh
    -- Create a linked server to Database2
    EXEC sp_addlinkedserver 
       @server = 'Server2', 
       @srvproduct = '',
       @provider = 'SQLNCLI', 
       @datasrc = 'Server2\InstanceName';
    
    -- Create a linked server login mapping
    EXEC sp_addlinkedsrvlogin 
       @rmtsrvname = 'Server2', 
       @locallogin = NULL , 
       @useself = 'False', 
       @rmtuser = 'remote_username', 
       @rmtpassword = 'remote_password';
    
Then, create a view to query data across databases: 

    ```sh
    -- Create a view in Database1
    CREATE VIEW AllOrdersAndPayments
    AS
    SELECT o.OrderID, o.OrderDate, p.PaymentDate, p.Amount
    FROM Sales.Orders o
    JOIN [Server2].[Database2].[Finance].Payments p ON o.OrderID = p.OrderID;

## 5. Central Management
Optionally, use a central database to manage metadata and maintain references to each sub-database, ensuring consistency and ease of management.

### Setup

1. **Create Databases**: Run `create_databases.sql` to set up the necessary databases.
2. **Create Schemas**: Run `schemas/create_schemas.sql` in each database.
3. **Create Tables**: Use scripts in `/tables` to create tables within each schema.
4. **Set Up Linked Servers**: (If needed) Use `setup_linked_servers.sql` to configure linked servers.
5. **Create Views**: Run `views/create_views.sql` to create cross-database views.


### Structure
you must follow bellow structure
```
/sql-express-multi-db-schema-solution
|-- /databases
|   |-- create_databases.sql
|   |-- configure_linked_servers.sql
|-- /schemas
|   |-- create_schemas_database1.sql
|   |-- create_schemas_database2.sql
|-- /tables
|   |-- create_tables_database1.sql
|   |-- create_tables_database2.sql
|-- /views
|   |-- create_views.sql
|-- /samples
|   |-- sample_data_database1.sql
|   |-- sample_data_database2.sql
|-- README.md
|-- LICENSE
```

### Detailed Description

1. **`/databases`**
   - **`create_databases.sql`**: Script to create multiple databases. Each database will be used to partition data.
     ```sql
     CREATE DATABASE Database1;
     CREATE DATABASE Database2;
     -- Add more databases as needed
     ```
   - **`configure_linked_servers.sql`**: Script to set up linked servers for cross-database queries if needed.
     ```sql
     -- Configure linked server to Database2
     EXEC sp_addlinkedserver 
        @server = 'Server2', 
        @srvproduct = '',
        @provider = 'SQLNCLI', 
        @datasrc = 'Server2\InstanceName';
     
     EXEC sp_addlinkedsrvlogin 
        @rmtsrvname = 'Server2', 
        @locallogin = NULL, 
        @useself = 'False', 
        @rmtuser = 'remote_username', 
        @rmtpassword = 'remote_password';
     ```

2. **`/schemas`**
   - **`create_schemas_database1.sql`**: Script to create schemas in `Database1`.
     ```sql
     USE Database1;
     CREATE SCHEMA Sales;
     CREATE SCHEMA Inventory;
     ```
   - **`create_schemas_database2.sql`**: Script to create schemas in `Database2`.
     ```sql
     USE Database2;
     CREATE SCHEMA HR;
     CREATE SCHEMA Finance;
     ```

3. **`/tables`**
   - **`create_tables_database1.sql`**: Script to create tables in `Database1`.
     ```sql
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
     ```
   - **`create_tables_database2.sql`**: Script to create tables in `Database2`.
     ```sql
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
     ```

4. **`/views`**
   - **`create_views.sql`**: Script to create views for cross-database queries.
     ```sql
     USE Database1;
     
     CREATE VIEW AllOrdersAndPayments AS
     SELECT o.OrderID, o.OrderDate, p.PaymentDate, p.Amount
     FROM Sales.Orders o
     JOIN [Server2].[Database2].[Finance].Payments p ON o.OrderID = p.OrderID;
     ```

5. **`/samples`**
   - **`sample_data_database1.sql`**: Script to insert sample data into `Database1`.
     ```sql
     USE Database1;
     
     INSERT INTO Sales.Orders (OrderID, OrderDate, CustomerID)
     VALUES (1, '2024-08-01', 101), (2, '2024-08-02', 102);
     
     INSERT INTO Inventory.Products (ProductID, ProductName, Quantity)
     VALUES (1, 'Product A', 100), (2, 'Product B', 200);
     ```
   - **`sample_data_database2.sql`**: Script to insert sample data into `Database2`.
     ```sql
     USE Database2;
     
     INSERT INTO HR.Employees (EmployeeID, EmployeeName, Department)
     VALUES (1, 'Alice Smith', 'Sales'), (2, 'Bob Johnson', 'Finance');
     
     INSERT INTO Finance.Payments (PaymentID, OrderID, PaymentDate, Amount)
     VALUES (1, 1, '2024-08-02', 150.00), (2, 2, '2024-08-03', 200.00);
     ```


   1. **Create Databases**:
      ```sh
      sqlcmd -S your_server -i databases/create_databases.sql
      ```

   2. **Configure Linked Servers** (if needed):
      ```sh
      sqlcmd -S your_server -i databases/configure_linked_servers.sql
      ```

   3. **Create Schemas**:
      ```sh
      sqlcmd -S your_server -i schemas/create_schemas_database1.sql
      sqlcmd -S your_server -i schemas/create_schemas_database2.sql
      ```

   4. **Create Tables**:
      ```sh
      sqlcmd -S your_server -i tables/create_tables_database1.sql
      sqlcmd -S your_server -i tables/create_tables_database2.sql
      ```

   5. **Insert Sample Data**:
      ```sh
      sqlcmd -S your_server -i samples/sample_data_database1.sql
      sqlcmd -S your_server -i samples/sample_data_database2.sql
      ```

   6. **Create Views**:
      ```sh
      sqlcmd -S your_server -i views/create_views.sql
      ```


### Usage

Query data across multiple databases using the provided views or stored procedures.

## Contributing

Feel free to fork this repository and contribute by submitting pull requests.

## License

This project is licensed under the MIT License.
