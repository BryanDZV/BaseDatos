--Ejercicio 1: Desarrollar un procedimiento que visualice el apellido 
--y la fecha de alta de todos los empleados ordenados por apellido.

SELECT ENAME, HIREDATE 
FROM EMP
ORDER BY ENAME;

--Ejercicio 2: Codificar un procedimiento que muestre el nombre de cada 
--departamento y el número de empleados que tiene.

SELECT D.DNAME,COUNT(E.EMPNO)
FROM DEPT D 
LEFT JOIN EMP E ON D.DEPTNO=E.DEPTNO
GROUP BY D.DNAME;

--	Ejercicio 3: Escribir un procedimiento que reciba una cadena y
--visualice el apellido y el número de empleado de todos los empleados cuyo
--apellido contenga la cadena especificada. Al finalizar visualizar el número de
--empleados mostrados.

SELECT E.ENAME,E.EMPNO
FROM EMP E
WHERE E.ENAME LIKE  'MARTIN'

/

SELECT ename, sal
FROM (
    SELECT ename, sal
    FROM emp 
    ORDER BY sal DESC
)
WHERE ROWNUM <= 5;
SELECT e.ename, e.sal
FROM (
    SELECT e1.ename, e1.sal
    FROM emp e1
    ORDER BY e1.sal DESC
) e
WHERE ROWNUM <= 5;
/
/*EJEMPLO*/
CREATE OR REPLACE PROCEDURE sal_alto_con_control_while IS

    CURSOR cur_sal_alto IS
    SELECT
        e.ename,
        e.sal
    FROM
        (
            SELECT
                e1.ename,
                e1.sal
            FROM
                emp e1
            ORDER BY
                e1.sal DESC
        ) e
    WHERE
        ROWNUM <= 5;

    -- Variables para almacenar los resultados del cursor
    v_ename emp.ename%TYPE;
    v_sal emp.sal%TYPE;

    -- Umbral de salario
    v_sal_umbral CONSTANT NUMBER := 5000;

BEGIN
    -- Abrir el cursor
    OPEN cur_sal_alto;

    -- Inicializar la variable de control
    FETCH cur_sal_alto INTO v_ename, v_sal;
    
    -- Usar un WHILE para recorrer los registros
    WHILE cur_sal_alto%FOUND LOOP
        -- Validación del salario
        IF v_sal > v_sal_umbral THEN
            -- Si el salario es mayor al umbral, mostrar el registro
            dbms_output.put_line('APELLIDO: ' || v_ename || ' SALARIO: ' || v_sal);
        ELSIF v_sal = 7000 THEN
            -- Si el salario es exactamente 7000, realizar una acción especial
            dbms_output.put_line('¡Alerta! El salario de ' || v_ename || ' es exactamente 7000.');
        END IF;
        
        -- Volver a hacer FETCH para la siguiente fila
        FETCH cur_sal_alto INTO v_ename, v_sal;
    END LOOP;

    -- Cerrar el cursor
    CLOSE cur_sal_alto;

EXCEPTION
    WHEN OTHERS THEN
        -- Manejo de excepciones: si ocurre un error, cerrar el cursor y mostrar el mensaje
        IF cur_sal_alto%ISOPEN THEN
            CLOSE cur_sal_alto;
        END IF;
        dbms_output.put_line('Ocurrió un error: ' || SQLERRM);
END sal_alto_con_control_while;
/




ROLLBACK;







