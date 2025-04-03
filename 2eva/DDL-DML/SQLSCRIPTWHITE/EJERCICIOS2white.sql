/*Encuentra los nombres de los empleados
que tienen un salario superior al salario promedio
de los empleados de su mismo cargo.*/

SELECT E.ENAME,E.SAL
FROM EMP E
WHERE E.SAL>(
SELECT AVG(E1.SAL)
FROM EMP E1
WHERE E1.JOB=E.JOB);

/*Lista los proyectos que comenzaron después de que se 
contrató al empleado más antiguo.*/

SELECT P.PROJ_NAME
FROM PROJECT P
WHERE P.START_DATE>(
SELECT MIN(E.HIREDATE)
FROM EMP E);

/*Calcula el ingreso total generado por proyectos de cada 
cliente y ordénalos de mayor a menor.*/

SELECT SUM(CR.AMOUNT) AS TOTAL_INGRESOS, P.PROJ_NAME,CL.CLIENT_NAME
FROM CONTRACT CR
INNER JOIN CLIENT CL ON cr.client_id=cl.client_id
INNER JOIN PROJECT P ON cr.proj_id=p.proj_id
GROUP BY P.PROJ_NAME,CL.CLIENT_NAME
ORDER BY TOTAL_INGRESOS DESC;

/*Encuentra los nombres de los empleados 
y el proyecto en el que trabajaron más horas.*/




SELECT e.ename, p.proj_name, ep.hours_worked
FROM emp_project ep
JOIN emp e ON ep.empno = e.empno
JOIN project p ON ep.proj_id = p.proj_id
WHERE ep.hours_worked = (
    SELECT MAX(hours_worked) 
    FROM emp_project 
    WHERE empno = e.empno
);
/*Lista los departamentos que no 
tienen ningún empleado asignado.*/
SELECT D.DNAME,E.EMPNO
FROM DEPT D
LEFT JOIN EMP E ON E.DEPTNO=D.DEPTNO
WHERE E.EMPNO IS NULL;
/*Calcula el total de comisiones ganadas por
empleados que trabajan en proyectos terminados en 2023.*/




SELECT SUM(e.comm) AS total_commission
FROM emp e
JOIN emp_project ep ON e.empno = ep.empno
JOIN project p ON ep.proj_id = p.proj_id
WHERE p.end_date BETWEEN DATE '2023-01-01' AND DATE '2023-12-31';

