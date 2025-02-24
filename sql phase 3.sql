DROP TABLE Category_Book CASCADE CONSTRAINTS;
DROP TABLE Order_Book CASCADE CONSTRAINTS;
DROP TABLE Branch_Book CASCADE CONSTRAINTS;
DROP TABLE Branch_Customer CASCADE CONSTRAINTS;
DROP TABLE OrdersTable CASCADE CONSTRAINTS;
DROP TABLE Category CASCADE CONSTRAINTS;
DROP TABLE Books CASCADE CONSTRAINTS;
DROP TABLE Customer CASCADE CONSTRAINTS;
DROP TABLE Branch CASCADE CONSTRAINTS;

CREATE TABLE Branch (
    branch_No CHAR(5),
    location VARCHAR2(50),
    phone_No NUMBER(8),
    CONSTRAINT PK_Branch PRIMARY KEY (branch_No)
);

CREATE TABLE Customer (
    name VARCHAR2(20),
    email VARCHAR2(20) NOT NULL,
    Mship_ID CHAR(10),
    city VARCHAR2(15),
    state VARCHAR2(30),
    zip CHAR(5),
    phone_No NUMBER(10),
    CONSTRAINT PK_Customer PRIMARY KEY (Mship_ID)
);

CREATE TABLE Branch_Customer (
    branch_No CHAR(5),
    Mship_ID CHAR(10),
	CONSTRAINT PK_BranchCustomer PRIMARY KEY (branch_No,Mship_ID),
    CONSTRAINT BC_fk FOREIGN KEY (branch_No) REFERENCES Branch (branch_No),
    CONSTRAINT BC_fk2 FOREIGN KEY (Mship_ID) REFERENCES Customer (Mship_ID)
);

CREATE TABLE OrdersTable ( 
    Order_No NUMBER(10),
    order_date DATE,
    total_Price NUMBER(10) CHECK (total_Price > 50),
    order_status VARCHAR2(10),
    Mship_ID CHAR(10),
    CONSTRAINT PK_Orders PRIMARY KEY (Order_No),
    CONSTRAINT Orders_fk FOREIGN KEY (Mship_ID) REFERENCES Customer (Mship_ID)
);

CREATE TABLE Books (
    book_ISBN CHAR(13),
    author_name VARCHAR2(20),
    publication_date DATE,
    CONSTRAINT PK_Books PRIMARY KEY (book_ISBN)
);

CREATE TABLE Branch_Book (
    branch_No CHAR(5),
    book_ISBN CHAR(13),
    CONSTRAINT PK_BranchBook PRIMARY KEY (branch_No, book_ISBN),
	CONSTRAINT BRB_fk1 FOREIGN KEY (branch_No) REFERENCES Branch (branch_No),
    CONSTRAINT BRB_fk2 FOREIGN KEY (book_ISBN) REFERENCES Books (book_ISBN)
);

CREATE TABLE Order_Book (
    Order_No NUMBER(10),
    book_ISBN CHAR(13),
	CONSTRAINT PK_OrderBook PRIMARY KEY (Order_No,book_ISBN),
    CONSTRAINT OrderB_fk FOREIGN KEY (Order_No) REFERENCES OrdersTable (Order_No),
    CONSTRAINT OrderB_fk2 FOREIGN KEY (book_ISBN) REFERENCES Books (book_ISBN)
);

CREATE TABLE Category (
    category_ID CHAR(10),
    category_discription VARCHAR2(80),
    category_name VARCHAR(15),
    CONSTRAINT PK_Category PRIMARY KEY (category_ID)
);

CREATE TABLE Category_Book (
    category_ID CHAR(10),
    book_ISBN CHAR(13),
	CONSTRAINT CategoryBook PRIMARY KEY (category_ID,book_ISBN),
    CONSTRAINT CategoryB_fk FOREIGN KEY (category_ID) REFERENCES Category (category_ID),
    CONSTRAINT CategoryB_fk2 FOREIGN KEY (book_ISBN) REFERENCES Books (book_ISBN)
);

INSERT INTO Branch VALUES ('1', 'YASMIN', 11111111);
INSERT INTO Branch VALUES ('2', 'NARJIS', 22222222);
INSERT INTO Branch VALUES ('3', 'YASMIN', 33333333);
INSERT INTO Branch VALUES ('4', 'HTEEN', 44444444);

