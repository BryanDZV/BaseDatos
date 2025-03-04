CREATE TABLE productos (
       id_producto   NUMBER
              CONSTRAINT productos_id_producto_pk PRIMARY KEY,
       nombre        VARCHAR2(50)
              CONSTRAINT productos_nombre_uq UNIQUE
       NOT NULL,
       precio        NUMBER(10, 2)
              CONSTRAINT productos_precio_ck CHECK ( precio > 0 ),
       stock         NUMBER
              CONSTRAINT productos_stock_ck CHECK ( stock >= 1 ),
       categoría     VARCHAR2(20)
              CONSTRAINT prodcutos_categoría_ck CHECK ( categoría IN ( 'ELECTRONICA',
              'ROPA', 'HOGAR' ) ),
       fecha_ingreso DATE DEFAULT sysdate
);

DROP TABLE productos;

ALTER TABLE productos DROP CONSTRAINT productos_nombre_uq;

ALTER TABLE productos ADD CONSTRAINT productos_nombre_uq UNIQUE ( nombre );

ALTER TABLE productos MODIFY
       nombre NOT NULL;
/*triiger*/

CREATE OR REPLACE VIEW resumen_salarios AS
       SELECT
              d.dname,
              round(
                     avg(e.sal),
                     2
              )          AS salario_promedio,
              MIN(e.sal) AS salario_minimo,
              MAX(e.sal) AS salario_maximo
       FROM
                   emp e
              INNER JOIN dept d ON e.deptno = d.deptno
       GROUP BY
              d.dname
       HAVING
              AVG(e.sal) > 2000;

SELECT
       e.ename,
       e.sal,
       d.dname
FROM
            emp e
       INNER JOIN dept d ON e.deptno = d.deptno
WHERE
       e.sal > (
              SELECT
                     AVG(e1.sal) AS salario_prom
              FROM
                     emp e1
       );

SELECT
       ename
FROM
       emp
WHERE
       ename LIKE '__A__';

ALTER TABLE emp
       ADD CONSTRAINT emp_sal_clerk_ck
              CHECK ( sal >= 1000
                      OR job = 'CLERK' );

DELETE FROM emp e1
WHERE
       sal <= (
              SELECT
                     sal
              FROM
                     emp e2
              WHERE
                     (
                            SELECT
                                   COUNT(*)
                            FROM
                                   emp e3
                            WHERE
                                   e3.sal <= e2.sal
                     ) <= (
                            SELECT
                                   COUNT(*) * 0.10
                            FROM
                                   emp
                     )
       );

SELECT
       ename,
       hiredate,
       add_months(hiredate, 120) AS promocion
FROM
       emp;

SELECT
       e.deptno,
       COUNT(e.ename) AS total_empleados
FROM
       emp e
WHERE
       e.sal > 2500
GROUP BY
       e.deptno
HAVING
       COUNT(e.ename) > 0.5 * (
              SELECT
                     COUNT(e1.ename)
              FROM
                     emp e1
              WHERE
                     e.deptno = e1.deptno
       );

CREATE SEQUENCE secuencia_id START WITH 1 INCREMENT BY 1;

INSERT INTO productos (
       id_producto,
       nombre,
       precio,
       stock,
       categoría,
       fecha_ingreso
) VALUES ( secuencia_id.NEXTVAL,
           'BOLA',
           10,
           40,
           'ELECTRONICA',
           sysdate );

INSERT INTO productos (
       id_producto,
       nombre,
       precio,
       stock,
       categoría,
       fecha_ingreso
) VALUES ( 45,
           'VIBRADOR',
           50,
           100,
           'ELECTRONICA',
           sysdate );

UPDATE emp e
SET
       e.sal = e.sal * 1.1
WHERE
       e.sal < (
              SELECT
                     AVG(e1.sal)
              FROM
                     emp e1
              WHERE
                     e1.deptno = e.deptno
              GROUP BY
                     deptno
       );

SELECT
       *
FROM
       emp
MINUS
SELECT
       *
FROM
       emp
