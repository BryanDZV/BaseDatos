DECLARE
       TYPE variable_registro IS RECORD (
                     campo_deptno NUMBER,
                     campo_ename    VARCHAR2(70)
       );
       empleado variable_registro;
BEGIN
       SELECT
              deptno,
              ename
       INTO
              empleado.campo_deptno,
              empleado.campo_ename
       FROM
              emp
       WHERE
              ename = 'ADAMS';

       dbms_output.put_line('Departmento Numero: ' || empleado.campo_deptno);
       dbms_output.put_line('Nombre de Empleado: ' || empleado.campo_ename);
END;