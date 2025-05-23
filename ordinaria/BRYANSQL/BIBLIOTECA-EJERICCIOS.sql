/*Crea un trigger AFTER UPDATE ON PRESTAMO que actualice el SALDO_MULTA en USUARIO si cambia la FECHA_DEVOLUCION.*/

CREATE OR REPLACE TRIGGER trg_multa_retraso AFTER
        UPDATE ON prestamo
        FOR EACH ROW
        WHEN ( old.fecha_devolucion != new.fecha_devolucion )
BEGIN
        UPDATE usuario
        SET
                saldo_multa =
                        CASE
                                WHEN ( :old.fecha_devolucion - :new.fecha_prestamo ) <= 5             THEN
                                        2
                                WHEN ( :old.fecha_devolucion - :new.fecha_prestamo ) BETWEEN
                                6 AND 15 THEN
                                        5
                                WHEN ( :old.fecha_devolucion - :new.fecha_prestamo ) > 15             THEN
                                        10
                                ELSE
                                        0
                        END
        WHERE
                id_usuario = :new.id_usuario;

END;
/
/*EJERCICIO 2 — PAQUETE con función y procedimiento
Crea un paquete PAQ_USUARIOS con:

Un procedimiento P_MOSTRAR_USUARIOS que muestre todos los usuarios.

Una función F_CONTAR_USUARIOS_MULTADOS que devuelva cuántos usuarios tienen saldo_multa mayor que 0.*/

CREATE OR REPLACE PACKAGE PAQ_USUARIOS AS
PROCEDURE P_MOSTRAR_USUARIOS;
FUNCTION F_CONTAR_USUARIOS_MULTADOS RETURN NUMBER;
END;

CREATE OR REPLACE PACKAGE BODY PAQ_USUARIOS AS
PROCEDURE P_MOSTRAR_USUARIOS 
IS
CURSOR CVER IS 
SELECT * FROM USUARIO;
VAUX_CVER CVER%ROWTYPE;
BEGIN
OPEN CVER;
FETCH CVER INTO VAUX_CVER;
WHILE CVER%FOUND LOOP
DBMS_OUTPUT.PUT_LINE('USUARIO: '||VAUX_CVER.NOMBRE);
FETCH CVER INTO VAUX_CVER;
END LOOP;
CLOSE CVER;
END;

FUNCTION F_CONTAR_USUARIOS_MULTADOS 
RETURN NUMBER
IS
VAUX_RETURN NUMBER;
BEGIN
SELECT COUNT(*)
      INTO VAUX_RETURN
      FROM USUARIO
     WHERE SALDO_MULTA > 0;
    RETURN VAUX_RETURN;
END;

END PAQ_USUARIOS;


DECLARE
VAUX_RESU NUMBER;
BEGIN
VAUX_RESU:=PAQ_USUARIOS.F_CONTAR_USUARIOS_MULTADOS;
DBMS_OUTPUT.PUT_LINE('SOY RESULTADOS RETURN---'||VAUX_RESU);
PAQ_USUARIOS.P_MOSTRAR_USUARIOS;
END;







