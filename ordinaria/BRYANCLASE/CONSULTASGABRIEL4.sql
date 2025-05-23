----------------------------------------------------------------------------------------------- CONSULTAS EJERCICIO 4 ---------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- EJERCICIO 4.1.1 -- | -- SELECT ROUND(MAX(SAL)) AS Sal_Max, ROUND(MIN(SAL)) AS Sal_Min, ROUND(SUM(SAL)) AS Suma_Sal, ROUND(AVG(SAL)) AS Media_Arit FROM EMP;
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- EJERCICIO 4.1.2 -- | -- SELECT JOB, ROUND(MAX(SAL)) AS Sal_Max, ROUND(MIN(SAL)) AS Sal_Min, ROUND(SUM(SAL)) AS Suma_Sal, ROUND(AVG(SAL)) AS Med_Arit FROM EMP GROUP BY JOB ORDER BY JOB;
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- EJERCICIO 4.1.3 -- | -- SELECT JOB, COUNT(*) AS Num_Pers FROM EMP GROUP BY JOB ORDER BY Num_Pers DESC;
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- EJERCICIO 4.1.4 -- | -- SELECT COUNT(*) AS num_direc FROM EMP WHERE JOB = 'MANAGER';
-- EJERCICIO 4.1.4 V2 | -- SELECT COUNT(DISTINCT MGR) NUM_DIRECTORES FROM EMP;
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- EJERCICIO 4.1.5 -- | -- SELECT (MAX(SAL) - MIN(SAL)) AS diferencia FROM EMP;
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- EJERCICIO 4.1.6 -B | -- SELECT MGR AS Num_Jefe, MIN(SAL) AS Sal_Min FROM EMP WHERE MGR IS NOT NULL GROUP BY MGR HAVING MIN(SAL) >= 1000 ORDER BY Sal_Min DESC;
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- EJERCICIO 4.1.7 CR | -- SELECT D.DNAME, D.LOC, COUNT(E.ENAME) AS NUM_EMP, ROUND(AVG(E.SAL), 0) AS SAL_MED FROM DEPT D LEFT JOIN  EMP E ON D.DEPTNO = E.DEPTNO GROUP BY D.DNAME, D.LOC;
-- EJERCICIO 4.1.7 SR | -- SELECT D.DNAME, D.LOC, COUNT(E.ENAME) AS NUM_EMP, AVG(E.SAL) AS SAL_MED FROM DEPT D LEFT JOIN  EMP E ON D.DEPTNO = E.DEPTNO GROUP BY D.DNAME, D.LOC;
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- EJERCICIO 4.2.8 -- | -- SELECT COUNT(*) AS TOTAL, SUM(DECODE(TO_CHAR(HIREDATE, 'YYYY'),1980,1,0)) AS "1980", SUM(DECODE(TO_CHAR(HIREDATE, 'YYYY'),1981,1,0)) AS "1981", SUM(DECODE(TO_CHAR(HIREDATE, 'YYYY'),1982,1,0)) AS "1982", SUM(DECODE(TO_CHAR(HIREDATE, 'YYYY'),1983,1,0)) AS "1983" FROM EMP;
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- EJERCICIO 4.2.9 (MAL) | -- SELECT JOB AS "JOB", NVL(TO_CHAR(SUM(DECODE(DEPTNO, 10, SAL, 0)) AS "DEPT 10", NVL(TO_CHAR(SUM(DECODE(DEPTNO, 20, SAL, 0)) AS "DEPT 20", NVL(TO_CHAR(SUM(DECODE(DEPTNO, 30, SAL, 0)) AS "DEPT 30", SUM(SAL) AS "TOTAL" FROM EMP GROUP BY JOB ORDER BY JOB ASC;
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

9.Visualice el empleo (JOB), salario correspondiente según departamento y el salario total para ese empleo de todos los departamentos.
SELECT JOB AS "JOB",
    SUM(DECODE(DEPTNO, 10, SAL, 0)) AS "DEPT 10",
    SUM(DECODE(DEPTNO, 20, SAL, 0)) AS "DEPT 20",
    SUM(DECODE(DEPTNO, 30, SAL, 0)) AS "DEPT 30",
    SUM(SAL) AS "TOTAL"FROM EMP GROUP BY JOB ORDER BY JOB ASC;
SELECT JOB AS "JOB",
    NVL(TO_CHAR(SUM(DECODE(DEPTNO, 10, SAL, NULL))),' ') AS "DEPT 10",
    NVL(TO_CHAR(SUM(DECODE(DEPTNO, 20, SAL, NULL))),' ') AS "DEPT 20",
    NVL(TO_CHAR(SUM(DECODE(DEPTNO, 30, SAL, NULL))),' ') AS "DEPT 30",
    SUM(SAL) AS "TOTAL"
    FROM EMP GROUP BY JOB ORDER BY JOB ASC;

-- CR = CON REDONDEO 
-- SR = SIN REDONDEO

------------------------------------------------------------------------------------------ GABRIEL RODRIGUEZ DAW 1 ------------------------------------------------------------------------------------------------------------------------------------