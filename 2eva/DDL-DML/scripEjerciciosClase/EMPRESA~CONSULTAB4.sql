--1.	Visualice sobre el salario el máximo, el mínimo, la suma y la media aritmética, para todos los empleados. Redondee los resultados de tal manera que muestre números enteros (sin decimales).

SELECT 
    ROUND(MAX(E.SAL)) AS SALARIO_MAXIMO,
    ROUND(MIN(E.SAL)) AS SALARIO_MINIMO,
    ROUND(SUM(E.SAL)) AS SUMA_SALARIOS,
    ROUND(AVG(E.SAL)) AS MEDIA_SALARIOS
FROM EMP E;
--2.	Visualice el máximo, el mínimo, la suma y la media aritmética de los salarios por puesto de trabajo (JOB).

SELECT E.JOB, ROUND(MAX(E.SAL)) AS SALARIO_MAXIMO,ROUND(MIN(E.SAL)) AS SALARIO_MINIMO,ROUND(SUM(E.SAL)) AS SUMA_SALARIOS,ROUND(AVG(E.SAL)) AS MEDIA_SALARIOS
FROM EMP E
GROUP BY E.JOB;

--3.	Escriba una consulta que visualice el número de personas que tiene el mismo puesto de trabajo.

SELECT JOB AS PUESTO, COUNT(DISTINCT(ENAME)) AS NUMERO_PERSONAS
FROM EMP
GROUP BY JOB 
ORDER  BY JOB DESC;




--4.	Determine el número total de directores. Etiquete la columna con el nombre num_directores.

SELECT JOB AS PUESTO ,COUNT((JOB)) AS NUM_DIRECTORES
FROM EMP
WHERE JOB='MANAGER'
GROUP BY JOB;



--5.	Escriba una consulta que visualice la diferencia entre el salario más alto y el más bajo de la empresa. Etiquete la columna con el nombre diferencia.
SELECT MAX((SAL)) AS SALARIO_MAXIMO, MIN ((SAL)) AS SALARIO_MIN, (MAX(SAL)-MIN(SAL)) AS DIFEREMCIA_SALDOS 
FROM EMP
WHERE SAL IS NOT NULL;
--6.	Visualice el número de jefe y salario del empleado con menor salario con dependencia de ese jefe. Excluya a cualquier empleado cuyo jefe no se identifique. Excluya cualquier grupo cuyo mínimo salario sea menor que 1000. Clasifique el resultado en orden descendiente de salarios.
SELECT E.MGR AS ID_JEFE, MIN(E.SAL)
FROM EMP E
WHERE E.MGR IS NOT NULL 
GROUP BY E.MGR
HAVING MIN(E.SAL) > 1000
ORDER BY MIN(E.SAL)DESC;

--7.	Escriba una consulta que visualice el nombre del departamento, localidad, número de empleados y la media de salarios, para todos los empleados de cada departamento.

SELECT  D.DNAME AS DEPARTAMENTO,D.LOC AS LOCALIDAD,E.DEPTNO,ROUND(AVG((E.SAL))) AS MEDIA_SALARIAL
FROM EMP E 
INNER JOIN DEPT D ON E.DEPTNO=D.DEPTNO
GROUP BY D.DNAME,D.LOC,E.DEPTNO
ORDER BY AVG(E.SAL) DESC;

-- 8.	Cree una consulta que visualice el número total de empleados y de ese total, el número de los que fueron contratados en 1980, 1981, 1982 y 1983. Etiquete las columnas como Total, 1980, 1981, 1982 y 1983, tal como se muestra a continuación:

SELECT  
    COUNT(ENAME) AS total,
    SUM(DECODE(TO_CHAR(HIREDATE, 'YYYY'), '1980', 1, 0)) AS "1980",
    SUM(DECODE(TO_CHAR(HIREDATE, 'YYYY'), '1981', 1, 0)) AS "1981",
    SUM(DECODE(TO_CHAR(HIREDATE, 'YYYY'), '1982', 1, 0)) AS "1982",
    SUM(DECODE(TO_CHAR(HIREDATE, 'YYYY'), '1983', 1, 0)) AS "1983"
FROM EMP;

--9.	Cree una matriz que visualice el empleo (JOB), salario correspondiente según departamento y el salario total para ese empleo de todos los departamentos, según el modelo siguiente:
//if en el grupo job deptno es 10 suma el salario sino suma 0
SELECT 
    JOB,
    SUM(DECODE(DEPTNO, 10, SAL, 0)) AS "DEPT 10",
    SUM(DECODE(DEPTNO, 20, SAL, 0)) AS "DEPT 20",
    SUM(DECODE(DEPTNO, 30, SAL, 0)) AS "DEPT 30",
    SUM(SAL) AS TOTAL
FROM EMP
GROUP BY JOB
ORDER BY JOB;


