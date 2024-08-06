# SQL Server Express Multi-Database Schema Solution

This project provides a solution to work around the 10 GB database size limitation in SQL Server Express by partitioning data across multiple databases and schemas.

## Features

- Logical partitioning of data using schemas and databases.
- Seamless querying across multiple databases using views and linked servers.

## Getting Started
To work around the 10 GB size limitation in SQL Server Express, you can use a multiple schema approach to logically partition your data across several databases. Each schema can reside in a different database, with each database remaining under the 10 GB limit. This solution does not require third-party tools and can be implemented entirely within SQL Server.


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
