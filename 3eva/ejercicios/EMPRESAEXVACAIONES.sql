/*PL/SQL EJERCICIOS I*/
/*Ejercicio 1: Realizar nuestro primer bloque pl/sql , que bos visualiza, dis, mes y año
actual, El mes será con nombre.*/
DECLARE
        vfecha DATE;
BEGIN
        vfecha := sysdate;
        dbms_output.put_line(TO_DATE(vfecha, 'DD-MM-YYYY'));
END;
/

/*Ejercicio 2: Crear un bloque de PL/SQL que permite visualizar el salario de KING ,utilizando las
tablas de empleados.*/
DECLARE
        vking emp.sal%TYPE;
BEGIN
        SELECT
                sal
        INTO vking
        FROM
                emp
        WHERE
                ename = 'KING';

        dbms_output.put_line('SALARIO  ' || vking);
END;

/*Ejercicio 3: Crear un bloque de PL/SQL que permite visualizar el salario que dese eel usaurio
utilizando las tablas de empleados.
*/
DECLARE
        vename emp.ename%TYPE;
        vsal   emp.sal%TYPE;
BEGIN
        vename := 'KING';
        SELECT
                sal
        INTO vsal
        FROM
                emp
        WHERE
                ename = vename;

        dbms_output.put_line('SALARIO ' || vsal);
END;

/*Ejercicio 4: Realizar un bloque Pl/SQL que reciba una cadena y la escriba al revés*/

DECLARE
        cadena_original VARCHAR2(100) := 'Hola Mundo';
        cadena_reves    VARCHAR2(100) := '';
BEGIN
        FOR i IN REVERSE 1..length(cadena_original) LOOP
                cadena_reves := cadena_reves ||
                substr(cadena_original, i, 1);
        END LOOP;

        dbms_output.put_line('Cadena original: ' || cadena_original);
        dbms_output.put_line('Cadena al revés: ' || cadena_reves);
END;
/
/*UT6: Programación con Bases de Datos: PL/SQL */
/*Ejercicio 1 Identificar en el siguiente ejemplo los siguientes elementos:
• la cabecera del procedimiento
• los parámetros del procedimiento
• ¿qué hace la expresión (precioant * 0.20) > ABS (precioant – nuevoprecio)?
• ¿por qué no tiene la cláusula DECLARE? ¿qué tiene en su lugar?
*/
CREATE OR REPLACE
PROCEDURE modificar_precio_producto (codigoprod NUMBER, nuevoprecio NUMBER)
AS
precioant NUMBER(5);
BEGIN
SELECT precio_uni INTO precioant
FROM productos
WHERE cod_producto = codigoprod;
IF (precioant * 0.20) > ABS (precioant – nuevoprecio) THEN
UPDATE productos SET precio_uni = nuevoprecio
1
Bases de datos. 1DAW
Profesora: Sonia Aranda Santos
2 1
WHERE cod_producto = codigoprod;
ELSE
DBMS_OUTPUT.PUT_LINE (‘Error, modificacion superior al 20%’);
END IF;
END modificar_precio_producto;
/*Ejercicio 2: Realizar un procedimiento cambiar_oficio al que le pasamos el numero de empleado
y el nuevo oficio, y actualizara dicho dato en la base de datos.
La ejecución de este procedimiento se debe hacer de dos formas:
1. Desde la linea de comandos pasándole 2 valorescualesquier
2. Desde otro bloque que nos pide los datos porteclado.*/
/
CREATE OR REPLACE PROCEDURE CAMBIAR_OFICIO (
   NEMPLEADO IN EMP.EMPNO%TYPE,
   NOFICIO   IN EMP.JOB%TYPE
)
IS
BEGIN
   UPDATE EMP
   SET JOB = NOFICIO
   WHERE EMPNO = NEMPLEADO;

IF SQL%ROWCOUNT = 0 THEN
      DBMS_OUTPUT.PUT_LINE('NO SE ENCONTRÓ EMPLEADO');
   ELSE
      DBMS_OUTPUT.PUT_LINE('ACTUALIZADO CORRECTAMENTE');
   END IF;
EXCEPTION

   WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/


/* 2. Llamarlo desde la línea de comandos*/

BEGIN
   cambiar_oficio(7369, 'ANALISTAS');
END;
/

/*3. Usarlo desde otro bloque que pide datos por teclado*/

DECLARE
  VNUMERO EMP.EMPNO%TYPE;
 VJOB EMP.JOB%TYPE;
