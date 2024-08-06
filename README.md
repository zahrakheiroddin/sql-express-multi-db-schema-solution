# SQL Server Express Multi-Database Schema Solution

This project provides a solution to work around the 10 GB database size limitation in SQL Server Express by partitioning data across multiple databases and schemas.

## Features

- Logical partitioning of data using schemas and databases.
- Seamless querying across multiple databases using views and linked servers.

## Getting Started

### Prerequisites

- SQL Server Express or any version of SQL Server.
- Basic knowledge of SQL and database administration.

### Setup

1. **Create Databases**: Run `create_databases.sql` to set up the necessary databases.
2. **Create Schemas**: Run `schemas/create_schemas.sql` in each database.
3. **Create Tables**: Use scripts in `/tables` to create tables within each schema.
4. **Set Up Linked Servers**: (If needed) Use `setup_linked_servers.sql` to configure linked servers.
5. **Create Views**: Run `views/create_views.sql` to create cross-database views.

### Usage

Query data across multiple databases using the provided views or stored procedures.

## Contributing

Feel free to fork this repository and contribute by submitting pull requests.

## License

This project is licensed under the MIT License.
