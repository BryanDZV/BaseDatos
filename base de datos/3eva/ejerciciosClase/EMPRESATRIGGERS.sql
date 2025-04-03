/*1.	Construir un disparador de base de datos que permita auditar las operaciones de inserción o borrado de datos que se realicen en la tabla emp según las siguientes especificaciones:
- En primer lugar se creará desde SQL Developer  la tabla auditaremple con la columna col1 VARCHAR2(200).
- Cuando se produzca cualquier manipulación se insertará una fila en dicha tabla que contendrá:
- Fecha y hora
- Número de empleado
- Apellido
- La operación de actualización INSERCIÓN o BORRADO
*/
CREATE TABLE auditaremple (
        col1 VARCHAR2(200)
);

CREATE OR REPLACE TRIGGER auditar_insercion_borrado AFTER
        INSERT OR DELETE ON emp
        FOR EACH ROW
DECLARE
        operacion VARCHAR2(200);
BEGIN
        IF inserting THEN
                operacion := 'SE HA INSERTADO UN EMPLEADO FECHA-HORA:  ' ||
                TO_DATE ( sysdate, 'DD/MM/YYYY HH24:MI:SS' ) ||
                'EMPNO:  ' ||
                :new.empno ||
                'NOMBRE:  ' ||
                :new.ename;
        ELSIF deleting THEN
                operacion := 'SE HA BORRADO UN EMPLEADO FECHA-HORA:  ' ||
                TO_DATE ( sysdate, 'DD/MM/YYYY HH24:MI:SS' ) ||
                'EMPNO:  ' ||
                :old.empno ||
                'NOMBRE:  ' ||
                :old.ename;
        END IF;

        INSERT INTO auditaremple ( col1 ) VALUES ( operacion );

END;
/
/*Escribir un trigger de base de datos un que permita auditar las modificaciones en la tabla empleados insertado en la tabla auditaremple los siguientes datos:
 Fecha y hora
- Número de empleado
- Apellido
- La operación de actualización: MODIFICACIÓN.
- El valor anterior y el valor nuevo de cada columna modificada. (solo las columnas modificadas)
*/
CREATE OR REPLACE TRIGGER auditar_modificacion AFTER
        UPDATE ON emp
        FOR EACH ROW
DECLARE
        operacion VARCHAR2(200);
BEGIN
        IF :new.empno != :old.empno THEN
                operacion := 'MODIFICATION: Fecha y Hora: ' ||
                to_char(sysdate, 'DD/MM/YYYY HH24:MI:SS') ||
                ' | Empleado: ' ||
                :new.empno ||
                ' | Apellido: ' ||
                :new.ename ||
                ' | Columna Modificada: EMPNO | Valor Anterior: ' ||
                :old.empno ||
                ' | Valor Nuevo: ' ||
                :new.empno;

                INSERT INTO auditaremple ( col1 ) VALUES ( operacion );

        END IF;

        IF :new.ename != :old.ename THEN
                operacion := 'MODIFICATION: Fecha y Hora: ' ||
                to_char(sysdate, 'DD/MM/YYYY HH24:MI:SS') ||
                ' | Empleado: ' ||
                :new.empno ||
                ' | Apellido: ' ||
                :new.ename ||
                ' | Columna Modificada: ENAME | Valor Anterior: ' ||
                :old.ename ||
                ' | Valor Nuevo: ' ||
                :new.ename;

                INSERT INTO auditaremple ( col1 ) VALUES ( operacion );

        END IF;

    /* Puedes agregar más condiciones aquí para auditar otras columnas como salario, etc.*/
END;
/
/*3.	Escribir un disparador de base de datos que haga fallar cualquier operación de modificación
del apellido o del número de un empleado, o que suponga una subida de sueldo superior al 10%.*/
/*
Condiciones a comprobar:
Modificación del apellido (ename).

Modificación del número de empleado (empno).

Subida de sueldo superior al 10% (comparando el valor anterior y el nuevo sueldo).*/
CREATE OR REPLACE TRIGGER evitar_modificaciones
BEFORE UPDATE ON emp
FOR EACH ROW
DECLARE
    -- Variables para almacenar el mensaje de error y el código de error
    v_mensaje VARCHAR2(200);
    v_codigo NUMBER;
BEGIN
    -- Comprobar si el apellido (ename) ha cambiado
    IF :NEW.ename != :OLD.ename THEN
        v_mensaje := 'Error: No se puede modificar el apellido del empleado.';
        v_codigo := -20001;
        -- Imprimir el mensaje en la salida de la base de datos
        DBMS_OUTPUT.PUT_LINE(v_mensaje);
        -- Impedir la actualización
        RAISE_APPLICATION_ERROR(v_codigo, v_mensaje);
    END IF;

    -- Comprobar si el número de empleado (empno) ha cambiado
    IF :NEW.empno != :OLD.empno THEN
        v_mensaje := 'Error: No se puede modificar el número de empleado.';
        v_codigo := -20002;
        DBMS_OUTPUT.PUT_LINE(v_mensaje);
        RAISE_APPLICATION_ERROR(v_codigo, v_mensaje);
    END IF;

    -- Comprobar si la subida del sueldo es mayor al 10%
    IF :NEW.sal > :OLD.sal * 1.10 THEN
        v_mensaje := 'Error: La subida de sueldo no puede ser superior al 10%.';
        v_codigo := -20003;
        DBMS_OUTPUT.PUT_LINE(v_mensaje);
        RAISE_APPLICATION_ERROR(v_codigo, v_mensaje);
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        -- Capturar cualquier excepción que ocurra y mostrar el mensaje
        DBMS_OUTPUT.PUT_LINE('Se ha producido un error: ' || SQLERRM);
        DBMS_OUTPUT.PUT_LINE('Código de error: ' || SQLCODE);
        -- Realizar rollback en caso de error
        ROLLBACK;
END;
/