WHERE
       deptno = (
              SELECT
                     deptno
              FROM
                     emp
              GROUP BY
                     deptno
              HAVING
                     AVG(sal) = (
                            SELECT
                                   MIN(AVG(sal))
                            FROM
                                   emp
                            GROUP BY
                                   deptno
                     )
       );

SELECT
       ename,
       sal
FROM
       emp
WHERE
       sal > 2850;

SELECT
       ename,
       deptno
FROM
       emp
WHERE
       empno = 7566;

SELECT
       *
FROM
       emp
WHERE
       sal NOT BETWEEN 1500 AND 2850;

SELECT
       ename,
       job,
       hiredate
FROM
       emp
WHERE
       hiredate BETWEEN TO_DATE('20-02-1981', 'DD-MM-YYYY') AND TO_DATE('01-05-1981',
       'DD-MM-YYYY');

SELECT
       ename,
       deptno
FROM
       emp
WHERE
       deptno IN ( 10, 30 )
ORDER BY
       ename;

SELECT
       ename AS "EMPLEADO",
       sal   AS "SALARIO MENSUAL"
FROM
       emp
WHERE
       deptno = 10
       OR deptno = 30
       AND sal > 1500;

SELECT
       ename,
       hiredate
FROM
       emp
WHERE
       hiredate BETWEEN TO_DATE('01-01-1982', 'DD-MM-YYYY') AND TO_DATE('31-12-1982',
       'DD-MM-YYYY');

SELECT
       ename,
       job
FROM
       emp
WHERE
       mgr IS NULL;

SELECT
       ename,
       sal,
       comm
FROM
       emp
WHERE
       comm IS NOT NULL
       AND comm <> 0
ORDER BY
       sal,
       comm DESC;

SELECT
       ename
FROM
       emp
WHERE
       ename LIKE '__A%';

SELECT
       ename
FROM
       emp
WHERE
       ( deptno = 30
         OR mgr = 7782 )
       AND length(ename) - length(replace(ename, 'L', '')) = 2;

SELECT
       ename
FROM
       emp
WHERE
       ( deptno = 30
         OR mgr = 7782 )
       AND ename LIKE '%LL%';

SELECT
       ename,
       job,
       sal
FROM
       emp
WHERE
       job IN ( 'CLERK', 'ANALYST' )
       AND sal NOT IN ( 1000, 3000, 5000 );

SELECT
       ename,
       sal,
       comm
FROM
       emp
WHERE
       comm > sal * 1.1;

SELECT
       sysdate AS fecha_actual
FROM
       emp;

SELECT
       empno,
       ename,
       sal,
       round(sal * 1.15, 0) AS salario_2
FROM
       emp;

SELECT
       empno,
       ename,
       sal,
       round(sal * 1.15, 0) AS salario_2,
       round(
              abs(sal - sal * 1.15),
              0
       )                    AS resta_sal
FROM
       emp;

SELECT
       ename,
       hiredate,
       add_months(hiredate, 6) AS revision
FROM
       emp;

SELECT
       ename,
       round((sysdate - hiredate) / 30) AS meses
FROM
       emp
ORDER BY
       meses;

SELECT
       round(hiredate, 'MM') AS redondeo_fecha
FROM
       emp;

SELECT
       ename
       || '    GANA   '
       || sal
       || '    MENSUALMENTE PERO QUIERE  '
       || '  3 VECES MAS '
FROM
       emp;

SELECT
       ename,
       rpad(sal, 15, '$')
FROM
       emp;

SELECT
       initcap(ename),
       length(ename) AS longitud_nombre
FROM
       emp
WHERE
       ename LIKE 'J%'
       OR ename LIKE 'A%'
       OR ename LIKE 'M%';

SELECT
       e.ename,
       d.deptno,
       d.dname
FROM
            emp e
       INNER JOIN dept d ON e.deptno = d.deptno;

SELECT
       e.job,
       d.deptno,
       d.loc
FROM
            emp e
       INNER JOIN dept d ON e.deptno = d.deptno
WHERE
       d.deptno = 30;

SELECT
       e.ename,
       d.dname,
       d.loc
FROM
            emp e
       INNER JOIN dept d ON e.deptno = d.deptno
WHERE
       comm IS NOT NULL
       AND comm <> 0;

