/*1
1.	Crear un procedimiento almacenado para actualizar el precio de un producto 
que se envíe como parámetro de entrada.*/

CREATE OR REPLACE PROCEDURE actualizar_precio (
        p_precio       IN NUMBER,
        p_cod_producto IN VARCHAR2
) IS
BEGIN
        UPDATE productos
        SET
                precio_unitario = p_precio
        WHERE
                cod_producto = p_cod_producto;

        IF SQL%rowcount = 0 THEN
                dbms_output.put_line('No se encontro el producto ' || p_cod_producto)
                ;
        ELSE
                dbms_output.put_line('Precio actualizado correctamente para el producto ' || p_cod_producto
                );
        END IF;

EXCEPTION
        WHEN OTHERS THEN
                dbms_output.put_line('Error al actualizar el precio');
END actualizar_precio;
/

DECLARE BEGIN
        actualizar_precio(1000, 'P0001');
END;

ROLLBACK;
/
/*2.	Crear una función que devuelva el nombre del producto más vendido*/
CREATE OR REPLACE FUNCTION producto_mas_vendido 
RETURN VARCHAR2 
IS
        v_producto productos.descripcion%TYPE;
BEGIN
    /* Obtenemos el nombre del producto más vendido*/
        SELECT
                p.descripcion
        INTO v_producto
        FROM
                     productos p
                INNER JOIN detalle_facturas df ON p.cod_producto = df.cod_producto
        GROUP BY
                p.descripcion,
                p.cod_producto
        HAVING
                COUNT(df.cantidad) = (
                        SELECT
                                MAX(pedidoxcantidad)
                        FROM
                                (
                                        SELECT
                                                COUNT(cantidad) AS pedidoxcantidad
                                        FROM
                                                detalle_facturas
                                        GROUP BY
                                                cod_producto
                                )
                )
        ORDER BY
                COUNT(df.cantidad) DESC;

        RETURN v_producto;  /* Devolvemos el nombre del producto más vendido*/
END producto_mas_vendido;
/

DECLARE
        v_producto VARCHAR2(255);  /* Declaramos una variable para almacenar el resultado*/
BEGIN
    /* Llamamos a la función PRODUCTO_MAS_VENDIDO y almacenamos el resultado en la variable V_PRODUCTO*/
        v_producto := producto_mas_vendido;
    
    /* Mostramos el resultado en la consola*/
        dbms_output.put_line('El producto más vendido es: ' || v_producto);
    /*PUEDO DIRECTAMENTE LLAMAR A LA FUNCION EN DBMS PORQUE TEINE RETURN LA FUNCION*/
END;


/*VERSION2 DE LA SQL CON ROWNUM
 SELECT P.DESCRIPCION, P.COD_PRODUCTO, COUNT(DF.CANTIDAD) AS PEDIDOXCANTIDAD
    FROM PRODUCTOS P
    INNER JOIN DETALLE_FACTURAS DF ON P.COD_PRODUCTO = DF.COD_PRODUCTO
    GROUP BY P.DESCRIPCION, P.COD_PRODUCTO
    ORDER BY PEDIDOXCANTIDAD DESC)
    WHERE ROWNUM<=1;*/
/
/*-vversion clase mario*/
CREATE OR REPLACE FUNCTION producto_mas_vendido RETURN VARCHAR2 AS
        v_producto_nombre VARCHAR2(30);
BEGIN
        SELECT
                p.descripcion
        INTO v_producto_nombre
        FROM
                     productos p
                JOIN detalle_facturas df ON p.cod_producto = df.cod_producto
        GROUP BY
                p.descripcion
        ORDER BY
                SUM(df.cantidad) DESC
        FETCH FIRST 1 ROWS ONLY;

        RETURN v_producto_nombre;
END producto_mas_vendido;

BEGIN
    /* Llamamos a la función y mostramos el resultado en consola*/
        dbms_output.put_line('Producto más vendido: ' || producto_mas_vendido);