BEGIN
   VNUMERO := &introduce_num_empleado;
   VJOB := '&introduce_nuevo_oficio';

   cambiar_oficio(VNUMERO, VJOB);
END;
/
/*Programación con Bases de Datos: PL/SQL
EJERCICIOS II 
Colección de ejercicios procedimientos y funciones Archivo*/
/*Ejercicio 1: Indicar los errores que aparecen en las siguientes instrucciones y la forma de
corregirlos.*/

DECLARE
 Num1 NUMBER(8,2) := 0
 Num2 NUMBER(8,2) NOT NULL DEFAULT 0;
 Num3 NUMBER(8,2) NOT NULL;
 Cantidad INTEGER(3);
 Precio, Descuento NUMBER(6);
 Num4 Num1%ROWTYPE;
 Dto CONSTANT INTEGER;
BEGIN
 ...
END; 

DECLARE
 Num1 NUMBER(8,2) := 0;
 Num2 NUMBER(8,2) NOT NULL DEFAULT 0;
 Num3 NUMBER(8,2) NOT NULL := 0;
 Cantidad INTEGER;
 Precio NUMBER(6);
 Descuento NUMBER(6);
 -- Num4 eliminado o corregido con referencia válida
 -- Ejemplo: Num4 tabla_ejemplo%ROWTYPE;
 Dto CONSTANT INTEGER := 10;
BEGIN
  ...
END;
/*Ejercicio 2: Escribir un procedimiento que reciba dos números y visualice su suma.*/
/

/
DECLARE
CREATE OR REPLACE PROCEDURE SUMA(V1 IN NUMBER,V2 IN NUMBER)
IS
VSUMA NUMBER;
BEGIN
VSUMA:=V1+V2;
DBMS_OUTPUT.PUT_LINE('LA SUMA ES----->' ||VSUMA);

END;
/
DECLARE
BEGIN
SUMA(2,1);
END;
/

/*Ejercicio 4: Escribir una funcion que reciba una fecha y devuelva el año, en número,
correspondiente a esa fecha. */
/

CREATE OR REPLACE FUNCTION AÑO (PFECHA IN DATE)
RETURN NUMBER
IS
VAÑO NUMBER;
BEGIN
VAÑO:=TO_NUMBER(TO_CHAR(PFECHA,'YYYY'));
RETURN VAÑO;
END AÑO;
/

/
/*Ejercicio 5: Escribir un bloque PL/SQL que haga uso de la función anterior. */


DECLARE
  VRESULTADOAÑO NUMBER;
BEGIN
  VRESULTADOAÑO := AÑO(SYSDATE);
  DBMS_OUTPUT.PUT_LINE('Año actual: ' || VRESULTADOAÑO);
END;
/
-- Bloque PL/SQL que pide una fecha y usa la función
DECLARE
  VAÑO EMP.HIREDATE%TYPE;  -- Usa el tipo de dato DATE
  VRESULTADOAÑO NUMBER;
BEGIN
  VAÑO := TO_DATE('&Introduce_fecha', 'DD/MM/YYYY');  -- Conversión de cadena a DATE
  VRESULTADOAÑO := AÑO(VAÑO);
  DBMS_OUTPUT.PUT_LINE('Año introducido: ' || VRESULTADOAÑO);
