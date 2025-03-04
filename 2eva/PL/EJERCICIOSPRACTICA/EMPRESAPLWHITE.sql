SET SERVEROUTPUT ON;

DECLARE
v_salario emp.sal%Type;
BEGIN
SELECT SAL INTO v_salario
FROM emp
WHERE ename='KING';
DBMS_OUTPUT.PUT_LINE('El salario de KING es: ' || v_salario);
END;

DECLARE V_SALMAX NUMBER;
BEGIN 
SELECT MAX(SAL) INTO V_SALMAX
FROM EMP;
DBMS_OUTPUT.PUT_LINE('El salario MAXIMO ES: '  || V_SALMAX);
END;

DECLARE
V_SALMIN EMP.SAL%TYPE;
BEGIN
SELECT MIN(SAL) INTO V_SALMIN
FROM EMP;
DBMS_OUTPUT.PUT_LINE('El salario MINIMO ES: ' || V_SALMIN);
END;


DECLARE
  v_departamento EMP.DEPTNO%TYPE;  -- Variable para almacenar el departamento
  v_cantidad NUMBER;  -- Variable para almacenar el número de empleados por departamento
BEGIN
  FOR CADAFILA IN (SELECT DEPTNO, COUNT(*) AS CANTIDAD FROM EMP GROUP BY DEPTNO) LOOP
    v_departamento := CADAFILA.DEPTNO;  -- Asigna el valor del departamento de la fila actual
    v_cantidad := CADAFILA.CANTIDAD;  -- Asigna el valor del número de empleados del departamento
    DBMS_OUTPUT.PUT_LINE('Departamento: ' || v_departamento || ', Número de empleados: ' || v_cantidad);  -- Muestra el resultado en la consola
  END LOOP;
END;
/
