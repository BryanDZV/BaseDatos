-- Creación de la base de datos para practicar SQL

-- Tabla de empleados (emp)
CREATE TABLE emp (
    empno INT PRIMARY KEY,
    ename VARCHAR(50),
    job VARCHAR(50),
    mgr INT,
    hiredate DATE,
    sal DECIMAL(10, 2),
    comm DECIMAL(10, 2),
    deptno INT
);

-- Tabla de departamentos (dept)
CREATE TABLE dept (
    deptno INT PRIMARY KEY,
    dname VARCHAR(50),
    loc VARCHAR(50)
);

-- Tabla de grados salariales (salgrade)
CREATE TABLE salgrade (
    grade INT PRIMARY KEY,
    losal DECIMAL(10, 2),
    hisal DECIMAL(10, 2)
);

-- Tabla de proyectos (project)
CREATE TABLE project (
    proj_id INT PRIMARY KEY,
    proj_name VARCHAR(100),
    start_date DATE,
    end_date DATE
);

-- Tabla de asignaciones de empleados a proyectos (emp_project)
CREATE TABLE emp_project (
    empno INT,
    proj_id INT,
    hours_worked DECIMAL(10, 2),
    PRIMARY KEY (empno, proj_id),
    FOREIGN KEY (empno) REFERENCES emp(empno),
    FOREIGN KEY (proj_id) REFERENCES project(proj_id)
);

-- Tabla de clientes (client)
CREATE TABLE client (
    client_id INT PRIMARY KEY,
    client_name VARCHAR(100),
    contact_email VARCHAR(100)
);

-- Tabla de contratos (contract)
CREATE TABLE contract (
    contract_id INT PRIMARY KEY,
    client_id INT,
    proj_id INT,
    contract_date DATE,
    amount DECIMAL(15, 2),
    FOREIGN KEY (client_id) REFERENCES client(client_id),
    FOREIGN KEY (proj_id) REFERENCES project(proj_id)
);

-- Inserción de datos en la tabla de departamentos
INSERT INTO dept (deptno, dname, loc) VALUES (10, 'ACCOUNTING', 'NEW YORK');
INSERT INTO dept (deptno, dname, loc) VALUES (20, 'RESEARCH', 'DALLAS');
INSERT INTO dept (deptno, dname, loc) VALUES (30, 'SALES', 'CHICAGO');
INSERT INTO dept (deptno, dname, loc) VALUES (40, 'OPERATIONS', 'BOSTON');

-- Inserción de datos en la tabla de empleados
INSERT INTO emp (empno, ename, job, mgr, hiredate, sal, comm, deptno) VALUES (7839, 'KING', 'PRESIDENT', NULL, DATE '1981-11-17', 5000, NULL, 10);
INSERT INTO emp (empno, ename, job, mgr, hiredate, sal, comm, deptno) VALUES (7566, 'JONES', 'MANAGER', 7839, DATE '1981-04-02', 2975, NULL, 20);
INSERT INTO emp (empno, ename, job, mgr, hiredate, sal, comm, deptno) VALUES (7698, 'BLAKE', 'MANAGER', 7839, DATE '1981-05-01', 2850, NULL, 30);
INSERT INTO emp (empno, ename, job, mgr, hiredate, sal, comm, deptno) VALUES (7782, 'CLARK', 'MANAGER', 7839, DATE '1981-06-09', 2450, NULL, 10);
INSERT INTO emp (empno, ename, job, mgr, hiredate, sal, comm, deptno) VALUES (7788, 'SCOTT', 'ANALYST', 7566, DATE '1987-07-13', 3000, NULL, 20);
INSERT INTO emp (empno, ename, job, mgr, hiredate, sal, comm, deptno) VALUES (7902, 'FORD', 'ANALYST', 7566, DATE '1981-12-03', 3000, NULL, 20);
INSERT INTO emp (empno, ename, job, mgr, hiredate, sal, comm, deptno) VALUES (7844, 'TURNER', 'SALESMAN', 7698, DATE '1981-09-08', 1500, 0, 30);
INSERT INTO emp (empno, ename, job, mgr, hiredate, sal, comm, deptno) VALUES (7654, 'MARTIN', 'SALESMAN', 7698, DATE '1981-09-28', 1250, 1400, 30);
INSERT INTO emp (empno, ename, job, mgr, hiredate, sal, comm, deptno) VALUES (7499, 'ALLEN', 'SALESMAN', 7698, DATE '1981-02-20', 1600, 300, 30);
INSERT INTO emp (empno, ename, job, mgr, hiredate, sal, comm, deptno) VALUES (7521, 'WARD', 'SALESMAN', 7698, DATE '1981-02-22', 1250, 500, 30);
INSERT INTO emp (empno, ename, job, mgr, hiredate, sal, comm, deptno) VALUES (7934, 'MILLER', 'CLERK', 7782, DATE '1982-01-23', 1300, NULL, 10);
INSERT INTO emp (empno, ename, job, mgr, hiredate, sal, comm, deptno) VALUES (7876, 'ADAMS', 'CLERK', 7788, DATE '1987-05-23', 1100, NULL, 20);
INSERT INTO emp (empno, ename, job, mgr, hiredate, sal, comm, deptno) VALUES (7900, 'JAMES', 'CLERK', 7698, DATE '1981-12-03', 950, NULL, 30);
INSERT INTO emp (empno, ename, job, mgr, hiredate, sal, comm, deptno) VALUES (7655, 'SMITH', 'CLERK', 7902, DATE '1980-12-17', 800, NULL, 20);

