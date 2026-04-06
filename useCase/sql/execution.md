SQL> CREATE TABLE Customers (
  2      customer_id NUMBER PRIMARY KEY,
  3      name VARCHAR2(100),
  4      city VARCHAR2(50)
  5  );

Table created.

SQL> CREATE TABLE Products (
  2      product_id NUMBER PRIMARY KEY,
  3      name VARCHAR2(100),
  4      category VARCHAR2(50),
  5      price NUMBER
  6  );

Table created.

SQL> CREATE TABLE Orders (
  2      order_id NUMBER PRIMARY KEY,
  3      customer_id NUMBER,
  4      order_date DATE,
  5      FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
  6  );

Table created.

SQL> CREATE TABLE Order_Items (
  2      order_id NUMBER,
  3      product_id NUMBER,
  4      quantity NUMBER,
  5      FOREIGN KEY (order_id) REFERENCES Orders(order_id),
  6      FOREIGN KEY (product_id) REFERENCES Products(product_id)
  7  );

Table created.

SQL> INSERT INTO Customers VALUES (1, 'aarcha', 'nepal');

1 row created.

SQL> INSERT INTO Customers VALUES (2, 'hitesh', 'tamil nadu');

1 row created.

SQL> INSERT INTO Customers VALUES (3, 'vikranth', 'telangana');

1 row created.

SQL>
SQL> INSERT INTO Products VALUES (10, 'Laptop', 'Electronics', 1200);

1 row created.

SQL> INSERT INTO Products VALUES (11, 'Phone', 'Electronics', 800);

1 row created.

SQL> INSERT INTO Products VALUES (12, 'Coffee Mug', 'Home', 15);

1 row created.

SQL>
SQL> INSERT INTO Orders VALUES (100, 1, TO_DATE('2023-10-01', 'YYYY-MM-DD'));

1 row created.

SQL> INSERT INTO Orders VALUES (101, 2, TO_DATE('2023-10-05', 'YYYY-MM-DD'));

1 row created.

SQL>
SQL> INSERT INTO Order_Items VALUES (100, 10, 1);

1 row created.

SQL> INSERT INTO Order_Items VALUES (101, 11, 2);

1 row created.

SQL> INSERT INTO Order_Items VALUES (101, 12, 5);

1 row created.

SQL> SELECT p.name, SUM(oi.quantity) as total_sold
  2  FROM Order_Items oi
  3  JOIN Products p ON oi.product_id = p.product_id
  4  GROUP BY p.name
  5  ORDER BY total_sold DESC;

NAME
--------------------------------------------------------------------------------
TOTAL_SOLD
----------
Coffee Mug
         5

Phone
         2

Laptop
         1


SQL> SELECT c.name, SUM(p.price * oi.quantity) as total_spent
  2  FROM Customers c
  3  JOIN Orders o ON c.customer_id = o.customer_id
  4  JOIN Order_Items oi ON o.order_id = oi.order_id
  5  JOIN Products p ON oi.product_id = p.product_id
  6  GROUP BY c.name
  7  ORDER BY total_spent DESC;

NAME
--------------------------------------------------------------------------------
TOTAL_SPENT
-----------
hitesh
       1675

aarcha
       1200


SQL> SELECT TO_CHAR(order_date, 'YYYY-MM') as month, SUM(p.price * oi.quantity) as revenue
  2  FROM Orders o
  3  JOIN Order_Items oi ON o.order_id = oi.order_id
  4  JOIN Products p ON oi.product_id = p.product_id
  5  GROUP BY TO_CHAR(order_date, 'YYYY-MM');

MONTH      REVENUE
------- ----------
2023-10       2875

SQL>
SQL> SELECT p.category, SUM(p.price * oi.quantity) as sales
  2  FROM Products p
  3  JOIN Order_Items oi ON p.product_id = oi.product_id
  4  GROUP BY p.category;

CATEGORY                                                SALES
-------------------------------------------------- ----------
Electronics                                              2800
Home                                                       75

SQL> SELECT name FROM Customers
  2  WHERE customer_id NOT IN (SELECT customer_id FROM Orders);

NAME
--------------------------------------------------------------------------------
vikranth

SQL>