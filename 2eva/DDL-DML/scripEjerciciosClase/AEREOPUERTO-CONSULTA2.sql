/*4.	Obtener la longitud de aquellos aviones con longitud 
menor que la media de los otros aviones y capacidad mayor que la
media de las diferentes capacidades de los otros aviones*/

SELECT 
    longitud
FROM 
    aviones a1
WHERE 
    longitud < (SELECT AVG(a2.longitud) FROM aviones a2 WHERE a1.id != a2.id)
    AND capacidad > (SELECT AVG(a2.capacidad) FROM aviones a2 WHERE a1.id != a2.id);

/*5.	Crear una vista sobre la tabla aviones con las columnas 
tipo y longitud para los aviones cuya longitud sea menor que la 
envergadura mas 10. ¿Cuál es la mayor longitud de la vista? 
Borrar la vista*/

CREATE VIEW vista_aviones AS
SELECT tipo, longitud
FROM aviones
WHERE longitud < envergadura + 10;
/*CONSULTAR LA LONGITUD DE LA VISTA*/
SELECT MAX(longitud) AS mayor_longitud
FROM vista_aviones;
/*BORRAR VISTA*/
DROP VIEW vista_aviones;


/*
6.	Visualizar los primeros 2 caracteres de los num_vuelo
y el origen de los vuelos a los que corresponden partes con número 
de parte entre 2 y 8 y que recorren distancias mayores que la media , 
ordenándolos alfabéticamente por origen

*/

SELECT 
    SUBSTR(v.num_vuelo, 1, 2) AS DOS_CARACTERES,
    v.origen
FROM vuelos v
JOIN partes p
    ON v.num_vuelo = p.num_vuelo
WHERE 
    p.num_parte BETWEEN 2 AND 8
    AND v.distancia > (SELECT AVG(distancia) FROM vuelos)
ORDER BY v.origen ASC;

/*

7.	Obtenga la longitud de los aviones que realizan vuelos
que recorren distancias mayores que la media de las distancias
de los vuelos recorridos por la misma compañía

*/

SELECT DISTINCT a.longitud
FROM aviones a
JOIN vuelos v
    ON a.TIPO = v.TIPO_AVION
WHERE v.distancia > (
    SELECT AVG(v1.distancia)
    FROM vuelos v1
    WHERE v1.TIPO_AVION = TIPO_AVION
);
/*
8.	Cree una vista sobre la tabla aviones con las columnas
tipo y velocidad de crucero para los aviones con capacidad
menor que 175 ¿Cuáles son la mayor y menor velocidad de crucero
de la vista? Borre la vista

/*
9.	Visualizar los números de vuelo, las tres primeras letras del
origen y las tres primeras letras del destino para los vuelos 
realizados por aviones con posibilidad de almacenar más combustible 
que la media de todos y con longitud menor que 2/3 de la máxima longitud. 
Ordenarlos por número de vuelo

*/

SELECT 
    v.num_vuelo,
    SUBSTR(v.origen, 0, 3) AS origen_corto,
    SUBSTR(v.destino, 0, 3) AS destino_corto
FROM vuelos v
JOIN aviones a
    ON v.TIPO_AVION = a.TIPO
WHERE 
    a.capacidad > (SELECT AVG(capacidad) FROM aviones)
    AND a.longitud < (SELECT MAX(longitud) * 2 / 3 FROM aviones)
ORDER BY v.num_vuelo;

/*
10.	Obtenga la capacidad de los aviones que realizan vuelos que 
recorren distancias menores que la media de las distancias de los 
vuelos recorridos por la misma compañía.

*/



