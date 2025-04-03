SET SERVEROUTPUT ON;

/*Crea un bloque anónimo que:

Declare una variable para almacenar el salario de un empleado.
Obtenga el salario del empleado cuyo apellido sea 'GARCÍA' desde una tabla ficticia empleados.
Si el salario es menor a 50,000, muestra un mensaje indicando que su salario es bajo. Usa DBMS_OUTPUT.PUT_LINE.*/

DECLARE
PL_SAL NUMBER;
BEGIN
SELECT SAL INTO PL_SAL
FROM EMP
WHERE ENAME='ALLEN';

IF PL_SAL<5000 THEN
DBMS_OUTPUT.PUT_LINE('EL SALARIO DE ALLEN ES BAJO ' || PL_SAL);
ELSE
DBMS_OUTPUT.PUT_LINE('EL SALARIO DE ALLEN ES'|| PL_SAL);
END IF;
END;
/
/*Crea un bloque anónimo que:

Actualice el salario de todos los empleados de la tabla empleados cuya categoría sea 'JUNIOR' incrementándolo en un 10%.
Muestra un mensaje indicando cuántas filas se actualizaron usando SQL%ROWCOUNT.
Usa un COMMIT para confirmar los cambios.*/

DECLARE
FILAS_ACTUALIZADAS NUMBER;

BEGIN
UPDATE EMP
SET SAL =SAL*1.10
WHERE JOB='SALESMAN';

/*SQL%ROWCOUNT  SOLO CUENTA LAS FILAS AFECTADAS*/
FILAS_ACTUALIZADAS:=SQL%ROWCOUNT;
DBMS_OUTPUT.PUT_LINE('FILAS ACTUALIZADAS: '|| FILAS_ACTUALIZADAS);

COMMIT;
END;
/

/*
¡Entendido! Aquí tienes los ejercicios adaptados para que estén más relacionados con Oracle SQL Developer y la base de datos. Todos implican el uso de consultas SQL dentro de bloques PL/SQL.

Ejercicio 1: Consulta con una variable
Crea un bloque anónimo que:

Declare una variable para almacenar el salario de un empleado.
Obtenga el salario del empleado cuyo apellido sea 'GARCÍA' desde una tabla ficticia empleados.
Si el salario es menor a 50,000, muestra un mensaje indicando que su salario es bajo. EE.UU DBMS_OUTPUT.PUT_LINE.
sql

Copiar

Editar
DECLARE
    salario NUMBER(10);
BEGIN
    SELECT sueldo INTO salario
    FROM empleados
    WHERE apellido = 'GARCÍA';
    
    IF salario < 50000 THEN
        DBMS_OUTPUT.PUT_LINE('El salario de GARCÍA es bajo: ' || salario);
    ELSE
        DBMS_OUTPUT.PUT_LINE('El salario de GARCÍA es adecuado: ' || salario);
    END IF;
END;
/
Ejercicio 2: Actualización condicional
Crea un bloque anónimo que:

Actualice el salario de todos los empleados de la tabla empleadoscuya categoría sea 'JUNIOR' incrementándolo en un 10%.
Muestra un mensaje indicando cuántas filas se actualizarán usando SQL%ROWCOUNT.
Usa un COMMITpara confirmar los cambios.
sql

Copiar

Editar
DECLARE
    filas_actualizadas NUMBER;
BEGIN
    UPDATE empleados
    SET sueldo = sueldo * 1.10
    WHERE categoria = 'JUNIOR';

    filas_actualizadas := SQL%ROWCOUNT;

    DBMS_OUTPUT.PUT_LINE('Filas actualizadas: ' || filas_actualizadas);

    COMMIT;
END;
/
Ejercicio 3: Manejo de excepciones con consultas
Crea un bloque anónimo que:

Busque el salario del empleado con ID 101 desde la tabla empleados.
Si el empleado no existe, captura la excepción NO_DATA_FOUNDy muestra 
un mensaje de error.*/


DECLARE
PL_SALEMPLEADO NUMBER;
/*SE OUEDE HACER CON SOLO UN BEGIN*/
BEGIN/*PARA LAS INSTRUCCIONES GENER*/
    BEGIN/*INTERNO PARA CAPTURAR EL ERROR*/
    SELECT SAL INTO PL_SALEMPLEADO
    FROM EMP
    WHERE EMPNO='7369';
    
    DBMS_OUTPUT.PUT_LINE('EL SALARIO DEL EMPLEADO EMPNO 7369 ES: '||PL_SALEMPLEADO);

