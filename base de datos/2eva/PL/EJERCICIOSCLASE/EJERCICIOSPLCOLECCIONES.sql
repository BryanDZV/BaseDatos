/*1. 
Crear un registro con el nombre , oficio, salario y lugar donde trabaja cada empleado. 
Coger en una colección, todos aquellos que ganen más de 1000 euros.*/
DECLARE
       TYPE emp_registro IS RECORD (
                     emp_nombre  VARCHAR2(70),
                     emp_oficio  VARCHAR2(70),
                     emp_salario NUMBER,
                     emp_lugar   VARCHAR2(70)
       );
       
       TYPE  TABLA_EMPLEADOS IS TABLE OF EMP_REGISTRO INDEX BY BINARY_INTEGER;
/*VARIABLE  TIPO TABLA*/
EMPLEADOS TABLA_EMPLEADOS;
BEGIN
SELECT E.ENAME,E.JOB,E.SAL,D.LOC
/*LOS VUELCO EN BULK ANTES Y LUEGO FILTRO*/
BULK COLLECT INTO EMPLEADOS
FROM EMP E
INNER JOIN DEPT D ON E.DEPTNO=D.DEPTNO
WHERE SAL > 1000;

/*APARTADO--Visualizar los datos de la colección y si no tuviese datos , nos lo debe indicar. */
IF EMPLEADOS.COUNT= 0 THEN
dbms_output.put_line('NO HAY EMPLEADOS');
ELSE
FOR i IN EMPLEADOS.FIRST..EMPLEADOS.LAST LOOP
dbms_output.put_line('EMPLEADO:  '|| EMPLEADOS(i).emp_nombre);
dbms_output.put_line('OFICIO EMPLEADO:  '|| EMPLEADOS(i).emp_oficio);
dbms_output.put_line('SALARIO EMPLEADO:  '|| EMPLEADOS(i).emp_salario);
dbms_output.put_line('LOCALIDAD EMPLEADO:  '|| EMPLEADOS(i).emp_lugar);
dbms_output.put_line('------------------------------------------------------------------');
END LOOP;
END IF;
END;

/*2. Crear una colección cuyo índice sea el numero de empleado de la tabla emp  
y que guarde toda la información de los empleados del departamento 20. */
DECLARE
TYPE EMPLEADO_REGISTRO IS RECORD(
NUMEROEMPLEADO EMP.EMPNO%TYPE,
NOMBRE  EMP.ENAME%TYPE,
OFICIO  EMP.JOB%TYPE,
MGR_REGISTRO  EMP.MGR%TYPE,
FECHA_CONTRATACION  EMP.HIREDATE%TYPE,
SALARIO EMP.SAL%TYPE,
COMISION EMP.COMM%TYPE,
DEPARTAMENTO EMP.DEPTNO%TYPE
);
TYPE COLECION_EMPLEADO IS TABLE OF EMPLEADO_REGISTRO INDEX BY BINARY_INTEGER;
EMPLEADOS COLECION_EMPLEADO;







/*A continuación visualizaremos la colección.*/