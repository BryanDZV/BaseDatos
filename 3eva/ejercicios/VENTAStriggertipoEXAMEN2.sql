/*EJERCICIO AVANZADO DE TRIGGER SOBRE EL SCRIPT VENTAS 
Eres parte del equipo de desarrollo de un sistema de facturación para una empresa de tecnología. Las tablas clientes, productos, facturas y detalle_facturas ya están creadas y pobladas.
El equipo necesita automatizar una serie de tareas cada vez que se registra un nuevo detalle de factura. Para ello, deberás diseñar tres triggers encadenados que se ejecuten cuando se inserte un nuevo detalle en la tabla detalle_facturas.

Diseña una cadena de tres triggers que cumplan las siguientes condiciones y se ejecuten en este orden:
1.	Trigger 1: Verifica que el producto insertado en detalle_facturas exista en la tabla productos. Si no existe, lanza un error.
2.	Trigger 2: Calcula automáticamente el subtotal del detalle de factura como cantidad * precio_unitario, sin que el usuario lo ingrese manualmente.
3.	Trigger 3: Una vez insertado el detalle, actualiza el campo importe_total de la factura correspondiente, sumando todos los subtotales de sus productos
*/
CREATE OR REPLACE TRIGGER trg_validacion BEFORE
       INSERT ON detalle_faacturas
       FOR EACH ROW
DECLARE
       vaux_cod_producto productos.cod_producto%TYPE;
       BEGIN
              SELECT
                     cod_producto
              INTO vaux_cod_producto
              FROM
                     productos
              WHERE
                     cod_producto = :new.COD_PRODUCTO;
                     dbms_output.put_line('EXISTE EL PRODUCTO');

       EXCEPTION
              WHEN no_data_found THEN
                     dbms_output.put_line('NO EXISTE EL PRODUCTO');
       END;
