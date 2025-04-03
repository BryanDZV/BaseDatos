/**
Ejercicio 1: Desarrollar un procedimiento que visualice el apellido y la fecha de alta de todos los empleados ordenados por apellido.
*/
CREATE OR REPLACE PROCEDURE listar_empleados IS
       CURSOR cur_emp IS
       SELECT
              ename,
              hiredate
       FROM
              emp
       ORDER BY
              ename;

BEGIN
       FOR rec IN cur_emp LOOP
              dbms_output.put_line('Empleado: '
                                   || rec.ename
                                   || ' - Fecha de Alta: '
                                   || to_char(rec.hiredate, 'DD-MON-YYYY'))
                                   ;
       END LOOP;
END listar_empleados;
/

DECLARE BEGIN
       listar_empleados;
END;
/
/**
	Ejercicio 2: Codificar un procedimiento que muestre el nombre de cada departamento 
       y el número de empleados que tiene.*/
CREATE OR REPLACE PROCEDURE contar_empleados IS

       CURSOR cur_dept IS
       SELECT
              d.dname,
              COUNT(e.empno) AS num_empleados
       FROM
              dept d
              LEFT JOIN emp  e ON d.deptno = e.deptno
       GROUP BY
              d.dname;

BEGIN
       FOR rec IN cur_dept LOOP
              dbms_output.put_line('Departamento: '
                                   || rec.dname
                                   || ' - Número de empleados: '
                                   || rec.num_empleados);
       END LOOP;
END contar_empleados;
/

DECLARE BEGIN
       contar_empleados;
END;

/*	Ejercicio 3: Escribir un procedimiento que reciba una cadena
y visualice el apellido y el número de empleado de todos los empleados cuyo apellido contenga la
cadena especificada. Al finalizar visualizar el número de empleados mostrados.*/
CREATE OR REPLACE PROCEDURE cadena (
       p_cadena IN VARCHAR2
) IS

       CURSOR cur_cadena IS
       SELECT
              e.ename,
              e.empno
       FROM
              emp e
       WHERE
              e.ename LIKE '%'
                           || p_cadena
                           || '%';

       vr_cadena cur_cadena%rowtype;
BEGIN
       OPEN cur_cadena;
       FETCH cur_cadena INTO vr_cadena;
       WHILE ( cur_cadena%found ) LOOP
              dbms_output.put_line('APELLIDO: '
                                   || vr_cadena.ename
                                   || ' - NUM-EMPLEADO: '
                                   || vr_cadena.empno);

              FETCH cur_cadena INTO vr_cadena;
       END LOOP;

       dbms_output.put_line('TOTAL EMPLEADO VISUALIZADOS:  ' || cur_cadena%rowcount
       );
       CLOSE cur_cadena;
END cadena;
/

DECLARE BEGIN
       cadena('A');
END;
/


/*	Ejercicio 4: Escribir un programa que visualice el apellido y el salario de los cinco 
empleados que tienen el salario más alto.*/
/*con for*/
CREATE OR REPLACE PROCEDURE sal_alto IS

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

BEGIN
       FOR rec IN cur_sal_alto LOOP
              dbms_output.put_line('APELLIDO:  '
                                   || rec.ename
                                   || '  SALARIO:  '
                                   || rec.sal);
       END LOOP;

       dbms_output.put_line('usando IMPLICITOS');
END sal_alto;
/

DECLARE BEGIN
       sal_alto;
END;
/
/*con OPEN,FETCH*/
CREATE OR REPLACE PROCEDURE sal_alto IS

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

       v_ename emp.ename%TYPE;
       v_sal   emp.sal%TYPE;
BEGIN
       OPEN cur_sal_alto;
       FETCH cur_sal_alto INTO
              v_ename,
              v_sal;
       WHILE cur_sal_alto%found LOOP
              dbms_output.put_line('APELLIDO: '
                                   || v_ename
                                   || ' SALARIO: '
                                   || v_sal);
              FETCH cur_sal_alto INTO
                     v_ename,
                     v_sal;
       END LOOP;

       dbms_output.put_line('USANDO explicitos');
       CLOSE cur_sal_alto;
