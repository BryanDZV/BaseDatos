-- TRIGGER 1: Verificar que el producto existe
CREATE OR REPLACE TRIGGER trg_verificar_producto
BEFORE INSERT ON detalle_facturas
FOR EACH ROW
DECLARE
  V_PRODUCTO productos.cod_producto%TYPE;
BEGIN
  SELECT cod_producto INTO V_PRODUCTO
  FROM productos
  WHERE cod_producto = :NEW.cod_producto;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20001, 'El producto no existe en la tabla productos.');
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20001,'A EXITE.');
    
END;
/
-- TRIGGER 2: Calcular el subtotal automáticamente
CREATE OR REPLACE TRIGGER trg_calcular_subtotal
BEFORE INSERT ON detalle_facturas
FOR EACH ROW
DECLARE
  v_precio productos.precio_unitario%TYPE;
BEGIN
  SELECT precio_unitario INTO v_precio
  FROM productos
  WHERE cod_producto = :NEW.cod_producto;

  :NEW.subtotal := :NEW.cantidad * v_precio;
END;
/
-- TRIGGER 3: Actualizar el importe total de la factura
CREATE OR REPLACE TRIGGER trg_actualizar_importe_total
AFTER INSERT ON detalle_facturas
FOR EACH ROW
BEGIN
  UPDATE facturas
  SET importe_total = (
    SELECT SUM(subtotal)
    FROM detalle_facturas
    WHERE cod_factura = :NEW.cod_factura
  )
  WHERE cod_factura = :NEW.cod_factura;
END;
/


--Ejecuta esta prueba con un producto que **sí existe**:

INSERT INTO detalle_facturas (cod_factura, cod_producto, cantidad, subtotal)
VALUES ('F0010', 'P0009', 2, 500);  


--Y esta prueba con un producto que **no existe**:


INSERT INTO detalle_facturas (cod_factura, cod_producto, cantidad, subtotal)
VALUES ('F0010', 'PX999', 2, 0);  -- Lanzará error: producto no existe

