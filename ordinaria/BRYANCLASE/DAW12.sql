CREATE TABLE usuarios_pruebas (
    id NUMBER PRIMARY KEY,  -- Columna para el ID, sin auto incremento
    nombre VARCHAR2(100),
    email VARCHAR2(100),
    edad NUMBER,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE SEQUENCE seq_usuarios_pruebas 
    START WITH 1  -- Empieza con el valor 1
    INCREMENT BY 1;  -- Incrementa en 1

CREATE OR REPLACE TRIGGER trg_usuarios_pruebas
BEFORE INSERT ON usuarios_pruebas
FOR EACH ROW
BEGIN
    :NEW.id := seq_usuarios_pruebas.NEXTVAL;
END;
/
INSERT INTO usuarios_pruebas (nombre, email, edad)
VALUES ('Juan Pérez', 'juan.perez@example.com', 28);

INSERT INTO usuarios_pruebas (nombre, email, edad)
VALUES ('Ana Gómez', 'ana.gomez@example.com', 34);

INSERT INTO usuarios_pruebas (nombre, email, edad)
VALUES ('Carlos López', 'carlos.lopez@example.com', 25);
