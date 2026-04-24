--Creating tables
CREATE TABLE Customers (
    customer_id NUMBER PRIMARY KEY,
    name VARCHAR2(100),
    city VARCHAR2(50)
);

CREATE TABLE Products (
    product_id NUMBER PRIMARY KEY,
    name VARCHAR2(100),
    category VARCHAR2(50),
    price NUMBER
);

CREATE TABLE Orders (
    order_id NUMBER PRIMARY KEY,
    customer_id NUMBER,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE Order_Items (
    order_id NUMBER,
    product_id NUMBER,
    quantity NUMBER,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

--Inserting data
INSERT INTO Customers VALUES (1, 'aarcha', 'nepal');
INSERT INTO Customers VALUES (2, 'hitesh', 'tamil nadu');
INSERT INTO Customers VALUES (3, 'vikranth', 'telangana');

INSERT INTO Products VALUES (10, 'Laptop', 'Electronics', 1200);
INSERT INTO Products VALUES (11, 'Phone', 'Electronics', 800);
INSERT INTO Products VALUES (12, 'Coffee Mug', 'Home', 15);

INSERT INTO Orders VALUES (100, 1, TO_DATE('2023-10-01', 'YYYY-MM-DD'));
INSERT INTO Orders VALUES (101, 2, TO_DATE('2023-10-05', 'YYYY-MM-DD'));

INSERT INTO Order_Items VALUES (100, 10, 1);
INSERT INTO Order_Items VALUES (101, 11, 2);
INSERT INTO Order_Items VALUES (101, 12, 5);

--Queries
--1. Top Selling Products

SELECT p.name, SUM(oi.quantity) as total_sold
FROM Order_Items oi
JOIN Products p ON oi.product_id = p.product_id
GROUP BY p.name
ORDER BY total_sold DESC;

--2. Monthly Revenue
SELECT c.name, SUM(p.price * oi.quantity) as total_spent
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN Order_Items oi ON o.order_id = oi.order_id
JOIN Products p ON oi.product_id = p.product_id
GROUP BY c.name
ORDER BY total_spent DESC;

--3. Inactive Customers
SELECT TO_CHAR(order_date, 'YYYY-MM') as month, SUM(p.price * oi.quantity) as revenue
FROM Orders o
JOIN Order_Items oi ON o.order_id = oi.order_id
JOIN Products p ON oi.product_id = p.product_id
GROUP BY TO_CHAR(order_date, 'YYYY-MM');

--4. Sales by Category
SELECT p.category, SUM(p.price * oi.quantity) as sales
FROM Products p
JOIN Order_Items oi ON p.product_id = oi.product_id
GROUP BY p.category;

--5. Customers with No Orders
SELECT name FROM Customers
WHERE customer_id NOT IN (SELECT customer_id FROM Orders);