/*cree una funcion llamada total partes que dado el identificador
de un avion nos devuelva todos los partes de ese avion*
/*hacer un bloque aninmo para probar esos partes*/

DECLARE
  total NUMBER;  
  
  ----empieza funcion
 FUNCTION totalPartes(tipo_p IN VARCHAR2)
RETURN NUMBER
IS
  v_total NUMBER := 0;  
BEGIN
  SELECT COUNT(*) INTO v_total
  FROM partes p
  INNER JOIN vuelos v ON v.num_vuelo = p.num_vuelo
  INNER JOIN aviones a ON a.tipo = v.tipo_avion
  WHERE a.tipo = tipo_p;
 RETURN v_total;
END totalPartes;
----fin funcion
BEGIN
  total := totalPartes('320');  -- Pasar el tipo de avión como parámetro
  DBMS_OUTPUT.PUT_LINE('Total de partes: ' || total);
END;
/

/****resoslucion examen****/

declare 
type partes_taba is table of partes%rowtype;
resultado partes_tabla;
function totalpartes(tipo aviones.tipo%type)
return partes_tabla
is
total_partes partes_tabla;
begin
 SELECT p.*)INTO bull
  FROM partes p
  INNER JOIN vuelos v ON v.num_vuelo = p.num_vuelo
  INNER JOIN aviones a ON a.tipo = v.tipo_avion
  WHERE a.tipo = tipo_p;
 RETURN v_total;
END totalPartes;