END;
/
/*3Escribir un procedimiento almacenado que permita actualizar el importe total de una factura, 
según el detalle que tenga asignado. El código de factura debe enviarse como parámetro de entrada.*/
CREATE OR REPLACE PROCEDURE actualizar_importe_factura (
        p_cod_factura IN CHAR
) AS
        v_importe_total NUMBER;
BEGIN
        SELECT
                SUM(subtotal)
        INTO v_importe_total
        FROM
                detalle_facturas
        WHERE
                cod_factura = p_cod_factura;

        UPDATE facturas
        SET
                importe_total = v_importe_total
        WHERE
                cod_factura = p_cod_factura;

END;
/

DECLARE BEGIN
        actualizar_importe_factura('F0010');
END;
/
/*VERSION2*/
DECLARE
        p_cod_factura CHAR(5) := 'F0001';
        CURSOR c_detalle_factura IS
        SELECT
                SUM(subtotal) AS total
        FROM
                detalle_facturas
        WHERE
                cod_factura = p_cod_factura;

        CURSOR c_importes_actualizados (
                p_cod_factura CHAR
        ) IS
        SELECT
                importe_total
        FROM
                facturas
        WHERE
                cod_factura = p_cod_factura;

        v_aux         c_detalle_factura%rowtype;
        v_aux1        NUMBER;
BEGIN
        OPEN c_detalle_factura;
        FETCH c_detalle_factura INTO v_aux;
        WHILE c_detalle_factura%found LOOP
                UPDATE facturas
                SET
                        importe_total = v_aux.total
                WHERE
                        cod_factura = p_cod_factura;

                OPEN c_importes_actualizados(p_cod_factura);
                FETCH c_importes_actualizados INTO v_aux1;
                CLOSE c_importes_actualizados;
                dbms_output.put_line('El importe actualizado de la factura ' ||
                p_cod_factura ||
                ' es: ' || v_aux1);
                FETCH c_detalle_factura INTO v_aux;
        END LOOP;

        CLOSE c_detalle_factura;
END;
/
/*4Crear un procedimiento que permita insertar información al detalle de una factura.*/
CREATE OR REPLACE PROCEDURE insertar_detalle_factura (
        p_cod_factura  IN detalle_facturas.cod_factura%TYPE,
        p_cod_producto IN detalle_facturas.cod_producto%TYPE,
        p_cantidad     IN detalle_facturas.cantidad%TYPE
) IS

        CURSOR c_subtotal IS
        SELECT
                nvl(
                        sum(subtotal),
                        0
                )
        FROM
                detalle_facturas
        WHERE
                cod_factura = p_cod_factura;

        v_aux     NUMBER;

    /* Variables para capturar errores*/
        v_sqlcode NUMBER;
        v_sqlerrm VARCHAR2(200);
BEGIN
    /* Obtener el subtotal*/
        OPEN c_subtotal;
        FETCH c_subtotal INTO v_aux;
        CLOSE c_subtotal;

    /* Insertar el detalle de factura*/
        INSERT INTO detalle_facturas (
                cod_factura,
                cod_producto,
                cantidad,
                subtotal
        ) VALUES ( p_cod_factura,
                   p_cod_producto,
                   p_cantidad,
                   v_aux );

        dbms_output.put_line('✅ Detalle insertado correctamente con subtotal: ' || v_aux
        );
EXCEPTION
        WHEN dup_val_on_index THEN
        /* Capturar código y mensaje del error*/
                v_sqlcode := sqlcode;
                v_sqlerrm := sqlerrm;
                dbms_output.put_line(' ERROR: Ya existe un registro con ese valor.');
                dbms_output.put_line(' SQLCODE: ' ||
                v_sqlcode ||
                ' - SQLERRM: ' || v_sqlerrm);
        WHEN OTHERS THEN
        /* Capturar código y mensaje del error*/
                v_sqlcode := sqlcode;
                v_sqlerrm := sqlerrm;
                IF v_sqlcode = -2291 THEN  /* ORA-02291 (clave foránea no encontrada)*/
                        dbms_output.put_line(' ERROR: No existe la factura con COD_FACTURA = ' || p_cod_factura
                        );
                ELSE
                        dbms_output.put_line('️ ERROR GENERAL: ' ||
                        v_sqlcode ||
                        ' - ' || v_sqlerrm);
                END IF;