SELECT
       e.ename,
       d.dname
FROM
            emp e
       INNER JOIN dept d ON e.deptno = d.deptno
WHERE
       ename LIKE '%A%';

SELECT
       e.ename,
       e.job,
       e.deptno,
       d.dname
FROM
            emp e
       INNER JOIN dept d ON e.deptno = d.deptno
WHERE
       loc = 'DALLAS';

SELECT
       e.ename  AS empleado,
       e.empno  AS num_empleado,
       e1.ename AS jefe,
       e.mgr    AS num_jefe
FROM
       emp e
       LEFT JOIN emp e1 ON e.mgr = e1.empno;

SELECT
       e1.ename AS empleado,
       e1.empno AS num_empleado,
       e2.ename AS jefe,
       e1.mgr   AS num_jefe
FROM
            emp e1
       INNER JOIN emp e2 ON e1.mgr = e2.empno;

SELECT
       e.ename  AS empleado_dado,
       e.deptno,
       e1.ename AS empleados
FROM
            emp e
       INNER JOIN emp e1 ON e.deptno = e1.deptno
WHERE
       e.ename = 'SMITH';

DESCRIBE SALGRADE;

SELECT
       e.ename,
       e.job,
       d.dname,
       e.sal,
       s.grade
FROM
            emp e
       INNER JOIN dept     d ON e.deptno = d.deptno
       INNER JOIN salgrade s ON e.sal BETWEEN s.losal AND s.hisal;

SELECT
       e.ename,
       e.hiredate
FROM
       emp e
WHERE
       e.hiredate > (
              SELECT
                     e1.hiredate
              FROM
                     emp e1
              WHERE
                     e1.ename = 'BLAKE'
       );

SELECT
       e.ename     AS nombre,
       e.hiredate  AS fecha_contra,
       e1.ename    AS jefes,
       e1.hiredate AS fecha_antes_contra
FROM
            emp e
       INNER JOIN emp e1 ON e.mgr = e1.empno
WHERE
       e.hiredate < e1.hiredate;

SELECT
       e.ename    AS empleado,
       e.hiredate AS fecha_contratacion_empleado,
       j.ename    AS jefe,
       j.hiredate AS fecha_contratacion_jefe
FROM
            emp e
       INNER JOIN emp j ON e.mgr = j.empno
WHERE
       e.hiredate < j.hiredate;

/*CONSULTA 4------------------------------------------------------------------------------------ */

SELECT
       trunc(
              max(sal),
              0
       ),
       trunc(
              min(sal),
              0
       ),
       trunc(
              avg(sal),
              0
       )
FROM
       emp;

SELECT
       job,
       MAX(sal),
       MIN(sal),
       AVG(sal)
FROM
       emp
GROUP BY
       job;

SELECT
       job,
       COUNT(ename)
FROM
       emp
GROUP BY
       job;

SELECT
       COUNT(ename) AS total_directores
FROM
       emp
WHERE
       job = 'MANAGER';

SELECT
       ( MAX(sal) - MIN(sal) ) AS direferencia
FROM
       emp;

SELECT
       mgr,
       MIN(sal) AS salario_minimo
FROM
       emp
WHERE
       mgr IS NOT NULL
GROUP BY
       mgr
HAVING
       MIN(sal) > 1000
ORDER BY
       MIN(sal);

SELECT
       d.dname,
       d.loc,
       COUNT(e.empno),
       trunc(
              avg(e.sal),
              0
       )
FROM
            emp e
       INNER JOIN dept d ON e.deptno = d.deptno
GROUP BY
       d.dname,
       d.loc;

SELECT
       COUNT(empno) AS total,
       SUM(decode(
              to_char(hiredate, 'YYYY'),
              1980,
              1,
              0
       ))           AS "1980",
       SUM(decode(
              to_char(hiredate, 'YYYY'),
              1981,
              1,
              0
       ))           AS "1981"
FROM
       emp;

