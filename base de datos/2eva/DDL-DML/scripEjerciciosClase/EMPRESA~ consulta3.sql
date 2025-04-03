-- 1. Visualizar el nombre, número de departamento y nombre de departamento de todos los empleados.
SELECT e.ENAME, e.DEPTNO, d.DNAME
FROM EMP e
JOIN DEPT d ON e.DEPTNO = d.DEPTNO;

-- 2. Crear un listado único de todos los puestos de trabajo (JOB) que hay en el departamento 30. Incluye la localidad del departamento 30 en el resultado.
SELECT DISTINCT e.JOB, d.LOCATION
FROM EMP e
JOIN DEPT d ON e.DEPTNO = d.DEPTNO
WHERE e.DEPTNO = 30;

-- 3. Visualizar el nombre del empleado, nombre del departamento y localidad de todos los empleados que ganan comisión.
SELECT e.ENAME, d.DNAME, d.LOCATION
FROM EMP e
JOIN DEPT d ON e.DEPTNO = d.DEPTNO
WHERE e.COMM IS NOT NULL;

-- 4. Visualizar el nombre del empleado y nombre del departamento de todos los empleados que tienen una "A" en su nombre.
SELECT e.ENAME, d.DNAME
FROM EMP e
JOIN DEPT d ON e.DEPTNO = d.DEPTNO
WHERE e.ENAME LIKE '%A%';

-- 5. Visualizar el nombre, puesto de trabajo, número del departamento y nombre del departamento de todos los empleados que trabajan en DALLAS.
SELECT e.ENAME, e.JOB, e.DEPTNO, d.DNAME
FROM EMP e
JOIN DEPT d ON e.DEPTNO = d.DEPTNO
WHERE d.LOCATION = 'DALLAS';

-- 6. Visualizar el nombre del empleado y el número de empleado junto con el nombre de su jefe y número de jefe. Etiquetar las columnas con Empleado, Num_empleado, Jefe, Num_jefe respectivamente.
SELECT e.ENAME AS Empleado, e.EMPLOYEE_ID AS Num_empleado, m.ENAME AS Jefe, m.EMPLOYEE_ID AS Num_jefe
FROM EMP e
LEFT JOIN EMP m ON e.MGR = m.EMPLOYEE_ID;

-- 7. Modificar la consulta anterior para visualizar todos los empleados incluyendo a KING, que no tiene jefe.
SELECT e.ENAME AS Empleado, e.EMPLOYEE_ID AS Num_empleado, m.ENAME AS Jefe, m.EMPLOYEE_ID AS Num_jefe
FROM EMP e
LEFT JOIN EMP m ON e.MGR = m.EMPLOYEE_ID
WHERE e.ENAME = 'KING' OR e.MGR IS NOT NULL;

-- 8. Crear una consulta que visualice el nombre del empleado, número de departamento y nombre de los empleados que trabajan en el mismo departamento que un empleado dado.
SELECT e.ENAME, e.DEPTNO, d.DNAME
FROM EMP e
JOIN DEPT d ON e.DEPTNO = d.DEPTNO
WHERE e.DEPTNO = (SELECT DEPTNO FROM EMP WHERE ENAME = 'BLAKE');

-- 9. Mostrar la estructura de la tabla SALGRADE. Crear una consulta que visualice el nombre, puesto de trabajo, nombre de departamento, salario y grado de todos los empleados.
DESCRIBE SALGRADE;

SELECT e.ENAME, e.JOB, d.DNAME, e.SAL, s.GRADE
FROM EMP e
JOIN DEPT d ON e.DEPTNO = d.DEPTNO
JOIN SALGRADE s ON e.SAL BETWEEN s.LOSAL AND s.HISAL;

-- 10. Crear una consulta para visualizar el nombre y fecha de contratación de cualquier empleado contratado después de BLAKE.
SELECT e.ENAME, e.HIREDATE
FROM EMP e
WHERE e.HIREDATE > (SELECT HIREDATE FROM EMP WHERE ENAME = 'BLAKE');

-- 11. Visualizar todos los nombres de los empleados y fechas de contratación junto con los nombres de sus jefes y fecha de contratación de todos los empleados que fueron contratados antes que sus jefes.
SELECT e.ENAME AS Empleado, e.HIREDATE AS Fecha_Empleado, m.ENAME AS Jefe, m.HIREDATE AS Fecha_Jefe
FROM EMP e
JOIN EMP m ON e.MGR = m.EMPLOYEE_ID
WHERE e.HIREDATE < m.HIREDATE;