INSERT INTO Customer VALUES ('Anoud', 'anoud@gmail.com', '112233', 'Riyadh', 'Central', '1133', 5353535353);
INSERT INTO Customer VALUES ('Noura', 'Noura@gmail.com', '445566', 'Dammam', 'Eastern', '3322', 5252525252);
INSERT INTO Customer VALUES ('Sara', 'Sara@gmail.com', '889900', 'Jeddah', 'Western', '2244', 5454545454);
INSERT INTO Customer VALUES ('Maha', 'Maha@gmail.com', '754400', 'Mecca', 'Western', '3355', 6765399987);

INSERT INTO Branch_Customer VALUES ('1', '112233');
INSERT INTO Branch_Customer VALUES ('2', '445566');
INSERT INTO Branch_Customer VALUES ('3', '889900');
INSERT INTO Branch_Customer VALUES ('4', '754400');

INSERT INTO OrdersTable VALUES (101010, TO_DATE('2024-01-11', 'YYYY-MM-DD'), 100, 'Confirmed', '112233');
INSERT INTO OrdersTable VALUES (202020, TO_DATE('2024-02-03', 'YYYY-MM-DD'), 250, 'Canceled', '445566');
INSERT INTO OrdersTable VALUES (303030, TO_DATE('2024-03-27', 'YYYY-MM-DD'), 75, 'Pending', '889900');
INSERT INTO OrdersTable VALUES (404040, TO_DATE('2020-06-05', 'YYYY-MM-DD'), 150, 'Pending', '889900');

INSERT INTO Books VALUES ('11111', 'NOURAN', TO_DATE('2017-01-01', 'YYYY-MM-DD'));
INSERT INTO Books VALUES ('22222', 'FATEN', TO_DATE('2020-12-01', 'YYYY-MM-DD'));
INSERT INTO Books VALUES ('33333', 'GHADA', TO_DATE('2024-05-01', 'YYYY-MM-DD'));
INSERT INTO Books VALUES ('44444', 'DANAH', TO_DATE('2020-06-01', 'YYYY-MM-DD'));

INSERT INTO Branch_Book VALUES ('1', '11111');
INSERT INTO Branch_Book VALUES ('2', '22222');
INSERT INTO Branch_Book VALUES ('3', '33333');
INSERT INTO Branch_Book VALUES ('4', '44444');

INSERT INTO Order_Book VALUES (101010, '11111');
INSERT INTO Order_Book VALUES (202020, '22222');
INSERT INTO Order_Book VALUES (303030,'33333');
INSERT INTO Order_Book VALUES (404040,'44444');

INSERT INTO Category VALUES ('001122', 'a genre that involve protagonists going on epic journeys.','Adventure');
INSERT INTO Category VALUES ('001133',  'a genre of speculative fiction that is intended to disturb, frighten, or scare.','Horror');
INSERT INTO Category VALUES ('001144', 'books about forms of education and how it is achieved or be educational itself','Educational');
INSERT INTO Category VALUES ('001155', 'a genre of speculative fiction that is intended to disturb, frighten, or scare.','Horror' );

INSERT INTO Category_Book VALUES ('001122', '11111');
INSERT INTO Category_Book VALUES ('001133', '22222');
INSERT INTO Category_Book VALUES ('001144', '33333');
INSERT INTO Category_Book VALUES ('001155', '44444');

--List all Customers Where City is Riyadh
SELECT name, email
FROM Customer
WHERE city = 'Riyadh';

--List all orders where total Price is less than 100
SELECT  *
FROM OrdersTable
WHERE total_Price < 100;

--List Books where authors name starts with the letter N
SELECT *
FROM Books
WHERE author_name LIKE 'N%';

--Lists the Total Price of all orders for each Customer 
SELECT Mship_ID, SUM(total_Price)
FROM OrdersTable
GROUP BY Mship_ID;

--Lists Total_sales for each city where Total_sales should be greater than 100
SELECT city, SUM(total_Price) AS total_sales
FROM Customer , OrdersTable
WHERE Customer.Mship_ID = OrdersTable.Mship_ID
GROUP BY city
HAVING SUM(total_Price) > 100;

--Lists the name and email of a Customer using ID and a Specific Order Number
SELECT Mship_ID,name,email
FROM Customer
WHERE Mship_ID = (
 SELECT Mship_ID
FROM OrdersTable
WHERE Order_No=303030
);