SELECT
       COUNT(empno) AS total,
       SUM(
              CASE
                     WHEN to_char(hiredate, 'YYYY') = '1980'
                     THEN 1
                     ELSE 0
              END
       )            AS "1980",
       SUM(
              CASE
                     WHEN to_char(hiredate, 'YYYY') = '1981'
                     THEN 1
                     ELSE 0
              END
       )            AS "1981",
       SUM(
              CASE
                     WHEN to_char(hiredate, 'YYYY') = '1982'
                     THEN 1
                     ELSE 0
              END
       )            AS "1982",
       SUM(
              CASE
                     WHEN to_char(hiredate, 'YYYY') = '1983'
                     THEN 1
                     ELSE 0
              END
       )            AS "1983"
FROM
       emp;

SELECT
       job,
       SUM(
              CASE
                     WHEN deptno = 10
                     THEN sal
                     ELSE 0
              END
       )              AS dept10,
       SUM(
              CASE
                     WHEN deptno = 20
                     THEN sal
                     ELSE 0
              END
       )              AS dept20,
       SUM(
              CASE
                     WHEN deptno = 30
                     THEN sal
                     ELSE 0
              END
       )              AS dept30,
       ceil(sum(sal)) AS total
FROM
       emp
GROUP BY
       job;

/*consulta5*/

SELECT
       e.ename,
       e.hiredate
FROM
       emp e
WHERE
              e.deptno = (
                     SELECT
                            e1.deptno
                     FROM
                            emp e1
                     WHERE
                            e1.ename = 'BLAKE'
              )
       AND e.ename <> 'BLAKE';

SELECT
       e.empno,
       e.ename
FROM
       emp e
WHERE
       e.sal > (
              SELECT
                     AVG(e1.sal)
              FROM
                     emp e1
       )
ORDER BY
       e.sal DESC;

SELECT
       e.empno,
       e.ename
FROM
       emp e
WHERE
       e.deptno IN (
              SELECT
                     e1.deptno
              FROM
                     emp e1
              WHERE
                     e1.ename LIKE ( '%T%' )
       );

SELECT
       e.ename,
       e.deptno,
       e.job
FROM
            emp e
       INNER JOIN dept d ON e.deptno = d.deptno
WHERE
       d.loc = 'DALLAS';

SELECT
       e.ename,
       e.sal
FROM
       emp e
WHERE
       e.mgr = (
              SELECT
                     e1.empno
              FROM
                     emp e1
              WHERE
                     e1.ename = 'KING'
       );

SELECT
       e.empno,
       e.ename,
       e.job
FROM
            emp e
       INNER JOIN dept d ON e.deptno = d.deptno
WHERE
       d.dname = 'SALES';

SELECT
       e.empno,
       e.ename,
       e.sal
FROM
       emp e
WHERE
              e.sal > (
                     SELECT
                            AVG(e1.sal)
                     FROM
                            emp e1
              )
       AND e.deptno IN (
              SELECT
                     e1.deptno
              FROM
                     emp e1
              WHERE
                     e1.ename LIKE '%T%'
       );

SELECT
       e.ename,
       e.deptno,
       e.sal
FROM
       emp e
WHERE
       e.deptno IN (
              SELECT
                     e1.deptno
              FROM
                     emp e1
              WHERE
                     e1.comm IS NOT NULL
       )
       AND e.sal IN (
              SELECT
                     e1.sal
              FROM
                     emp e1
              WHERE
                     e1.comm IS NOT NULL
       );

SELECT
       e.ename,
       e.deptno,
       e.sal
FROM
       emp e
WHERE
       ( e.sal, e.deptno ) IN (
              SELECT
                     e1.sal, e1.deptno
              FROM
                     emp e1
              WHERE
                     e1.comm IS NOT NULL
                     AND e1.comm <> 0
       );

SELECT
       e.ename,
       e.deptno,
       e.sal
FROM
       emp e
WHERE
       EXISTS (
              SELECT
                     1
              FROM
                     emp e1
              WHERE
                     e1.comm IS NOT NULL
                     AND e1.deptno = e.deptno
                     AND e1.sal = e.sal
       );

SELECT
       e.ename,
       e.deptno,
       e.sal
FROM
       emp e
WHERE
       ( e.sal, e.comm ) IN (
              SELECT
                     e1.sal, e1.comm
              FROM
                          emp e1
                     JOIN dept d ON e1.deptno = d.deptno
              WHERE
                     d.loc = 'DALLAS'
       );

