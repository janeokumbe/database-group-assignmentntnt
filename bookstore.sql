-- This SQL script creates a database for a bookstore with tables for books, authors, publishers, and languages.
-- It includes the creation of tables with appropriate data types, primary keys, and foreign key constraints.
-- The script also includes comments to explain the purpose of each table and its columns.
-- This script is designed to be run in a MySQL environment.
-- It creates a database named BookStore_db and defines the following tables:

CREATE database BookStore_db; -- Create the database
USE BookStore_db;  -- Use the created database

CREATE TABLE publisher (
    publisher_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255)
); -- Table for publishers with a unique ID and name

CREATE TABLE book_language (
    language_id INT AUTO_INCREMENT PRIMARY KEY,
    language_name VARCHAR(100)
); -- Table for book languages with a unique ID and language name

CREATE TABLE book (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    publisher_id INT,
    language_id INT,
    publication_year YEAR,
    price DECIMAL(8,2),
    stock_quantity INT,
    FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id),
    FOREIGN KEY (language_id) REFERENCES book_language(language_id)
); -- Table for books with a unique ID, title, publisher, language, publication year, price, and stock quantity
-- The publisher and language columns are foreign keys referencing the respective tables

CREATE TABLE author (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100)
); -- Table for authors with a unique ID, first name, and last name
-- This table allows for multiple authors to be associated with a book

CREATE TABLE book_author (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id),
    FOREIGN KEY (author_id) REFERENCES author(author_id)
); -- Junction table for many-to-many relationship between books and authors
-- This table allows for multiple authors to be associated with a book and vice versa

-- CUSTOMER & ADDRESS TABLES
-- The following tables are for customer information and their addresses
-- These tables are designed to store customer details and their associated addresses

CREATE TABLE customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(255) UNIQUE,
    phone VARCHAR(20)
); -- Table for customers with a unique ID, first name, last name, email, and phone number
-- The email column is unique to prevent duplicate entries

CREATE TABLE country (
    country_id INT AUTO_INCREMENT PRIMARY KEY,
    country_name VARCHAR(100)
); -- Table for countries with a unique ID and country name
-- This table allows for multiple addresses to be associated with a customer

CREATE TABLE address (
    address_id INT AUTO_INCREMENT PRIMARY KEY,
    street VARCHAR(255),
    city VARCHAR(100),
    state VARCHAR(100),
    postal_code VARCHAR(20),
    country_id INT,
    FOREIGN KEY (country_id) REFERENCES country(country_id)
); -- Table for addresses with a unique ID, street, city, state, postal code, and country
-- The country column is a foreign key referencing the country table

CREATE TABLE address_status (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(50) NOT NULL
); -- Table for address statuses with a unique ID and status name
-- This table allows for different statuses to be associated with an address

CREATE TABLE customer_address (
    customer_id INT,
    address_id INT,
    status_id INT,
    PRIMARY KEY (customer_id, address_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (address_id) REFERENCES address(address_id),
    FOREIGN KEY (status_id) REFERENCES address_status(status_id)
); -- Junction table for many-to-many relationship between customers and addresses
-- This table allows for multiple addresses to be associated with a customer and vice versa

Orders & Shipping Tables
-- The following tables are for order and shipping information
-- These tables are designed to store order details and their associated shipping information
CREATE TABLE cust_order (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    shipping_method_id INT,
    order_status_id INT,
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (shipping_method_id) REFERENCES shipping_method(method_id),
    FOREIGN KEY (order_status_id) REFERENCES order_status(status_id)
);-- Table for customer orders with a unique ID, customer ID, order date, shipping method, order status, and total amount
-- The customer, shipping method, and order status columns are foreign keys referencing the respective tables

CREATE TABLE order_line (
    order_id INT,
    book_id INT,
    quantity INT,
    price DECIMAL(8,2),
    PRIMARY KEY (order_id, book_id),
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id)
);-- Table for order lines with a unique ID, order ID, book ID, quantity, and price
-- The order ID and book ID columns are foreign keys referencing the respective tables

CREATE TABLE shipping_method (
    method_id INT AUTO_INCREMENT PRIMARY KEY,
    method_name VARCHAR(100),
    cost DECIMAL(6,2)
);-- Table for shipping methods with a unique ID, method name, and cost
-- This table allows for different shipping methods to be associated with an order

CREATE TABLE order_status (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(50) 
);-- Table for order statuses with a unique ID and status name
-- This table allows for different statuses to be associated with an order

CREATE TABLE order_history (
    history_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    status_id INT,
    status_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (status_id) REFERENCES order_status(status_id)
);-- Table for order history with a unique ID, order ID, status ID, and status date
-- The order ID and status ID columns are foreign keys referencing the respective tables

