END insertar_detalle_factura;
/

DECLARE BEGIN
        insertar_detalle_factura('F0011', 'P0003', 9);
END;
/
/*5 Desarrollar un procedimiento almacenado que devuelva un reporte con la lista y sumatoria total 
de todas las facturas agrupadas por cliente.*/
/*VERSION AGRUPANDO TODAS LAS FACTURAS*/
CREATE OR REPLACE PROCEDURE reporte AS

        CURSOR c_reporte IS
        SELECT
                c.cod_cliente,
                c.nombres,
                SUM(f.importe_total) AS total_factura
        FROM
                     clientes c
                INNER JOIN facturas f ON c.cod_cliente = f.cod_cliente
        GROUP BY
                c.cod_cliente,
                c.nombres
        ORDER BY
                c.cod_cliente;

        v_aux c_reporte%rowtype;
BEGIN
        OPEN c_reporte;
        FETCH c_reporte INTO v_aux;
        WHILE c_reporte%found LOOP
                dbms_output.put_line(v_aux.cod_cliente ||
                '--Cliente: ' ||
                v_aux.nombres);
                dbms_output.put_line('Total facturas: ' || v_aux.total_factura);
                dbms_output.put_line(lpad('-', 40, '-'));/*LPAD(cadena, longitud, caracter)*/
                FETCH c_reporte INTO v_aux;
        END LOOP;

        CLOSE c_reporte;
END;
/*VERSION FACTURA INDIVIDUAL*/
CREATE OR REPLACE PROCEDURE reporte AS

        CURSOR c_reporte IS
        SELECT
                c.cod_cliente,
                c.nombres,
                f.cod_factura,
                f.importe_total
        FROM
                     clientes c
                INNER JOIN facturas f ON c.cod_cliente = f.cod_cliente
        ORDER BY
                c.cod_cliente,
                f.cod_factura;

        v_aux c_reporte%rowtype;
BEGIN
        OPEN c_reporte;
        FETCH c_reporte INTO v_aux;
        WHILE c_reporte%found LOOP
                dbms_output.put_line(v_aux.cod_cliente ||
                ' -- Cliente: ' ||
                v_aux.nombres);
                dbms_output.put_line('Factura: ' ||
                v_aux.cod_factura ||
                ' Importe: ' ||
                to_char(
                        round(v_aux.importe_total, 2),
                        '$999,999.00'
                ));

                dbms_output.put_line(lpad('-', 40, '-')); /* Línea separadora*/


                FETCH c_reporte INTO v_aux;
        END LOOP;

        CLOSE c_reporte;
END;
/

BEGIN
        reporte;
END;
/
/*VERSION 2 FOR IMPLICITO*/
CREATE OR REPLACE PROCEDURE reporte_cliente_ventas IS

        v_total NUMBER := 0;
        CURSOR clientes_cursor IS
        SELECT
                cod_cliente,
                nombres
        FROM
                clientes
        WHERE
                cod_cliente IN (
                        SELECT DISTINCT
                                ( cod_cliente )
                        FROM
                                facturas
                );

        CURSOR facturas_cursor IS
        SELECT
                cod_factura,
                importe_total,
                cod_cliente
        FROM
                facturas;

BEGIN
        dbms_output.put_line(lpad('-', 70, '-'));
        dbms_output.put_line('INFORME DE VENTAS');
        dbms_output.put_line(lpad('-', 70, '-'));
        FOR cli IN clientes_cursor LOOP
                dbms_output.put_line(chr(13) ||
                rpad(
                        upper(cli.cod_cliente),
                        6
                ) ||
                upper(cli.nombres));

                dbms_output.put_line(lpad('-', 70, '-'));
                v_total := 0;
                FOR fa IN facturas_cursor LOOP
                        IF fa.cod_cliente = cli.cod_cliente THEN
                                v_total := v_total + fa.importe_total;
                                dbms_output.put_line(rpad(fa.cod_factura, 6) ||
                                to_char(
                                        round(fa.importe_total, 2),
                                        '$999,999.00'
                                ));

                        END IF;
                END LOOP;

                dbms_output.put_line(rpad('Total:', 6) ||
                to_char(
                        round(v_total, 2),
                        '$999,999.00'
                ));

        END LOOP;