END;
/
/*Ejercicio 6: Dado el siguiente procedimiento:
CREATE OR REPLACE PROCEDURE crear_depart (
 v_num_dept depart.dept_no%TYPE,
 v_dnombre depart.dnombre%TYPE DEFAULT 'PROVISIONAL',
 v_loc depart.loc%TYPE DEFAULT ‘PROVISIONAL’)
IS
BEGIN
 INSERT INTO depart
 VALUES (v_num_dept, v_dnombre, v_loc);
END crear_depart;
Indicar cuáles de las siguientes llamadas son correctas y cuáles incorrectas, en este último caso
escribir la llamada correcta usando la notación posicional (en los casos que se pueda):
1. crear_depart;
2. crear_depart(50);
3. crear_depart('COMPRAS');
4. crear_depart(50,'COMPRAS');
5. crear_depart('COMPRAS', 50);
6. crear_depart('COMPRAS', 'VALENCIA');
7. crear_depart(50, 'COMPRAS', 'VALENCIA');
8. crear_depart('COMPRAS', 50, 'VALENCIA');
9. crear_depart('VALENCIA', ‘COMPRAS’);
10.crear_depart('VALENCIA', 50); 
*/
# | Llamada | ¿Correcta? | Explicación | Corrección si es incorrecta
1 | crear_depart; | ❌ | Falta el parámetro obligatorio v_num_dept. | crear_depart(50);
2 | crear_depart(50); | ✅ | Correcta. Solo se da v_num_dept, los otros toman su valor por defecto. | -
3 | crear_depart('COMPRAS'); | ❌ | El primer parámetro debería ser numérico (dept_no). | crear_depart(50, 'COMPRAS');
4 | crear_depart(50,'COMPRAS'); | ✅ | Correcta. El tercero (v_loc) toma el valor por defecto. | -
5 | crear_depart('COMPRAS', 50); | ❌ | Orden incorrecto de los tipos. Se espera número, cadena, cadena. | crear_depart(50, 'COMPRAS');
6 | crear_depart('COMPRAS', 'VALENCIA'); | ❌ | Faltan los valores correctos en orden: primero un número. | crear_depart(50, 'COMPRAS', 'VALENCIA');
7 | crear_depart(50, 'COMPRAS', 'VALENCIA'); | ✅ | Correcta. Todos los parámetros se proporcionan correctamente. | -
8 | crear_depart('COMPRAS', 50, 'VALENCIA'); | ❌ | Orden incorrecto. v_num_dept debe ser numérico. | crear_depart(50, 'COMPRAS', 'VALENCIA');
9 | crear_depart('VALENCIA', 'COMPRAS'); | ❌ | Mismo problema: v_num_dept no es un número. | crear_depart(50, 'VALENCIA', 'COMPRAS');
10 | crear_depart('VALENCIA', 50); | ❌ | v_num_dept debe ser el primer parámetro y numérico. | crear_depart(50, 'VALENCIA');
/*Ejercicio 7: Desarrollar una función que devuelva el número de años completos que hay entre
dos fechas que se pasan como argumentos. */
/
CREATE OR REPLACE FUNCTION NUMAÑOS (
  p_fecha1 IN EMP.HIREDATE%TYPE,
  p_fecha2 IN EMP.HIREDATE%TYPE
) RETURN NUMBER
IS
  v_dias   NUMBER;
  v_anios  NUMBER;
BEGIN
  -- Calculamos la diferencia en días (resta directa entre fechas)
  v_dias := ABS(p_fecha1 - p_fecha2);

  -- Convertimos los días en años aproximados (365 días por año)
  v_anios := TRUNC(v_dias / 365);
/*
VAÑOS:=TRUNC(ABS(MONTHS_BETWEEN(PFECHA1,PFECHA2))/12);*/
  RETURN v_anios;
END NUMAÑOS;
/
DECLARE
BEGIN
  DBMS_OUTPUT.PUT_LINE('Años completos: ' ||
    NUMAÑOS(DATE '2010-04-15',DATE '2020-04-14')); -- Debería dar 9
END;
/

/*Ejercicio 8: Escribir una función que, haciendo uso de la función anterior devuelva los trienios
que hay entre dos fechas. (Un trienio son tres años completos). */
/
/*CREATE OR REPLACE FUNCTION TRIENIOS (
  p_fecha1 IN DATE,
  p_fecha2 IN DATE
) RETURN NUMBER
IS
  v_anios   NUMBER;
  v_trienios NUMBER;
BEGIN
  -- Usamos la función anterior para calcular los años completos
  v_anios := anios_entre_fechas(p_fecha1, p_fecha2);
  
  -- Calculamos los trienios (dividimos entre 3)
  v_trienios := TRUNC(v_anios / 3);
  
  RETURN v_trienios;
END TRIENIOS;
/
*/
CREATE OR REPLACE FUNCTION TRIENIOS
RETURN NUMBER
IS
  VTRIENIOS NUMBER;
  VAÑOS NUMBER;
BEGIN
  -- Llamamos a la función NUMAÑOS con fechas fijas (sin parámetros)
  VAÑOS := NUMAÑOS(DATE '2010-04-15', DATE '2020-04-14');
  
  -- Calculamos los trienios (dividimos entre 3)
  VTRIENIOS := TRUNC(VAÑOS / 3);
  
  -- Retornamos el número de trienios
  RETURN VTRIENIOS;
END TRIENIOS;
/

DECLARE
  VTRIENIOS NUMBER;
BEGIN
  -- Llamamos a la función TRIENIOS
  VTRIENIOS := TRIENIOS();
  
  -- Muestra el número de trienios calculados
  DBMS_OUTPUT.PUT_LINE('El número de trienios es: ' || VTRIENIOS);
