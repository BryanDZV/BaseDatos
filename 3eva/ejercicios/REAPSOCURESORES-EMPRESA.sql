/*1-Enunciado: Escribe un bloque PL/SQL que muestre el nombre (ename) y la fecha de alta (hiredate) de los empleados, ordenados por la fecha de alta.*/
DECLARE
CURSOR C_ALTA IS
SELECT ENAME,HIREDATE
FROM EMP
ORDER BY HIREDATE;
V_AUX C_ALTA%ROWTYPE;
BEGIN
OPEN C_ALTA;
FETCH C_ALTA INTO V_AUX;
WHILE C_ALTA %FOUND LOOP
DBMS_OUTPUT.PUT_LINE('EMPLEADOS--->'|| V_AUX.ENAME);
FETCH C_ALTA INTO V_AUX;
END LOOP;
CLOSE C_ALTA;
END;

/*-2 Escribe un bloque PL/SQL que muestre el nombre (ename) y la fecha de alta (hiredate) de los empleados, ordenados por la fecha de alta, utilizando un cursor y un bucle WHIL*/

DECLARE 
CURSOR C_EMPLEADOS  IS
SELECT * 
FROM EMP 
ORDER BY HIREDATE DESC;
V_AUX C_EMPLEADOS%ROWTYPE;
BEGIN
OPEN C_EMPLEADOS;
FETCH C_EMPLEADOS INTO V_AUX;
WHILE C_EMPLEADOS %FOUND LOOP
        DBMS_OUTPUT.PUT_LINE('EMPLEADO: ' || V_AUX.ENAME || ' - Fecha de contratación: ' || V_AUX.HIREDATE );
FETCH C_EMPLEADOS INTO V_AUX;
END LOOP;
CLOSE C_EMPLEADOS;
END;
/
/*3 Escribe un bloque PL/SQL que modifique el salario de los empleados que tengan un salario menor a 1500, utilizando un cursor con la cláusula FOR UPDATE.
*/
DECLARE
CURSOR C_MODIFICAR IS
SELECT *
FROM EMP
WHERE SAL>1500
FOR UPDATE;
V_AUX C_MODIFICAR%ROWTYPE;
BEGIN
OPEN C_MODIFICAR;
FETCH C_MODIFICAR INTO V_AUX;
WHILE C_MODIFICAR %FOUND LOOP
UPDATE EMP
SET SAL=SAL+500
WHERE CURRENT OF C_MODIFICAR;
DBMS_OUTPUT.PUT_LINE('SALARIOS MODIFICADOS CORRECTAMENTE');

FETCH C_MODIFICAR INTO V_AUX;

END LOOP;
CLOSE C_MODIFICAR;
END;

/*4 Escribe un bloque PL/SQL que muestre el número de empleados (count(*))
por cada departamento, utilizando un cursor.*/
/
DECLARE
    CURSOR C_NUMEROEMPLE IS 
    SELECT D.DEPTNO, D.DNAME, COUNT(E.EMPNO) AS EMPLEADOS
    FROM DEPT D
    LEFT JOIN EMP E ON D.DEPTNO = E.DEPTNO  
    GROUP BY D.DEPTNO, D.DNAME;  

    V_AUX C_NUMEROEMPLE%ROWTYPE;
BEGIN
    OPEN C_NUMEROEMPLE;
    FETCH C_NUMEROEMPLE INTO V_AUX;
    
    WHILE C_NUMEROEMPLE %FOUND LOOP
        DBMS_OUTPUT.PUT_LINE('DEPARTAMENTO: ' || V_AUX.DEPTNO || ' (' || V_AUX.DNAME || ') - NÚMERO DE EMPLEADOS: ' || V_AUX.EMPLEADOS);
        FETCH C_NUMEROEMPLE INTO V_AUX;
    END LOOP;

    CLOSE C_NUMEROEMPLE;
END;
/

/*5  Escribe un bloque PL/SQL que actualice el salario de los empleados con salario nulo a 1000, utilizando la cláusula WHERE CURRENT OF.*/

DECLARE
CURSOR C_ACTUALIZACION_SAL IS
SELECT *
FROM EMP
WHERE SAL =800
FOR UPDATE;
V_AUX C_ACTUALIZACION_SAL%ROWTYPE;
BEGIN
OPEN C_ACTUALIZACION_SAL;
FETCH C_ACTUALIZACION_SAL INTO V_AUX;
WHILE C_ACTUALIZACION_SAL %FOUND LOOP
UPDATE EMP
SET SAL=SAL+1000
WHERE CURRENT OF C_ACTUALIZACION_SAL;
DBMS_OUTPUT.PUT_LINE('SALARIOS ACTUALIZADOS CORRECTAMENTE A 1000');
FETCH C_ACTUALIZACION_SAL INTO V_AUX;
END LOOP;
CLOSE C_ACTUALIZACION_SAL;
END;
/

