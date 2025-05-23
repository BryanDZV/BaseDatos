/*EJERCICIO AVANZADO DE TRIGGER SOBRE EL SCRIPT VENTAS -TIPOEXAMEN
Eres parte del equipo de desarrollo de un sistema de facturación para una empresa de tecnología. Las tablas clientes, productos, facturas y detalle_facturas ya están creadas y pobladas.
El equipo necesita automatizar una serie de tareas cada vez que se registra un nuevo detalle de factura. Para ello, deberás diseñar tres triggers encadenados que se ejecuten cuando se inserte un nuevo detalle en la tabla detalle_facturas.

Diseña una cadena de tres triggers que cumplan las siguientes condiciones y se ejecuten en este orden:
1.	Trigger 1: Verifica que el producto insertado en detalle_facturas exista en la tabla productos. Si no existe, lanza un error.
*/
/
CREATE OR REPLACE TRIGGER TRG_VALIDACION
BEFORE INSERT ON DETALLE_FACTURAS
FOR EACH ROW
DECLARE
    vauxcod_producto PRODUCTOS.COD_PRODUCTO%TYPE;
    vauxcod_factura  FACTURAS.COD_FACTURA%TYPE;
BEGIN
    -- Validar producto
    BEGIN
        SELECT cod_producto
        INTO vauxcod_producto
        FROM productos
        WHERE cod_producto = :NEW.cod_producto;
    EXCEPTION
        WHEN no_data_found THEN
            DBMS_OUTPUT.PUT_LINE('NO EXISTE EL PRODUCTO');
            RAISE_APPLICATION_ERROR(-20001, 'NO EXISTE EL PRODUCTO');
    END;

    -- Validar factura
    BEGIN
        SELECT cod_factura
        INTO vauxcod_factura
        FROM facturas
        WHERE cod_factura = :NEW.cod_factura;
    EXCEPTION
        WHEN no_data_found THEN
            DBMS_OUTPUT.PUT_LINE('NO EXISTE LA FACTURA');
            RAISE_APPLICATION_ERROR(-20002, 'NO EXISTE LA FACTURA');
    END;
END;
/
--CON TIPO REGISTRO SE PEUDE Y HACIENDO UNA COLUTA DE AMBAS A LA VEZ 
CREATE OR REPLACE TRIGGER trg_validacion
BEFORE INSERT ON detalle_facturas
FOR EACH ROW
DECLARE
    -- Definimos un registro con los campos que nos interesan
    TYPE registro_validacion IS RECORD (
        cod_factura  facturas.cod_factura%TYPE,
        cod_producto productos.cod_producto%TYPE
    );
    v_reg registro_validacion;
BEGIN
    BEGIN
        SELECT f.cod_factura, p.cod_producto
        INTO v_reg
        FROM facturas f
        JOIN productos p
        ON 1 = 1  -- ⚠ Esto se usa solo si no hay relación directa. Si hay relación, pon la correcta (por ejemplo usando la tabla intermedia)
        WHERE f.cod_factura = :NEW.cod_factura
          AND p.cod_producto = :NEW.cod_producto;

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20001, 'ERROR: No existe la factura o el producto');
    END;
END;
/




/

INSERT  INTO DETALLE_FACTURAS
VALUES('F0011','P0003',89,20);