END;
/
/*Ejemplo de cómo definir ambas funciones dentro de un bloque anónimo:*/
DECLARE
  -- Definimos la función NUMAÑOS dentro del bloque anónimo
  FUNCTION NUMAÑOS (
    p_fecha1 IN DATE,
    p_fecha2 IN DATE
  ) RETURN NUMBER
  IS
    v_dias NUMBER;
  BEGIN
    v_dias := p_fecha2 - p_fecha1;  -- Diferencia en días
    RETURN v_dias / 365;  -- Convertir días a años
  END NUMAÑOS;

  -- Definimos la función TRIENIOS dentro del bloque anónimo
  FUNCTION TRIENIOS RETURN NUMBER IS
    VTRIENIOS NUMBER;
    VAÑOS NUMBER;
  BEGIN
    -- Llamamos a la función NUMAÑOS con fechas fijas
    VAÑOS := NUMAÑOS(DATE '2010-04-15', DATE '2020-04-14');
    
    -- Calculamos los trienios (dividimos entre 3)
    VTRIENIOS := TRUNC(VAÑOS / 3);
    
    -- Retornamos el número de trienios
    RETURN VTRIENIOS;
  END TRIENIOS;

  -- Variable para almacenar el resultado
  v_trienios NUMBER;

BEGIN
  -- Llamamos a la función TRIENIOS
  v_trienios := TRIENIOS();
  
  -- Mostramos el resultado
  DBMS_OUTPUT.PUT_LINE('El número de trienios es: ' || v_trienios);
END;
/
/*Ejercicio 9: Añadir la columna total2 y en ella escribir la suma del salario y la comisión de los
empleados con comisión distinta a 0*/
ALTER TABLE EMP
ADD(TOTAL2 NUMBER);
ALTER TABLE EMP DROP COLUMN TOTAL2;
/
BEGIN
  UPDATE EMP
  SET TOTAL2 = NVL(SAL, 0) + NVL(COMM, 0)
  WHERE COMM <> 0;
END;
/
/*Ejercicio 10: Escribir una función que devuelva solamente caracteres alfabéticos sustituyendo
cualquier otro carácter por blancos a partir de una cadena que se pasará en la llamada. */
CREATE OR REPLACE FUNCTION CADENITA(PCADENA IN VARCHAR2)
RETURN VARCHAR2
IS
VAUXCADENA VARCHAR2(200);
BEGIN
  VAUXCADENA := REGEXP_REPLACE(PCADENA, '[^A-Za-z]', ' ');
RETURN VAUXCADENA;
/*
FOR I IN 1..LENGTH(PCADENA) LOOP
    VLETRA := SUBSTR(PCADENA, I, 1);
    IF (ASCII(VLETRA) BETWEEN ASCII('A') AND ASCII('Z')) OR 
       (ASCII(VLETRA) BETWEEN ASCII('a') AND ASCII('z')) THEN
      VAUXCADENA := VAUXCADENA || VLETRA;
    ELSE
      VAUXCADENA := VAUXCADENA || ' ';
    END IF;
  END LOOP;
  RETURN VAUXCADENA;
  */
END CADENITA;
/
BEGIN
  DBMS_OUTPUT.PUT_LINE(CADENITA('H0l@, ¿qu3 t4l? #DAW2025!'));
END;
/
/*Ejercicio 11: Realizar un procedimiento que incremente el salario de los empleados que tengan
una comisión superior al 5% del salario, en un x% .
El valor de x lo debe especificar el usuario. */

CREATE OR REPLACE PROCEDURE INCREMENTO(PPORCENTAJE IN NUMBER)
IS
BEGIN
  UPDATE EMP
  SET SAL = SAL + (SAL * PPORCENTAJE) / 100
  WHERE COMM > (SAL * 5) / 100;
END INCREMENTO;
/
BEGIN
  INCREMENTO(1120);
END;
/

/*Ejercicio 12: Insertar un empleado en la tabla EMP. Su número será superior a los existentes y
la fecha de incorporaron en la empresa será la actual. */
DECLARE
  VEMPNO   EMP.EMPNO%TYPE;
  VDEPTNO  EMP.DEPTNO%TYPE;
BEGIN
  -- Obtener el número de empleado más alto y un departamento válido
  SELECT MAX(EMPNO), MAX(DEPTNO) INTO VEMPNO, VDEPTNO
  FROM EMP;

  -- Insertar nuevo empleado
  INSERT INTO EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
  VALUES (VEMPNO + 1, 'PEPE', 'MANAGER', NULL, SYSDATE, 1000, NULL, VDEPTNO);
END;
/
/*Ejercicio 13: Codificar un procedimiento que permita borrar un empleado cuyo número se
pasará en la llamada. */
CREATE OR REPLACE PROCEDURE BORRAR(PEMPNO IN EMP.EMPNO%TYPE)
IS

