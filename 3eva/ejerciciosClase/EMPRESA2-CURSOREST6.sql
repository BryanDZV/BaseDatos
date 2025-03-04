CREATE OR REPLACE PROCEDURE listar_empleados
IS
    CURSOR cur_emp IS
        SELECT ENAME, HIREDATE 
        FROM EMP
        ORDER BY ENAME;
BEGIN
    FOR rec IN cur_emp LOOP
        DBMS_OUTPUT.PUT_LINE('Empleado: ' || rec.ENAME || ' - Fecha de Alta: ' || TO_CHAR(rec.HIREDATE, 'DD-MON-YYYY'));
    END LOOP;
END listar_empleados;
/
DECLARE
BEGIN
listar_empleados;
END;
/

CREATE OR REPLACE PROCEDURE contar_empleados
IS
    CURSOR cur_dept IS
        SELECT D.DNAME, COUNT(E.EMPNO) AS NUM_EMPLEADOS
        FROM DEPT D
        LEFT JOIN EMP E ON D.DEPTNO = E.DEPTNO
        GROUP BY D.DNAME;
BEGIN
    FOR rec IN cur_dept LOOP
        DBMS_OUTPUT.PUT_LINE('Departamento: ' || rec.DNAME || ' - Número de empleados: ' || rec.NUM_EMPLEADOS);
    END LOOP;
END contar_empleados;
/

DECLARE
BEGIN
contar_empleados;
END;

CREATE OR REPLACE  NUM_EMPLEADOS
IS
BEGIN