END sal_alto;
/
/*	Ejercicio 5: Codificar un programa que visualice los dos empleados que ganan menos de cada oficio.*/

/*CREATE OR REPLACE PROCEDURE gan_menos IS*/
DECLARE
       CURSOR cur_gan_menos IS
       SELECT
              e1.ename,
              e1.sal,
              e1.job
       FROM
              emp e1
       WHERE
              e1.sal IN (
                     SELECT
                            MIN(e2.sal)
                     FROM
                            emp e2
                     WHERE
                            e2.job = e1.job
                     UNION ALL
                     SELECT
                            MIN(e3.sal)
                     FROM
                            emp e3
                     WHERE
                                   e3.job = e1.job
                            AND e3.sal > (
                                   SELECT
                                          MIN(e4.sal)
                                   FROM
                                          emp e4
                                   WHERE
                                          e4.job = e1.job
                            )
              )
       ORDER BY
              e1.job,
              e1.sal;

       v_ename emp.ename%TYPE;
       v_sal   emp.sal%TYPE;
       v_job   emp.job%TYPE;
BEGIN
       OPEN cur_gan_menos;
       LOOP
              FETCH cur_gan_menos INTO
                     v_ename,
                     v_sal,
                     v_job;
              EXIT WHEN cur_gan_menos%notfound;
              dbms_output.put_line('OFICIO: '
                                   || v_job
                                   || ' - EMPLEADO: '
                                   || v_ename
                                   || ' - SALARIO: '
                                   || v_sal);

       END LOOP;

       CLOSE cur_gan_menos;
END;
/

/*UPDATE EMP SET SAL = 1250 WHERE ENAME = 'MARTIN';*/


/*	Ejercicio 6: Escribir un programa que muestre. El listado será utilizando rupturas de control.	
•	Para cada empleado: apellido y salario.
•	Para cada departamento: Número de empleados y suma de los salarios del departamento.
•	Al final del listado: Número total de empleados y suma de todos los salarios
*/

CREATE OR REPLACE PROCEDURE listado_emp_dept IS

       CURSOR cur_empleados IS
       SELECT
              ename,
              sal
       FROM
              emp;

       CURSOR cur_departamentos IS
       SELECT
              d.dname,
              COUNT(e.ename) AS numero_empleados,
              SUM(e.sal)     AS suma_salarios
       FROM
              dept d
              LEFT JOIN emp  e ON d.deptno = e.deptno
       GROUP BY
              d.dname;

       vr_empleados      cur_empleados%rowtype;
       vr_departamentos  cur_departamentos%rowtype;
       v_total_empleados NUMBER := 0;
       v_total_salarios  NUMBER := 0;
BEGIN
       OPEN cur_empleados;
       FETCH cur_empleados INTO vr_empleados;
       WHILE ( cur_empleados%found ) LOOP
              dbms_output.put_line('APELLIDO: '
                                   || vr_empleados.ename
                                   || ' SALARIO: '
                                   || vr_empleados.sal);

              v_total_salarios := v_total_salarios + vr_empleados.sal;
              /*v_total_empleados := v_total_empleados + 1;*/
              v_total_empleados := cur_empleados%rowcount;
              FETCH cur_empleados INTO vr_empleados;
       END LOOP;

       CLOSE cur_empleados;
       dbms_output.put_line('-------------------------------------------------------------------'
       );
       OPEN cur_departamentos;
       FETCH cur_departamentos INTO vr_departamentos;
       WHILE ( cur_departamentos%found ) LOOP
              dbms_output.put_line('DEPARTAMENTO:'
                                   || vr_departamentos.dname
                                   || '// NUMERO EMPLEADOS:'
                                   || vr_departamentos.numero_empleados
                                   || '// SUMA SALARIO:'
                                   || vr_departamentos.suma_salarios);

              FETCH cur_departamentos INTO vr_departamentos;
       END LOOP;

       CLOSE cur_departamentos;
       dbms_output.put_line('-------------------------------------------------------------------'
       );
       dbms_output.put_line('TOTAL DE EMPLEADOS: ' || v_total_empleados);
       dbms_output.put_line('TOTAL DE SALARIOS: ' || v_total_salarios);