SELECT
       e.ename,
       e.deptno,
       e.sal
FROM
       emp e
WHERE
       EXISTS (
              SELECT
                     1
              FROM
                          emp e1
                     INNER JOIN dept d ON e1.deptno = d.deptno
              WHERE
                            d.loc = 'DALLAS'
                     AND e1.sal = e.sal
                     AND e1.comm = e.comm
       );

SELECT
       e.ename,
       e.hiredate,
       e.sal
FROM
       emp e
WHERE
       ( e.sal,
         e.comm ) = (
              SELECT
                     e1.sal,
                     e1.comm
              FROM
                     emp e1
              WHERE
                     e1.ename = 'SCOTT'
       );

SELECT
       e.ename,
       e.hiredate,
       e.sal
FROM
       emp e
WHERE
       EXISTS (
              SELECT
                     1
              FROM
                     emp e1
              WHERE
                            e.sal = e1.sal
                     AND e.comm = e1.comm
                     AND e1.ename = 'SCOTT'
       );

SELECT
       e.sal
FROM
       emp e
WHERE
       e.sal > (
              SELECT
                     MIN(e1.sal)
              FROM
                     emp e1
              WHERE
                     e1.job = 'CLERK'
       )
ORDER BY
       e.sal DESC;

SELECT
       ename,
       job,
       sal
FROM
       emp
WHERE
       sal > ANY (
              SELECT
                     sal
              FROM
                     emp
              WHERE
                     job = 'CLERK'
       )
ORDER BY
       sal DESC;

/*CONSULTA 6*/

INSERT INTO dept (
       deptno,
       dname,
       loc
) VALUES ( 50,
           'DESARROLLO',
           ',MADRID' );

UPDATE dept
SET
       loc = 'MADRID'
WHERE
       loc = ',MADRID';

ALTER TABLE emp MODIFY
       job VARCHAR2(10);

INSERT INTO dept (
       deptno,
       dname,
       loc
) VALUES ( 35,
           'SENIOR',
           'VALENCIA' );

INSERT INTO dept (
       deptno,
       dname,
       loc
) VALUES ( 65,
           'JUNIOR',
           'VALENCIA' );

INSERT INTO emp (
       empno,
       ename,
       job,
       mgr,
       hiredate,
       sal,
       comm,
       deptno
) VALUES ( 8010,
           'GARCIA',
           'MANAGER',
           7839,
           '16/11/2004',
           3000,
           0,
           50 );

INSERT INTO emp (
       empno,
       ename,
       job,
       mgr,
       hiredate,
       sal,
       comm,
       deptno
) VALUES ( 8011,
           'GARRIDO',
           'SENIOR',
           8010,
           '17/11/2004',
           1800,
           0,
           35 );

INSERT INTO emp (
       empno,
       ename,
       job,
       mgr,
       hiredate,
       sal,
       comm,
       deptno
) VALUES ( 8012,
           'ORTEGA',
           'JUNIOR',
           8012,
           '17/11/2004',
           1800,
           0,
           65 );

COMMIT;

UPDATE emp
SET
       ename = 'PEPE'
WHERE
       ename = 'GARRIDO';

DELETE FROM emp
WHERE
       ename = 'ORTEGA';

ALTER TABLE emp ADD nueva_columna VARCHAR2(70);

ALTER TABLE emp
       ADD CONSTRAINT nombre_restr_fk FOREIGN KEY ( nueva_columna )
              REFERENCES dept ( deptno );

ALTER TABLE emp MODIFY
       nueva_columna NUMBER(4, 2);

ALTER TABLE emp DROP COLUMN nueva_columna;

/* ejercicios COLECION PROCEDIMIENTOS*/

CREATE OR REPLACE PROCEDURE cambiar_oficio (
       p_empno  IN NUMBER DEFAULT 50,
       p_newjob IN VARCHAR2 DEFAULT 'JUAN'
) IS
BEGIN
       UPDATE emp
       SET
              job = p_newjob
       WHERE
              empno = p_empno;

       dbms_output.put_line('Oficio actualizado correctamente para el empleado ' || p_empno
       );
       SAVEPOINT sp1;
