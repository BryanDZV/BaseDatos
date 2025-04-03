BEGIN
       dbms_output.put_line('HOLA BYAN');
END;

DECLARE
       num1      NUMBER := 4;
       num2      NUMBER := 3;
       resultado NUMBER;
BEGIN
       resultado := num1 + num2;
       dbms_output.put_line('EL RESULTADO ES ' || resultado);
END;

DECLARE
       pi    NUMBER := 3.14159;
       area  NUMBER;
       radio NUMBER := 5;
BEGIN
       area := pi * radio * radio;
       dbms_output.put_line('EL RESULTADO ES ' || area);
END;

DECLARE
       num1     NUMBER;
       resultad BOOLEAN;
BEGIN
       num1 := -7;
       IF num1 > 0
       THEN dbms_output.put_line('ES POSITIVO EL NUMER: ' || num1);
       ELSE dbms_output.put_line('ES NEGATIVO EL NUMER: ' || num1);
       END IF;

END;

BEGIN
       FOR i IN 1..5 LOOP
              dbms_output.put_line(i);
       END LOOP;
END;

DECLARE
       i NUMBER := 1;
BEGIN
       WHILE 5 <= i LOOP
              dbms_output.put_line(i);
              i := i + 1;
       END LOOP;
END;

DECLARE
       num1      NUMBER;
       num2      NUMBER;
       resultado NUMBER;
BEGIN
       num1      := 2;
       num2      := 12;
       resultado := num1 / num2;
       dbms_output.put_line('RESULTADO DE LA DIVISION ES: ' || resultado);
EXCEPTION
       WHEN zero_divide
       THEN dbms_output.put_line('Error: No se puede dividir por cero');
END;

DECLARE
       num1      NUMBER := 4;
       num2      NUMBER := 5;
       resultado NUMBER;
BEGIN
       resultado := num1 * num2;
       dbms_output.put_line('EL RESULTADO DEL PRODUCTO ES: ' || resultado);
END;

DECLARE
       resultado NUMBER;
BEGIN
       SELECT
              COUNT(*)
       INTO resultado
       FROM
              emp;

       dbms_output.put_line('TODOS LOS RESGISTROS ' || resultado);
END;

DECLARE
       nombre            emp.ename%TYPE := 'MILLER';
       actualizacion_sal NUMBER := 1340;
BEGIN
       UPDATE emp
       SET
              sal = actualizacion_sal
       WHERE
              ename = nombre;

       dbms_output.put_line('ACTUALIZADO SALARIO DE ' || actualizacion_sal);
END;

DECLARE
       PROCEDURE bloquenom_proc IS
       BEGIN
              dbms_output.put_line('HOLA MUNDO');
       END bloquenom_proc;

BEGIN
       bloquenom_proc;
END;

DECLARE
       PROCEDURE suma_pr (
              num1 NUMBER,
              num2 NUMBER
       ) IS
              resultado NUMBER;
       BEGIN
              resultado := num1 + num2;
              dbms_output.put_line('LA SUMA ES ' || resultado);
       END suma_pr;

BEGIN
       suma_pr(10, 2);
END;

DECLARE
       PROCEDURE es_par (
              num1 NUMBER
       ) IS
       BEGIN
              IF MOD(num1, 2) = 0
              THEN
                     dbms_output.put_line(num1 || ' es par');
              ELSE dbms_output.put_line(num1 || ' es impar');
              END IF;
       END es_par;

BEGIN
       es_par(12);
END;

DECLARE
       PROCEDURE factorial_pr (
              num1 NUMBER
       ) IS
              resultado NUMBER := 1;
              i         NUMBER;
       BEGIN
              FOR i IN 1..num1 LOOP
                     resultado := resultado * i;
              END LOOP;
              dbms_output.put_line('EL FACTORIAL DEL '
                                   || num1
                                   || 'ES: '
                                   || resultado);
       END factorial_pr;

BEGIN
       factorial_pr(7);
END;
/*//*/
DECLARE
       PROCEDURE obtener_empleados (
              n_departamento IN NUMBER,
              n_nombre       IN VARCHAR
       ) IS
              resultado VARCHAR2(70);
       BEGIN
              SELECT
                     ename
              INTO resultado
              FROM
                     emp
              WHERE
                            deptno = n_departamento
                     AND ename = n_nombre;

              dbms_output.put_line('EL RESULTADO ES: ' || resultado);
       END obtener_empleados;

BEGIN
       obtener_empleados(10, 'KING');
END;
/*//*/
DECLARE
       PROCEDURE salariototal_empleado (
              n_empleado IN NUMBER
       ) IS
              resultado NUMBER;
       BEGIN
              SELECT
                     sal
              INTO resultado
              FROM
                     emp
              WHERE
                     empno = n_empleado;

              dbms_output.put_line('EL RESULTADO ES: ' || resultado);
       END salariototal_empleado;

BEGIN
       salariototal_empleado(7839);
END;

-- Primero, declaramos el procedimiento correctamente
/*EJEMPLO INSERTTT*/
CREATE OR REPLACE PROCEDURE nuevo_empleado (
    n_empno    IN NUMBER,
    n_ename    IN VARCHAR2,
    n_job      IN VARCHAR2,
    n_mgr      IN NUMBER,
    n_hiredate IN DATE,
    n_sal      IN NUMBER,
    n_comm     IN NUMBER,
    n_deptno   IN NUMBER
) IS
BEGIN
    -- Inserción de los datos en la tabla EMP
    INSERT INTO EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
    VALUES (n_empno, n_ename, n_job, n_mgr, n_hiredate, n_sal, n_comm, n_deptno);
    
    -- Mensaje de confirmación
    dbms_output.put_line('EMPLEADO INSERTADO: ' || n_ename);
END nuevo_empleado;
/

-- Luego, llamamos al procedimiento con los parámetros adecuados
BEGIN
    nuevo_empleado(1, 'Cocinero', 12, TO_DATE('2025-01-01', 'YYYY-MM-DD'), 3000, 500, 10);
END;
/

/*EJEMPLO UPDATE*/
CREATE OR REPLACE PROCEDURE AUMENTAR_SALARIO(N_EMPLEADO IN NUMBER, X_PORCENTAJE NUMBER)
IS
BEGIN 
    -- Realizamos la actualización directamente con el cálculo del nuevo salario
    UPDATE EMP
    SET SAL =  NVL(SAL, 1000) * (1 + X_PORCENTAJE / 100)
    WHERE EMPNO = N_EMPLEADO;

    -- Mensaje de confirmación
    dbms_output.put_line('SALARIO ACTUALIZADO DE EMPLEADO CON NUMERO: ' || N_EMPLEADO);
END AUMENTAR_SALARIO;
/

-- Luego, llamamos al procedimiento con los parámetros adecuados
BEGIN
    AUMENTAR_SALARIO(7934, 80);  -- Aumenta el salario del empleado con EMPNO = 7934 en un 80%
END;
/

CREATE OR REPLACE PROCEDURE CATEGORIA_SALARIAL(N_EMPLEADO IN NUMBER,G_SALARIAL OUT NUMBER )
IS
BEGIN
SELECT GRADE INTO G_SALARIAL
FROM SALGRADE
WHERE EMPNO=
ASDSA;
END CATEGORIA_SALARIAL;






ROLLBACK;