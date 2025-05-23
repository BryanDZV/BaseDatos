/*Escribir un paquete pq_provincia que creará una tabla PL/SQL con 50 elementos de tipo registro que contendrán los campos correspondientes (ya codificado), y que incluirá, además,
los siguientes procedimientos (a codificar):
-1          provincia: Función. Recibe el  código de provincia y devuelve el nombre de la provincia.
- 2         código: Función. Recibe el nombre de la provincia y devuelve el código.
-3          cp: Función. Recibe la provincia y devuelve los dos primeros dígitos del código postal.
- 4       Crear una función ver_provincias que nos devuelve una tabla con todos los códigos de provincia  y nombre de aquellos codigo               menores que 20.  
-5          borrar_prov: elimina la tabla PL/SQL
*/

-- Crear o reemplazar la función
CREATE OR REPLACE FUNCTION F_PROVINCIA(P_COD_PROVINCIA IN PROVINCIAS.MCOD%TYPE)
RETURN PROVINCIAS.PROV%TYPE
IS
    V_NOMPROVINCIA PROVINCIAS.PROV%TYPE;
    V_SQLCODE NUMBER;
BEGIN
    SELECT PROV INTO V_NOMPROVINCIA
    FROM PROVINCIAS
    WHERE MCOD = P_COD_PROVINCIA;

    RETURN V_NOMPROVINCIA;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
          DBMS_OUTPUT.PUT_LINE( 'NO HAY PROVINCIA');
    WHEN OTHERS THEN
    V_SQLCODE:=SQLCODE;
    DBMS_OUTPUT.PUT_LINE('ha surgido un ERROR:  '|| V_SQLCODE);
       
END F_PROVINCIA;
/

DECLARE
    V_NOMBRE_PROVINCIA PROVINCIAS.PROV%TYPE;
BEGIN
    V_NOMBRE_PROVINCIA := F_PROVINCIA('A');
    DBMS_OUTPUT.PUT_LINE('Nombre de la provincia: ' || V_NOMBRE_PROVINCIA);
END;
/

/*2 DEVOLVER CODIFO DE PROVINCIA RECIBIENDO NOMBRE PROVINCIA*/
CREATE OR REPLACE FUNCTION F_CODIGO(P_NOM_PROVINCIA IN PROVINCIAS.PROV%TYPE)
RETURN PROVINCIAS.CP%TYPE
IS
    V_CODIGO PROVINCIAS.MCOD%TYPE;
    V_SQLCODE NUMBER;
BEGIN
    SELECT MCOD INTO V_CODIGO
    FROM PROVINCIAS
    WHERE PROV = P_NOM_PROVINCIA;

    RETURN V_CODIGO;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE( 'NO HAY PROVINCIA');
    WHEN OTHERS THEN
        V_SQLCODE := SQLCODE;
        DBMS_OUTPUT.PUT_LINE('Ha surgido un ERROR: ' || V_SQLCODE);
        RETURN NULL;
END F_CODIGO;
/

DECLARE
    V_CODIGO PROVINCIAS.MCOD%TYPE;
BEGIN
    V_CODIGO :=F_CODIGO('ALICANTE');
    DBMS_OUTPUT.PUT_LINE('Nombre de la provincia: ' || V_CODIGO);
END;
/
/*3 DEVOVLER CODICO POSTAL RECICBIENDO CON NOMBRE*/
-- Crear o reemplazar la función

CREATE OR REPLACE FUNCTION F_CP(P_NOM_PROVINCIA IN PROVINCIAS.PROV%TYPE)
RETURN PROVINCIAS.CP%TYPE
IS
    V_COD_POSTAL PROVINCIAS.CP%TYPE;
    V_SQLCODE NUMBER;
BEGIN
    SELECT CP INTO V_COD_POSTAL
    FROM PROVINCIAS
    WHERE PROV = P_NOM_PROVINCIA;

    RETURN V_COD_POSTAL;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE( 'NO HAY PROVINCIA');
    WHEN OTHERS THEN
        V_SQLCODE := SQLCODE;
        DBMS_OUTPUT.PUT_LINE('Ha surgido un ERROR: ' || V_SQLCODE);
        RETURN NULL;
END F_CP;
/
DECLARE
    V_CP PROVINCIAS.CP%TYPE;
BEGIN
    V_CP :=F_CP('ALICANTE');
    DBMS_OUTPUT.PUT_LINE('Nombre de la provincia: ' || V_CP);
END;
/



/


/*BORRAR TABLA*/
DROP TABLE PROVINCIAS;
