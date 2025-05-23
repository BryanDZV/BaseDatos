
/*1.	 Conectarse como manager y  Crearse el tablespace dai2tab.dbs con un tamaño de 10M.*/
/*ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;
CREATE USER MANAGER IDENTIFIED BY 123456;
GRANT "CREATE_TABLESPACES" To MANAGER;*/
CREATE TABLESPACE dai2tab
DATAFILE 'ruta' SIZE 10M;

DROP USER MANAGER CASCADE;

---

/*2. Ver los tablespaces creados*/

SELECT tablespace_name FROM dba_tablespaces;


/*3. Crear usuario `dai2b` con tablespace `dai2tab` y cuota de 5M*/
ALTER SESSION SET "_ORACLE_SCRIPT"=true;
CREATE USER dai2b IDENTIFIED BY 123456
DEFAULT TABLESPACE dai2tab
QUOTA 5M ON dai2tab;

/*4. Crear usuario `dai2c` igual al anterior*/
ALTER SESSION SET "_ORACLE_SCRIPT"=true;
CREATE USER dai2c IDENTIFIED BY 123456
DEFAULT TABLESPACE dai2tab
QUOTA 5M ON dai2tab;


/*5. Ver todos los usuarios*/

SELECT username, default_tablespace, profile, authentication_type
FROM dba_users
WHERE account_status = 'OPEN';
--WHERE username='DAI2B';


/*6. Conceder privilegios `CONNECT`, `RESOURCE` a ambos usuarios*/

GRANT CONNECT, RESOURCE TO dai2b;
GRANT CONNECT, RESOURCE TO dai2c;


/*7. Conectarse como `dai2b` y crear tabla `prueba` + insertar 3 registros*/

-- Conexión: dai2b/dai2b

CREATE TABLE prueba (
  id NUMBER,
  nombre VARCHAR2(50)
);

INSERT INTO prueba VALUES (1, 'Ejemplo1');
INSERT INTO prueba VALUES (2, 'Ejemplo2');
INSERT INTO prueba VALUES (3, 'Ejemplo3');
COMMIT;

/*8. Conectarse como admin y cambiar la password de `dai2b` a `case2`*/

ALTER USER dai2b IDENTIFIED BY case2;


/*9. Conectarse como `dai2b` con nueva contraseña*/

-- Conexión: dai2b/case2


/*10. `dai2b` concede privilegios `SELECT, INSERT, UPDATE` sobre `prueba` a `dai2c`*/

GRANT SELECT, INSERT, UPDATE ON prueba TO dai2c;

/*11. Conectarse como `dai2c` y ver contenido de `prueba`*/

SELECT * FROM dai2b.prueba;


/*12. Conectarse como `dai2b` y revocar permisos a `dai2c`*/

REVOKE SELECT, INSERT, UPDATE ON prueba FROM dai2c;


/*13. Conectarse como `dai2c` e intentar ver `prueba` otra vez*/

SELECT * FROM dai2b.prueba;
-- Resultado: ORA-00942: table or view does not exist


/*14. Ver privilegios del usuario actual y del sistema*/

-- Ver privilegios sobre objetos:
SELECT * FROM user_tab_privs;

-- Ver privilegios de sistema:
SELECT * FROM user_sys_privs;

/*15. Ver usuarios, tablespaces y tablas*/

-- Usuarios:
SELECT username FROM dba_users;

-- Tablespaces:
SELECT tablespace_name FROM dba_tablespaces;

-- Tablas:
SELECT table_name FROM all_tables WHERE owner IN ('DAI2B', 'DAI2C');

/*16. Conectarse como `manager` y borrar usuarios y tablespace*/


DROP USER dai2b CASCADE;
DROP USER dai2c CASCADE;
DROP TABLESPACE dai2tab INCLUDING CONTENTS AND DATAFILES;
