--1
--1.Escribir una consulta para visualizar el nombre, número de departamento y nombre de departamento de todos los empleados
SELECT E.ENAME,E.DEPTNO,D.DNAME
FROM EMP E
LEFT JOIN DEPT D ON E.DEPTNO=D.DEPTNO;
--2.	Crear un listado único de todos los puestos de trabajo (JOB) que hay en el departamento 30. Incluya la localidad del departamento 30 en el resultado.
SELECT DISTINCT E.JOB, D.DEPTNO, D.LOC
FROM EMP E
INNER JOIN DEPT D ON E.DEPTNO = D.DEPTNO
WHERE D.DEPTNO = 30;

-- 3.	Escribir una consulta para visualizar el nombre del empleado, nombre del departamento y localidad de todos los empleados que ganan comisión.
SELECT E.ENAME,D.DNAME,D.LOC,E.COMM
FROM EMP E
INNER JOIN DEPT D ON E.DEPTNO=D.DEPTNO
WHERE E.COMM IS NOT NULL;
--4.	Visualizar el nombre del empleado y nombre del departamento de todos los empleados que tienen una A en su nombre.
SELECT E.ENAME,D.DNAME
FROM EMP E
INNER JOIN DEPT D ON E.DEPTNO=D.DEPTNO
WHERE e.ENAME LIKE '%A%';
--5.	Escribir una consulta para visualizar el nombre, puesto de trabajo, número del departamento y nombre del departamento de todos los empleados que trabajan en DALLAS.
SELECT E.ENAME,E.JOB,D.DEPTNO,D.DNAME
FROM EMP E
INNER JOIN DEPT D ON E.DEPTNO=D.DEPTNO
WHERE D.LOC='DALLAS';

--6 Visualizar el nombre del empleado y el número de empleado junto con el nombre de su jefe y número de jefe. Etiquetar las columnas con Empleado, Num_empleado, Jefe, Num_jefe respectivamente.
SELECT E.ENAME AS EMPLEADO,E.EMPNO AS "NUM EMPLEADO",m.ENAME AS Jefe, m.EMPNO AS Num_jefe
FROM EMP E
INNER JOIN EMP M ON E.MGR=M.EMPNO;

--7.	Modificar la consulta anterior para visualizar todos los empleados incluyendo a KING, que no tiene jefe.
SELECT E.ENAME AS EMPLEADO,E.EMPNO AS "NUM EMPLEADO",m.ENAME AS Jefe, m.EMPNO AS Num_jefe
FROM EMP E
LEFT JOIN EMP M ON E.MGR=M.EMPNO
WHERE e.ENAME = 'KING' OR e.MGR IS NOT NULL;


--8.	Crear una consulta que visualice el nombre del empleado, número de departamento y nombre de los empleados que trabajan en el mismo departamento que un empleado dado.

SELECT E.ENAME,D.DEPTNO,D.DNAME
FROM EMP E
INNER JOIN DEPT D  ON E.DEPTNO=D.DEPTNO
WHERE D.DEPTNO=(SELECT E.DEPTNO FROM EMP E WHERE E.ENAME='BLAKE');

--9.	Mostrar la estructura de la tabla SALGRADE. Crear una consulta que visualice el nombre, puesto de trabajo, nombre de departamento, salario y grado de todos los empleados.
DESCRIBE SALGRADE;
SELECT E.ENAME,E.JOB,D.DNAME,E.SAL,S.GRADE
FROM EMP E
INNER JOIN DEPT D ON E.DEPTNO=D.DEPTNO
INNER JOIN SALGRADE S ON E.SAL BETWEEN S.LOSAL AND S.HISAL;

--10.	Crear una consulta para visualizar el nombre y fecha de contratación de cualquier empleado contratado después de BLAKE.
SELECT E.ENAME,E.HIREDATE
FROM EMP E
WHERE E.HIREDATE >(SELECT HIREDATE FROM EMP WHERE ENAME='BLAKE');
//WHERE E.HIREDATE>TO_DATE('01-05-1981','DD-MM-YYYY');
--1.	Visualizar todos los nombres de los empleados y fechas de contratación junto con los nombres de sus jefes y fecha de contratación de todos los empleados que fueron contratados antes que sus jefes.
SELECT E.ENAME, E.HIREDATE,M.ENAME AS JEFE
FROM EMP E
INNER JOIN EMP M ON E.MGR=M.EMPNO
WHERE E.HIREDATE<M.HIREDATE;



