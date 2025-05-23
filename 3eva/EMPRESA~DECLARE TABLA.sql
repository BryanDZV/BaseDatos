DECLARE
    -- Definir tabla para almacenar múltiples registros
    TYPE tablaEmpleados IS TABLE OF emp%ROWTYPE INDEX BY BINARY_INTEGER;
    
    -- Variable para almacenar los empleados
    empleados tablaEmpleados;
BEGIN
    -- Almacenar varias filas en la colección
    SELECT * BULK COLLECT INTO empleados FROM emp WHERE sal > 3000;

    -- Recorrer la colección usando el índice de la tabla
    FOR i IN empleados.FIRST..empleados.LAST LOOP
        -- Verificar si el índice es válido
        IF i IS NOT NULL THEN
            dbms_output.put_line('Empleado: ' || empleados(i).ENAME || ', Salario: ' || empleados(i).SAL);
        END IF;
    END LOOP;
END;
