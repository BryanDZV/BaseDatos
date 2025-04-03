-- Crear tabla CUSTOMERS
CREATE TABLE CUSTOMERS (
    custid INT PRIMARY KEY,
    cname VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(15),
    address VARCHAR(255)
);

INSERT INTO CUSTOMERS (custid, cname, email, phone, address) VALUES (1, 'Alice', 'alice@example.com', '1234567890', '123 Elm Street');
INSERT INTO CUSTOMERS (custid, cname, email, phone, address) VALUES (2, 'Bob', 'bob@example.com', '0987654321', '456 Oak Avenue');
INSERT INTO CUSTOMERS (custid, cname, email, phone, address) VALUES (3, 'Charlie', 'charlie@example.com', '5678901234', '789 Pine Road');

-- Crear tabla PRODUCTS
CREATE TABLE PRODUCTS (
    prodid INT PRIMARY KEY,
    name VARCHAR(100),
    price DECIMAL(10, 2),
    stock INT
);

INSERT INTO PRODUCTS (prodid, name, price, stock) VALUES (1, 'Laptop', 1000.00, 50);
INSERT INTO PRODUCTS (prodid, name, price, stock) VALUES (2, 'Mouse', 25.75, 200);
INSERT INTO PRODUCTS (prodid, name, price, stock) VALUES (3, 'Keyboard', 45.60, 150);
INSERT INTO PRODUCTS (prodid, name, price, stock) VALUES (4, 'Monitor', 300.00, 80);

-- Crear tabla CATEGORIES
CREATE TABLE CATEGORIES (
    catid INT PRIMARY KEY,
    cname VARCHAR(100)
);

INSERT INTO CATEGORIES (catid, cname) VALUES (1, 'Electronics');
INSERT INTO CATEGORIES (catid, cname) VALUES (2, 'Accessories');
INSERT INTO CATEGORIES (catid, cname) VALUES (3, 'Furniture');

-- Relación PRODUCTOS-CATEGORIAS
CREATE TABLE PRODUCT_CATEGORIES (
    prodid INT,
    catid INT,
    PRIMARY KEY (prodid, catid),
    FOREIGN KEY (prodid) REFERENCES PRODUCTS(prodid),
    FOREIGN KEY (catid) REFERENCES CATEGORIES(catid)
);

INSERT INTO PRODUCT_CATEGORIES (prodid, catid) VALUES (1, 1);
INSERT INTO PRODUCT_CATEGORIES (prodid, catid) VALUES (2, 2);
INSERT INTO PRODUCT_CATEGORIES (prodid, catid) VALUES (3, 2);
INSERT INTO PRODUCT_CATEGORIES (prodid, catid) VALUES (4, 1);

-- Crear tabla ORDERS
CREATE TABLE ORDERS (
    ordid INT PRIMARY KEY,
    custid INT,
    order_date DATE,
    total_amount DECIMAL(10, 2),
    status VARCHAR(20),
    FOREIGN KEY (custid) REFERENCES CUSTOMERS(custid)
);

INSERT INTO ORDERS (ordid, custid, order_date, total_amount, status) VALUES (101, 1, TO_DATE('2024-01-15', 'YYYY-MM-DD'), 120.50, 'Completed');
INSERT INTO ORDERS (ordid, custid, order_date, total_amount, status) VALUES (102, 2, TO_DATE('2024-02-20', 'YYYY-MM-DD'), 45.60, 'Pending');
INSERT INTO ORDERS (ordid, custid, order_date, total_amount, status) VALUES (103, 1, TO_DATE('2024-03-05', 'YYYY-MM-DD'), 300.00, 'Completed');
INSERT INTO ORDERS (ordid, custid, order_date, total_amount, status) VALUES (104, 3, TO_DATE('2024-03-10', 'YYYY-MM-DD'), 150.00, 'Shipped');

-- Crear tabla ORDER_ITEMS
CREATE TABLE ORDER_ITEMS (
    ordid INT,
    prodid INT,
    quantity INT,
    PRIMARY KEY (ordid, prodid),
    FOREIGN KEY (ordid) REFERENCES ORDERS(ordid),
    FOREIGN KEY (prodid) REFERENCES PRODUCTS(prodid)
);

