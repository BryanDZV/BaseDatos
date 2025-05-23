/* Crear estructura SI USARA RECORD
DROP TYPE REGISTRO_EMPLEADOS;
CREATE OR REPLACE REGISTRO_EMPLEADOS IS RECORD(COLUMAS QUE QUIERO);
Y AHORA SU COLECION 
CREATE OR REPLACE TYPE TABLA_EMPLEADOS IS TABLE OF REGISTRO_EMPLEADOS;

/ */
 

/* Crear colección para los registros USANDO ROWTYPE YA TE HACE LA COLECION 
*/
/
DROP TYPE TABLA_EMPLEADOS;
/
DROP FUNCTION FUNCION_TABLA;
/*ASI SE CREAN REALMENTE PAR EL RECOR SERIA IGUAL FEURA DE BLQOUE PL/SQL NO FUNCIONA*/
DECLARE
    -- Definir el tipo de colección que se va a usar (TABLE OF EMP%ROWTYPE)
    CREATE OR REPLACE TYPE TABLA_EMPLEADOS IS TABLE OF EMP%ROWTYPE;
        -- Variable para almacenar los registros de la colección
    VAUX_TABLA_LLAMADA TABLA_EMPLEADOS;
    
    -- Definir una función que devuelve la colección de registros de EMP
   CREATE OR REPLACE FUNCTION FUNCION_TABLA_EMPLEADOS RETURN TABLA_EMPLEADOS IS
        -- Definir una variable interna para almacenar la colección de registros
        VAUX_TABLA TABLA_EMPLEADOS;
    BEGIN
        -- Realizar la consulta y almacenar los registros en la colección usando BULK COLLECT
        SELECT * 
        BULK COLLECT INTO VAUX_TABLA
        FROM EMP;
        
        -- Retornar la colección de registros
        RETURN VAUX_TABLA;
    END FUNCION_TABLA_EMPLEADOS;
    

BEGIN
    -- Llamar a la función y almacenar el resultado en la variable VAUX_TABLA
    VAUX_TABLA_LLAMADA := FUNCION_TABLA_EMPLEADOS();

    -- Iterar sobre la colección y mostrar los resultados
    FOR i IN 1 .. VAUX_TABLA_LLAMADA.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE('Empleado: ' || VAUX_TABLA_LLAMADA(i).EMPNO || ', ' || VAUX_TABLA_LLAMADA(i).ENAME);
    END LOOP;
END;
/
