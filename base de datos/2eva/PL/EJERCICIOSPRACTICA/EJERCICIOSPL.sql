SET SERVEROUTPUT ON

--Ejercicio 1: Realizar nuestro primer bloque PL/SQL, que visualiza día, mes y año actual, donde el mes será con nombre.
--Este ejercicio utiliza las funciones de fecha de Oracle para obtener la fecha actual y formatearla.


DECLARE
  v_fecha DATE := SYSDATE;  
  v_dia NUMBER;
  v_mes VARCHAR2(20);
  v_anio NUMBER;
BEGIN
  v_dia := TO_NUMBER(TO_CHAR(v_fecha, 'DD'));  
  v_mes := TO_CHAR(v_fecha, 'FMMonth');        
  v_anio := TO_NUMBER(TO_CHAR(v_fecha, 'YYYY')); 
  
  dbms_output.put_line('Día: ' || v_dia); 
  dbms_output.put_line('Mes: ' || v_mes);  
  dbms_output.put_line('Año: ' || v_anio); 
END;
/
--Ejercicio 2: Crear un bloque de PL/SQL que permite visualizar el salario de KING, utilizando las tablas de empleados.
--Este ejercicio asume que hay una tabla llamada empleados con las columnas nombre y salario. Se busca el salario de un empleado llamado "KING".


DECLARE
  v_salario EMP.SAL%TYPE;  
  BEGIN
  SELECT SALY INTO v_salario 
  FROM EMP
  WHERE nombre = 'KING';

  dbms_output.put_line('El salario de KING es: ' || v_salario); 
END;
/
--Ejercicio 3: Crear un bloque de PL/SQL que permite visualizar el salario que desea el usuario, utilizando las tablas de empleados.
--Este bloque permitirá al usuario ingresar el nombre de un empleado para obtener su salario.


DECLARE
  v_nombre empleados.nombre%TYPE; 
  v_salario empleados.salario%TYPE;  
BEGIN
  -- Solicita al usuario que ingrese el nombre del empleado
  v_nombre := 'KING';  -- Este valor puede ser modificado por el usuario si se utiliza un entorno interactivo
  
  -- Consulta el salario del empleado ingresado
  SELECT salario INTO v_salario
  FROM empleados
  WHERE nombre = v_nombre;
  
  -- Muestra el salario del empleado
  dbms_output.put_line('El salario de ' || v_nombre || ' es: ' || v_salario);
END;















/
DECLARE
  v_cadena VARCHAR2(100) := 'Hola Mundo';  -- Cadena de texto que se invertirá
  v_cadena_invertida VARCHAR2(100) := '';  -- Variable para almacenar la cadena invertida
  v_longitud NUMBER;  -- Longitud de la cadena
  v_indice NUMBER;  -- Índice para recorrer la cadena
BEGIN
  -- Obtener la longitud de la cadena
  v_longitud := LENGTH(v_cadena);

  -- Recorrer la cadena desde el último carácter hasta el primero
  v_indice := v_longitud;
  WHILE v_indice > 0 LOOP
    -- Extraer el carácter actual y añadirlo a la cadena invertida
    v_cadena_invertida := v_cadena_invertida || SUBSTR(v_cadena, v_indice, 1);
    -- Decrementar el índice
    v_indice := v_indice - 1;
  END LOOP;

  -- Mostrar la cadena original e invertida
  dbms_output.put_line('Cadena original: ' || v_cadena);
  dbms_output.put_line('Cadena invertida: ' || v_cadena_invertida);
END;
/

/*/
/*Resumen de las soluciones:
Ejercicio 1: Utiliza SYSDATE para obtener la fecha actual y la función TO_CHAR para formatearla, mostrando día, mes (con nombre) y año.
Ejercicio 2: Realiza una consulta SELECT para obtener el salario de un empleado específico (KING) de la tabla empleados.
Ejercicio 3: Permite consultar el salario de un empleado cuyo nombre es proporcionado (en este caso se usa 'KING' como ejemplo).
Ejercicio 4: Involucra el uso de la función REVERSE para invertir una cadena de texto.
*/
