CREATE OR REPLACE PACKAGE PAQ_BIBLIOTECA IS

TYPE REG_LIBRO IS RECORD(
ISBN LIBRO.ISBN%TYPE,
TITULO LIBRO.TITULO%TYPE,
AUTOR LIBRO.AUTOR%TYPE,
GENERO LIBRO.GENERO%TYPE,
FECHA_PUBLICACION LIBRO.FECHA_PUBLICACION%TYPE);
TYPE TB_LISTAR_LIBROS IS TABLE OF REG_LIBRO;
CURSOR CUR_LIBROS RETURN REG_LIBRO;
CURSOR CUR_LIBROS(pgenero in libro.genero%type, f boolean ) RETURN REG_LIBRO;
FUNCTION LISTAR_LIBROS RETURN TB_LISTAR_LIBROS;
FUNCTION LISTAR_LIBROS(pgenero in libro.gener%type) RETURN TB_LISTAR_LIBROS;
PROCEDURE  IMPRIMIR_LIBROS;
PROCEDURE IMPRIMIR_LIBROS(pgenero in libro.genero%type);
END;
/
CREATE OR REPLACE PACKAGE BODY PAQ_BIBLIOTECA 
IS
CURSOR CUR_LIBROS RETURN REG_LIBRO IS
SELECT * 
FROM LIBRO;

--FUNC
FUNCTION LISTAR_LIBROS 
RETURN TB_LISTAR_LIBROS
IS
VAUXTB_LISTAR_LIBROS TB_LISTAR_LIBROS;
BEGIN
SELECT * BULK COLLECT INTO VAUXTB_LISTAR_LIBROS
FROM LIBRO;
RETURN VAUXTB_LISTAR_LIBROS;
END;

FUNCTION LISTAR_LIBROS(PGENERO IN LIBRO.GENERO%TYPE)
RETURN TB_LISTAR_LIBROS
IS
VAUXTB_LISTAR_LIBROS TB_LISTAR_LIBROS;
BEGIN
SELECT * BULK COLLECT INTO VAUXTB_LISTAR_LIBROS
FROM LIBRO
WHERE GENERO=PGENERO;
RETURN VAUXTB_LISTAR_LIBROS;
END;

--PROCE
PROCEDURE IMPRIMIR_LIBROS
IS
VAUXREG_LIBRO REG_LIBRO;
--CURSOR
BEGIN
OPEN CUR_LIBROS;
FETCH CUR_LIBROS INTO VAUXREG_LIBRO;
WHILE CUR_LIBROS%FOUND LOOP
DBMS_OUTPUT.PUT_LINE(VAUXREG_LIBRO.ISBN ||VAUXREG_LIBRO.TITULO||VAUXREG_LIBRO.AUTOR||VAUXREG_LIBRO.GENERO||VAUXREG_LIBRO.FECHA_PUBLICACION);
FETCH CUR_LIBROS INTO VAUXREG_LIBRO;
END LOOP;
CLOSE CUR_LIBROS;
END;

PROCEDURE IMPRIMIR_LIBROS(pgenero in libro.genero%type,f boolean)
IS
VAUXREG_LIBRO REG_LIBRO;
CURSOR CUR_LIBROS RETURN REG_LIBRO IS
SELECT * 
FROM LIBRO
where genero=pgenero;
BEGIN
OPEN CUR_LIBROS(pgenero,f);
FETCH CUR_LIBROS INTO VAUXREG_LIBRO;
WHILE CUR_LIBROS%FOUND LOOP
DBMS_OUTPUT.PUT_LINE(VAUXREG_LIBRO.ISBN ||VAUXREG_LIBRO.TITULO||VAUXREG_LIBRO.AUTOR||VAUXREG_LIBRO.GENERO||VAUXREG_LIBRO.FECHA_PUBLICACION);
FETCH CUR_LIBROS INTO VAUXREG_LIBRO;
END LOOP;
CLOSE CUR_LIBROS;
END;

END;
/


DECLARE
BEGIN
DBMS_OUTPUT.PUT_LINE(PAQ.BIBLIOTECA.LISTAR_LIBROS());
DBMS_OUTPUT.PUT_LINE(PAQ.BIBLIOTECA.LISTAR_LIBROS('Realismo M�gico'));
PAQ_BIBLIOTECA.imprimir_libros;
PAQ_BIBLIOTECA.imprimir_libros('Realismo M�gico', true);
END;
/