CREATE OR REPLACE PACKAGE pq_provincia AS
    TYPE T_tab_prov IS TABLE OF PROVINCIAS%ROWTYPE INDEX BY BINARY_INTEGER;
    tab_prov T_tab_prov;

    FUNCTION provincia(v_cod VARCHAR2) RETURN VARCHAR2;
    FUNCTION codigo(v_prov VARCHAR2) RETURN VARCHAR2;
    FUNCTION cp(v_prov VARCHAR2) RETURN VARCHAR2;
    FUNCTION ver_provincias RETURN T_tab_prov;
    PROCEDURE borrar_prov;
END pq_provincia;
/
CREATE OR REPLACE PACKAGE BODY pq_provincia AS

    CURSOR c_prov IS SELECT * FROM provincias;

    -- Inicializa la tabla PL/SQL si está vacía
    PROCEDURE cargar_tabla IS
        i BINARY_INTEGER := 0;
    BEGIN
        IF tab_prov.COUNT = 0 THEN
            FOR reg IN c_prov LOOP
                i := i + 1;
                tab_prov(i) := reg;
            END LOOP;
        END IF;
    END cargar_tabla;

    -- Devuelve el nombre de la provincia a partir del código
    FUNCTION provincia(v_cod VARCHAR2) RETURN VARCHAR2 IS
    BEGIN
        cargar_tabla;
        FOR i IN tab_prov.FIRST .. tab_prov.LAST LOOP
            IF tab_prov(i).mcod = v_cod THEN
                RETURN tab_prov(i).prov;
            END IF;
        END LOOP;
        RETURN NULL;
    END provincia;

    -- Devuelve el código de la provincia a partir del nombre
    FUNCTION codigo(v_prov VARCHAR2) RETURN VARCHAR2 IS
    BEGIN
        cargar_tabla;
        FOR i IN tab_prov.FIRST .. tab_prov.LAST LOOP
            IF UPPER(tab_prov(i).prov) = UPPER(v_prov) THEN
                RETURN tab_prov(i).mcod;
            END IF;
        END LOOP;
        RETURN NULL;
    END codigo;

    -- Devuelve el CP a partir del nombre de la provincia
    FUNCTION cp(v_prov VARCHAR2) RETURN VARCHAR2 IS
    BEGIN
        cargar_tabla;
        FOR i IN tab_prov.FIRST .. tab_prov.LAST LOOP
            IF UPPER(tab_prov(i).prov) = UPPER(v_prov) THEN
                RETURN tab_prov(i).cp;
            END IF;
        END LOOP;
        RETURN NULL;
    END cp;

    -- Devuelve las provincias cuyo CP (numérico) es menor que 20
    FUNCTION ver_provincias RETURN T_tab_prov IS
        resultado T_tab_prov;
        j INTEGER := 0;
    BEGIN
        cargar_tabla;
        FOR i IN tab_prov.FIRST .. tab_prov.LAST LOOP
            IF TO_NUMBER(tab_prov(i).cp) < 20 THEN
                j := j + 1;
                resultado(j) := tab_prov(i);
            END IF;
        END LOOP;
        RETURN resultado;
    END ver_provincias;

    -- Borra la tabla PL/SQL
    PROCEDURE borrar_prov IS
    BEGIN
        tab_prov.DELETE;
    END borrar_prov;

END pq_provincia;
/
SET SERVEROUTPUT ON
BEGIN
    DBMS_OUTPUT.PUT_LINE('Nombre de BA: ' || pq_provincia.provincia('BA'));
    DBMS_OUTPUT.PUT_LINE('Código de CANTABRIA: ' || pq_provincia.codigo('CANTABRIA'));
    DBMS_OUTPUT.PUT_LINE('CP de CORDOBA: ' || pq_provincia.cp('CORDOBA'));
END;
/

-- Ver provincias con CP < 20
DECLARE
    resultado pq_provincia.T_tab_prov;
BEGIN
    resultado := pq_provincia.ver_provincias;
    FOR i IN resultado.FIRST .. resultado.LAST LOOP
        DBMS_OUTPUT.PUT_LINE(resultado(i).mcod || ' - ' || resultado(i).prov || ' - ' || resultado(i).cp);
    END LOOP;
END;
/

-- Borrar la tabla PL/SQL
BEGIN
    pq_provincia.borrar_prov;
END;
/