END reporte_cliente_ventas;
/

BEGIN
        reporte_cliente_ventas;
END;
/
/*VERSION 3 CON 2 CURSORES*/
/*5 Desarrollar un procedimiento almacenado que devuelva un reporte con la lista y sumatoria total 
de todas las facturas agrupadas por cliente.*/
CREATE OR REPLACE PROCEDURE reporte_cliente_ventas IS

        v_total NUMBER := 0;
        CURSOR clientes_cursor IS
        SELECT
                cod_cliente,
                nombres
        FROM
                clientes
        WHERE
                cod_cliente IN (
                        SELECT DISTINCT
                                cod_cliente
                        FROM
                                facturas
                );

        CURSOR facturas_cursor (
                p_cod_cliente clientes.cod_cliente%TYPE
        ) IS
        SELECT
                cod_factura,
                importe_total
        FROM
                facturas
        WHERE
                cod_cliente = p_cod_cliente;

        v_aux   clientes_cursor%rowtype;
        v_aux1  facturas_cursor%rowtype;
BEGIN
        dbms_output.put_line(lpad('-', 70, '-'));
        dbms_output.put_line('INFORME DE VENTAS');
        dbms_output.put_line(lpad('-', 70, '-'));
        OPEN clientes_cursor;
        FETCH clientes_cursor INTO v_aux;
        WHILE clientes_cursor%found LOOP
                dbms_output.put_line(v_aux.cod_cliente ||
                ' -- Cliente: ' ||
                v_aux.nombres);
                OPEN facturas_cursor(v_aux.cod_cliente);
                FETCH facturas_cursor INTO v_aux1;
                v_total := 0;
                WHILE facturas_cursor%found LOOP
                        v_total := v_total + v_aux1.importe_total;
                        dbms_output.put_line('Factura: ' ||
                        v_aux1.cod_factura ||
                        ' Importe TOTAL: ' ||
                        v_aux1.importe_total);

                        FETCH facturas_cursor INTO v_aux1;
                END LOOP;

                CLOSE facturas_cursor;
                dbms_output.put_line(lpad('-', 40, '-'));
                FETCH clientes_cursor INTO v_aux;
        END LOOP;

        CLOSE clientes_cursor;
END reporte_cliente_ventas;
/

BEGIN
        reporte_cliente_ventas;
END;
/
/*PAQUETES*/
CREATE OR REPLACE PACKAGE pventas IS
        PROCEDURE actualizar_precio (
                p_precio       IN NUMBER,
                p_cod_producto IN VARCHAR2
        );

        FUNCTION producto_mas_vendido RETURN productos.descripcion%TYPE;

END pventas;
/
CREATE OR REPLACE PACKAGE BODY PVENTAS IS
  PROCEDURE ACTUALIZAR_PRECIO(p_precio IN NUMBER, p_cod_producto IN VARCHAR2) IS
  BEGIN
    UPDATE productos
    SET precio = p_precio
    WHERE cod_producto = p_cod_producto;

  END ACTUALIZAR_PRECIO;


  FUNCTION producto_mas_vendido RETURN VARCHAR2 IS
       v_producto
productos.descripcion%TYPE;

BEGIN
    /* Obtenemos el nombre del producto más vendido*/
        SELECT
                p.descripcion
        INTO v_producto
        FROM
                     productos p
                INNER JOIN detalle_facturas df ON p.cod_producto = df.cod_producto
        GROUP BY
                p.descripcion,
                p.cod_producto
        HAVING
                COUNT(df.cantidad) = (
                        SELECT
                                MAX(pedidoxcantidad)
                        FROM
                                (
                                        SELECT
                                                COUNT(cantidad) AS pedidoxcantidad
                                        FROM
                                                detalle_facturas
                                        GROUP BY
                                                cod_producto
                                )
                )
        ORDER BY
                COUNT(df.cantidad) DESC;

        RETURN v_producto;
END producto_mas_vendido;
/

ROLLBACK;


