/*Crear un trigger BEFORE INSERT que registre un mensaje cada vez que se inserte un nuevo empleado en la tabla EMP.*/
/* Eliminar la tabla de mensajes si ya existe*/
DROP TABLE audi_mensajes;

/* Crear la tabla para registrar los mensajes*/
CREATE TABLE audi_mensajes (
        mensaje VARCHAR2(255),
        fecha   DATE DEFAULT current_timestamp
);
/

-- Crear el trigger BEFORE INSERT
CREATE OR REPLACE TRIGGER TG_EMP_BEFORE
BEFORE INSERT ON EMP
FOR EACH ROW
BEGIN
    -- Insertar mensaje en la tabla audi_mensajes
    INSERT INTO audi_mensajes (mensaje, fecha)
    VALUES (
        CONCAT('EMPLEADO INSERTADO: ', :NEW.ENAME),
        TO_DATE(SYSDATE, 'DD-MM-YYYY')
    );
END;
/
-- Insertar un ejemplo en la tabla EMP
INSERT INTO EMP(empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES(7837, 'PEPE', 'JUAN', 10, SYSDATE, 3453, 0, 20);
/
-- Realizar un ROLLBACK para deshacer la transacción
ROLLBACK;
/

-- Verificar que los registros no se hayan insertado
SELECT * FROM AUDI_MENSAJES;
SELECT * FROM EMP;
---------
/*2 Crear un trigger AFTER INSERT que registre la fecha de inserción de un nuevo empleado en una tabla de auditoría.*/

CREATE OR REPLACE TG_INSERT_AFTER
BEFORE INSERT ON EMP
FOR EACH ROW
DECLARE
BEGIN
INSERT INTO AUDI_MENSAJES(MENSAJE,FECHA)
VALUES(CONCAT('EMPLEADO INSERTADO:  ',:NEW.EMP),TO_DATE(SYSDATE,'DD-MM-YYYY'));
END;
/
INSERT INTO EMP(empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES(1112,'JUANITO',NULL,NULL,SYSDATE,8989,0,30);
/
/*3 Crear un trigger BEFORE UPDATE que evite la actualización del salario a un valor inferior al salario
actual de un empleado.*/
CREATE OR REPLACE TRIGGER TG_UPDATE_SAL
BEFORE UPDATE ON EMP
FOR EACH ROW
BEGIN
    -- Bloquear si el nuevo salario es menor al anterior
    IF :NEW.sal < :OLD.sal THEN
        raise_application_error(-20001, 'El nuevo salario no puede ser inferior al salario actual');
    END IF;

    -- Registrar mensaje en la tabla de auditoría
    INSERT INTO AUDI_MENSAJES (mensaje, fecha)
    VALUES (
        'SALARIO ACTUALIZADO A: ' || :NEW.sal,
        SYSTIMESTAMP
    );
END;
/


UPDATE emp
SET
        sal = 980
WHERE
        empno = 7900;


/*4Crear una vista que combine las tablas EMP y DEPT, y 
luego crear un trigger INSTEAD OF que permita insertar datos 
en ambas tablas al insertar en la vista.*/
CREATE OR REPLACE VIEW V_EMP_DEPT AS
SELECT E.EMPNO,E.ENAME,E.SAL,D.DNAME,D.DEPTNO,E.COMM
FROM EMP E
INNER JOIN DEPT D ON E.DEPTNO=D.DEPTNO;
/
CREATE OR REPLACE TRIGGER TG_EMP_DEPT
INSTEAD OF INSERT ON V_EMP_DEPT
FOR EACH ROW
DECLARE
    vaux_deptno DEPT.DEPTNO%TYPE;
BEGIN
    BEGIN
        -- Intentar obtener el DEPTNO del departamento por el nombre
        SELECT DEPTNO INTO vaux_deptno
        FROM DEPT
        WHERE DNAME = :NEW.DNAME;

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            -- Si no existe, insertar el nuevo departamento con DEPTNO autogenerado
            INSERT INTO DEPT(DEPTNO, DNAME, LOC)
            VALUES (
                (SELECT NVL(MAX(DEPTNO), 0) + 1 FROM DEPT),
                :NEW.DNAME,
                'DESCONOCIDO'
            );

            -- Obtener el deptno recién insertado
            SELECT DEPTNO INTO vaux_deptno
            FROM DEPT
            WHERE DNAME = :NEW.DNAME;
    END;

    -- Insertar el empleado con el deptno obtenido
    INSERT INTO EMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
    VALUES (:NEW.EMPNO, :NEW.ENAME, NULL, NULL, SYSDATE, :NEW.SAL, :NEW.COMM, vaux_deptno);
END;
/
INSERT INTO V_EMP_DEPT (EMPNO, ENAME, SAL, COMM, DNAME)
VALUES (9999, 'CARLA', 2500, NULL, 'LOGISTICA');

SELECT * FROM DEPT WHERE DNAME = 'LOGISTICA';
SELECT * FROM EMP WHERE EMPNO = 9999;

ROLLBACK;











