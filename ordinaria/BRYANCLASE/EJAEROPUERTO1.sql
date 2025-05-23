------------------------------- EJERCICIO AEROPUERTO 1 -----------------------------------------
------------------------------------------------------------------------------------------------
-- EJERCICIO 1.1 -- | -- SELECT TIPO, CAPACIDAD FROM AVIONES A1 WHERE CAPACIDAD > (SELECT AVG(CAPACIDAD) FROM AVIONES A2 WHERE A2.TIPO<>A1.TIPO) AND ENVERGADURA <(SELECT AVG(ENVERGADURA) FROM AVIONES A2 WHERE A2.TIPO<>A1.TIPO);
------------------------------------------------------------------------------------------------
-- EJERCICIO 1.2 -- | -- SE DA EL VIERNES LAS VISTAS
------------------------------------------------------------------------------------------------
-- EJERCICIO 1.3 CON WHERE | -- 
SELECT DISTINCT SUBSTR(V.ORIGEN,0,3) AS ORIGENES,SUBSTR(V.DESTINO,0,3) AS DESTINO
FROM VUELOS V
WHERE V.TIPO_AVION=(
SELECT A.TIPO
FROM AVIONES A 
WHERE A.LONGITUD>(
SELECT AVG(A.LONGITUD)*(2/3)
FROM AVIONES A)
AND A.ENVERGADURA<(
SELECT MAX(A.ENVERGADURA)-5
FROM AVIONES A))
ORDER BY DESTINO DESC;
------------------------------------------------------------------------------------------------
-- EJERCICIO 1.3 CON JOIN --
SELECT DISTINCT SUBSTR(V.ORIGEN,0,3) AS ORIGENES,SUBSTR(V.DESTINO,0,3) AS DESTINO
FROM VUELOS V
INNER JOIN AVIONES A ON V.TIPO_AVION=A.TIPO
WHERE A.LONGITUD>(
SELECT AVG(A.LONGITUD)*(2/3)
FROM AVIONES A)
AND A.ENVERGADURA<(
SELECT MAX(A.ENVERGADURA)-5
FROM AVIONES A)
ORDER BY DESTINO DESC;

---------------------------------------------------------------------------------------------------
-- EJERCICIO 1.3 CON SUBSELECT (PROFESORA)
select distinct substr(origen, 0, 3) as ORIG, substr(destino, 0, 3) as DEST
from vuelos where tipo_avion in (select tipo from aviones 
where longitud > (select avg(longitud) * 2 / 3
                    from aviones)
and envergadura < (select max(envergadura) - 5
                    from aviones))
order by DEST;
---------------------------------------------------------------------------------------------------
-- EJERCICIO 1.4 --
select longitud, capacidad from aviones where longitud < ( select avg(longitud) from aviones ) and capacidad > ( select avg( capacidad) from aviones);
---------------------------------------------------------------------------------------------------
-- EJERCICIO 1.5 --
---------------------------------------------------------------------------------------------------
-- EJERCICIO 1.6 --

---------------------------------------------------------------------------------------------------
-- EJERCICIO 1.7 -- 