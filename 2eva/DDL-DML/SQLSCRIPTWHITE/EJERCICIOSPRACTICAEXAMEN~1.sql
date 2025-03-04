-- Ejercicios:
-- 1. Encuentra el nombre y salario de los empleados que trabajaron en proyectos cuyo contrato superó los 70,000.
-- 2. Muestra el nombre de los clientes y los proyectos que tienen contratados, junto con el total de horas trabajadas en esos proyectos.


















--1
SELECT E.EMPNO,E.SAL,C.AMOUNT
FROM EMP E
INNER JOIN emp_project EP ON e.empno=ep.empno
INNER JOIN CONTRACT C ON ep.proj_id=c.proj_id
WHERE c.amount>70000;

--2
SELECT C.CLIENT_NAME,P.PROJ_NAME,SUM(EP.HOURS_WORKED)AS HORAS_TRAJADAS
FROM CLIENT C
INNER JOIN contract CT ON c.client_id=ct.client_id
INNER JOIN PROJECT P ON p.proj_id=ct.proj_id
INNER JOIN emp_project EP ON p.proj_id=ep.proj_id
GROUP BY C.CLIENT_NAME,P.PROJ_NAME;



-- 3. Lista los nombres de los empleados que tienen el salario mayor al promedio de su departamento.
SELECT E.ENAME,E.SAL
FROM EMP E
WHERE E.SAL >(
SELECT AVG(E1.SAL) AS SALARIO_PROMEDIO
FROM EMP E1
WHERE e.deptno=e1.deptno);

-- 4. Calcula el total de ingresos generados por cada cliente considerando sus contratos.

SELECT SUM(CR.AMOUNT) AS INGRESOS_TOTALES,CT.CLIENT_NAME
FROM contract CR
INNER JOIN CLIENT CT ON cr.client_id=ct.client_id
GROUP BY ct.client_name;

-- 5. Encuentra el nombre de los empleados que no han trabajado en ningún proyecto.

SELECT E.ENAME
FROM EMP E
INNER JOIN emp_project EP ON e.empno=ep.empno
WHERE ep.proj_id IS NULL;

-- 6. Lista los empleados que trabajan en departamentos ubicados en 'NEW YORK' y que han trabajado en proyectos con fecha de fin en 2023.


SELECT E.ENAME,D.DNAME,P.END_DATE AS FECHA_FIN_PROYECTO
FROM EMP E
INNER JOIN DEPT D ON E.DEPTNO=d.deptno
INNER JOIN EMP_PROJECT EP ON e.empno=ep.empno
INNER JOIN PROJECT P ON ep.proj_id=p.proj_id
WHERE D.LOC='NEW YORK' AND P.END_DATE BETWEEN '01-01-2023' AND '31-12-2023';

-- 7. Usa una subconsulta para encontrar los departamentos con más de 3 empleados.PRACTICAR MAS


SELECT DISTINCT E.DEPTNO
FROM EMP E
WHERE E.DEPTNO IN (
SELECT E1.DEPTNO
FROM EMP E1
GROUP BY E1.DEPTNO
HAVING COUNT(E1.EMPNO)>3);

-- 8. Encuentra el nombre de los empleados que tienen un salario dentro del rango de su grado salarial.
SELECT E.ENAME,E.SAL
FROM EMP E
INNER JOIN SALGRADE S ON E.SAL BETWEEN S.LOSAL AND s.hisal;


-- 9. Obtén el nombre del cliente que contrató el proyecto con mayor monto registrado.

SELECT CT.CLIENT_NAME,CR.AMOUNT
FROM CLIENT CT
INNER JOIN CONTRACT CR ON ct.client_id=cr.client_id
WHERE CR.AMOUNT=(
SELECT MAX(CR1.AMOUNT)
FROM CONTRACT CR1);


-- 10. Calcula el número total de proyectos en los que participó cada empleado.--PROBLEMAS