END listado_emp_dept;
/

DECLARE BEGIN
       listado_emp_dept;
END;

/**	Ejercicio 7: Desarrollar un procedimiento que permita insertar nuevos departamentos según las siguientes especificaciones:
•	Se pasará al procedimiento el nombre del departamento y la localidad.
•	El procedimiento insertará la fila nueva asignando como número de departamento la decena siguiente al número
       mayor de la  tabla. 
•	Se incluirá gestión de posibles errores.
*/
/*ALTER TABLE DEPT DROP COLUMN columna1 //borrar columnas*/
/*DELETE FROM DEPT WHERE DEPTNO = 50; //borar registros*/
/

CREATE OR REPLACE PROCEDURE insertar_departamento (
       p_nombre    IN VARCHAR2,
       p_localidad IN VARCHAR2
) IS

       v_num_depto  NUMBER := 0;
       CURSOR dept_cursor IS
       SELECT
              MAX(deptno) AS max_deptno
       FROM
              dept;

       CURSOR verificar_cursor IS
       SELECT
              dname,
              loc
       FROM
              dept
       WHERE
                     dname = p_nombre
              AND loc = p_localidad;

       vr_dept      dept_cursor%rowtype;
       vr_verificar verificar_cursor%rowtype;
BEGIN
       OPEN verificar_cursor;
       FETCH verificar_cursor INTO vr_verificar;
       IF verificar_cursor%found THEN
              dbms_output.put_line('El departamento "'
                                   || p_nombre
                                   || '" en la localidad "'
                                   || p_localidad
                                   || '". YA EXISTE.');

              CLOSE verificar_cursor;
              RETURN;
       END IF;
    
    /* Si no existe*/
       OPEN dept_cursor;
       FETCH dept_cursor INTO vr_dept;
       v_num_depto := ( vr_dept.max_deptno / 10 + 1 ) * 10;
       CLOSE dept_cursor;
       BEGIN
              INSERT INTO dept (
                     deptno,
                     dname,
                     loc
              ) VALUES ( v_num_depto,
                         p_nombre,
                         p_localidad );

              dbms_output.put_line('Departamento insertado con éxito: '
                                   || p_nombre
                                   || ' - '
                                   || p_localidad
                                   || ' (Deptno: '
                                   || v_num_depto
                                   || ')');

       END;

       CLOSE verificar_cursor;
END insertar_departamento;
/

/* ALTER TABLE dept MODIFY  dname VARCHAR2(50);*/
DECLARE BEGIN
       insertar_departamento('RECURSOS', 'MADRID');
END;
/
/*7*/
SELECT
       *
FROM
       dept;

DECLARE
       PROCEDURE insertar_depts (
              v_dname dept.dname%TYPE,
              v_loc   dept.loc%TYPE
       ) IS
              v_deptno dept.deptno%TYPE;
              aux      dept.deptno%TYPE;
       BEGIN
              SELECT
                     MAX(dept.deptno)
              INTO v_deptno
              FROM
                     dept;

              v_deptno := v_deptno + 10;
              SELECT
                     deptno
              INTO aux
              FROM
                     dept
              WHERE
                     v_dname = dname;

              raise_application_error(-20001, 'NOMBRE DUPLICADO');
       EXCEPTION
              WHEN no_data_found THEN
                     INSERT INTO dept VALUES ( v_deptno,
                                               v_dname,
                                               v_loc );

       END;

BEGIN
       insertar_depts('VENTAS', 'LONDON');
END;
/


/**Ejercicio 8: Escribir un procedimiento que reciba todos los datos de un nuevo empleado 
procese la transacción de alta, gestionando posibles errores.*/

