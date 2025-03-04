/*Indicar los errores que aparecen
en las siguientes instrucciones y la forma de corregirlos. */

DECLARE
       num1      NUMBER(8, 2) := 0;
       num2      NUMBER(8, 2) NOT NULL DEFAULT 0;
       num3      NUMBER(8, 2) NOT NULL DEFAULT 0;
       cantidad  INTEGER;
       precio    NUMBER(6);
       descuento NUMBER(6);
       num4      num1%TYPE;
       dto       CONSTANT INTEGER := 2;
BEGIN
       num3 := num1 + num2;
END;

/*: Escribir un procedimiento que reciba dos números y visualice su suma.*/

CREATE OR REPLACE PROCEDURE suma (
       num1 NUMBER,
       num2 IN NUMBER
) IS
       resultado NUMBER;
BEGIN
       resultado := num1 + num2;
       dbms_output.put_line('La suma de '
                            || num1
                            || ' y '
                            || num2
                            || ' es: '
                            || resultaado);

END suma;
/

BEGIN
       suma(10, 20);
END;


/*4Escribir una funcion que reciba una fecha y devuelva el año, en número,
correspondiente a esa fecha. */

CREATE OR REPLACE FUNCTION obtener (
       fecha DATE
) /*POR DEFECTO ES IN*/ RETURN NUMBER IS
       año NUMBER;
BEGIN
       año := TO_NUMBER ( to_char(fecha, 'YYYY') );
       RETURN año;
END obtener;

/*Ejercicio 5: Escribir un bloque PL/SQL que haga uso de la función anterior.*/
DECLARE
       fecha     DATE := TO_DATE ( '2025-01-28', 'YYYY-MM-DD' );
       resultado NUMBER;
BEGIN
       resultado := obtener(fecha);
       dbms_output.put_line('El año es: ' || resultado);
END;


/*Ejercicio 6: Dado el siguiente procedimiento:
cuáles de las siguientes llamadas son correctas y cuáles incorrectas, en este último caso
escribir la llamada correcta usando la notación posicional*/

CREATE OR REPLACE PROCEDURE crear_depart (
       v_num_dept depart.dept_no%TYPE,
       v_dnombre  depart.dnombre%TYPE DEFAULT 'PROVISIONAL',
       v_loc      depart.loc%TYPE DEFAULT ‘provisional’
) IS
BEGIN
       INSERT INTO depart VALUES ( v_num_dept,
                                   v_dnombre,
                                   v_loc );

END crear_depart;

/*1. crear_depart;*/
    /*np correcta. Al menos se debe proporcionar el valor obligatorio para v_num_dept.*/
/*2. crear_depart(50);*/
    /*correcta*/
/*3. crear_depart('COMPRAS');*/
    /*Incorrecta. El primer parámetro debe ser v_num_dept (un número), pero 'COMPRAS' es un valor de texto.*/
    /*crear_depart('50','COMPRAS');*/
/*4. crear_depart(50,'COMPRAS');*/
    /*CORRECTA*/
/*5. crear_depart('COMPRAS', 50);*/
    /*INCORRECTA crear_depart(50, 'COMPRAS');*/

/*6. crear_depart('COMPRAS', 'VALENCIA');*/
    /*INCORRECTA crear_depart(50, 'COMPRAS', 'VALENCIA');*/

/*7. crear_depart(50, 'COMPRAS', 'VALENCIA');*/
    /*CORRECTA*/
/*8. crear_depart('COMPRAS', 50, 'VALENCIA');*/
    /*INCORRECTA crear_depart(50, 'COMPRAS', 'VALENCIA');*/
/*9. crear_depart('VALENCIA', ‘COMPRAS’);*/
    /*INCORRECTA crear_depart(50, 'COMPRAS', 'VALENCIA');*/
/*10.crear_depart('VALENCIA', 50);*/
    /*INCORRECTA crear_depart(50, 'VALENCIA');*/
    
/*7 Desarrollar una función que devuelva el número de años completos
que hay entre dos fechas que se pasan como argumentos.*/

