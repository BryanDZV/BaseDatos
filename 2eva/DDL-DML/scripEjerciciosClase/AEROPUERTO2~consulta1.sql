/*Crear una vista sobre la tabla partes y
sus columnas num_parte y fecha para los partes con hora 
de llegada posterior a las 12.00.00 ¿Cuál es la fecha de
llegada más tardía? Borre la vista*/

CREATE VIEW VISTA_PARTES AS
SELECT NUM_PARTE,FECHA
FROM PARTES
WHERE to_char(hora_llegada,'HH24')>('12');

SELECT MAX(FECHA) AS FECHA_TARDIA 
FROM VISTA_PARTES;

DROP VIEW VISTA_PARTES;

/*12.	Visualizar los  dos primeros caracteres de los 
números de vuelo y el destino de los vuelos a que
corresponden partes con combustibles consumidos mayores
que un tercio de la media de todos los combustibles
consumidos. Ordenarlos alfabéticamente por destinos*/

SELECT DISTINCT
    SUBSTR(P.NUM_VUELO, 1, 2) AS PRIMEROS_DOS_CARACTERES,
    V.DESTINO
FROM 
    PARTES P
INNER JOIN 
    VUELOS V 
ON 
    P.NUM_VUELO = V.NUM_VUELO
WHERE 
    P.COMB_CONSUMIDO > (
        SELECT 
            AVG(COMB_CONSUMIDO) / 3
        FROM 
            PARTES
    )
ORDER BY 
    V.DESTINO ASC;


SELECT DISTINCT SUBSTR(V.DESTINO,1,2) AS DESTINO,P.COMB_CONSUMIDO
FROM VUELOS V
INNER JOIN PARTES P ON V.NUM_VUELO=P.NUM_VUELO
WHERE P.COMB_CONSUMIDO > (
SELECT 1/3*AVG(P1.COMB_CONSUMIDO)
FROM PARTES P1)
ORDER BY DESTINO ASC;

/*13.Obtener los número de vuelos de aquellos que
recorren una distancia mayor que la media de las que 
recorren los vuelos que parten del mismo origen*/

SELECT  NUM_VUELO
FROM VUELOS V
WHERE DISTANCIA>(
SELECT AVG(V1.DISTANCIA)
FROM VUELOS V1
WHERE V.ORIGEN=V1.ORIGEN);

/*14.	Crear una vista sobre la tabla partes con sus 
columnas num_parte y comb_consumido para los vuelos en 
que se consumió más de 1500 litros. ¿Cuántos partes hay 
en la vista? Borre la vista*/

CREATE VIEW VISTA_PARTES AS
SELECT NUM_PARTE,COMB_CONSUMIDO
FROM PARTES
WHERE COMB_CONSUMIDO >1500;

/*CUANTO PARTES HAY*/
SELECT COUNT(NUM_PARTE)
FROM VISTA_PARTES;

/*BORRAR VISTA*/
DROP VIEW VISTA_PARTES;

/*15.	Visualizar el total de plazas libres por número
de vuelo para los realizados desde Madrid a Barcelona o 
Sevilla y que recorran una distancia menor que la media 
de todos los vuelos que salen de Madrid. Ordenarlos de 
menor a mayor*/



SELECT V.NUM_VUELO,SUM(R.PLAZAS_LIBRES) AS PLAZAS_LIBRES
FROM VUELOS V
INNER JOIN RESERVAS R ON V.NUM_VUELO=R.NUM_VUELO
WHERE V.ORIGEN='MADRID' AND V.DESTINO IN ('BARCELONA','SEVILLA') AND
V.DISTANCIA<(
SELECT AVG(V1.DISTANCIA)
FROM VUELOS V1
WHERE V1.ORIGEN='MADRID')
GROUP BY V.NUM_VUELO
ORDER BY PLAZAS_LIBRES ASC;

SELECT  R.NUM_VUELO, SUM(R.PLAZAS_LIBRES) AS PLAZAS_LIBRES
FROM RESERVAS R
WHERE R.NUM_VUELO IN (
SELECT V.NUM_VUELO FROM VUELOS V WHERE V.ORIGEN='MADRID' AND V.DESTINO IN ('BARCELONA','SEVILLA')
AND V.DISTANCIA<(SELECT AVG(V1.DISTANCIA) FROM VUELOS V1 WHERE V1.ORIGEN='MADRID'))
GROUP BY R.NUM_VUELO
ORDER BY PLAZAS_LIBRES ASC;





/*16.	Obtener los número de vuelos de aquellos 
que recorren una distancia menor que la media de 
las que recorren los vuelos que llegan a su mismo destino*/


SELECT V.NUM_VUELO
FROM VUELOS V
WHERE V.DISTANCIA <(
SELECT AVG(V1.DISTANCIA)
FROM VUELOS V1
WHERE V.DESTINO=V1.DESTINO);

/*17.	Crear una vista sobre la tabla partes
con sus columnas num_parte y comb_consumido para 
los partes con fecha entre el 28 y el 30 de Septiembre 
de 1993. Visualizar todo el contenido de la vista.
Borrar la vista.*/

CREATE  VIEW VISTA_PARTES AS
SELECT NUM_PARTE, COMB_CONSUMIDO
FROM PARTES
WHERE FECHA BETWEEN TO_DATE('28-09-1993','DD-MM-YYYY') AND TO_DATE('29-09-1993','DD-MM-YYYY');

