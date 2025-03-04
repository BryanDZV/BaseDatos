/**----------------1*/
/*Cabecera del procedimiento:*/
--CREATE OR REPLACE PROCEDURE modificar_precio_producto (codigoprod NUMBER, nuevoprecio NUMBER)
--modificar_precio_producto: Nombre del procedimiento.
--codigoprod NUMBER, nuevoprecio NUMBER: Los parámetros del procedimiento.
/*
Expresión (precioant * 0.20) > ABS(precioant - nuevoprecio):*/

--Compara si el 20% del precio anterior es mayor que la diferencia absoluta entre el precio anterior y el nuevo precio )PARA Que el cambio de precio no supere el 20%.

--¿Por qué no tiene la cláusula DECLARE?
-- porque se usa AS, que permite declarar variables locales directamente QUE ES IGUAL QUE IS

/*EJERCICIO 2--------------------*/

--1
CREATE OR REPLACE PROCEDURE cambiar_JOB (num_empleado NUMBER, nuevo_JOB VARCHAR2) --TIPO IN
IS
BEGIN
    UPDATE EMP
    SET JOB = nuevo_JOB
    WHERE EMPNO = num_empleado;

    DBMS_OUTPUT.PUT_LINE('El oficio del empleado ' || num_empleado || ' ha sido actualizado a ' || nuevo_JOB);
END cambiar_JOB;

--1
-- pasándole 2 valorescualesquier
/*PARAMETOS POSICIONAL*/
BEGIN
    cambiar_JOB(7934, 'Gerente');--ANTES CLERKC
END;

/*CON EXECUTE*//*PARAMETRO NOMINAL*/
EXECUTE cambiar_JOB(num_empleado => 102, nuevo_JOB => 'Analista');

---2 DESDE OTRO BLOQUE Y MANUALMENTE DATOS CON BLOQUE ANONIMO
DECLARE
    v_num_empleado NUMBER;     
    v_nuevo_JOB VARCHAR2(50); 
BEGIN
    -- AQUI manualmente LOS PARAMETROS
    v_num_empleado := 7369;
    v_nuevo_JOB := 'Supervisor';

    --  procedimiento con las variables
    cambiar_JOB(v_num_empleado, v_nuevo_JOB);
END;



ROLLBACK;

