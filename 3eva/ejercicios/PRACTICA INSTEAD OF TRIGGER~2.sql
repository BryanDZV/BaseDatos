/* 7 Ejercicios de práctica de Vistas + Triggers INSTEAD OF
*/
/*Ejercicio 1 (el que hiciste ya)
Vista: EMP_DEPT (campos: Empno, Ename, Dname, Sal, Hiredate, Loc)
Condiciones:

Jefe siempre KING.

Si el Dname no existe, se crea (10 + último ID).

Borrado elimina empleado de EMP.*/

/
CREATE OR REPLACE VIEW V_EMP_DEPT AS
SELECT E.EMPNO,E.ENAME,E.SAL,E.HIREDATE,D.DNAME,D.LOC
FROM EMP E
INNER JOIN DEPT D ON E.DEPTNO=D.DEPTNO;
/
SELECT * 
FROM V_EMP_DEPT;
/