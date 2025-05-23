
DROP TABLE USUARIOS_BLOQUEADOS CASCADE CONSTRAINTS;
DROP TABLE PRESTAMO CASCADE CONSTRAINTS;
DROP TABLE USUARIO CASCADE CONSTRAINTS;
DROP TABLE LIBRO CASCADE CONSTRAINTS;

-- Crear tabla LIBRO
CREATE TABLE LIBRO (
    isbn VARCHAR2(20) PRIMARY KEY,
    titulo VARCHAR2(100),
    autor VARCHAR2(100),
    genero VARCHAR2(50),
    fecha_publicacion DATE
);

-- Crear tabla USUARIO
CREATE TABLE USUARIO (
    id_usuario NUMBER PRIMARY KEY,
    nombre VARCHAR2(100),
    fecha_nacimiento DATE,
    nacionalidad VARCHAR2(50),
    saldo_multa NUMBER DEFAULT 0
);

-- Crear tabla PRESTAMO
CREATE TABLE PRESTAMO (
    id_prestamo NUMBER PRIMARY KEY,
    fecha_prestamo DATE,
    fecha_devolucion DATE,
    estado VARCHAR2(20),
    id_usuario NUMBER,
    isbn VARCHAR2(20),
    CONSTRAINT fk_prestamo_usuario FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario),
    CONSTRAINT fk_prestamo_libro FOREIGN KEY (isbn) REFERENCES LIBRO(isbn),
    CONSTRAINT chk_estado CHECK (estado IN ('pendiente', 'devuelto', 'atrasado'))
);

-- Crear tabla USUARIOS_BLOQUEADOS
CREATE TABLE USUARIOS_BLOQUEADOS (
    id_usuario NUMBER PRIMARY KEY,
    motivo_bloqueo VARCHAR2(100),
    fecha_bloqueo DATE
 );

-- Inserts en LIBRO
INSERT INTO LIBRO (isbn, titulo, autor, genero, fecha_publicacion) 
VALUES ('978-1234567890', 'Cien Años de Soledad', 'Gabriel García Márquez', 'Realismo Mágico', TO_DATE('1967-05-30','YYYY-MM-DD'));

INSERT INTO LIBRO (isbn, titulo, autor, genero, fecha_publicacion) 
VALUES ('978-9876543210', 'Don Quijote de la Mancha', 'Miguel de Cervantes', 'Novela', TO_DATE('1605-01-16','YYYY-MM-DD'));

-- Inserts en USUARIO
INSERT INTO USUARIO (id_usuario, nombre, fecha_nacimiento, nacionalidad, saldo_multa)
VALUES (1, 'Ana Torres', TO_DATE('1990-06-15','YYYY-MM-DD'), 'España', 0);

INSERT INTO USUARIO (id_usuario, nombre, fecha_nacimiento, nacionalidad, saldo_multa)
VALUES (2, 'Carlos López', TO_DATE('1985-03-22','YYYY-MM-DD'), 'México', 5);

-- Inserts en PRESTAMO
INSERT INTO PRESTAMO (id_prestamo, fecha_prestamo, fecha_devolucion, estado, id_usuario, isbn)
VALUES (1, TO_DATE('2024-04-01','YYYY-MM-DD'), TO_DATE('2024-04-15','YYYY-MM-DD'), 'devuelto', 1, '978-1234567890');

INSERT INTO PRESTAMO (id_prestamo, fecha_prestamo, fecha_devolucion, estado, id_usuario, isbn)
VALUES (2, TO_DATE('2024-04-10','YYYY-MM-DD'), NULL, 'pendiente', 2, '978-9876543210');

-- Inserts en USUARIOS_BLOQUEADOS
INSERT INTO USUARIOS_BLOQUEADOS (id_usuario, motivo_bloqueo, fecha_bloqueo)
VALUES (12, 'Devolución tardía', TO_DATE('2024-04-20','YYYY-MM-DD'));