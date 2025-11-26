# Library Database System

A SQL-based library management system that models branches, customers, books, categories, and orders.  
The project includes full database creation, constraints, sample inserts, and analytical queries.

## Features
- Create and manage library branches
- Store customer information and membership IDs
- Track books, authors, categories, and publication dates
- Manage orders and order status
- Many-to-many relationships using junction tables:
  - Branch_Book
  - Category_Book
  - Branch_Customer
  - Order_Book

## Tables Included
- Branch
- Customer
- Branch_Customer
- OrdersTable
- Books
- Branch_Book
- Order_Book
- Category
- Category_Book

## Key Constraints
- Primary keys on all main entities
- Foreign keys linking customers, branches, books, categories, and orders
- CHECK constraint on total price (> 50)
- Composite keys for relationship tables

## Sample Queries Included
- List customers living in Riyadh
- Retrieve orders with total price < 100
- List books where author name starts with 'N'
- Calculate total order price per customer
- Calculate total city sales > 100
- Get customer name & email using a specific order number

## Technologies Used
- Oracle SQL / SQL Developer
- Relational Database Design (ERD → Tables)