/*FUNCION*/
CREATE OR REPLACE FUNCTION numerosaños (
       v_fecha  DATE DEFAULT TO_DATE ( '2025-01-01', 'YYYY-MM-DD' ),
       v_fecha2 DATE DEFAULT TO_DATE ( '2024-01-01', 'YYYY-MM-DD' )
) RETURN NUMBER IS
       resultado NUMBER;
BEGIN
       resultado := trunc(abs(months_between((v_fecha),(v_fecha2)) / 12));

       RETURN resultado;
END numerosaños;


/*LLAMADA*/
DECLARE
       resultado NUMBER;
BEGIN
       resultado := numerosaños(TO_DATE('2000-01-01', 'YYYY-MM-DD'), TO_DATE
       ('2012-01-01', 'YYYY-MM-DD'));

       dbms_output.put_line('EL NÚMERO DE AÑOS ES: ' || resultado);
END;

ROLLBACK;

/*Ejercicio 8: Escribir una función que, haciendo uso de la función anterior devuelva los trienios
que hay entre dos fechas. (Un trienio son tres años completos).*/


CREATE OR REPLACE FUNCTION trienios (
       v_fecha  DATE DEFAULT TO_DATE ( '2025-01-01', 'YYYY-MM-DD' ),
       v_fecha2 DATE DEFAULT TO_DATE ( '2024-01-01', 'YYYY-MM-DD' )
) RETURN NUMBER IS
       resultado NUMBER;
BEGIN
       resultado := trunc(abs(numerosaños(v_fecha, v_fecha2)) / 3);
       RETURN resultado;
END trienios;
/


/*LLAMADA*/

DECLARE
       resultado NUMBER;
BEGIN
       resultado := trienios(TO_DATE('2025-01-01', 'YYYY-MM-DD'), TO_DATE('2015-01-01'
       , 'YYYY-MM-DD'));

       dbms_output.put_line('EL NÚMERO DE TRIENIOS ES: ' || resultado);
END;
/

/*9:procedimiento pasarle un empleado y en ella escribir la suma
del salario y la comisión de los empleados con comisión distinta a 0*/
/*ES UN UPDATE*/

CREATE OR REPLACE PROCEDURE sumar_salarioycomision (
       n_empleado IN NUMBER
) IS
       salario  NUMBER;
       comision NUMBER;
       total    NUMBER;
BEGIN
    /* Obtener el salario y la comisión del empleado con el ID dado*/
       SELECT
              sal,
              comm
       INTO
              salario,
              comision
       FROM
              emp
       WHERE
                     empno = n_empleado
              AND comm <> 0;

       total := salario + comision;
       dbms_output.put_line('El total (salario + comisión) del empleado '
                            || n_empleado
                            || ' es: '
                            || total);
EXCEPTION
       WHEN no_data_found THEN
              dbms_output.put_line('EL  empleado NO DATOS en comisión .');
END sumar_salarioycomision;
/

DECLARE
       n_empleado NUMBER := 7499;
BEGIN
       sumar_salarioycomision(n_empleado);
END;
/




/*10: Escribir una función que devuelva solamente caracteres alfabéticos sustituyendo
cualquier otro carácter por blancos a partir de una cadena que se pasará en la llamada.*/

CREATE OR REPLACE FUNCTION filtrar_alfabeticos (
       p_cadena VARCHAR2
) RETURN VARCHAR2 IS
       resultado VARCHAR2(40) := '';
       caracter  CHAR(1);
BEGIN
       FOR i IN 1..length(p_cadena) LOOP
              caracter := substr(p_cadena, i, 1);/*SUBSTR(<expresion>, <posicion_ini>, <longitud> )*/
              IF caracter BETWEEN 'A' AND 'Z'
                 OR caracter BETWEEN 'a' AND 'z' THEN
                     resultado := resultado || caracter;
              ELSE
                     resultado := resultado || ' ';
              END IF;

       END LOOP;

       RETURN resultado;
END filtrar_alfabeticos;

/*llamda*/

DECLARE
       prueba VARCHAR2(30);
BEGIN
       prueba := filtrar_alfabeticos('Hell0, W0rld!');
       dbms_output.put_line(prueba);