/*COMMIT;*/
END cambiar_oficio;
/

DECLARE BEGIN
       cambiar_oficio(8012, 'JUNIOR');
END;
/

CREATE OR REPLACE PROCEDURE dos_numeros (
       num1 IN NUMBER,
       num2 IN NUMBER
) IS
       v_1  NUMBER;
       v_2  NUMBER;
       suma NUMBER;
BEGIN
       v_1  := num1;
       v_2  := num2;
       suma := v_1 + v_2;
       dbms_output.put_line('LA SUMA ES:  ' || suma);
END dos_numeros;
/

DECLARE BEGIN
       dos_numeros(4, 7);
END;
/

CREATE OR REPLACE FUNCTION fechas (
       f1 IN DATE
) RETURN NUMBER IS
       anio NUMBER;
BEGIN
    /* Convierte la fecha a un número de año*/
       anio := TO_NUMBER ( to_char(f1, 'YYYY') );
       RETURN anio;
END fechas;
/

DECLARE
       fecha     DATE := TO_DATE ( '2025-01-28', 'YYYY-MM-DD' );  /* La fecha que pasas a la función*/
       resultado NUMBER;  /* Para almacenar el año devuelto por la función*/
BEGIN
    /* Llamar a la función FECHAS y almacenar el resultado en RESULTADO*/
       resultado := fechas(fecha);

    /* Mostrar el resultado del año*/
       dbms_output.put_line('El año es: ' || resultado);
END;
/

CREATE OR REPLACE FUNCTION cantidad_años (
       f1 IN DATE,
       f2 IN DATE
) RETURN NUMBER IS
       v_resultado NUMBER;
BEGIN
    /* Calcular la diferencia en años entre F1 y F2*/
       v_resultado := trunc(abs(months_between(f1, f2)) / 3);/*O 12*/

    /* Devolver el resultado*/
       RETURN v_resultado;
END cantidad_años;
/

DECLARE
       resultado NUMBER;
BEGIN
       resultado := cantidad_años(TO_DATE('05-01-2012', 'DD-MM-YYYY'), TO_DATE('01-01-2023'
       , 'DD-MM-YYYY'));

       dbms_output.put_line('LOS AÑOS SON:  ' || resultado);
END;
/

ALTER TABLE emp ADD total2 NUMBER;

CREATE OR REPLACE PROCEDURE actualizar_columna (
       sal  NUMBER,
       comm NUMBER
) IS
BEGIN
       UPDATE emp
       SET
              total2 = sal + comm
       WHERE
              comm IS NOT NULL
              AND comm <> 0;

       dbms_output.put_line('ACTUALIZADA COLUMNA ');
END actualizar_columna;

CREATE OR REPLACE FUNCTION filtro (
       cadena IN VARCHAR2
) RETURN VARCHAR2 IS
       resultado VARCHAR2(70) := '';
       caracter  CHAR(1);
BEGIN
       FOR i IN 1..( length(cadena) ) LOOP
              caracter := substr(cadena, i, 1);
              IF caracter BETWEEN 'A' AND 'Z'
                 OR caracter BETWEEN 'a' AND 'z'
              THEN resultado := resultado || caracter;
              ELSE resultado := resultado || ' ';
              END IF;

       END LOOP;

       RETURN resultado;
END filtro;

DECLARE
       resultado VARCHAR2(70);
BEGIN
       resultado := filtro('HOLA PEPE P45P32P');
       dbms_output.put_line(resultado);
END;

/
DECLARE
TYPE CAJA_REGIS IS record ( nombre VARCHAR(100),
       edad NUMBER,
       email VARCHAR2(100)
);
V_CAJA CAJA_REGIS;
BEGIN
V_CAJA.NOMBRE:='JUAN';
V_CAJA.EDAD:=20;
V_CAJA.EMAIL:='ADA@DSAD';
dbms_output.put_line('Nombre: ' || V_CAJA.nombre);
    dbms_output.put_line('Edad: ' || V_CAJA.edad);
    dbms_output.put_line('Email: ' || V_CAJA.email);
END;