/*6 Escribe un bloque PL/SQL que reciba un parámetro cadena y muestre los empleados cuyo nombre (ename) 
contenga esa cadena.
*/
DECLARE
P_CADENA VARCHAR2(70):='M';
CURSOR C_EMPLE_CADENA IS
SELECT *
FROM EMP
WHERE ENAME LIKE '%'||P_CADENA||'%';
V_AUX C_EMPLE_CADENA%ROWTYPE;
BEGIN
OPEN C_EMPLE_CADENA;
FETCH C_EMPLE_CADENA INTO V_AUX;
WHILE C_EMPLE_CADENA %FOUND LOOP
DBMS_OUTPUT.PUT_LINE('EMPLEADOS: '||V_AUX.ENAME);
FETCH C_EMPLE_CADENA INTO V_AUX;
END LOOP;
CLOSE  C_EMPLE_CADENA;
END;
/

/*7 Escribe un bloque PL/SQL que actualice el salario de todos los empleados dedepartamento 20 en un 
10%, y luego muestre el número de filas afectadas utilizando el cursor implícito SQL%ROWCOUNT.*/
DECLARE
P_DEPTNO NUMBER:=20;
CURSOR C_ACTUA_SAL IS
SELECT *
FROM EMP
WHERE DEPTNO=P_DEPTNO
FOR UPDATE;
V_AUX C_ACTUA_SAL%ROWTYPE;
V_CNT NUMBER:=0;
BEGIN
OPEN C_ACTUA_SAL;
FETCH C_ACTUA_SAL INTO V_AUX;
WHILE C_ACTUA_SAL %FOUND LOOP
UPDATE EMP
   SET SAL = SAL * 1.10
WHERE CURRENT OF C_ACTUA_SAL;
V_CNT:=V_CNT+1;
FETCH C_ACTUA_SAL INTO V_AUX;
END LOOP;
CLOSE C_ACTUA_SAL;
-- 🔹 Mensaje de salida con la cantidad de empleados actualizados
    DBMS_OUTPUT.PUT_LINE('Número de empleados actualizados: ' || V_CNT);
END;
/

DECLARE
BEGIN
UPDATE EMP
SET SAL=SAL*1.1
WHERE DEPTNO=20;
 DBMS_OUTPUT.PUT_LINE('Número de filas afectadas: ' || SQL%ROWCOUNT);
END;
/
/*8 Escribe un bloque PL/SQL que calcule el salario promedio de todos los empleados utilizando un cursor.*/
DECLARE
    CURSOR C_PROMEDIO IS 
        SELECT AVG(SAL) AS SAL_PROMEDIO FROM EMP;
    
    V_AUX EMP.SAL%TYPE;
BEGIN
    OPEN C_PROMEDIO;
    FETCH C_PROMEDIO INTO V_AUX;  -- 🔹 Solo un FETCH es suficiente
    CLOSE C_PROMEDIO;

    -- 🔹 Mostrar el promedio de salarios
    DBMS_OUTPUT.PUT_LINE('El salario promedio es: ' || V_AUX);
END;
/
/*9 Crea un bloque PL/SQL que busque los empleados con el mayor salario y los muestre en pantalla.*/
DECLARE
CURSOR C_EMPLEMAXSAL IS
SELECT E.SAL
FROM EMP E
WHERE E.SAL=(
SELECT MAX(E1.SAL)AS MAXIMO
FROM EMP E1);

V_AUX EMP.SAL%TYPE;
BEGIN
OPEN C_EMPLEMAXSAL;
FETCH C_EMPLEMAXSAL INTO V_AUX;
WHILE C_EMPLEMAXSAL %FOUND LOOP
DBMS_OUTPUT.PUT_LINE('EMPLEADO CON MAYOR SALARIO: '||V_AUX);
FETCH C_EMPLEMAXSAL INTO V_AUX;
END LOOP;
CLOSE C_EMPLEMAXSAL;
END;

/
/* 10 Escribe un procedimiento que reciba un número de departamento y cuente cuántos empleados hay en ese departamento.*/
--SI SOLO DEVUEVLE UNA FILA MEJOR SELECT INTO
CREATE OR REPLACE PROCEDURE EMPLEXDEPTNO(P_DEPTNO IN EMP.DEPTNO%TYPE)
IS
    V_AUX NUMBER;  -- Variable para almacenar el número de empleados
BEGIN
    -- Seleccionamos directamente el número de empleados sin necesidad de un cursor
    SELECT COUNT(EMPNO)
    INTO V_AUX
    FROM EMP
    WHERE DEPTNO = P_DEPTNO;

    -- Mostramos el resultado
    DBMS_OUTPUT.PUT_LINE('Número de empleados en el departamento ' || P_DEPTNO || ': ' || V_AUX);
