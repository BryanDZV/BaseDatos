/*1.	Obtener la capacidad de aquellos aviones con
capacidad mayor que la media de los otros aviones y 
envergadura menor que la media de las diferentes envergaduras 
de los otros aviones*/

SELECT A.CAPACIDAD,A.TIPO
FROM AVIONES A 
WHERE A.CAPACIDAD > (
SELECT AVG(A1.CAPACIDAD)
FROM AVIONES A1
WHERE A.TIPO<>A1.TIPO)
AND ENVERGADURA<(
SELECT AVG(ENVERGADURA) 
FROM AVIONES A1
WHERE A1.TIPO<>A.TIPO);

 /*2.	Cree una vista sobre la tabla aviones con las columnas
 envergadura y tipo para los aviones de los tipos
 737 o 73S. ¿Cuántos aviones hay en la vista? Borre la vista*/
 
 
 /*3.	Visualizar las tres primeras letras de los orígenes
 y destinos de los vuelos realizados por aviones con longitud 
 mayor que 2/3 de la media y envergadura menor la máxima 
 envergadura menos 5, ordenados alfabéticamente por destino*/
 
 
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
 
 
/*4.	Obtener la longitud de aquellos aviones
con longitud menor que la media de los otros aviones 
y capacidad mayor que la media de las diferentes capacidades
de los otros aviones*/
 
 SELECT A.LONGITUD
 FROM AVIONES A
 WHERE A.LONGITUD<(
 SELECT AVG(A1.LONGITUD)
 FROM AVIONES A1
 WHERE A.TIPO<>A1.TIPO) 
 AND A.CAPACIDAD > (
 SELECT AVG(A1.CAPACIDAD)
 FROM AVIONES A1
 WHERE A.TIPO<>A1.TIPO);
 
 SELECT A.LONGITUD
 FROM AVIONES A
 WHERE A.LONGITUD<(
 SELECT AVG(A1.LONGITUD)
 FROM AVIONES A1
 WHERE A.TIPO<>A1.TIPO) 
 AND A.CAPACIDAD > (
 SELECT AVG(A1.CAPACIDAD)
 FROM AVIONES A1
 WHERE A.TIPO<>A1.TIPO);
 

 /*
 5.	Crear una vista sobre la tabla aviones con las columnas tipo y 
 longitud para los aviones cuya longitud sea menor que la envergadura mas 10.
 ¿Cuál es la mayor longitud de la vista? Borrar la vista
 */
 
 
 /*6.	Visualizar los primeros 2 caracteres de los num_vuelo y el origen de 
 los vuelos a los que corresponden partes con número de parte entre 2 y 8 y que 
 recorren distancias mayores que la media , ordenándolos alfabéticamente por origen*/
 
 
 SELECT SUBSTR(V.NUM_VUELO,0,2) AS VUELO_NUMERO,SUBSTR(V.ORIGEN,0,2) AS ORIGEN_VUELO
 FROM VUELOS V
 INNER JOIN PARTES P ON V.NUM_VUELO=P.NUM_VUELO
 WHERE P.NUM_PARTE BETWEEN 2 AND 8 
 AND V.DISTANCIA > (
 SELECT AVG(V.DISTANCIA)
 FROM vuelos V)
 ORDER BY ORIGEN ;
 
 /*
 7.	Obtenga la longitud de los aviones que 
 realizan vuelos que recorren distancias mayores
 que la media de las distancias de los vuelos recorridos por la misma compañía
 */
 
 
 SELECT A.LONGITUD
 FROM AVIONES A
 INNER JOIN  VUELOS V ON A.TIPO=V.TIPO_AVION
 WHERE V.DISTANCIA > (
 SELECT AVG(V.DISTANCIA) 
 FROM VUELOS V
 WHERE V.NUM_VUELO=(
 SELECT V1.NUM_VUELO 
 FROM VUELOS V1
 WHERE V1.NUM_VUELO=V.NUM_VUELO));
 
 /*
 9.	Visualizar los números de vuelo, las tres primeras letras del origen y las
 tres primeras letras del destino para los vuelos realizados por aviones con 
 posibilidad de almacenar más combustible que la media de todos y con longitud menor 
 que 2/3 de la máxima longitud. Ordenarlos por número de vuelo
 
 */
 
/* SELECT V.NUM_VUELO,SUBSTR(V.ORIGEN,0,3),SUBSTR(V.DESTINO,0,3)
 FROM VUELOS V
 INNER JOIN AVIONES A ON V.TIPO_VUELO=A.TIPO
 WHERE A.CAPACIDAD>*/
 
 


 


 
 
 
 
 