BEGIN
DELETE FROM EMP
WHERE EMPNO=PEMPNO;

END;
/
DECLARE
BEGIN
BORRAR(8013);
END;
/*Ejercicio 14: Escribir un procedimiento que modifique la localidad de un departamento. El
procedimiento recibirá como parámetros el número del departamento y la localidad nueva. 
*/

CREATE OR REPLACE PROCEDURE MODIFICARLOC(PDEPTNO IN DEPT.DEPTNO%TYPE,PLOCNUEVA IN DEPT.LOC%TYPE)
IS

BEGIN
UPDATE DEPT
SET LOC=PLOCNUEVA
WHERE DEPTNO=PDEPTNO;
END;
/
BEGIN
MODIFICARLOC(65,'MANHATA');
END;
/*Ejercicio 15: Visualizar todos los procedimientos y funciones del usuario almacenados en la
base de datos y su situación (valid o invalid).*/
select * from user_tables;
SELECT OBJECT_NAME, OBJECT_TYPE, STATUS
FROM USER_OBJECTS;

/*Programación con Bases de Datos: PL/SQL
EJERCICIOS III

Para la realización de los ejercicios de esta hoja vamos a utilizar las table EMP y DEPT de Oracle
*/
/*Ejercicio 1: Desarrollar un procedimiento que visualice el apellido y la fecha de alta de todos los empleados ordenados por apellido.*/
/
DECLARE
CURSOR CVER IS
SELECT ENAME,HIREDATE 
FROM EMP
ORDER BY ENAME;
VAUXENAME EMP.ENAME%TYPE;
VAUXHIREDATE EMP.HIREDATE%TYPE;
PROCEDURE VER
IS
BEGIN
OPEN CVER;
FETCH CVER INTO VAUXENAME,VAUXHIREDATE;
WHILE CVER%FOUND LOOP
DBMS_OUTPUT.PUT_LINE('APELLIDOS----'|| VAUXENAME||'  FECHA----'||VAUXHIREDATE);
FETCH CVER INTO VAUXENAME,VAUXHIREDATE;
END LOOP;
CLOSE CVER;
END;
BEGIN
VER;
END;
/
DECLARE
CURSOR CVER IS
SELECT * FROM EMP
ORDER BY ENAME;
VAUX EMP%ROWTYPE;
PROCEDURE VER
IS
BEGIN
OPEN CVER;
FETCH CVER INTO VAUX;
WHILE CVER%FOUND LOOP
DBMS_OUTPUT.PUT_LINE('APELLIDO---'||VAUX.ENAME||'**/**FECHA----'||VAUX.HIREDATE);
FETCH CVER INTO VAUX;
END LOOP;
CLOSE CVER;
END;
BEGIN
VER;
END;
/*Ejercicio 2: Codificar un procedimiento que muestre el nombre de cada departamento y el número de empleados que tiene.*/
DECLARE
CURSOR CVER IS
SELECT D.DNAME,COUNT(E.EMPNO) AS NUMERO_EMPLEADOS
FROM DEPT D
INNER JOIN EMP E ON D.DEPTNO=E.DEPTNO
GROUP BY D.DNAME;
VAUX CVER%ROWTYPE;
PROCEDURE VER
IS
BEGIN
OPEN CVER;
FETCH CVER INTO VAUX;
WHILE CVER%FOUND LOOP
DBMS_OUTPUT.PUT_LINE('NOMBRE DEPTNO---'||VAUX.DNAME||'**/**NUM EMPLEADOS---'||VAUX.NUMERO_EMPLEADOS);
FETCH CVER INTO VAUX;
END LOOP;
CLOSE CVER;
END;
BEGIN
VER;
END;

/*	Ejercicio 3: Escribir un procedimiento que reciba una cadena y visualice el apellido y el número de empleado de todos los empleados
cuyo apellido contenga la cadena especificada. Al finalizar visualizar el número de empleados mostrados.*/

