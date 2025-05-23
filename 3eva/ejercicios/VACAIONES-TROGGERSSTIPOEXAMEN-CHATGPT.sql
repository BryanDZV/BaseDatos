/*EJEMPLO DE MODIFICAR OTRAS FILAS DE UNA TABLA QUE TIENE LA FILA QUE ACTIVO EL TRIGGER
¡Perfecto! Te mostraré un ejemplo detallado para solucionar el problema de modificar **otras filas de la misma tabla** sin provocar el error de **mutating table**. Para esto, utilizaremos un **paquete PL/SQL** junto con triggers a nivel de **sentencia** (`AFTER STATEMENT`).

### 🟢 **Paso 1: Crear el Paquete PL/SQL**

Primero, vamos a crear un **paquete** que almacene temporalmente las filas que necesitamos modificar. Luego, usaremos este paquete en el trigger para modificar las filas de la tabla.

#### Paquete (Package):

```sql
-- Paquete PL/SQL para almacenar datos temporales
CREATE OR REPLACE PACKAGE pkg_empleados AS
  -- Declaramos una colección para almacenar IDs de empleados
  TYPE t_empleados IS TABLE OF NUMBER;
  g_empleados t_empleados;  -- Variable global para almacenar los empleados afectados
END pkg_empleados;
/

-- Paquete de implementación (cuerpo)
CREATE OR REPLACE PACKAGE BODY pkg_empleados AS

  -- Procedimiento para agregar empleados a la lista
  PROCEDURE agregar_empleado(p_id_empleado IN NUMBER) IS
  BEGIN
    g_empleados.EXTEND;
    g_empleados(g_empleados.COUNT) := p_id_empleado;
  END agregar_empleado;

END pkg_empleados;
/
```

### 🟡 **Paso 2: Crear el Trigger `BEFORE` para agregar los empleados a la colección**

El siguiente paso es usar un **trigger `BEFORE`** para agregar los empleados que han sido **actualizados** o **insertados** a nuestra colección en el paquete.

```sql
-- Trigger BEFORE para almacenar empleados afectados
CREATE OR REPLACE TRIGGER trg_before_update_empleados
BEFORE UPDATE ON empleados
FOR EACH ROW
BEGIN
  -- Agregar el ID del empleado a la colección en el paquete
  pkg_empleados.agregar_empleado(:NEW.id_empleado);
END;
/
```

Con este trigger, cada vez que un empleado se actualice, el **ID del empleado** afectado se almacenará en la colección `g_empleados` del paquete.

### 🟢 **Paso 3: Crear el Trigger `AFTER` a nivel de sentencia**

Ahora, utilizaremos un trigger **`AFTER STATEMENT`** para aplicar las modificaciones en la tabla **empleados**, usando los valores guardados en el paquete. Este trigger se ejecutará una vez después de que todas las filas hayan sido procesadas.

```sql
-- Trigger AFTER para modificar otras filas de la tabla
CREATE OR REPLACE TRIGGER trg_after_update_empleados
AFTER UPDATE ON empleados
DECLARE
  v_empleado_id NUMBER;
BEGIN
  -- Recorremos la colección de empleados afectados
  FOR i IN 1 .. pkg_empleados.g_empleados.COUNT LOOP
    v_empleado_id := pkg_empleados.g_empleados(i);
    
    -- Ahora modificamos la fila, por ejemplo, incrementando el salario
    UPDATE empleados
    SET salario = salario * 1.1
    WHERE id_empleado = v_empleado_id;
  END LOOP;

  -- Limpiar la colección después de usarla
  pkg_empleados.g_empleados := pkg_empleados.t_empleados(); 
END;
/
```

Este trigger **modifica otras filas de la tabla `empleados`** (en este caso, incrementando el salario de los empleados afectados) después de que la actualización se haya realizado.

### 🧠 **Explicación del proceso**:

1. **Trigger `BEFORE`**: Guarda los **IDs de los empleados** afectados en una colección del paquete `pkg_empleados`.
2. **Trigger `AFTER`**: Después de la actualización, el trigger recorre la colección y aplica **modificaciones** a las filas correspondientes.

### 🔄 **¿Por qué funciona?**
- El trigger `AFTER STATEMENT` se ejecuta una sola vez **después** de que se haya procesado toda la sentencia (es decir, después de que todas las filas han sido modificadas). Al no operar fila por fila, no se genera el error de "mutating table".
- Usamos un **paquete** para almacenar temporalmente los registros afectados, lo que nos permite acceder a esos datos después, sin problemas de mutación.

---

### ✅ **Resumen del flujo:**

1. **Trigger `BEFORE`**: Guarda los empleados afectados en el paquete.
2. **Trigger `AFTER STATEMENT`**: Modifica otras filas de la tabla, usando la información almacenada en el paquete.

---

¡Y listo! Así puedes modificar otras filas de la misma tabla sin causar errores de mutación. ¿Te gustaría hacer alguna modificación o agregar algo más a este ejemplo?

*/