SELECT E.ENAME,COUNT(EP.PROJ_ID) AS NUMERO_PROYECTOS
FROM EMP E
INNER JOIN emp_project EP ON e.empno=ep.empno
GROUP BY E.ENAME;



-- 11. Encuentra el empleado con el menor salario en cada departamento.


SELECT e.deptno, e.ename, e.sal
FROM emp e
WHERE e.sal = (
    SELECT MIN(e2.sal)
    FROM emp e2
    WHERE e2.deptno = e.deptno
);



-- 12. Muestra el promedio de horas trabajadas por proyecto.

SELECT P.PROJ_NAME,AVG(EP.HOURS_WORKED)AS MEDIA_HORAS
FROM PROJECT P
INNER JOIN EMP_PROJECT EP ON p.proj_id=ep.proj_id
GROUP BY P.PROJ_NAME;

-- 13. Encuentra el proyecto que terminó más recientemente y los empleados que trabajaron en él.

SELECT P.PROJ_NAME,P.END_DATE,E.ENAME
FROM PROJECT P
INNER JOIN EMP_PROJECT EP ON p.proj_id=ep.proj_id
INNER JOIN EMP E ON ep.empno=e.empno
WHERE p.end_date=(
SELECT MAX(P1.END_DATE)
FROM PROJECT P1);

-- 14. Lista los empleados que reportan directamente al presidente (KING).
SELECT E.ENAME,E.MGR
FROM EMP E
WHERE E.MGR=(
SELECT E1.EMPNO
FROM EMP E1
WHERE E1.ENAME='KING');

-- 15. Obtén el salario anual de cada empleado, sumando su comisión si corresponde.
/*AGRUPAR POR CADA EMPLEADO*/
SELECT E.ENAME,(E.SAL*12)+ DECODE(E.COMM, NULL,0,E.COMM)AS SALARIO_ANUAL_COMISION
FROM EMP E;


-- 16. Calcula el monto total de los contratos firmados en 2023.

SELECT SUM(CT.AMOUNT)AS TOTAL_MONTO
FROM CONTRACT CT
WHERE CT.contract_date BETWEEN '01-01-2023' AND '31-12-2023';

-- 17. Encuentra el empleado más antiguo en cada departamento.

SELECT E.ENAME,E.DEPTNO,E.HIREDATE
FROM EMP E
WHERE E.HIREDATE=(
SELECT MIN(E1.HIREDATE)
FROM EMP E1
WHERE E1.DEPTNO=E.DEPTNO);

--18: Lista los clientes que no tienen ningún contrato firmado.
SELECT CL.CLIENT_NAME,CR.CONTRACT_ID
FROM CLIENT CL
INNER JOIN CONTRACT CR ON cl.client_id=cr.client_id
WHERE cr.contract_id IS NULL;



-- 19. Encuentra los proyectos que tienen al menos tres empleados asignados.

SELECT P.PROJ_NAME,COUNT(EP.EMPNO)
FROM PROJECT P
INNER JOIN EMP_PROJECT EP ON p.proj_id=Ep.proj_id
GROUP BY p.proj_name
HAVING COUNT(EP.EMPNO)=3;


SELECT p.proj_name
FROM project p
JOIN emp_project ep ON p.proj_id = ep.proj_id
GROUP BY p.proj_name
HAVING COUNT(ep.empno) >= 3;

-- 20. Muestra los nombres de los empleados y su cargo para 
--aquellos que trabajaron en proyectos en los últimos tres meses.

SELECT E.ENAME,E.JOB,EP.EMPNO
FROM EMP E
INNER JOIN EMP_PROJECT EP ON e.empno=ep.empno
INNER JOIN PROJECT P ON ep.proj_id=p.proj_id
WHERE MONTHS_BETWEEN(sysdate, p.end_date) <= 3;

-------------------------------------------------------------------------------------------------------------

