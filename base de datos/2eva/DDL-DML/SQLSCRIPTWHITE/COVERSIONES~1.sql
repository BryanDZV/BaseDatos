--Conversión de fecha a caracteres
--Muestra el nombre de los clientes y la fecha de sus pedidos 
--en formato DD-Month-YYYY. Utiliza TO_CHAR.
SELECT C.CNAME AS NOMBRE_CLIENTE,TO_CHAR(O.ORDER_DATE,'DD-MM-YYYY') AS FECHA_FORMATEADA
FROM CUSTOMERS C
INNER JOIN ORDERS O ON C.CUSTID=O.CUSTID
ORDER BY FECHA_FORMATEADA DESC;
--2
/*Uso de TO_NUMBER para comparar datos
Busca pedidos donde el total sea mayor a 100. 
Usa TO_NUMBER para convertir datos si es necesario.*/

SELECT *
FROM ORDERS O
WHERE TO_NUMBER(O.TOTAL_AMOUNT)>100;
--3
/* Uso de NVL
Muestra los nombres de los clientes, 
sus correos electrónicos y, si el correo es nulo,
muestra 'No Email'.*/

SELECT C.CNAME,NVL(C.EMAIL,'NO EMAIL') AS EMAILS_NULOS
FROM CUSTOMERS C;

--4
/*TO_DATE y formato de fecha
Inserta un nuevo pedido con una fecha proporcionada como 
texto en formato DDMMYYYY. Usa TO_DATE para convertir la fecha.*/

INSERT INTO ORDERS(ordid, custid, order_date, total_amount, status)
VALUES(105, 3, TO_DATE('10122024', 'DD-MM-YYYY'), 250.00, 'Pending');

--5
/*Uso de DECODE
Muestra los nombres de los empleados y un comentario dependiendo de su departamento:

'IT': "Trabaja en Tecnología"
'HR': "Trabaja en Recursos Humanos"
Otros: "Otro departamento"
*/

SELECT E.ENAME,D.DNAME,DECODE(D.DNAME,'IT','Trabaj en Tecnología','HR','Trabaja en Recursos Humanos','OTROS','OTRO DEPARTAMENTO')AS COMENTARIOS
FROM EMPLOYEES E
INNER JOIN DEPARTMENTS D ON E.DEPTNO=D.DEPTNO;

--6
/*Comparar formatos RR y YY
Inserta un pedido con una fecha en formato RR y 
muestra cómo se interpreta comparado con YY.*/

INSERT INTO ORDERS(ordid, custid, order_date, total_amount, status)
VALUES(106,2,TO_DATE('15-12-24','DD-MM-RR'),180.00,'Completed');

SELECT order_date, TO_CHAR(order_date, 'YYYY') AS year_interpreted
FROM ORDERS
WHERE ordid = 106;

--7
/* Subconsulta con funciones de conversión
Encuentra los empleados cuyo salario anual (multiplicando por 12) 
es mayor a 40,000 y muestra sus nombres. Usa NVL si hay comisiones nulas.*/

SELECT ename,SAL*12 AS SALARIO_ANUAL
FROM EMPLOYEES
WHERE (sal * 12) + NVL((SELECT GRADE FROM SALGRADES WHERE grade = 1), 0) > 40000;

--8 Formateo de números con TO_CHAR
--Muestra los productos con su precio formateado con separador de miles y símbolo de euro.

SELECT name, TO_CHAR(price, '999,999.99') || ' €' AS formatted_price
FROM PRODUCTS;
--9 Anidamiento de funciones
/*Encuentra la fecha del próximo viernes después de 6 meses de la fecha
de contratación de cada empleado y formatea la salida como 'Day, Month DD, YYYY'.*/
SELECT ENAME, TO_CHAR(ADD_MONTHS(NEXT_DAY(HIREDATE,'VIERNES'),6),'DAY,MONTH D,YYYY') AS FECHA
FROM EMPLOYEES;

--10
/*10: Filtrar y ordenar usando conversiones
Muestra los pedidos realizados por clientes cuyo nombre empieza con 
'A', ordenados por fecha en formato 'YYYY/MM/DD'*/
SELECT O.ORDID,C.CNAME,TO_CHAR(O.ORDER_DATE,'YYYY/MM/DD') AS FECHA_FORMATEADA
FROM ORDERS O
INNER JOIN CUSTOMERS C ON O.CUSTID=C.CUSTID
WHERE C.CNAME LIKE 'A%'
ORDER BY O.ORDER_DATE ;