/*EJERCICIO AVANZADO DE TRIGGER SOBRE EL SCRIPT VENTAS -TIPOEXAMEN
1.	Trigger 1: Verifica que el producto insertado en detalle_facturas exista en la tabla productos.
Si no existe, lanza un error.*/
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
INSERT  INTO DETALLE_FACTURAS
VALUES('F0011','P0003',89,20);
/
/* Trigger 2: Calcular automáticamente el subtota
Calcula automáticamente el subtotal multiplicando la cantidad por el precio unitario del producto.*/

SELECT DF.CANTIDAD,P.PRECIO_UNITARIO
FROM DETALLE_FACTURAS DF
INNER JOIN PRODUCTOS P ON DF.COD_PRODUCTO=P.COD_PRODUCTO
/
CREATE OR REPLACE  TRIGGER TRG_SUBTOTAL
BEFORE INSERT ON DETALLE_FACTURAS
FOR EACH ROW
DECLARE
VAUXCOD_PRODUCTO PRODUCTOS.COD_PRODUCTO%TYPE;
BEGIN
 -- Buscar precio del producto
SELECT COD_PRODUCTO INTO VAUXCOD_PRODUCTO
FROM PRODUCTOS
WHERE COD_PRODUCTO=:NEW.COD_PRODUCTO;

--CALCULAR LA CLUMNA BEFORE USO :NEW
:NEW.SUBTOTAL:=:NEW.CANTIDAD*VAUXCOD_PRODUCTO;

END;


/

/*Actualizar el importe total de la factura.Este trigger se ejecutará después de insertar 
un detalle de factura. Actualiza el campo importe_total en la tabla facturas, sumando 
todos los subtotales de los detalles asociados a la factura*/

SELECT SUM(SUBTOTAL)AS TOTAL_FACTURA
FROM DETALLE_FACTURAS
GROUP BY COD_FACTURA;
/
CREATE OR REPLACE TRIGGER TRG_IMPORTE_TOTAL
AFTER INSERT ON DETALLE_FACTURAS
FOR EACH ROW
DECLARE
VAUX_IMPORTE_TOTAL FACTURAS.IMPORTE_TOTAL%TYPE;
BEGIN
SELECT SUM(SUBTOTAL)AS TOTAL_FACTURA INTO VAUX_IMPORTE_TOTAL
FROM DETALLE_FACTURAS
WHERE COD_FACTURA=:NEW.COD_FACTURA;

UPDATE FACTURAS
SET IMPORTE_TOTAL=VAUX_IMPORTE_TOTAL
WHERE COD_FACTURA=:NEW.COD_FACTURA;

END;
/

/*Ejercicio 1: Verificación de existencia de cliente y actualización de descuento
Descripción:
Crear un trigger que verifique si un cliente existe en la tabla clientes cuando 
se inserta un detalle de factura.Si el cliente no existe, el trigger lanzará un error. 
Además, si el cliente es "VIP" (indicado en la tabla clientes), se debe aplicar un descuento del 5%
al subtotal.*/
CREATE OR REPLACE TRIGGER TRG_VALIDACION_CLIENTE
BEFORE INSERT ON DETALLE_FACTURAS
FOR EACH ROW
DECLARE
BEGIN
        BEGIN
        --VALIDAR SI EXISTE LA FACTURA
        SELECT COD_FACTURA INTO VAUXCOD_FACTURA
        FROM FACTURAS
        WHERE COD_FACTURA=:NEW.FACTURA;
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
        DBMS_OUPUT.PUT_LINE('NO EXISTE LA FACTUR');
        RAISE_APLICATION_ERROR('NO EXISTE LA FACTURA');
        END;
        BEGIN
        --VALIDAR QUE EXITE EL CLIENTE/ASOCIADO A ESA FACTURA
        SELECT COD_CLIENTE INTO VAUXCOD_CLIENTE
        FROM FACTURAS
        WHERE COD_FACTURA=VAUXCOD_FACTURA;
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('NO EXISTE CLIENTE ASOCIADO A ESA FACTURA');
        RAISE_APLICATION_ERROR('NO EXISTE EL CLIENTE');
        END;
        --SI ES VIP7DESCUETO 5% 100-5=95/100=0.95 Y 0.95=0.05
        IF VAUXCOD_CLIENTE='VIP' THEN
        :NEW.SUBTOTAL= :NEW.subtotal - (:NEW.subtotal * 0.05);
        --:NEW.SUBTOTAL=:NEW.SUBTOTAL*0.95