CREATE OR REPLACE PROCEDURE alta_empleado (
       p_empno    IN NUMBER,
       p_ename    IN VARCHAR2,
       p_job      IN VARCHAR2,
       p_mgr      IN NUMBER,
       p_hiredate IN DATE,
       p_sal      IN NUMBER,
       p_comm     IN NUMBER,
       p_deptno   IN NUMBER
) IS
    /*----Variables específicas PARA VERIFICAR CON X CAMPOS*/
      /* v_nombre EMP.ENAME%TYPE;*/
    /*v_numero EMP.EMPNO%TYPE;*/
    /*----O VARIABLE ROW ESTRUCUTRA TENGO Q COGER TODO EN CONSULTA**/
   /* v_nombre EMP.ENAME%TYPE;*/
    /*v_numero EMP.EMPNO%TYPE;*/
       vr_verificar_empleado emp%rowtype;

    /* Cursor para verificar si el empleado ya existe*/
       CURSOR cur_verficar_empleado IS
       SELECT
              *
       FROM
              emp
       WHERE
              empno = p_empno;

BEGIN
       OPEN cur_verficar_empleado;
       FETCH cur_verficar_empleado INTO vr_verificar_empleado;
       IF cur_verficar_empleado%found THEN
              dbms_output.put_line('Error: El empleado con número '
                                   || p_empno
                                   || ' ya existe.');
              CLOSE cur_verficar_empleado;
              RETURN;
       END IF;

       CLOSE cur_verficar_empleado;
       INSERT INTO emp (
              empno,
              ename,
              job,
              mgr,
              hiredate,
              sal,
              comm,
              deptno
       ) VALUES ( p_empno,
                  p_ename,
                  p_job,
                  p_mgr,
                  p_hiredate,
                  p_sal,
                  p_comm,
                  p_deptno );

       dbms_output.put_line('Empleado '
                            || p_ename
                            || ' con número de empleado '
                            || p_empno
                            || ' ha sido dado de alta correctamente.');

END alta_empleado;
/
/*-ALTER TABLE EMP DROP COLUMN NUEVA_COLUMNA;*/
/*ALTER TABLE EMP DROP COLUMN TOTAL2;*/
DECLARE BEGIN
       alta_empleado(1234, 'Juan Perez', 'ANALYST', 7839, TO_DATE('2025/03/06'
       ,
                     'YYYY/MM/DD'), 2500, 2, 10);
END;
/

ROLLBACK;

/**
	Ejercicio 9: Codificar un procedimiento reciba como parámetros un numero de departamento, 
       un importe y un porcentaje; y suba el salario a todos los empleados del departamento indicado en la llamada.
       La subida será el porcentaje o el importe indicado en la llamada (el que sea más beneficioso para el empleado en 
       cada caso).*/
CREATE OR REPLACE PROCEDURE subir_salario(
    p_deptno   IN emp.deptno%TYPE,
    p_importe   IN NUMBER,
    p_porcentaje IN NUMBER
) AS
    CURSOR cur_subir_salario IS
        SELECT empno, sal
        FROM emp
        WHERE deptno = p_deptno;
    
    v_nuevo_salario NUMBER;
