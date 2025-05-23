/*Conectarse como manager y  Crearse el tablespace dai2tab.dbs con un tamaño de 10M.*/

/*CREATE USER nombre_usuario
IDENTIFIED BY contraseña
[DEFAULT TABLESPACE tablespace]
[QUOTA {tamaño | UNLIMITED} ON tablespace]
[PROFILE perfil]
[PASSWORD EXPIRE]
[ACCOUNT {LOCK | UNLOCK}];
--------------
CREATE TABLESPACE dai2tab
DATAFILE 'dai2tab.dbs'
SIZE 10M
AUTOEXTEND ON NEXT 5M MAXSIZE 50M
EXTENT MANAGEMENT LOCAL
SEGMENT SPACE MANAGEMENT AUTO;
*/
/*1.	 Conectarse como manager y  Crearse el tablespace dai2tab.dbs con un tamaño de 10M.*/
ALTER SESSION SET"_ORACLE_SCRIPT"=TRUE;
CREATE USER MANAGER 
IDENTIFIED BY 123456;
GRANT CREATE SESSION, CREATE TABLE, CREATE TABLESPACE TO manager;

CREATE TABLESPACE dai2tab
DATAFILE 'dai2tab.dbs'
SIZE 10M
AUTOEXTEND ON NEXT 5M MAXSIZE 50M
EXTENT MANAGEMENT LOCAL
SEGMENT SPACE MANAGEMENT AUTO;
/*2.	Ver los tablespaces creados*/
SELECT tablespace_name, status, contents FROM DBA_tablespaces;
/*3.	Crear un usuario llamado dai2b asignado al tablespace dai2tab con una cuota de 5M,
como password dai2b.*/
ALTER SESSION SET"_ORACLE_SCRIPT"=TRUE;
CREATE USER DAI2B
IDENTIFIED BY DAI2B
DEFAULT TABLESPACE DAI2TAB
QUOTA 5M ON DAI2TAB;

SELECT *
FROM ALL_USERS
WHERE USERNAME='DAI2B';

/*4.	Crear un usuario llamado dai2c asignado al tablespace dai2tab con una cuota de 5M, como password dai2c.*/
ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;
CREATE USER DAI2C
IDENTIFIED BY DAI2C
DEFAULT TABLESPACE DAI2TAB
QUOTA 5M ON DAI2TAB;

/*5.	Ver todos los usuarios*/
SELECT *
FROM ALL_USERS;
/*6.	Conceder los privilegios de Connect, Resource a ambos usuarios.*/
GRANT CONNECT,RESOURCE TO DAI2B;
GRANT CONNECT,RESOURCE TO DAI2C;
/*7.	Conectarse como dai2b y crear una tabla nueva llamada prueba con dos campos e insertar 3
registros.*/
CREATE TABLE PRUEBA(
NOMBRE VARCHAR2(300),
EDAD NUMBER,
FECHA DATE DEFAULT SYSDATE,

CONSTRAINT PK_PRUEBA PRIMARY KEY (NOMBRE)
);

INSERT INTO PRUEBA
VALUES('PEPE',89,DEFAULT);
INSERT INTO PRUEBA
VALUES('PEPES',89,DEFAULT);
INSERT INTO PRUEBA
VALUES('PEPESA',89,DEFAULT);

SELECT *
FROM PRUEBA;

/*8.	Conectarse de nuevo como administrador y cambiar la password al usuario dai2b y ponerle case2.*/
ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;
ALTER USER dai2b IDENTIFIED BY case2;

/*9.	Conectarse como usuario dai2b y su nueva password case2.*/
--done
/*10.Conectarse como dai2b y conceder privilegios select , insert, update al usuario dai2c sobre 
la tabla prueba que pertenece a dai2b.*/
GRANT SELECT,INSERT,UPDATE ON PRUEBA TO DAI2C;

/*11.	Conectarse como dai2c y ver el contenido la tabla   prueba.*/
--DESDE DAI2C
SELECT *
FROM  DAI2B.PRUEBA;

/*12.	Conectarse como dai2b Revocar los privilegios de select, insert, update 
sobre la tabla  prueba al usuario dai2c.*/
REVOKE SELECT,INSERT,UPDATE ON PRUEBA FROM DAI2C;


/*13.Conectarse de nuevo como dai2c y ver el contenido la tabla   prueba,  comprobar que ocurre.*/

--LANZA QUE NO EXISTE LA TABLA DESDE DAI2C
SELECT *
FROM  DAI2B.PRUEBA;

/*14.	Ver los privilegios del usuario actual, y los privilegios del sistema asignados al usuario.*/

--1. Ver los privilegios del sistema asignados al usuario actual
SELECT * FROM USER_SYS_PRIVS;
--2. Ver los privilegios ACTUALES sobre objetos QUE TENGO  (tablas, vistas, etc.)
SELECT * FROM USER_TAB_PRIVS;
-- 4. Ver todos los privilegios que tiene cualquier usuario (requiere privilegios de DBA)
--Si estás conectado como administrador (SYS, SYSTEM, etc.):
SELECT * FROM DBA_SYS_PRIVS WHERE GRANTEE = 'NOMBRE_USUARIO';
SELECT * FROM DBA_TAB_PRIVS WHERE GRANTEE = 'NOMBRE_USUARIO';
SELECT * FROM DBA_ROLE_PRIVS WHERE GRANTEE = 'NOMBRE_USUARIO';
/*15.	Ver todos los usuarios creados, todos los tablespaces creados y todas las tablas creadas.*/
--📝 Necesitas estar conectado como administrador (SYS, SYSTEM o con rol DBA).
--Ver todos los usuarios creados en la base de datos

SELECT username FROM dba_users;

--Ver todos los tablespaces creados
SELECT tablespace_name FROM DBA_tablespaces;

--. Ver todas las tablas creadas por todos los usuarios
SELECT OWNER,TABLE_NAME
FROM DBA_TABLES;

/*SINO TENGO PERIMSO DBA

| Consulta                          | Qué muestra                                         |
|----------------------------------|-----------------------------------------------------|
| `SELECT * FROM all_users;`       | Todos los usuarios visibles para tu usuario        |
| `SELECT * FROM all_tables;`      | Todas las tablas visibles para tu usuario          |
| `SELECT * FROM user_tables;`     | Solo las tablas creadas por tu usuario actual      |*/

/*16.	Conectarse como manager y borrar los usuarios y el tablespace.*/


---CONECTADO DESDE SYSTEM AL AGUN ADMISITRADOR O DAR PERMISOS A MANGER
GRANT DROP USER TO manager;
GRANT DROP TABLESPACE TO manager;
---Y LUEGO EJECUTAR
DROP USER DAI2B CASCADE;

--Borrar el tablespace
DROP TABLESPACE dai2TAB INCLUDING CONTENTS AND DATAFILES;


--
SELECT * FROM dictionary;

SELECT * FROM dict WHERE table_name LIKE 'USER_%';

SELECT * FROM dictionary WHERE table_name LIKE '%PRIV%';






