/*EJERCICIOS SOBRE EL SCRIPT VENTAS

1.	Crear un procedimiento almacenado para actualizar el precio de un producto que se envíe
como parámetro de entrada. */
/
/*SELECT INTO + ROWNUM PORQ DEVEUVLE 1 FILA*/
DECLARE 
PROCEDURE  VER(PCOD_PRODUCTO IN PRODUCTOS.COD_PRODUCTO%TYPE,PPRECIO_UNITARIO IN PRODUCTOS.PRECIO_UNITARIO%TYPE)
IS
BEGIN
UPDATE PRODUCTOS
SET PRECIO_UNITARIO=PPRECIO_UNITARIO
WHERE COD_PRODUCTO=PCOD_PRODUCTO;
END;
BEGIN
VER('P0001',280);
END;
/
SELECT *
FROM PRODUCTOS;
/
/*2.	Crear una función que devuelva el nombre del producto más vendido*/
 SELECT P.DESCRIPCION, SUM(DF.SUBTOTAL) AS TOTAL
            FROM PRODUCTOS P
            JOIN DETALLE_FACTURAS DF ON P.COD_PRODUCTO = DF.COD_PRODUCTO
            GROUP BY P.DESCRIPCION
            ORDER BY TOTAL DESC;
DECLARE
    FUNCTION VER
    RETURN PRODUCTOS.DESCRIPCION%TYPE
    IS
        VAUXDESCRIPCION PRODUCTOS.DESCRIPCION%TYPE;
    BEGIN
        SELECT DESCRIPCION
        INTO VAUXDESCRIPCION
        FROM (
            SELECT P.DESCRIPCION, SUM(DF.SUBTOTAL) AS TOTAL
            FROM PRODUCTOS P
            JOIN DETALLE_FACTURAS DF ON P.COD_PRODUCTO = DF.COD_PRODUCTO
            GROUP BY P.DESCRIPCION
            ORDER BY TOTAL DESC
        )
        WHERE ROWNUM = 1;

        RETURN VAUXDESCRIPCION;
    END;
BEGIN
    DBMS_OUTPUT.PUT_LINE(VER); -- mostrar la descripción
END;
/
/*CURSOR SI USO SQL PURO Y PUEDE HAVER 1 O MAS FILAS DEVUELTAS*/
DECLARE
    -- Función que devuelve los productos más vendidos
    FUNCTION VER
    RETURN VARCHAR2 -- Modificamos para devolver una cadena (todos los productos más vendidos)
    IS
        -- Declaramos el cursor para los productos más vendidos
        CURSOR CUR_VENTAS IS
        SELECT P.DESCRIPCION, SUM(DF.SUBTOTAL) AS TOTAL_PRODUCTO
        FROM PRODUCTOS P
        INNER JOIN DETALLE_FACTURAS DF ON P.COD_PRODUCTO = DF.COD_PRODUCTO
        GROUP BY P.DESCRIPCION
        HAVING SUM(DF.SUBTOTAL) = (
            SELECT MAX(TOTAL_PRODUCTO)
            FROM (
                SELECT SUM(SUBTOTAL) AS TOTAL_PRODUCTO
                FROM DETALLE_FACTURAS
                GROUP BY COD_PRODUCTO
            ) T
        );
        
        -- Usamos %ROWTYPE para crear una variable que almacene una fila completa
        VAUXCVER CUR_VENTAS%ROWTYPE;
        V_RESULTADO VARCHAR2(32767) := ''; 

    BEGIN
        -- Abre el cursor
        OPEN CUR_VENTAS;

        -- Fetch primero y luego verificar si se encontraron datos
        FETCH CUR_VENTAS INTO VAUXCVER;  -- Obtener la primera fila

        -- Usamos un WHILE para recorrer el cursor
        WHILE CUR_VENTAS%FOUND LOOP
            -- Concatenar las descripciones de los productos más vendidos
            V_RESULTADO :=V_RESULTADO || VAUXCVER.DESCRIPCION || ' (' || VAUXCVER.TOTAL_PRODUCTO || ')';

            -- Fetch la siguiente fila
            FETCH CUR_VENTAS INTO VAUXCVER;
        END LOOP;

        -- Cerrar el cursor
        CLOSE CUR_VENTAS;

        RETURN V_RESULTADO;  -- Devolver todos los productos más vendidos concatenados
    END;
    