END EMPLEXDEPTNO;
/
--VERSION 2
CREATE OR REPLACE PROCEDURE contar_empleados(p_deptno NUMBER) AS
    v_contador NUMBER := 0;
    CURSOR c_empleados IS 
        SELECT empno FROM emp WHERE deptno = p_deptno;
    v_emp emp.empno%TYPE;
BEGIN
    OPEN c_empleados;
    FETCH c_empleados INTO v_emp;
    WHILE c_empleados%FOUND LOOP
        v_contador := v_contador + 1;
        FETCH c_empleados INTO v_emp;
    END LOOP;
    CLOSE c_empleados;
    
    DBMS_OUTPUT.PUT_LINE('Número de empleados en el departamento ' || p_deptno || ': ' || v_contador);
END contar_empleados;
/

BEGIN
contar_empleados(20);
EMPLEXDEPTNO(20);  -- Llamamos al procedimiento para el departamento 20

END;
/
/*11 Escribe un bloque PL/SQL que muestre los 
empleados cuyo salario sea mayor al salario promedio.*/

DECLARE
CURSOR C_EMPLE_SALALTO IS
SELECT E.ENAME,E.SAL
FROM EMP E
WHERE E.SAL>(
SELECT AVG(E1.SAL) 
FROM EMP E1);
V_AUX  C_EMPLE_SALALTO%ROWTYPE;
BEGIN
OPEN  C_EMPLE_SALALTO;
FETCH  C_EMPLE_SALALTO INTO V_AUX;
WHILE  C_EMPLE_SALALTO%FOUND LOOP
DBMS_OUTPUT.PUT_LINE('NOMBRE: '||V_AUX.ENAME||'-SALARIO: '||V_AUX.SAL);
FETCH  C_EMPLE_SALALTO INTO V_AUX;
END LOOP;
CLOSE  C_EMPLE_SALALTO;
END;
/
/*12 Escribe un bloque PL/SQL que aumente el salario en un 10%
a los empleados que llevan más de 5 años en la empresa.*/
DECLARE
CURSOR C_ANTIGUEDAD IS
SELECT SAL,EMPNO
FROM EMP
WHERE HIREDATE <= ADD_MONTHS(SYSDATE, -60)
FOR UPDATE;
--
CURSOR C_NUEVO (P_EMPNO EMP.EMPNO%TYPE) IS
SELECT SAL
FROM EMP
WHERE EMPNO=P_EMPNO;
V_AUX C_ANTIGUEDAD%ROWTYPE;
V_AUX1 EMP.SAL%TYPE;
BEGIN
OPEN C_ANTIGUEDAD;
FETCH C_ANTIGUEDAD INTO V_AUX;
WHILE C_ANTIGUEDAD %FOUND LOOP
UPDATE EMP
SET SAL=SAL*1.10
WHERE CURRENT OF C_ANTIGUEDAD;

-- Abrir el segundo cursor para recuperar el nuevo salario
        OPEN C_NUEVO(V_AUX.EMPNO);
        FETCH C_NUEVO INTO V_AUX1;
        CLOSE C_NUEVO;
DBMS_OUTPUT.PUT_LINE('SALARIO '|| V_AUX.SAL ||' ACTUALIZADO A '||V_AUX1);
FETCH C_ANTIGUEDAD INTO V_AUX;
END LOOP;
CLOSE C_ANTIGUEDAD;
END;
/
--VERSION 2 DEL 12
DECLARE
    CURSOR C_ANTIGUEDAD IS
        SELECT EMPNO, SAL  -- También selecciona EMPNO para identificar al empleado
        FROM EMP
        WHERE HIREDATE <= ADD_MONTHS(SYSDATE, -60)
        FOR UPDATE;

    V_AUX C_ANTIGUEDAD%ROWTYPE;
    V_NUEVO_SAL EMP.SAL%TYPE;  -- Variable para guardar el nuevo salario

BEGIN
    OPEN C_ANTIGUEDAD;
    FETCH C_ANTIGUEDAD INTO V_AUX;

    WHILE C_ANTIGUEDAD%FOUND LOOP
        -- Actualizar salario
        UPDATE EMP
        SET SAL = SAL * 1.10
        WHERE CURRENT OF C_ANTIGUEDAD;

        -- Recuperar el nuevo salario
        SELECT SAL INTO V_NUEVO_SAL FROM EMP WHERE EMPNO = V_AUX.EMPNO;

        -- Mostrar antes y después
        DBMS_OUTPUT.PUT_LINE('SALARIO '|| V_AUX.SAL ||' ACTUALIZADO A '|| V_NUEVO_SAL);

        FETCH C_ANTIGUEDAD INTO V_AUX;
    END LOOP;

    CLOSE C_ANTIGUEDAD;
END;
/

/








/
ROLLBACK;