DECLARE
--PENAME EMP.ENAME%TYPE:='A';
--CURSOR CVER IS
--SELECT * FROM EMP;
--WHERE ENAME LIKE '%'||'A'||'%';
--VAUX CVER%ROWTYPE;
PROCEDURE VER(PENAME IN EMP.ENAME%TYPE)
IS
CURSOR CVER IS
SELECT * FROM EMP
WHERE ENAME LIKE '%'||PENAME||'%';
VAUX CVER%ROWTYPE;
BEGIN
OPEN CVER;
FETCH CVER INTO VAUX;
WHILE CVER%FOUND LOOP
DBMS_OUTPUT.PUT_LINE('NOMBRE---'||VAUX.ENAME||'**/**NUM EMPLEADO---'||VAUX.EMPNO);
FETCH CVER INTO VAUX;
END LOOP;
CLOSE CVER;
END;
BEGIN
VER('A');
--VER;
END;
/*Ejercicio 4: Escribir un programa que visualice el apellido y el salario de los cinco empleados que tienen el salario más alto.*/

DECLARE
CURSOR CVER IS
SELECT ENAME,SAL
FROM (SELECT ENAME,SAL
FROM EMP
ORDER BY SAL DESC)
WHERE ROWNUM<=5;
VAUX CVER%ROWTYPE;
PROCEDURE VER
IS
BEGIN
OPEN CVER;
FETCH CVER INTO VAUX;
WHILE CVER%FOUND LOOP
DBMS_OUTPUT.PUT_LINE('NOMBRE----'||VAUX.ENAME||'/*/*SALARIO----'||VAUX.SAL);
FETCH CVER INTO VAUX;
END LOOP;
CLOSE CVER;
END;
BEGIN
VER;
END;
/
DECLARE
CURSOR CVER IS
SELECT ENAME,SAL
FROM (SELECT ENAME,SAL
FROM EMP
ORDER BY SAL DESC)
WHERE ROWNUM<=5;
VAUXENAME EMP.ENAME%TYPE;
VAUXSAL EMP.SAL%TYPE;
PROCEDURE VER
IS
BEGIN
OPEN CVER;
FETCH CVER INTO VAUXENAME,VAUXSAL;
WHILE CVER%FOUND LOOP
DBMS_OUTPUT.PUT_LINE('NOMBRE----'||VAUXENAME||'/*/*SALARIO----'||VAUXSAL);
FETCH CVER INTO VAUXENAME,VAUXSAL;
END LOOP;
CLOSE CVER;
END;
BEGIN
VER;
END;

/*	Ejercicio 6: Escribir un programa que muestre. El listado será utilizando rupturas de control.*********
	
•	Para cada empleado: apellido y salario.
•	Para cada departamento: Número de empleados y suma de los salarios del departamento.
•	Al final del listado: Número total de empleados y suma de todos los salarios.
*/
SELECT ENAME,SAL
FROM EMP;

SELECT  DEPTNO,COUNT(EMPNO)AS NUMERO_EMPLEADOS,SUM(SAL)AS SALSARIO_DEPARTAMENTO
FROM EMP
GROUP BY DEPTNO;

SELECT COUNT(EMPNO)AS TOTAL_EMPLEADO,SUM(SAL)AS TOTAL_SALARIO
FROM EMP;

/
DECLARE 
    CURSOR CVER IS
        SELECT ENAME, SAL, DEPTNO
        FROM EMP
        ORDER BY DEPTNO; -- importante para rupturas

    VAUXCVER CVER%ROWTYPE;

    PROCEDURE VER
    IS
        VAUXDEPTNO EMP.DEPTNO%TYPE := NULL;

        -- Acumuladores por departamento
        v_total_dep NUMBER := 0;
        v_suma_dep NUMBER := 0;

        -- Acumuladores generales
        v_total_general NUMBER := 0;
        v_suma_general NUMBER := 0;
    BEGIN
        OPEN CVER;
        FETCH CVER INTO VAUXCVER;

        WHILE CVER%FOUND LOOP
            -- Ruptura de control
            IF VAUXDEPTNO IS NOT NULL AND VAUXDEPTNO != VAUXCVER.DEPTNO THEN
                DBMS_OUTPUT.PUT_LINE('TOTAL EMPLEADOS DEPARTAMENTO ' || VAUXDEPTNO || ': ' || v_total_dep);
                DBMS_OUTPUT.PUT_LINE('TOTAL SALARIO DEPARTAMENTO ' || VAUXDEPTNO || ': ' || v_suma_dep);
                DBMS_OUTPUT.PUT_LINE('----------------------------------------');

                -- Reiniciar acumuladores por depto
                v_total_dep := 0;
                v_suma_dep := 0;
            END IF;

            -- Mostrar datos del empleado
            DBMS_OUTPUT.PUT_LINE('APELLIDO EMPLEADO: ' || VAUXCVER.ENAME || ' - SALARIO: ' || VAUXCVER.SAL);

            -- Acumular
            v_total_dep := v_total_dep + 1;
            v_suma_dep := v_suma_dep + VAUXCVER.SAL;

            v_total_general := v_total_general + 1;
            v_suma_general := v_suma_general + VAUXCVER.SAL;

            -- Guardar departamento actual
            VAUXDEPTNO := VAUXCVER.DEPTNO;

            FETCH CVER INTO VAUXCVER;
        END LOOP;

        -- Mostrar último departamento
        IF VAUXDEPTNO IS NOT NULL THEN
            DBMS_OUTPUT.PUT_LINE('TOTAL EMPLEADOS DEPARTAMENTO ' || VAUXDEPTNO || ': ' || v_total_dep);
            DBMS_OUTPUT.PUT_LINE('TOTAL SALARIO DEPARTAMENTO ' || VAUXDEPTNO || ': ' || v_suma_dep);
            DBMS_OUTPUT.PUT_LINE('----------------------------------------');
        END IF;

        -- Totales generales
        DBMS_OUTPUT.PUT_LINE('>> TOTAL GENERAL EMPLEADOS: ' || v_total_general);
        DBMS_OUTPUT.PUT_LINE('>> SUMA TOTAL SALARIOS: ' || v_suma_general);

        CLOSE CVER;
         EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Ha ocurrido un error dentro del procedimiento VER: ' || SQLERRM);
            IF CVER%ISOPEN THEN
                CLOSE CVER;
            END IF;
    END;
    

