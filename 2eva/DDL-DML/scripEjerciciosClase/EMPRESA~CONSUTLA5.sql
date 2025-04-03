--1 Escribir una consulta que visualice el nombre y fecha de alta de todos los empleados que 
--trabajan en el mismo departamento que Blake. Excluir a Blake. 

SELECT ENAME 
FROM EMP;

SELECT ENAME,HIREDATE,DEPTNO
FROM EMP 
WHERE DEPTNO=(
SELECT E.DEPTNO
FROM EMP E
WHERE E.ENAME='BLAKE'  ) AND ENAME<>'BLAKE';


---2. Cree una subconsulta que visualice el número y nombre de todos los empleados que ganan 
--más que la media de salarios. Clasifique el resultado en orden descendiente de salarios. 

SELECT EMPNO,ENAME,SAL
FROM EMP
WHERE SAL>(
SELECT AVG(SAL)
FROM EMP)
ORDER BY SAL DESC;



--3Escriba una consulta que visualice el número y nombre de todos los empleados que trabajan 
--en un departamento con algún empleado cuyo nombre contenga una “T”. 

SELECT EMPNO,ENAME,DEPTNO
FROM EMP
WHERE DEPTNO IN
(SELECT DISTINCT DEPTNO 
FROM EMP
WHERE ENAME LIKE '%T%');

--4 Visualice el nombre, número de departamento y puesto de trabajo de todos los
--empleados cuyo departamento se encuentre en Dallas. 

SELECT E.ENAME,D.DEPTNO,JOB
FROM EMP E
INNER JOIN DEPT D ON E.DEPTNO=D.DEPTNO
WHERE D.DEPTNO=(
SELECT D.DEPTNO FROM DEPT D WHERE D.LOC='DALLAS');


/*5 Visualice el nombre y salario de todos los empleados que dependan de King. */

SELECT E.ENAME,E.SAL
FROM EMP E
WHERE E.MGR=(
SELECT E.EMPNO FROM EMP E WHERE E.ENAME='KING');

/*6--
Visualice el número, nombre y puesto de trabajo de todos los empleados del departamento 
“Sales” 
*/

SELECT D.DEPTNO,D.DNAME,E.JOB
FROM DEPT D
INNER JOIN EMP E ON D.DEPTNO=E.DEPTNO
WHERE D.DEPTNO =(
SELECT DEPTNO FROM DEPT WHERE DNAME='SALES');

/*7
Visualice el número, nombre y salario de todos los empleados que ganen más 
que la media de  salarios y que trabajen en un departamento en el que algún 
empleado contenga una T en su nombre. 

*/
SELECT E.EMPNO,E.ENAME,E.SAL,AVG(E.SAL) AS SALARIO_MEDIA
FROM EMP E
WHERE E.DEPTNO=(
SELECT E.DEPTNO 
FROM EMP E
WHERE  E.ENAME LIKE '%T%')AND E.SAL> AVG(E.SAL);


/*8
. Escriba una consulta para visualizar el nombre, número de departamento y salario de 
cualquier empleado, cuyo nº de departamento y salario se correspondan (ambos) con el nº de 
departamento y salario de cualquier empleado que tenga comisión. 

*/

SELECT E.ENAME,E.SAL,E.DEPTNO
FROM EMP E 
WHERE (E.DEPTNO,E.SAL)IN(
SELECT E1.DEPTNO,E1.SAL FROM EMP E1 WHERE E1.COMM IS NOT NULL);

/*
9. Visualice el nombre, número de departamento y salario de 
cualquier empleado cuyo salario y  comisión coincidan (los dos) 
con el salario y comisión de cualquier empleado de Dallas. 
*/


SELECT E.ENAME, E.DEPTNO, E.SAL 
FROM EMP E
WHERE (E.SAL, E.COMM) IN (
    SELECT E1.SAL, E1.COMM
    FROM EMP E1
    INNER JOIN DEPT D ON E1.DEPTNO = D.DEPTNO
    WHERE D.DNAME = 'DALLAS'
)
OR (E.SAL IS  NULL AND E.COMM IS NULL);






/*
10. Cree una consulta para visualizar el nombre, fecha 
de alta y salario de todos los empleados 
que tengan el mismo salario y comisión que Scott. 

*/
SELECT E.ENAME, E.HIREDATE, E.SAL
FROM EMP E
WHERE (E.SAL, E.COMM) = (
    SELECT E1.SAL, E1.COMM
    FROM EMP E1
    WHERE E1.ENAME = 'SCOTT'
);

SELECT E.ENAME, E.HIREDATE, E.SAL,E.COMM
FROM EMP E
WHERE (E.SAL = (SELECT E1.SAL FROM EMP E1 WHERE E1.ENAME = 'SCOTT') 
    OR (E.SAL IS NULL AND (SELECT E1.SAL FROM EMP E1 WHERE E1.ENAME = 'SCOTT') IS NULL))
  AND
    (E.COMM = (SELECT E1.COMM FROM EMP E1 WHERE E1.ENAME = 'SCOTT') 
    OR (E.COMM IS NULL AND (SELECT E1.COMM FROM EMP E1 WHERE E1.ENAME = 'SCOTT') IS NULL));

/*
11. Cree una consulta para visualizar a los empleados que ganan
un salario superior al salario de cualquier empleado con oficio 
CLERK. Ordene el resultado por salario descendentemente.
*/

SELECT E.ENAME,E.SAL
FROM EMP E
WHERE E.SAL >ALL (
SELECT E1.SAL FROM EMP E1 WHERE JOB='CLERK')
ORDER BY E.SAL DESC;

SELECT E.ENAME,E.SAL
FROM EMP E
WHERE E.SAL > (
SELECT MAX(E1.SAL) FROM EMP E1 WHERE JOB='CLERK')
ORDER BY E.SAL DESC;