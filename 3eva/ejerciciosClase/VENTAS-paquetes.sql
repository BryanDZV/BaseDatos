/*Crear un paquete que tenga un procedimiento para mostrar los datos de un cliente según su código.*/
CREATE OR REPLACE PACKAGE pk IS
/*AQUI TODO LO PUBLICO CABECERA CURSORES PROCE Y FUNC*/
        PROCEDURE datos_cliente (
                p_cod_cliente IN clientes.cod_cliente%TYPE
        );

END pk;
/
/*VERSION 1 CON RECORT*//*ALMACENA UNA FILA DE X COLUMNAS VARIAS FILAS TABLA*/
CREATE OR REPLACE PACKAGE BODY pk IS/*NO TIENE BEGIN EL PAQUETE*/
/*AQUI TODO LO PRIVADO*/
        PROCEDURE datos_cliente (
                p_cod_cliente IN clientes.cod_cliente%TYPE
        ) IS

        /* Declaramos el tipo de la variable v_aux correctamente*/
                TYPE t_datos_cliente IS RECORD (
                                cod_cliente clientes.cod_cliente%TYPE,
                                nombres     clientes.nombres%TYPE,
                                distrito    clientes.distrito%TYPE,
                                telefono    clientes.telefono%TYPE
                );
                v_aux     t_datos_cliente;  /* Usamos el tipo t_datos_cliente para la variable v_aux*/
       /*-variables para errores*/
                v_sqlcode NUMBER;
                v_sqlerrm VARCHAR2(70);
                CURSOR c_datos_cliente IS
                SELECT
                        cod_cliente,
                        nombres,
                        distrito,
                        telefono
                FROM
                        clientes
                WHERE
                        cod_cliente = p_cod_cliente;

        BEGIN
                OPEN c_datos_cliente;
                FETCH c_datos_cliente INTO v_aux;/*AQUI USO LA VARIABLE TYPE PODRIA USAR UNA TIPO CURSOR*/
                WHILE c_datos_cliente%found LOOP
                        dbms_output.put_line(lpad('-', 70, '-'));
                        dbms_output.put_line('DATOS EMPLEADO');
                        dbms_output.put_line(lpad('-', 70, '-'));
                        dbms_output.put_line(v_aux.cod_cliente ||
                        '    ' ||
                        v_aux.nombres);
                        dbms_output.put_line(v_aux.distrito ||
                        '    ' ||
                        v_aux.telefono);
                        FETCH c_datos_cliente INTO v_aux;
                END LOOP;

                CLOSE c_datos_cliente;
        EXCEPTION
                WHEN no_data_found THEN
                        v_sqlcode := sqlcode;
                        v_sqlerrm := sqlerrm;
                        dbms_output.put_line('No hay datos para el cliente con código: ' || p_cod_cliente
                        );
                        dbms_output.put_line('SQLCODE: ' || v_sqlcode);
                        dbms_output.put_line('ERRMM: ' || v_sqlerrm);
                WHEN OTHERS THEN
                        v_sqlcode := sqlcode;
                        v_sqlerrm := sqlerrm;
                        dbms_output.put_line('SQLCODE: ' || v_sqlcode);
                        dbms_output.put_line('ERRMM: ' || v_sqlerrm);
        END datos_cliente;

END pk;
/

BEGIN
        pk.datos_cliente('C0001');  /* Llamada correcta al procedimiento 'datos_cliente'*/
END;
/
/*VERSION 2 CON VARIABLE ROWTYPE*//*ALAMACENA 1 FILA CON TODAS LAS COLUMNAS /VARIAS FILAS TABLA*/
CREATE OR REPLACE PACKAGE BODY pk IS

        PROCEDURE datos_cliente (
                p_cod_cliente IN clientes.cod_cliente%TYPE
        ) IS
        /* Cursor definido fuera del bloque de ejecución*/
                CURSOR c_datos_cliente IS
                SELECT
                        nombres,
                        distrito,
                        telefono
                FROM
                        clientes
                WHERE
                        cod_cliente = p_cod_cliente;

        /* Variable del mismo tipo que el cursor*/
                v_aux c_datos_cliente%rowtype;
        BEGIN
                OPEN c_datos_cliente;
                FETCH c_datos_cliente INTO v_aux;  /* Primer FETCH antes del bucle*/

                WHILE c_datos_cliente%found LOOP
                        dbms_output.put_line('DATOS CLIENTE: ' ||
                        v_aux.nombres ||
                        ', Distrito: ' ||
                        v_aux.distrito ||
                        ', Teléfono: ' ||
                        v_aux.telefono);

                        FETCH c_datos_cliente INTO v_aux;  /* Siguiente FETCH dentro del bucle*/
                END LOOP;

                CLOSE c_datos_cliente;
        END datos_cliente;