BEGIN
    -- Llamamos a la función y mostramos el resultado
    DBMS_OUTPUT.PUT_LINE(VER); -- Mostrar los productos más vendidos
END;
/
/*3.	Escribir un procedimiento almacenado que permita actualizar el importe total de una factura, 
según el detalle que tenga asignado. El código de factura debe enviarse como parámetro de entrada*/
DECLARE
  PROCEDURE VER(PCOD_FACTURA IN FACTURAS.COD_FACTURA%TYPE)
  IS
    CURSOR CVER IS
      SELECT SUM(SUBTOTAL) AS TOTAL_PRODUCTO
      FROM DETALLE_FACTURAS
      WHERE COD_FACTURA = PCOD_FACTURA
      GROUP BY COD_FACTURA;
      
    VAUXCVER CVER%ROWTYPE;
  BEGIN
    OPEN CVER;
    FETCH CVER INTO VAUXCVER;
    IF CVER%FOUND THEN
      UPDATE FACTURAS
      SET IMPORTE_TOTAL = VAUXCVER.TOTAL_PRODUCTO
      WHERE COD_FACTURA = PCOD_FACTURA;
    END IF;
    CLOSE CVER;
  END;
BEGIN 
  VER('F0001');
END;
/
/*4.	Crear un procedimiento que permita insertar información al detalle de una factura.*/
CREATE OR REPLACE PROCEDURE InsertarDetalleFactura (
  PCOD_FACTURA   IN DETALLE_FACTURAS.COD_FACTURA%TYPE,
  PCOD_PRODUCTO  IN DETALLE_FACTURAS.COD_PRODUCTO%TYPE,
  PCANTIDAD      IN DETALLE_FACTURAS.CANTIDAD%TYPE,
  PSUBTOTAL      IN DETALLE_FACTURAS.SUBTOTAL%TYPE
)
IS
BEGIN
  INSERT INTO DETALLE_FACTURAS (COD_FACTURA, COD_PRODUCTO, CANTIDAD, SUBTOTAL)
  VALUES (PCOD_FACTURA, PCOD_PRODUCTO, PCANTIDAD, PSUBTOTAL);
  DBMS_OUTPUT.PUT_LINE('✅ Detalle de factura insertado correctamente.');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('❗Error al insertar detalle: ' || SQLERRM);
END;
/
BEGIN
  InsertarDetalleFactura('F0001', 'P0010', 3, 1);
END;
/
/*5.	Desarrollar un procedimiento almacenado que devuelva un reporte con la lista
y sumatoria total de todas facturas agrupadas por cliente.*/
DECLARE
PROCEDURE VER
IS
CURSOR CVER IS
SELECT C.NOMBRES,F.IMPORTE_TOTAL,F.COD_FACTURA
FROM CLIENTES C
LEFT JOIN FACTURAS F ON C.COD_CLIENTE=F.COD_CLIENTE
GROUP BY NOMBRES,IMPORTE_TOTAL,COD_FACTURA;
VAUXCVER CVER%ROWTYPE;
BEGIN
OPEN CVER;
FETCH CVER INTO VAUXCVER;
WHILE CVER%FOUND LOOP
DBMS_OUTPUT.PUT_LINE('CLIENTE: '||VAUXCVER.NOMBRES||' IMPORTE TOTAL: '||VAUXCVER.IMPORTE_TOTAL||' FACUTURA :'||VAUXCVER.COD_FACTURA);
 -- Línea separadora
      DBMS_OUTPUT.PUT_LINE(LPAD('-', 50, '*'));  -- 50 es el número de guiones
FETCH CVER INTO VAUXCVER;
END LOOP;
CLOSE CVER;
END;
BEGIN
VER;
END;