BEGIN
    VER;
END;
/
/*	Ejercicio 7: Desarrollar un procedimiento que permita insertar nuevos departamentos según las siguientes especificaciones:
•	Se pasará al procedimiento el nombre del departamento y la localidad.
•	El procedimiento insertará la fila nueva asignando como número de departamento la decena siguiente al número mayor de la  tabla. 
•	Se incluirá gestión de posibles errores.
*/
DECLARE
  PROCEDURE VER(PNOMDEPTNO IN DEPT.DNAME%TYPE, PLOCA IN DEPT.LOC%TYPE) IS
    VAUXDEPTNO DEPT.DEPTNO%TYPE;
    VAUXVALIDAR NUMBER;

    -- Excepción personalizada
  --  EX_DEPARTAMENTO_EXISTE EXCEPTION;

  BEGIN
    -- Obtener el número máximo
    SELECT MAX(DEPTNO) INTO VAUXDEPTNO FROM DEPT;
     INSERT INTO DEPT VALUES (VAUXDEPTNO + 5, PNOMDEPTNO, PLOCA);
      DBMS_OUTPUT.PUT_LINE('INSERTADO CORRECTAMENTE');
 /*   -- Verificar si el nuevo DEPTNO ya existe
    SELECT COUNT(*) INTO VAUXVALIDAR
    FROM DEPT
    WHERE DEPTNO = VAUXDEPTNO + 5;

    -- Validación con excepción
    IF VAUXVALIDAR = 0 THEN
      INSERT INTO DEPT VALUES (VAUXDEPTNO + 5, PNOMDEPTNO, PLOCA);
      DBMS_OUTPUT.PUT_LINE('INSERTADO CORRECTAMENTE');
    ELSE
      RAISE EX_DEPARTAMENTO_EXISTE;  -- salta al EXCEPTION directamente
    END IF;

  EXCEPTION
    WHEN EX_DEPARTAMENTO_EXISTE THEN
      DBMS_OUTPUT.PUT_LINE('YA HAY UN DEPARTAMENTO CON ESE NUMERO');
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('ERROR GENERAL: ' || SQLERRM);
      */
  EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
      DBMS_OUTPUT.PUT_LINE('ERROR: YA EXISTE UN DEPARTAMENTO CON ESE DEPTNO');
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('ERROR GENERAL: ' || SQLERRM);
  END;
BEGIN
  VER('LUCAS', 'PEPAS');
END;

/*Ejercicio 8: Escribir un procedimiento que reciba todos los datos de un nuevo empleado procese la transacción de alta, 
gestionando posibles errores.*/
/
DECLARE
PROCEDURE VER(
PEMPNO EMP.EMPNO%TYPE,
PENAME EMP.ENAME%TYPE,
PJOB EMP.JOB%TYPE,
PMGR EMP.MGR%TYPE,
PHIREDATE EMP.HIREDATE%TYPE,
PSAL EMP.SAL%TYPE,
PCOMM EMP.COMM%TYPE,
PDEPTNO EMP.DEPTNO%TYPE)
IS
BEGIN
INSERT INTO EMP 
VALUES(PEMPNO,PENAME,PJOB,PMGR,PHIREDATE,PSAL,PCOMM,PDEPTNO);
END;
BEGIN
VER(3719,'ZA','MANAG',7389,SYSDATE,1000,10,30);
END;
/