--Ejercicio 1: Realizar nuestro primer bloque PL/SQL, que visualiza día, mes y año actual, donde el mes será con nombre.
--Este ejercicio utiliza las funciones de fecha de Oracle para obtener la fecha actual y formatearla.


DECLARE
  v_fecha DATE := SYSDATE;  -- Obtiene la fecha actual
  v_dia NUMBER;
  v_mes VARCHAR2(20);
  v_anio NUMBER;
BEGIN
  v_dia := TO_NUMBER(TO_CHAR(v_fecha, 'DD'));  -- Extrae el día
  v_mes := TO_CHAR(v_fecha, 'FMMonth');        -- Extrae el mes con nombre completo
  v_anio := TO_NUMBER(TO_CHAR(v_fecha, 'YYYY'));  -- Extrae el año
  
  dbms_output.put_line('Día: ' || v_dia);  -- Muestra el día
  dbms_output.put_line('Mes: ' || v_mes);  -- Muestra el mes
  dbms_output.put_line('Año: ' || v_anio);  -- Muestra el año
END;
/
--Ejercicio 2: Crear un bloque de PL/SQL que permite visualizar el salario de KING, utilizando las tablas de empleados.
--Este ejercicio asume que hay una tabla llamada empleados con las columnas nombre y salario. Se busca el salario de un empleado llamado "KING".


DECLARE
  v_salario empleados.salario%TYPE;  -- Declara una variable para almacenar el salario
BEGIN
  SELECT salario INTO v_salario  -- Selecciona el salario de KING
  FROM empleados
  WHERE nombre = 'KING';

  dbms_output.put_line('El salario de KING es: ' || v_salario);  -- Muestra el salario
END;
/
--Ejercicio 3: Crear un bloque de PL/SQL que permite visualizar el salario que desea el usuario, utilizando las tablas de empleados.
--Este bloque permitirá al usuario ingresar el nombre de un empleado para obtener su salario.


DECLARE
  v_nombre empleados.nombre%TYPE;  -- Variable para el nombre del empleado
  v_salario empleados.salario%TYPE;  -- Variable para el salario
BEGIN
  -- Solicita al usuario que ingrese el nombre del empleado
  v_nombre := 'KING';  -- Este valor puede ser modificado por el usuario si se utiliza un entorno interactivo
  
  -- Consulta el salario del empleado ingresado
  SELECT salario INTO v_salario
  FROM empleados
  WHERE nombre = v_nombre;
  
  -- Muestra el salario del empleado
  dbms_output.put_line('El salario de ' || v_nombre || ' es: ' || v_salario);
END;
/
--Ejercicio 4: Realizar un bloque PL/SQL que reciba una cadena y la escriba al revés.
--Este bloque invierte una cadena de texto proporcionada.


DECLARE
  v_cadena VARCHAR2(100) := 'Hola Mundo';  -- Cadena de texto que se invertirá
  v_cadena_invertida VARCHAR2(100);  -- Variable para almacenar la cadena invertida
BEGIN
  -- Invertir la cadena utilizando la función REVERSE
  v_cadena_invertida := REVERSE(v_cadena);
  
  -- Mostrar la cadena invertida
  dbms_output.put_line('Cadena original: ' || v_cadena);
  dbms_output.put_line('Cadena invertida: ' || v_cadena_invertida);
END;
/
/*Resumen de las soluciones:
Ejercicio 1: Utiliza SYSDATE para obtener la fecha actual y la función TO_CHAR para formatearla, mostrando día, mes (con nombre) y año.
Ejercicio 2: Realiza una consulta SELECT para obtener el salario de un empleado específico (KING) de la tabla empleados.
Ejercicio 3: Permite consultar el salario de un empleado cuyo nombre es proporcionado (en este caso se usa 'KING' como ejemplo).
Ejercicio 4: Involucra el uso de la función REVERSE para invertir una cadena de texto.
*/
