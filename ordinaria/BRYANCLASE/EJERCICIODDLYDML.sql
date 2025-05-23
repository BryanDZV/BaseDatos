------------------------------------------- EJERCICIOS DDL Y DML ---------------------------------------------
--------------------------------------------------------------------------------------------------------------
-- EJERCICIO 1.1 -- CREATE TABLE DEPT2 AS SELECT * FROM DEPT;
-- EJERCICIO 1.2 -- CREATE TABLE EMP2 AS SELECT * FROM EMP;
-- EJERCICIO 1.3 -- CREATE TABLE SALGRADE2 AS SELECT * FROM SALGRADE;
--------------------------------------------------------------------------------------------------------------
-- EJERCICIO 2.1 -- | -- INSERT INTO DEPT2 (DEPTNO, DNAME, LOC)VALUES (50, 'DESARROLLO', 'MADRID');
--------------------------------------------------------------------------------------------------------------
-- EJERCICIO 2.2 -- | -- ALTER TABLE EMP2 MODIFY JOB VARCHAR2(20);
--------------------------------------------------------------------------------------------------------------
-- EJERCICIO 2.3 -- | -- 
INSERT INTO EMP2 (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES (8010, 'GARCIA', 'JEFE PROYECTO', 7839, TO_DATE('16-NOV-2004', 'DD-MON-YYYY'), 3000, NULL, 50);

INSERT INTO EMP2 (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES (8011, 'GARRIDO', 'PROGRAMADOR SENIOR', 8010, TO_DATE('17-NOV-2004', 'DD-MON-YYYY'), 1500, NULL, 50);

INSERT INTO EMP2 (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES (8012, 'ORTEGA', 'PROGRAMADOR JUNIOR', 8010, TO_DATE('17-NOV-2004', 'DD-MON-YYYY'), 1000, NULL, 50);

INSERT INTO EMP2 (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES (8013, 'ROJAS', 'PROGRAMADOR JUNIOR', 8010, TO_DATE('17-NOV-2004', 'DD-MON-YYYY'), 1000, NULL, 50);
--------------------------------------------------------------------------------------------------------------
-- EJERCICIO 2.4 -- | -- SELECT * FROM EMP2 WHERE DEPTNO = 50;
--------------------------------------------------------------------------------------------------------------
-- EJERCICIO 2.5 -- | -- COMMIT;
--------------------------------------------------------------------------------------------------------------
-- EJERCICIO 2.6 -- | -- UPDATE EMP2 SET ENAME='VELASCO' WHERE EMPNO=8011;
-- COMPROBACION EJ 2.6 | -- SELECT * FROM EMP2 WHERE EMPNO=8011;
--------------------------------------------------------------------------------------------------------------
-- EJERCICIO 2.7 -- | -- DELETE FROM EMP2 WHERE EMPNO='8013';
-- COMPROBACION EJ 2.7 | -- SELECT * FROM EMP2 WHERE ENAME='ROJAS';
