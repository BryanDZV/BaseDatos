/*1. Procedimiento para actualizar el precio de un producto*/
CREATE OR REPLACE PROCEDURE actualizar (
        p_cod_producto IN productos.cod_producto%TYPE,
        p_precio       IN productos.precio_unitario%TYPE
) IS

        CURSOR c_actualizar IS
        SELECT
                cod_producto,
                descripcion
        FROM
                productos
        WHERE
                cod_producto = p_cod_producto
        FOR UPDATE;

        v_aux     c_actualizar%rowtype;
        v_sqlcode NUMBER;
        v_sqlerrm VARCHAR2(200);
BEGIN
        OPEN c_actualizar;
        FETCH c_actualizar INTO v_aux;
        UPDATE productos
        SET
                precio_unitario = p_precio
        WHERE
                CURRENT OF c_actualizar;

        dbms_output.put_line('ACTUALIZADO CORRECTAMENTE');
        CLOSE c_actualizar;
EXCEPTION
        WHEN OTHERS THEN
                v_sqlcode := sqlcode;
                v_sqlerrm := sqlerrm;
                IF v_sqlcode = -1410 THEN
                        dbms_output.put_line('NO HAY PRODUCTO CON EL CODIGO DADO');
                ELSE
                        dbms_output.put_line('ERROR ::' || v_sqlcode);
                        dbms_output.put_line(v_sqlerrm);
                END IF;

END actualizar;
/

DECLARE BEGIN
        actualizar('P0009', 3000);
END;
/
/**************************************/
/*2.	Crear una función que devuelva el nombre del producto más vendido*/
CREATE OR REPLACE FUNCTION NOMBRE
RETURN PRODUCTOS.DESCRIPCION%TYPE
IS

CURSOR C_NOMBRE IS
SELECT P.DESCRIPCION,P.COD_PRODUCTO, SUM(DF.SUBTOTAL) AS TOTAL_PRODUCTO
FROM PRODUCTOS P
INNER JOIN DETALLE_FACTURAS DF ON P.COD_PRODUCTO=DF.COD_PRODUCTO
GROUP BY P.DESCRIPCION,P.COD_PRODUCTO
ORDER BY TOTAL_PRODUCTO DESC;
V_NOMBRE_RETURN PRODUCTOS.DESCRIPCION%TYPE;
V_AUX C_NOMBRE%ROWTYPE;
BEGIN
OPEN  C_NOMBRE;
FETCH C_NOMBRE INTO V_AUX;
V_NOMBRE_RETURN:=V_AUX.DESCRIPCION;

CLOSE C_NOMBRE;
RETURN V_NOMBRE_RETURN;
END ;
/
DECLARE
    V_PRODUCTO PRODUCTOS.DESCRIPCION%TYPE;
BEGIN 
    V_PRODUCTO := NOMBRE;  -- Llamar a la función y guardar el resultado
    DBMS_OUTPUT.PUT_LINE('El producto más vendido es: ' || V_PRODUCTO);
END;
/
ROLLBACK;
/