END;
/
/*11: Realizar un procedimiento que incremente el salario de los empleados que tengan
una comisión superior al 5% del salario, en un x% .
El valor de x lo debe especificar el usuario.*/
CREATE OR REPLACE PROCEDURE incrementar_salario (
       x_porcentaje NUMBER
) IS
       resultado NUMBER;
BEGIN
       UPDATE emp
       SET
              sal = sal * ( 1 + x_porcentaje / 100 )
       WHERE
              comm > ( sal * 0.05 );
     
               
    /*COMMIT; si lo hago se guarada en la base de datos*/
END incrementar_salario;
/
/*LLAMADA*/

BEGIN
       incrementar_salario(10);
       dbms_output.put_line('A SIDO ACTUALIZADO');
END;
/
/*12 Insertar un empleado en la tabla EMP. Su número será superior a los existentes y
la fecha de incorporaron en la empresa será la actual.*/


DECLARE
 N_EMPLEADO NUMBER;
    NOMBRE VARCHAR2(50):='PEPITO';
    TRABAJO VARCHAR2(50);
    MGR NUMBER;
    HIREDATE DATE TO_DATE DEFAULT('2025-01-01','YYYY-MM-DD');
    SALARIO NUMBER:=500;
    
    /*TIENE QUE TENER TODAS LAS COLUMNAS DE LA TABAL O SALDRA NULL O ERRORES POR RESTRICCIONES*/
BEGIN
    SELECT (MAX(EMPNO)) +1 
    INTO N_EMPLEADO 
    FROM EMP;
    
    INSERT INTO EMP (EMPNO , ENAME, JOB,MGR,HIREDATE,SAL,COMM,DEPTNO)
    VALUES (N_EMPLEADO, NOMBRE, SALARIO);
    
END; 

SELECT *
FROM EMP;

/*13: Codificar un procedimiento que permita borrar un empleado cuyo número se
pasará en la llamada*/

CREATE OR REPLACE PROCEDURE BORRAR_EMPLEADO(N_EMPLEADO NUMBER ) 
IS
BEGIN
    DELETE FROM EMP
    WHERE EMPNO = N_EMPLEADO;

    --COMMIT;
END BORRAR_EMPLEADO;
/

/*LLAMADA PARA BORRA*/
DECLARE
PRUEBA NUMBER;
BEGIN
PRUEBA:=7935;
BORRAR_EMPLEADO(PRUEBA);
END;

/*Ejercicio 14: Escribir un procedimiento que modifique la localidad de un departamento. El
procedimiento recibirá como parámetros el número del departamento y la localidad nueva*/

CREATE OR REPLACE PROCEDURE CAMBIO_LOCALIDAD(N_DEPARTAMENTO IN NUMBER ,N_LOCALIDAD IN  VARCHAR2 )
IS
BEGIN
UPDATE DEPT
SET LOC =N_LOCALIDAD
WHERE DEPTNO=N_DEPARTAMENTO;

END CAMBIO_LOCALIDAD;

/*LLAMADA*/
DECLARE
PRUEBA_NUMERO NUMBER:=10;
PRUEBA_LOCALIDAD VARCHAR2(70):='PRUEBA';
BEGIN
CAMBIO_LOCALIDAD(PRUEBA_NUMERO,PRUEBA_LOCALIDAD);
END;

/*Ejercicio 15: Visualizar todos los procedimientos y funciones del usuario almacenados en la
base de datos y su situación (valid o invalid)*/


DESCRIBE dictionary;

SELECT * 
FROM  dictionary 
WHERE table_name = 'USER_OBJECTS';

SELECT table_name 
FROM  dictionary
WHERE LOWER(comments) LIKE '%columns%';

SELECT OBJECT_NAME, OBJECT_TYPE, STATUS
FROM USER_OBJECTS
WHERE OBJECT_TYPE IN ('PROCEDURE', 'FUNCTION');

SELECT OBJECT_NAME, OBJECT_TYPE 
FROM   USER_OBJECTS
WHERE OBJECT_TYPE IN ('PROCEDURE', 'FUNCTION')
ORDER BY OBJECT_NAME;


rollback;