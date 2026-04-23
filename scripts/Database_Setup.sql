/*
=============================================================
Database Setup and Schema Initialization
=============================================================
Script Purpose:
    This script sets up a new database named 'DataWarehouseAnalytics'. 
    It first checks whether the database already exists — if it does, 
    the existing database is removed and a fresh one is created in its place. 
    A schema named 'gold' is also created as part of the initialization.

WARNING:
    Executing this script will permanently delete the 'DataWarehouseAnalytics' 
    database if it currently exists, along with all data stored inside it. 
    Make sure you have a valid backup before proceeding. This action cannot be undone.
*/

USE master;
GO

-- Remove the existing 'DataWarehouseAnalytics' database if found
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouseAnalytics')
BEGIN
    ALTER DATABASE DataWarehouseAnalytics SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE DataWarehouseAnalytics;
END;
GO

-- Build a fresh instance of the 'DataWarehouseAnalytics' database
CREATE DATABASE DataWarehouseAnalytics;
GO

USE DataWarehouseAnalytics;
GO

-- Set up the gold schema
CREATE SCHEMA gold;
GO

CREATE TABLE gold.dim_customers(
	customer_key int,
	customer_id int,
	customer_number nvarchar(50),
	first_name nvarchar(50),
	last_name nvarchar(50),
	country nvarchar(50),
	marital_status nvarchar(50),
	gender nvarchar(50),
	birthdate date,
	create_date date
);
GO

CREATE TABLE gold.dim_products(
	product_key int,
	product_id int,
	product_number nvarchar(50),
	product_name nvarchar(50),
	category_id nvarchar(50),
	category nvarchar(50),
	subcategory nvarchar(50),
	maintenance nvarchar(50),
	cost int,
	product_line nvarchar(50),
	start_date date
);
GO

CREATE TABLE gold.fact_sales(
	order_number nvarchar(50),
	product_key int,
	customer_key int,
	order_date date,
	shipping_date date,
	due_date date,
	sales_amount int,
	quantity tinyint,
	price int
);
GO

-- Clear any existing records before loading fresh data
TRUNCATE TABLE gold.dim_customers;
GO

-- Load customer data from the CSV source file
BULK INSERT gold.dim_customers
FROM 'C:\Data\sql-data-analytics-project\datasets\flat-files\dim_customers.csv'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);
GO

TRUNCATE TABLE gold.dim_products;
GO

-- Load product data from the CSV source file
BULK INSERT gold.dim_products
FROM 'C:\Data\sql-data-analytics-project\datasets\flat-files\dim_products.csv'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);
GO

TRUNCATE TABLE gold.fact_sales;
GO

-- Load sales transaction data from the CSV source file
BULK INSERT gold.fact_sales
FROM 'C:\Data\sql-data-analytics-project\datasets\flat-files\fact_sales.csv'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);
GO