END pk;
/
/****************************************************************************************/
/*EJERCICIO2
2.	Crear un paquete PK_facturas que contiene un procedimiento ver_facturas sobrecargado. 
Cuando le pasamos un identicador de  factura me visualiza la información de la factura y todos sus detalles*/
CREATE OR REPLACE PACKAGE pk_facturas AS
    PROCEDURE ver_facturas (p_cod_factura IN facturas.cod_factura%TYPE);  --  facturas por codigo de factura
    PROCEDURE ver_facturas;  --  todas las facturas
    PROCEDURE ver_facturas (p_cod_cliente IN facturas.cod_cliente%TYPE, p_mostrar_detalles IN BOOLEAN);  --  facturas de un cliente
END pk_facturas;
/

CREATE OR REPLACE PACKAGE BODY pk_facturas AS

    --  factura específica y sus detalles
    PROCEDURE ver_facturas (p_cod_factura IN facturas.cod_factura%TYPE) IS
        CURSOR c_ver_facturas IS
            SELECT f.cod_factura, f.fecha_emision, f.cod_cliente, 
                   df.cod_producto, df.cantidad, df.subtotal
            FROM facturas f
            LEFT JOIN detalle_facturas df ON f.cod_factura = df.cod_factura
            WHERE f.cod_factura = p_cod_factura;

        v_aux c_ver_facturas%ROWTYPE;
    BEGIN
        OPEN c_ver_facturas;
        FETCH c_ver_facturas INTO v_aux;
        
        WHILE c_ver_facturas%FOUND LOOP

            dbms_output.put_line('Factura: ' || v_aux.cod_factura);
            dbms_output.put_line('Fecha: ' || v_aux.fecha_emision);
            dbms_output.put_line('Cliente: ' || v_aux.cod_cliente);
            dbms_output.put_line('Producto: ' || v_aux.cod_producto || ', Cantidad: ' || v_aux.cantidad ||  ', Subtotal: ' || v_aux.subtotal);
            dbms_output.put_line('--------------------------------------------------------------------------------------------------------');
            FETCH c_ver_facturas INTO v_aux;
        END LOOP;

        CLOSE c_ver_facturas;
    END ver_facturas;

    -- todas las facturas
    PROCEDURE ver_facturas IS
        CURSOR c_ver_facturas IS
            SELECT f.cod_factura FROM facturas f;

        v_aux c_ver_facturas%ROWTYPE;
    BEGIN
        OPEN c_ver_facturas;
        FETCH c_ver_facturas INTO v_aux;

        WHILE c_ver_facturas%FOUND LOOP
            pk_facturas.ver_facturas(v_aux.cod_factura);  -- Le paso el parámetro desde otro procedimiento
            FETCH c_ver_facturas INTO v_aux;
        END LOOP;

        CLOSE c_ver_facturas;
    END ver_facturas;

    -- facturas de un cliente
    PROCEDURE ver_facturas (p_cod_cliente IN facturas.cod_cliente%TYPE, p_mostrar_detalles IN BOOLEAN) IS
        CURSOR c_ver_facturas_cliente IS
            SELECT f.cod_factura
            FROM facturas f
            WHERE f.cod_cliente = p_cod_cliente;

        v_aux c_ver_facturas_cliente%ROWTYPE;
    BEGIN
        OPEN c_ver_facturas_cliente;
        FETCH c_ver_facturas_cliente INTO v_aux;
        
        WHILE c_ver_facturas_cliente%FOUND LOOP
            IF p_mostrar_detalles THEN
                pk_facturas.ver_facturas(v_aux.cod_factura);  -- mostrar los detalles
            ELSE
                dbms_output.put_line('Factura: ' || v_aux.cod_factura);  -- Solo muestra la factura sin detalles
            END IF;
            FETCH c_ver_facturas_cliente INTO v_aux;
        END LOOP;

        CLOSE c_ver_facturas_cliente;
    END ver_facturas;

END pk_facturas;
/



-- ver una factura específica
BEGIN
    pk_facturas.ver_facturas('F0001');  
END;
/

--  ver todas las facturas Y SU detalles
BEGIN
    pk_facturas.ver_facturas;        
END;
/
-- todas las facturas del cliente con detalles
BEGIN
    pk_facturas.ver_facturas('C0004', TRUE);  
END;
/


