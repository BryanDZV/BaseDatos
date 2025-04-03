/*Ejercicio 1: hacer un procedimiento al que le pasamos el ENAME de un 
empleado dado, y le incrementa incrementarle el salario en un 10%.  Controlar
dos excepciones predefinidas de ORACLE, NO_DATA_FOUND y TOO_MANY_ROWS.
En cualquiera de los das dos excepciones nos debe visualizar un mensaje */

CREATE OR REPLACE PROCEDURE AUMENTOSAL (
   P_ENAME VARCHAR2
) IS
   V_SAL NUMBER;
BEGIN

   SELECT SAL INTO V_SAL
   FROM EMP
   WHERE ENAME = P_ENAME;

   V_SAL := V_SAL * 1.10;

   UPDATE EMP
   SET SAL = V_SAL
   WHERE ENAME = P_ENAME;
      DBMS_OUTPUT.PUT_LINE('---EMPLEADO ' || P_ENAME);

EXCEPTION
   WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('--- No se encontró el empleado con nombre ' || P_ENAME);

   WHEN TOO_MANY_ROWS THEN
      DBMS_OUTPUT.PUT_LINE('--- Se encontraron VARIOS EMPLEADOS CON EL NOMBRE ' || P_ENAME);
END AUMENTOSAL;
/
INSERT INTO EMP (EMPNO, ENAME, SAL)
VALUES (7944, 'MILLER', 1350);


DECLARE
BEGIN
AUMENTOSAL('MILLER');
END;
ROLLBACK;


/*2Ejercicio 2:
Realizar una función llamada insertar_departamento, a la que le pasamos tres valores que
correspondan al número, nombre y localidad de un departamento.
Esta función inserta en la tabla DEPT los valores aceptados.
Controlar los siguientes errores:
Si el departamento ya existe, devolverá un -1.
Si algún dato del nombre del departamento o localidad son mayores de longitud que la
especificada en la tabla, devolver 1.
Si se producen otros errores, devolver -2.
En caso de que todo vaya bien devolvemos 0.
Nota: El error ORACLE de longitud del dato fuera del rango es el 1438*/

CREATE OR REPLACE FUNCTION INSERTAR_DEPARTAMENTO (
   P_DEPTNO    NUMBER,
   P_DNAME    VARCHAR2,
   P_LOC  VARCHAR2
) RETURN NUMBER IS
   V_FILAS NUMBER;
BEGIN
   SELECT COUNT(*) INTO V_FILAS FROM DEPT WHERE DEPTNO = p_deptno;
   IF V_FILAS > 0 THEN
      RETURN -1; 
   END IF;
   INSERT INTO DEPT (DEPTNO, DNAME, LOC) 
   VALUES (p_deptno, p_dname, p_loc);

   RETURN 0; 

EXCEPTION
   WHEN DUP_VAL_ON_INDEX THEN
      RETURN -1; 

   WHEN OTHERS THEN
      IF SQLCODE = -1438 THEN
         RETURN 1; 
      ELSE
         RETURN -2; -- Otro error
      END IF;
END insertar_departamento;
/


