BEGIN
OPEN cur_subir_salario;
FETCH cur_subir_salario INTO v_nuevo_salario;
WHILE(cur_subir_salario%FOUND) LOOP
IF p_importe >  ( cur_subir_salario.sal * ( p_porcentaje / 100 ) 
v_nuevo_salario:= cur_subir_salario.sal+p_importe
else
v_nuevo_salario=
 
        
        -- Actualizamos el salario del empleado con la opción más beneficiosa
        UPDATE empleados
        SET salario = v_nuevo_salario
        WHERE emp_no = r_emp.emp_no;
    END LOOP;
    
    COMMIT;
END subir_salario;

   UPDATE emp
       SET
              sal =
                     CASE
                            WHEN ( sal * ( p_porcentaje / 100 ) ) > p_importe
                            THEN
                                   sal + ( sal * ( p_porcentaje / 100 ) )
                            ELSE
                                   sal + p_importe
                     END
       WHERE
              deptno = p_deptno;

       dbms_output.put_line('Se han actualizado los salarios en el departamento ' || p_deptno
       );


CREATE OR REPLACE PROCEDURE subir_salario (
       p_deptno     IN NUMBER,
       p_importe    IN NUMBER,
       p_porcentaje IN NUMBER
) IS
CURSOR actualizar_salario
is


BEGIN
    
END subir_salario;
/

BEGIN
       subir_salario(10, 200, 10);
END;
/

COMMIT;

--9
declare
    procedure subir_sueldo (v_deptno emp.deptno%type, v_importe number, v_porcentaje number)
    is
        cursor c_emples is
            select empno, sal from emp where deptno = v_deptno for update;
        v_emple c_emples%rowtype;
        v_salnuevo emp.sal%type;
    begin
        open c_emples;
        fetch c_emples into v_emple;
        while (c_emples%found) loop
            if (v_emple.sal * v_porcentaje / 100 > v_importe) then
                v_salnuevo:=v_emple.sal+v_emple.sal*v_porcentaje/100;
            else
                v_salnuevo:=v_emple.sal+v_importe;
            end if;
            update emp
            set sal = v_salnuevo
            where current of c_emples;
            fetch c_emples into v_emple;
        end loop;
        close c_emples;
    end;
begin
    subir_sueldo (30, 100, 30);
end;
/
rollback;
select * from emp;
/*10*/
CREATE OR REPLACE PROCEDURE subir_sueldo_inferior_promedio AS
    
    CURSOR c_empleados IS
        SELECT E.ENAME, E.SAL, E.JOB
        FROM EMP e
        WHERE e.SAL < (SELECT AVG(E1.SAL) FROM EMP E1 WHERE E1.JOB = e.JOB)
        FOR UPDATE;

    V_ENAME EMP.ENAME%TYPE;
    V_SAL EMP.SAL%TYPE;
    V_JOB EMP.JOB%TYPE;
    v_salario_medio NUMBER;
    v_nuevo_salario
number;

BEGIN
       OPEN c_empleados;
       FETCH c_empleados INTO
              v_ename,
              v_sal,
              v_job;
       WHILE c_empleados%found LOOP
              SELECT
                     AVG(e1.sal)
              INTO v_salario_medio
              FROM
                     emp e1
              WHERE
                     e1.job = v_job;

              v_nuevo_salario := v_sal + ( ( v_salario_medio - v_sal ) * 0.5
              );
              UPDATE emp
              SET
                     sal = v_nuevo_salario
              WHERE
                     ename = v_ename;

              FETCH c_empleados INTO
                     v_ename,
                     v_sal,
                     v_job;
       END LOOP;

       CLOSE c_empleados;
END subir_sueldo_inferior_promedio;
/
/*11*/

declare
    cursor c_emples is
    select * from emp
    order by ename;
    v_emple c_emples%rowtype;
    v_compres number(10);
    v_total number(10);
    v_trienio number(10);
begin
    open c_emples;
    fetch c_emples into v_emple;
    while (c_emples%found) loop
        select count(*) into v_compres from emp where mgr = v_emple.empno;
        v_compres:=v_compres*10000;
        v_trienio:=trunc(months_between(sysdate,v_emple.hiredate)/12/3)*5000;
        v_total:=v_emple.sal+v_compres+nvl(v_emple.comm,0)+v_trienio;
        dbms_output.put_line('********************************************');
        dbms_output.put_line('Liquidación del empleado: ' || v_emple.ename || ' Dpto: ' || v_emple.deptno || ' Oficio: ' || v_emple.job);
        dbms_output.put_line('Salario: ' || v_emple.sal);
        dbms_output.put_line('Trienios: ' || v_trienio);
        dbms_output.put_line('Comp. responsabilidad: ' || v_compres);
        dbms_output.put_line('Comisión: ' || nvl(v_emple.comm,0));
        dbms_output.put_line('-------------');
        dbms_output.put_line('Total: ' || v_total);
        fetch c_emples into v_emple;
    end loop;
    close c_emples;
end;
/



/*12*/
CREATE TABLE T_liquidacion (
    apellido VARCHAR2(50),
    departamento NUMBER,
    oficio VARCHAR2(50),
    salario NUMBER(10,2),
    trienios NUMBER(10,2),
    comp_responsabilidad NUMBER(10,2),
    comision NUMBER(10,2),
    total NUMBER(10,2)
);


ROLLBACK;