/*VER CONTENIDO DE LA VISTA*/

SELECT *
FROM VISTA_PARTES;

/*7*/
/*BORRAR VISTA*/

DROP VIEW VISTA_PARTES;

/*18	Visualizar el número de vuelo y la media 
de las plazas libres por número de vuelo para los realizados
desde Barcelona o Sevilla a Madrid y que recorren una distancia
menor que la media de todos de los vuelos que llegan a Madrid 
más 10.  Ordenarlos de menor a mayor*/

/*CON JOIN*/
SELECT R.NUM_VUELO,AVG(R.PLAZAS_LIBRES)AS MEDIA_PLAZAS_LIBRES,V.DESTINO,V.ORIGEN
FROM RESERVAS R 
INNER JOIN VUELOS V ON R.NUM_VUELO=V.NUM_VUELO
WHERE V.ORIGEN IN ('BARCELONA','SEVILLA') AND V.DESTINO='MADRID' AND 
V.DISTANCIA<(
SELECT AVG(V1.DISTANCIA)+10 AS DISTANCIA_MEDIA
FROM VUELOS V1
WHERE V1.DESTINO='MADRID')
GROUP BY  R.NUM_VUELO, V.DESTINO, V.ORIGEN
ORDER BY MEDIA_PLAZAS_LIBRES ASC;

/*CON WHERE*/
SELECT 
   NUM_VUELO,
    AVG(plazas_libres) AS media_plazas_libres
FROM 
    RESERVAS
WHERE NUM_VUELO IN (
SELECT V.NUM_VUELO 
FROM VUELOS V 
WHERE V.ORIGEN IN ('BARCELONA','SEVILLA') AND V.DESTINO='MADRID' AND
V.DISTANCIA <(
SELECT AVG(V1.DISTANCIA)
FROM VUELOS V1 
WHERE V1.DESTINO='MADRID')+10)
GROUP BY NUM_VUELO
ORDER BY 1;
   
/*CON EXIST*/


/*19.	Obtener, para cada número de vuelo, el total de plazas libres 
de los vuelos que recorren distancias mayores que la media de las distancias 
recorridas por vuelos de las misma compañía*/

SELECT SUM(R.PLAZAS_LIBRES),V.DISTANCIA
FROM RESERVAS R
INNER JOIN VUELOS V ON R.NUM_VUELO=V.NUM_VUELO
WHERE V.DISTANCIA>(
SELECT AVG(V1.DISTANCIA) AS DISTANCIA_MEDIA
FROM VUELOS V1
WHERE v.tipo_avion=v1.tipo_avion)
GROUP BY V.DISTANCIA
HAVING SUM(R.PLAZAS_LIBRES)>250 ;

SELECT 
    SUM(R.PLAZAS_LIBRES) AS total_plazas_libres, 
    V.DISTANCIA
FROM 
    RESERVAS R
INNER JOIN 
    VUELOS V 
ON 
    R.NUM_VUELO = V.NUM_VUELO
WHERE 
    V.DISTANCIA > (
        SELECT AVG(V1.DISTANCIA)
        FROM VUELOS V1
        WHERE V.TIPO_AVION = V1.TIPO_AVION
    )
GROUP BY 
    V.DISTANCIA
HAVING 
    SUM(R.PLAZAS_LIBRES) > 250;


/*19.	Obtener, para cada número de vuelo, el total de plazas libres 
de los vuelos que recorren distancias mayores que la media de las distancias 
recorridas por vuelos de las misma compañía Y QUE SUPERE 250 */

/*20.	Crear una vista sobre la tabla vuelos con las columnas num_vuelo
y tipo_avion con las distancias recorridas mayores a 900. Visualizar los datos 
de la vista para los vuelos de Iberia. Borrar la vista */

CREATE VIEW VISTA_VUELOS AS 
SELECT NUM_VUELO,TIPO_AVION
FROM VUELOS
WHERE DISTANCIA >900;

/*VER LOS VUELOS IBERIA*/

SELECT *
FROM VISTA_VUELOS
WHERE NUM_VUELO in ('Iberia');


/*BORRAR VISTA*/

DROP VIEW VISTA_VUELOS;
/*6debe aparecer*/

/*21.	Crear una vista con las ciudades y la suma de las 
capacidades de los aviones que salen de  esas ciudades. Se debe obtener
información solo de las ciudades de las que al menos salgan tres vuelos.

*/

CREATE VIEW VISTA_AVIONESV AS
SELECT V.ORIGEN,SUM(A.CAPACIDAD) AS SUMA_CAPACIDA
FROM VUELOS V
INNER JOIN AVIONES A ON V.TIPO_AVION=A.TIPO
GROUP BY V.ORIGEN;

/*CIUDADES CON 3 VUELOS*/


SELECT COUNT(ORIGEN)
FROM VISTA_AVIONESV
GROUP BY ORIGEN
HAVING (COUNT>3);

/*BORRAR VISTA_AVIONESV*/

DROP VIEW VISTA_AVIONESV;

/*CONSTRARINT CONSULTAS*/

SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE
FROM all_constraints
WHERE TABLE_NAME='RESERVAS';

SELECT * FROM VUELOS;