/*	Ejercicio 9: Codificar un procedimiento reciba como parámetros un numero de departamento, un importe 
y un porcentaje; y suba el salario a todos los empleados del departamento indicado en la llamada. La subida será
el porcentaje o el importe indicado en la llamada (el que sea más beneficioso para el empleado en cada caso).*/

DECLARE
  PROCEDURE VER(PDEPTNO IN EMP.DEPTNO%TYPE, PIMPORTE IN NUMBER, PPORC IN NUMBER) IS
    CURSOR CVER IS
      SELECT EMPNO, SAL
      FROM EMP
      WHERE DEPTNO = PDEPTNO
      FOR UPDATE;  -- Para poder actualizar en el cursor directamente

    VAUXCVER CVER%ROWTYPE;
    VAUXSALNUEVO EMP.SAL%TYPE;
    VAUXPORC NUMBER;
  BEGIN
    OPEN CVER;
    FETCH CVER INTO VAUXCVER;
   
    WHILE CVER%FOUND LOOP
   -- Calculamos la subida por porcentaje
      VAUXPORC := (VAUXCVER.SAL * PPORC) / 100;

      -- Determinamos cuál es más beneficioso
      IF PIMPORTE > VAUXPORC THEN
        UPDATE EMP
        SET SAL = SAL + PIMPORTE
        WHERE CURRENT OF CVER;
      ELSE
        UPDATE EMP
        SET SAL = SAL + VAUXPORC
        WHERE CURRENT OF CVER;
      END IF;

      FETCH CVER INTO VAUXCVER;
    END LOOP;

    CLOSE CVER;
    DBMS_OUTPUT.PUT_LINE('SALARIOS ACTUALIZADOS');

  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('ERROR: ' || SQLERRM);
  END;

BEGIN
  VER(30, 300, 30);
END;
/


SELECT SAL 
FROM EMP
WHERE DEPTNO=30;
/*	Ejercicio 10: Escribir un procedimiento que suba el sueldo de todos los empleados que ganen menos
que el salario medio de su oficio. La subida será de el 50% de la diferencia entre el salario del empleado y 
la media de su oficio. Se deberá asegurar que la transacción no se quede a medias, y se gestionarán los posibles errores. */
/
SELECT E.ENAME, E.JOB, E.SAL
FROM EMP E
WHERE E.SAL < (
  SELECT AVG(E1.SAL)
  FROM EMP E1
  WHERE E1.JOB = E.JOB
);

/
DECLARE
  CURSOR CVER IS
    SELECT ENAME, SAL, JOB
    FROM EMP
    FOR UPDATE;

  VAUXCVER CVER%ROWTYPE;
  VAUXDIFERENCIA EMP.SAL%TYPE;
  VAUXSUBIDA EMP.SAL%TYPE;
  VAUXSALMEDIO EMP.SAL%TYPE;
  VCONTADOR NUMBER := 0;  -- << Añadimos contador manual

  PROCEDURE VER IS
  BEGIN
    OPEN CVER;
    FETCH CVER INTO VAUXCVER;

    WHILE CVER%FOUND LOOP
      -- Obtener el salario medio del mismo trabajo
      SELECT AVG(SAL) INTO VAUXSALMEDIO
      FROM EMP
      WHERE JOB = VAUXCVER.JOB;

      IF VAUXCVER.SAL < VAUXSALMEDIO THEN
        VAUXDIFERENCIA := VAUXSALMEDIO - VAUXCVER.SAL;
        VAUXSUBIDA := (VAUXDIFERENCIA * 50) / 100;

        UPDATE EMP
        SET SAL = VAUXCVER.SAL + VAUXSUBIDA
        WHERE CURRENT OF CVER;

        IF SQL%ROWCOUNT > 0 THEN
          VCONTADOR := VCONTADOR + 1;  -- << Contamos la fila actualizada
          DBMS_OUTPUT.PUT_LINE('Empleado actualizado: ' || VAUXCVER.ENAME ||
                               ' | Nuevo salario estimado: ' || 
                               (VAUXCVER.SAL + VAUXSUBIDA));
        END IF;
      END IF;

      FETCH CVER INTO VAUXCVER;
    END LOOP;

    CLOSE CVER;

    DBMS_OUTPUT.PUT_LINE('Total de filas actualizadas: ' || VCONTADOR); -- << mostramos el total real
  END;

BEGIN
  VER;
END;
/









ROLLBACK;