/

DESC DETALLE_FACTURAS;
/
/*EJERCICIOS DE PAQUETES 
1.	Crear un paquete con todos los ejercicios de la colección de ventas avanzado.
*/
/
CREATE OR REPLACE PACKAGE PKG_EJERCICIOS IS

    -- Tipo de registro para el cursor CVER (Total por factura)
    TYPE TREG_CVER IS RECORD (
        TOTAL_PRODUCTO NUMBER
    );

    -- Tipo de registro para el cursor CVERREPORTE (reporte de clientes)
    TYPE TREG_REPORTE IS RECORD (
        NOMBRES        CLIENTES.NOMBRES%TYPE,
        IMPORTE_TOTAL  FACTURAS.IMPORTE_TOTAL%TYPE,
        COD_FACTURA    FACTURAS.COD_FACTURA%TYPE
    );

    -- Declaración de cursores usando los tipos anteriores
    CURSOR CVER(PCOD_FACTURA IN FACTURAS.COD_FACTURA%TYPE) RETURN TREG_CVER;
    CURSOR CVERREPORTE RETURN TREG_REPORTE;

    -- Declaración de procedimientos y funciones
    PROCEDURE ACTUALIZAR_PRECIO(
        PCOD_PRODUCTO     IN PRODUCTOS.COD_PRODUCTO%TYPE,
        PPRECIO_UNITARIO  IN PRODUCTOS.PRECIO_UNITARIO%TYPE
    );

    FUNCTION PRODUCTO_MASVENDIDO RETURN VARCHAR2;

    PROCEDURE ACTUALIZAR_IMPORTETOTAL(PCOD_FACTURA IN FACTURAS.COD_FACTURA%TYPE);

    PROCEDURE REPORTE;

END PKG_EJERCICIOS;
/

CREATE OR REPLACE PACKAGE BODY PKG_EJERCICIOS IS

    -- CURSOR que devuelve el total de una factura
    CURSOR CVER(PCOD_FACTURA IN FACTURAS.COD_FACTURA%TYPE) RETURN TREG_CVER IS
        SELECT SUM(SUBTOTAL) AS TOTAL_PRODUCTO
        FROM DETALLE_FACTURAS
        WHERE COD_FACTURA = PCOD_FACTURA
        GROUP BY COD_FACTURA;

    -- CURSOR para reporte de clientes y sus facturas
    CURSOR CVERREPORTE RETURN TREG_REPORTE IS
        SELECT C.NOMBRES, F.IMPORTE_TOTAL, F.COD_FACTURA
        FROM CLIENTES C
        LEFT JOIN FACTURAS F ON C.COD_CLIENTE = F.COD_CLIENTE
        ORDER BY C.NOMBRES;

    -- Procedimiento para actualizar el precio de un producto
    PROCEDURE ACTUALIZAR_PRECIO(
        PCOD_PRODUCTO     IN PRODUCTOS.COD_PRODUCTO%TYPE,
        PPRECIO_UNITARIO  IN PRODUCTOS.PRECIO_UNITARIO%TYPE
    ) IS
    BEGIN
        UPDATE PRODUCTOS
        SET PRECIO_UNITARIO = PPRECIO_UNITARIO
        WHERE COD_PRODUCTO = PCOD_PRODUCTO;
    END;

    -- Función que devuelve la descripción del producto más vendido
    FUNCTION PRODUCTO_MASVENDIDO RETURN VARCHAR2 IS
        VAUXDESCRIPCION VARCHAR2(255);
    BEGIN
        SELECT DESCRIPCION
        INTO VAUXDESCRIPCION
        FROM (
            SELECT P.DESCRIPCION, SUM(DF.SUBTOTAL) AS TOTAL
            FROM PRODUCTOS P
            JOIN DETALLE_FACTURAS DF ON P.COD_PRODUCTO = DF.COD_PRODUCTO
            GROUP BY P.DESCRIPCION
            ORDER BY TOTAL DESC
        )
        WHERE ROWNUM = 1;

        RETURN VAUXDESCRIPCION;
    END;

    -- Procedimiento para actualizar el importe total de una factura
    PROCEDURE ACTUALIZAR_IMPORTETOTAL(PCOD_FACTURA IN FACTURAS.COD_FACTURA%TYPE) IS
        VREG TREG_CVER;
    BEGIN
        OPEN CVER(PCOD_FACTURA);
        FETCH CVER INTO VREG;
        IF CVER%FOUND THEN
            UPDATE FACTURAS
            SET IMPORTE_TOTAL = VREG.TOTAL_PRODUCTO
            WHERE COD_FACTURA = PCOD_FACTURA;
        END IF;
        CLOSE CVER;
    END;

    -- Procedimiento para mostrar un reporte de clientes y facturas
    PROCEDURE REPORTE IS
        VREG TREG_REPORTE;
    BEGIN
        OPEN CVERREPORTE;
        FETCH CVERREPORTE INTO VREG;
        WHILE CVERREPORTE%FOUND LOOP
            DBMS_OUTPUT.PUT_LINE('CLIENTE: ' || VREG.NOMBRES ||
                                 ' | IMPORTE TOTAL: ' || VREG.IMPORTE_TOTAL ||
                                 ' | FACTURA: ' || VREG.COD_FACTURA);
            DBMS_OUTPUT.PUT_LINE(LPAD('-', 50, '*'));
            FETCH CVERREPORTE INTO VREG;
        END LOOP;
        CLOSE CVERREPORTE;
    END;