-- Inserción de datos en la tabla de grados salariales
INSERT INTO salgrade (grade, losal, hisal) VALUES (1, 700, 1200);
INSERT INTO salgrade (grade, losal, hisal) VALUES (2, 1201, 1400);
INSERT INTO salgrade (grade, losal, hisal) VALUES (3, 1401, 2000);
INSERT INTO salgrade (grade, losal, hisal) VALUES (4, 2001, 3000);
INSERT INTO salgrade (grade, losal, hisal) VALUES (5, 3001, 9999);

-- Inserción de datos en la tabla de proyectos
INSERT INTO project (proj_id, proj_name, start_date, end_date) VALUES (101, 'Database Migration', DATE '2023-01-15', DATE '2023-06-30');
INSERT INTO project (proj_id, proj_name, start_date, end_date) VALUES (102, 'Website Redesign', DATE '2023-03-01', DATE '2023-09-15');
INSERT INTO project (proj_id, proj_name, start_date, end_date) VALUES (103, 'Mobile App Development', DATE '2023-05-01', DATE '2023-12-31');

-- Inserción de datos en la tabla de asignaciones de empleados a proyectos
INSERT INTO emp_project (empno, proj_id, hours_worked) VALUES (7839, 101, 120.5);
INSERT INTO emp_project (empno, proj_id, hours_worked) VALUES (7566, 101, 85.0);
INSERT INTO emp_project (empno, proj_id, hours_worked) VALUES (7698, 102, 100.0);
INSERT INTO emp_project (empno, proj_id, hours_worked) VALUES (7788, 103, 200.0);
INSERT INTO emp_project (empno, proj_id, hours_worked) VALUES (7902, 103, 195.5);
INSERT INTO emp_project (empno, proj_id, hours_worked) VALUES (7654, 102, 75.0);
INSERT INTO emp_project (empno, proj_id, hours_worked) VALUES (7499, 102, 50.0);

-- Inserción de datos en la tabla de clientes
INSERT INTO client (client_id, client_name, contact_email) VALUES (1, 'Acme Corp', 'contact@acme.com');
INSERT INTO client (client_id, client_name, contact_email) VALUES (2, 'Globex Inc', 'info@globex.com');
INSERT INTO client (client_id, client_name, contact_email) VALUES (3, 'Soylent Ltd', 'support@soylent.com');

-- Inserción de datos en la tabla de contratos
INSERT INTO contract (contract_id, client_id, proj_id, contract_date, amount) VALUES (1001, 1, 101, DATE '2023-01-10', 50000);
INSERT INTO contract (contract_id, client_id, proj_id, contract_date, amount) VALUES (1002, 2, 102, DATE '2023-03-05', 75000);
INSERT INTO contract (contract_id, client_id, proj_id, contract_date, amount) VALUES (1003, 3, 103, DATE '2023-05-20', 120000);