INSERT INTO ORDER_ITEMS (ordid, prodid, quantity) VALUES (101, 1, 1);
INSERT INTO ORDER_ITEMS (ordid, prodid, quantity) VALUES (101, 2, 2);
INSERT INTO ORDER_ITEMS (ordid, prodid, quantity) VALUES (102, 3, 1);
INSERT INTO ORDER_ITEMS (ordid, prodid, quantity) VALUES (103, 4, 1);
INSERT INTO ORDER_ITEMS (ordid, prodid, quantity) VALUES (104, 2, 4);

-- Crear tabla EMPLOYEES
CREATE TABLE EMPLOYEES (
    empno INT PRIMARY KEY,
    ename VARCHAR(100),
    sal DECIMAL(10, 2),
    deptno INT,
    mgr INT,
    hiredate DATE
);

INSERT INTO EMPLOYEES (empno, ename, sal, deptno, mgr, hiredate) VALUES (1, 'John', 5000, 10, NULL, TO_DATE('2020-01-15', 'YYYY-MM-DD'));
INSERT INTO EMPLOYEES (empno, ename, sal, deptno, mgr, hiredate) VALUES (2, 'Jane', 4500, 20, 1, TO_DATE('2021-03-20', 'YYYY-MM-DD'));
INSERT INTO EMPLOYEES (empno, ename, sal, deptno, mgr, hiredate) VALUES (3, 'Mike', 3000, 10, 1, TO_DATE('2022-06-10', 'YYYY-MM-DD'));
INSERT INTO EMPLOYEES (empno, ename, sal, deptno, mgr, hiredate) VALUES (4, 'Anna', 3500, 20, 2, TO_DATE('2023-02-25', 'YYYY-MM-DD'));

-- Crear tabla DEPARTMENTS
CREATE TABLE DEPARTMENTS (
    deptno INT PRIMARY KEY,
    dname VARCHAR(100),
    loc VARCHAR(100)
);

INSERT INTO DEPARTMENTS (deptno, dname, loc) VALUES (10, 'IT', 'New York');
INSERT INTO DEPARTMENTS (deptno, dname, loc) VALUES (20, 'HR', 'Los Angeles');
INSERT INTO DEPARTMENTS (deptno, dname, loc) VALUES (30, 'Finance', 'Chicago');

-- Crear tabla SALGRADES
CREATE TABLE SALGRADES (
    grade INT PRIMARY KEY,
    losal DECIMAL(10, 2),
    hisal DECIMAL(10, 2)
);

INSERT INTO SALGRADES (grade, losal, hisal) VALUES (1, 1000, 2000);
INSERT INTO SALGRADES (grade, losal, hisal) VALUES (2, 2001, 3000);
INSERT INTO SALGRADES (grade, losal, hisal) VALUES (3, 3001, 4000);
INSERT INTO SALGRADES (grade, losal, hisal) VALUES (4, 4001, 5000);
INSERT INTO SALGRADES (grade, losal, hisal) VALUES (5, 5001, 6000);

-- Crear tabla AUDIT_LOG
CREATE TABLE AUDIT_LOG (
    logid INT PRIMARY KEY,
    table_name VARCHAR(50),
    operation VARCHAR(20),
    timestamp DATE,
    user_name VARCHAR(50)
);

INSERT INTO AUDIT_LOG (logid, table_name, operation, timestamp, user_name) VALUES (1, 'ORDERS', 'INSERT', SYSDATE, 'admin');
INSERT INTO AUDIT_LOG (logid, table_name, operation, timestamp, user_name) VALUES (2, 'EMPLOYEES', 'UPDATE', SYSDATE, 'manager');

-- Crear tabla TRANSACTIONS
CREATE TABLE TRANSACTIONS (
    transid INT PRIMARY KEY,
    ordid INT,
    payment_date DATE,
    amount DECIMAL(10, 2),
    payment_method VARCHAR(20),
    FOREIGN KEY (ordid) REFERENCES ORDERS(ordid)
);

INSERT INTO TRANSACTIONS (transid, ordid, payment_date, amount, payment_method) VALUES (1, 101, TO_DATE('2024-01-16', 'YYYY-MM-DD'), 120.50, 'Credit Card');
INSERT INTO TRANSACTIONS (transid, ordid, payment_date, amount, payment_method) VALUES (2, 103, TO_DATE('2024-03-06', 'YYYY-MM-DD'), 300.00, 'PayPal');