END PKG_EJERCICIOS;
/
/
/
/*pasando PARAMETRO CON OMBRE Y VALOR*/
DECLARE
    VPRODUCTO_MAS_VENDIDO VARCHAR2(255);
BEGIN
    -- 1. Actualizar el precio de un producto
    PKG_EJERCICIOS.ACTUALIZAR_PRECIO(PCOD_PRODUCTO => 101, PPRECIO_UNITARIO => 15.99);
    DBMS_OUTPUT.PUT_LINE('Precio actualizado correctamente.');

    -- 2. Obtener el producto más vendido
    VPRODUCTO_MAS_VENDIDO := PKG_EJERCICIOS.PRODUCTO_MASVENDIDO;
    DBMS_OUTPUT.PUT_LINE('Producto más vendido: ' || VPRODUCTO_MAS_VENDIDO);

    -- 3. Actualizar el importe total de una factura
    PKG_EJERCICIOS.ACTUALIZAR_IMPORTETOTAL(PCOD_FACTURA => 2001);
    DBMS_OUTPUT.PUT_LINE('Importe total actualizado para la factura 2001.');

    -- 4. Mostrar reporte de facturas y clientes
    PKG_EJERCICIOS.REPORTE;

END;
/
/*PASANDO POR POSICION LOS PARAMETROS*/
/
DECLARE
    VPRODUCTO_MAS_VENDIDO VARCHAR2(255);
BEGIN
    -- 1. Actualizar el precio de un producto (por posición)
    PKG_EJERCICIOS.ACTUALIZAR_PRECIO(101, 15.99);  -- 101 es el COD_PRODUCTO y 15.99 el PRECIO_UNITARIO
    DBMS_OUTPUT.PUT_LINE('Precio actualizado correctamente.');

    -- 2. Obtener el producto más vendido
    VPRODUCTO_MAS_VENDIDO := PKG_EJERCICIOS.PRODUCTO_MASVENDIDO;
    DBMS_OUTPUT.PUT_LINE('Producto más vendido: ' || VPRODUCTO_MAS_VENDIDO);

    -- 3. Actualizar el importe total de una factura (por posición)
    PKG_EJERCICIOS.ACTUALIZAR_IMPORTETOTAL(2001);  -- 2001 es el COD_FACTURA
    DBMS_OUTPUT.PUT_LINE('Importe total actualizado para la factura 2001.');

    -- 4. Mostrar reporte de facturas y clientes
    PKG_EJERCICIOS.REPORTE;

END;
/



ROLLBACK;