EXCEPTION
    WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('NO HAY EMMPLEADO');
    END;
END;
/

/*Bloques anidados
Crea un bloque anónimo que:

En el bloque principal, declare una variable para un departamento
(por ejemplo, 'Ventas').En un subbloque, obtenga el número total
de empleados en ese departamento desde la tabla empleadosy muestra
el resultado.Maneja cualquier error que pueda ocurrir en el
subbloque (por ejemplo, si el departamento no existe).*/

DECLARE
DEPARTAMENTO NUMBER :='20';
TOTAL_EMPLEADOS NUMBER;
BEGIN
    BEGIN
        SELECT COUNT(EMPNO) INTO TOTAL_EMPLEADOS
        FROM EMP
        WHERE DEPTNO=DEPARTAMENTO;
        dbms_output.put_line('TOTAL DE EMPLEADOS ES: '|| TOTAL_EMPLEADOS);
    
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
        dbms_output.put_line('ERROR NO HAY EPARTAMENTO');
    END;
END;
/

/*----------------------------------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------------------------------*/
/* Uso básico de variables
Crea un bloque anónimo que:

Declare una variable para almacenar un porcentaje de descuento 
( NUMBER) y otra para almacenar el precio final ( NUMBER).
Inicializa el porcentaje de descuento con un valor del 10%.
Supón que el precio original es 200. Calcula el precio final 
aplicando el descuento y muestra el resultado usando 
DBMS_OUTPUT.PUT_LINE.*/

DECLARE
DESCUENTO NUMBER(7,2):=10;
PRECIO_FINAL NUMBER;
BEGIN
PRECIO_FINAL:=200-(200*descuento/100);
dbms_output.put_line('EL PRECIO FINAL CON DESCUENTO ES: '||PRECIO_FINAL);
END;
/

/*Variables con %TYPE
Crea un bloque anónimo que:

Declare una variable del mismo tipo que la columna
sueldo de la tabla empleados, utilizando %TYPE.
Obtenga el sueldo de un empleado con apellido 'MARTÍNEZ'.
Incrementa el sueldo en un 15% y muestra el nuevo
sueldo usando DBMS_OUTPUT.PUT_LINE.*/



DECLARE 
SALARIO_ACTUAL EMP.SAL%TYPE;
NUEVO_SALARIO EMP.SAL%TYPE;
BEGIN
SELECT SAL INTO SALARIO_ACTUAL
FROM EMP
WHERE ENAME='MARTIN';

NUEVO_SALARIO:=SALARIO_ACTUAL*1.15;
dbms_output.put_line('EL SALARIO ACTUAL ES: '|| SALARIO_ACTUAL);

dbms_output.put_line('EL SALARIO CON UNA SUBIDA DEL 15% ES: '|| NUEVO_SALARIO);
END;
/

/* Uso de constantes
Crea un bloque anónimo que:

Declare una constante IVA(21%) y otra DESCUENTO(10%).
Declare una variable precio_inicialcon valor 500 y 
otra precio_finalque calculará el precio después de
aplicar IVA y descuento.Muestra el precio final usando
DBMS_OUTPUT.PUT_LINE.*/


DECLARE 

IVA CONSTANT NUMBER(7,2):=21;
DESCUENTO CONSTANT NUMBER(7.2):=10;
PRECIO_INICIAL NUMBER(10,2):=500;
PRECIO_FINAL NUMBER(10,2);
BEGIN
precio_final := precio_inicial + (precio_inicial * IVA / 100) - (precio_inicial * DESCUENTO / 100);
    DBMS_OUTPUT.PUT_LINE('El precio final con IVA y descuento es: ' || precio_final);
END;
/


/*Uso de %ROWTYPE
Crea un bloque anónimo que:

Declare una variable tipo registro para cargar una fila 
completa de la tabla empleadosusando %ROWTYPE.
Obtenga todos los datos del empleado con empleado_id = 102.
Muestra el apellido y el sueldo del empleado usando
DBMS_OUTPUT.PUT_LINE.*/

DECLARE 

ROW_EMPLEADOS EMP%ROWTYPE;

BEGIN
SELECT * INTO ROW_EMPLEADOS
FROM EMP
WHERE ENAME='SMITH';
dbms_output.put_line('PARA SACAR LOS DATOS DE ROWTYPE DEBES ACCEDER A LOS VALORES CON VARIABLEROW.COLUMANA ASIU--->: '|| row_empleados.ENAME ||'   '|| row_empleados.JOB);
END;
/