END;

/*Ejercicio 2: Actualización automática del stock después de una venta
Descripción:
Crear un trigger que, después de insertar un detalle de factura, actualice automáticamente el stock de productos en la tabla productos.*/

--ME CREO UNA STOCK APRA PODER HACER EL JEERCICIO
/
ALTER TABLE PRODUCTOS
ADD(STOCK NUMBER);
UPDATE PRODUCTOS 
SET STOCK=50
WHERE COD_PRODUCTO='P0001';
/
CREATE OR REPLACE TRIGGER TGR_STOCK
AFTER INSERT ON DETALLE_FACTURAS
FOR EACH ROW
DECLARE
    VAUX_STOCK PRODUCTOS.STOCK%TYPE;
BEGIN
    -- VALIDACIÓN DEL STOCK
    BEGIN
        SELECT STOCK INTO VAUX_STOCK
        FROM PRODUCTOS
        WHERE COD_PRODUCTO = :NEW.COD_PRODUCTO;

        -- Verificar que hay stock suficiente
        IF VAUX_STOCK < :NEW.CANTIDAD THEN
            RAISE_APPLICATION_ERROR(-20003, 'Stock insuficiente.');
        END IF;

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20001, 'Producto no encontrado.');
    END;

    -- ACTUALIZAR STOCK
    UPDATE PRODUCTOS
    SET STOCK = STOCK - :NEW.CANTIDAD
    WHERE COD_PRODUCTO = :NEW.COD_PRODUCTO;
END;
/
/*Ejercicio 3: Validación de fecha de compra
Descripción:
Crear un trigger que verifique que la fecha de la factura no sea una fecha futura cuando se inserte un registro en la tabla facturas.*/

CREATE OR REPLACE TRIGGER TRG_VALICION_FECHA
BEFORE INSERT ON FACTURAS
FOR EACH ROW
DECLARE
BEGIN
--VALIDACION FECHA
IF :NEW.FECHA_EMISION>SYSDATE THEN
RAISE_APPLICATION_ERROR(-20003,'FECHA NO PEUDE SER FUTRURA');
END IF;

END;

/*Ejercicio 4: Recalcular total de factura cuando se actualiza un detalle
Descripción:
Crear un trigger que, cuando se actualice un detalle de factura (por ejemplo, cambiando la cantidad o el precio unitario), recalculé el importe_total de la factura.*/

CREATE OR REPLACE TRIGGER TRG_ACTUALIZACION
AFTER UPDATE ON DETALLE_FACTURAS
FOR EACH ROW
DECLARE 

BEGIN
 -- Recalcular el importe total de la factura
    UPDATE facturas
    SET importe_total = (SELECT SUM(subtotal) FROM detalle_facturas WHERE COD_FACTURA = :NEW.COD_factura)
    WHERE COD_FACTURA = :NEW.COD_factura;


END;

/*Ejercicio 6. Restringir ventas por distrito
Objetivo: No permitir insertar detalles si el cliente no es del distrito "Lince".*/

CREATE OR REPLACE TRIGGER TRG_DISTRITO
BEFORE INSERT ON DETALLE_FACTURAS
FOR EACH ROW
DECLARE
VAUX_DISTRITO CLIENTES.DISTRITO%TYPE;
BEGIN

--VALIDAR QUE CLIENTE SEA DE DISTRITO LINCE

SELECT C.DISTRITO INTO VAUX_DISTRITO
FROM CLIENTES C
INNER JOIN FACTURAS F ON F.COD_CLIENTE=C.COD_CLIENTE
WHERE F.COD_FACTURA=:NEW.COD_FACTURA;

  IF VAUX_DISTRITO <> 'Lince' THEN
    RAISE_APPLICATION_ERROR(-20003, 'Solo se permiten ventas a clientes de Lince.');
  END IF;

END;
/















