/
CREATE TABLE AUDITAR_EMP
(FECHA_MODIFICACION DATE,
NUMERO_EMPLEADO VARCHAR2(300),
APELLIDO VARCHAR2(300),
OPERACION VARCHAR2(300));
/
ALTER TABLE  AUDITAR_EMP ADD (VALORES_MODIFICADOS VARCHAR2(400));
ALTER TABLE  AUDITAR_EMP ADD (VALOR_NUEVO VARCHAR2(400));
ALTER TABLE AUDITAR_EMP ADD(COLUMNA_MODIFICDA VARCHAR2(400));
ALTER TABLE AUDITAR_EMP DROP COLUMN VALORES_MODIFICADOS;
ALTER TABLE AUDITAR_EMP RENAME COLUMN COLUMNA_MODIFICDA TO COLUMNA_MODIFICADA;
/
CREATE OR REPLACE TRIGGER TRG_EMP
AFTER INSERT OR DELETE ON EMP
FOR EACH ROW
BEGIN
    -- Si la operación es una inserción
    IF INSERTING THEN
        INSERT INTO AUDITAR_EMP
        VALUES (SYSDATE, :NEW.EMPNO, :NEW.ENAME, 'INSERCIÓN');
    -- Si la operación es un borrado
    ELSIF DELETING THEN
        INSERT INTO AUDITAR_EMP
        VALUES (SYSDATE, :OLD.EMPNO, :OLD.ENAME, 'BORRADO');
    END IF;
END;
/
INSERT INTO EMP (EMPNO, ENAME) VALUES (1234, 'John Doe');
/
DELETE FROM EMP WHERE EMPNO = 1234;
/
--TABLAS
SELECT * FROM AUDITAR_EMP;
DESCRIBE AUDITAR_EMP;
SELECT * FROM EMP;
/

CREATE OR REPLACE TRIGGER TRG_EMP_UPD
AFTER UPDATE ON EMP
FOR EACH ROW
DECLARE
BEGIN
  IF :OLD.ENAME != :NEW.ENAME OR
     :OLD.JOB != :NEW.JOB OR
     :OLD.MGR != :NEW.MGR OR
     :OLD.SAL != :NEW.SAL OR
     :OLD.COMM != :NEW.COMM OR
     :OLD.DEPTNO != :NEW.DEPTNO THEN

    IF :OLD.ENAME != :NEW.ENAME THEN
      INSERT INTO AUDITAR_EMP
      (fecha_modificacion, numero_empleado, apellido, operacion, valor_anterior, valor_nuevo, columna_modificada)
      VALUES (SYSDATE, :NEW.EMPNO, :NEW.ENAME, 'ACTUALIZACION', TO_CHAR(:OLD.ENAME), TO_CHAR(:NEW.ENAME), 'ENAME');
    END IF;

    IF :OLD.JOB != :NEW.JOB THEN
      INSERT INTO AUDITAR_EMP
      (fecha_modificacion, numero_empleado, apellido, operacion, valor_anterior, valor_nuevo, columna_modificada)
      VALUES (SYSDATE, :NEW.EMPNO, :NEW.ENAME, 'ACTUALIZACION', TO_CHAR(:OLD.JOB), TO_CHAR(:NEW.JOB), 'JOB');
    END IF;

    IF :OLD.MGR != :NEW.MGR THEN
      INSERT INTO AUDITAR_EMP
      (fecha_modificacion, numero_empleado, apellido, operacion, valor_anterior, valor_nuevo, columna_modificada)
      VALUES (SYSDATE, :NEW.EMPNO, :NEW.ENAME, 'ACTUALIZACION', TO_CHAR(:OLD.MGR), TO_CHAR(:NEW.MGR), 'MGR');
    END IF;

    IF :OLD.SAL != :NEW.SAL THEN
      INSERT INTO AUDITAR_EMP
      (fecha_modificacion, numero_empleado, apellido, operacion, valor_anterior, valor_nuevo, columna_modificada)
      VALUES (SYSDATE, :NEW.EMPNO, :NEW.ENAME, 'ACTUALIZACION', TO_CHAR(:OLD.SAL), TO_CHAR(:NEW.SAL), 'SAL');
    END IF;

    IF :OLD.COMM != :NEW.COMM THEN
      INSERT INTO AUDITAR_EMP
      (fecha_modificacion, numero_empleado, apellido, operacion, valor_anterior, valor_nuevo, columna_modificada)
      VALUES (SYSDATE, :NEW.EMPNO, :NEW.ENAME, 'ACTUALIZACION', TO_CHAR(:OLD.COMM), TO_CHAR(:NEW.COMM), 'COMM');
    END IF;

    IF :OLD.DEPTNO != :NEW.DEPTNO THEN
      INSERT INTO AUDITAR_EMP
      (fecha_modificacion, numero_empleado, apellido, operacion, valor_anterior, valor_nuevo, columna_modificada)
      VALUES (SYSDATE, :NEW.EMPNO, :NEW.ENAME, 'ACTUALIZACION', TO_CHAR(:OLD.DEPTNO), TO_CHAR(:NEW.DEPTNO), 'DEPTNO');
    END IF;

  END IF;
END;
/

DECLARE
BEGIN
UPDATE EMP
SET SAL=SAL+10
WHERE EMPNO=7369;
END;
/

/*el 3 me falta de este*/


/*EJERCICIO  DE TRIGGERS DICCIONARIO DD

Ejercicio1: Hacer un procedimiento que visualice todos los triggers existentes en nuestro usuario.
*/
/
DECLARE
PROCEDURE VER_TRIGGERS
IS
TYPE REG_TRG IS RECORD(
TRIGGER_NAME USER_TRIGGERS.TRIGGER_NAME%TYPE;
VAUX REG_TRG;
BEGIN
SELECT TRIGGER_NAME INTO VAUX
FROM USER_TRIGGERS;
DBMS_OUTPUT.PUT_LINE('NOMBRE:  '||VAUX.TRIGGER_NAME);
END;
BEGIN
VER_TRIGGERS;
END;
/
/*Ejercicio 2:
 Sabiendo que Oracle tiene algunas variables que permiten acceder a los atributos del evento
 del disparo ORA_YSEVENT (evento) ORA_LOGIN_USER, SYSTIMESTAMP. Crear un trigger
 que permita guardar esta información en la tabla auditar , que tendrá tres campos con evento, 
 usuario y fecha, cada vez que nos conectemos. Por otra parte , esta tabla auditar , 
 tendrá un trigger asociado , para que nadie pueda modificar nada de dicha tabla
*/


CREATE OR REPLACE TRIGGER auditar_logon_trigger
AFTER LOGON ON DATABASE
DECLARE
  v_evento VARCHAR2(100) := 'LOGIN';
  v_usuario VARCHAR2(100);
  v_fecha TIMESTAMP;
BEGIN
  -- Obtener el usuario que está realizando el inicio de sesión
  v_usuario := SYS_CONTEXT('USERENV', 'SESSION_USER');
  -- Obtener la fecha y hora actual
  v_fecha := SYSTIMESTAMP;

  -- Insertar la información en la tabla AUDITAR
  INSERT INTO auditar (evento, usuario, fecha)
  VALUES (v_evento, v_usuario, v_fecha);
END;
/





rollback;









