-- ================================================
-- 1. DROP de triggers
-- ================================================
DROP TRIGGER trg_curso_escolar_bir;
DROP TRIGGER trg_asignatura_bir;
DROP TRIGGER trg_grado_bir;
DROP TRIGGER trg_persona_bir;
DROP TRIGGER trg_departamento_bir;

-- ================================================
-- 2. DROP de secuencias
-- ================================================
DROP SEQUENCE curso_escolar_seq;
DROP SEQUENCE asignatura_seq;
DROP SEQUENCE grado_seq;
DROP SEQUENCE persona_seq;
DROP SEQUENCE departamento_seq;

-- ================================================
-- 3. DROP de tablas (en orden inverso a dependencias)
-- ================================================
DROP TABLE alumno_se_matricula_asignatura CASCADE CONSTRAINTS;
DROP TABLE asignatura                  CASCADE CONSTRAINTS;
DROP TABLE curso_escolar               CASCADE CONSTRAINTS;
DROP TABLE profesor                    CASCADE CONSTRAINTS;
DROP TABLE grado                       CASCADE CONSTRAINTS;
DROP TABLE persona                     CASCADE CONSTRAINTS;
DROP TABLE departamento                CASCADE CONSTRAINTS;

-- ================================================
-- 4. CREACIÓN DE SECUENCIAS, TABLAS Y TRIGGERS
-- ================================================

CREATE TABLE departamento (
    id NUMBER(10) PRIMARY KEY,
    nombre VARCHAR2(50) NOT NULL
);
CREATE SEQUENCE departamento_seq START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;
CREATE OR REPLACE TRIGGER trg_departamento_bir
BEFORE INSERT ON departamento FOR EACH ROW
BEGIN
  IF :NEW.id IS NULL THEN
    SELECT departamento_seq.NEXTVAL INTO :NEW.id FROM dual;
  END IF;
END;
/

CREATE TABLE persona (
    id              NUMBER(10) PRIMARY KEY,
    nif             VARCHAR2(9)  UNIQUE,
    nombre          VARCHAR2(25) NOT NULL,
    apellido1       VARCHAR2(50) NOT NULL,
    apellido2       VARCHAR2(50),
    ciudad          VARCHAR2(25) NOT NULL,
    direccion       VARCHAR2(50) NOT NULL,
    telefono        VARCHAR2(9),
    fecha_nacimiento DATE        NOT NULL,
    sexo            CHAR(1)      NOT NULL CHECK(sexo IN ('H','M')),
    tipo            VARCHAR2(10) NOT NULL CHECK(tipo IN ('profesor','alumno'))
);
CREATE SEQUENCE persona_seq START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;
CREATE OR REPLACE TRIGGER trg_persona_bir
BEFORE INSERT ON persona FOR EACH ROW
BEGIN
  IF :NEW.id IS NULL THEN
    SELECT persona_seq.NEXTVAL INTO :NEW.id FROM dual;
  END IF;
END;
/

CREATE TABLE profesor (
    id_profesor     NUMBER(10) PRIMARY KEY,
    id_departamento NUMBER(10) NOT NULL,
    CONSTRAINT fk_profesor_persona FOREIGN KEY(id_profesor)     REFERENCES persona(id),
    CONSTRAINT fk_profesor_depto   FOREIGN KEY(id_departamento) REFERENCES departamento(id)
);

CREATE TABLE grado (
    id     NUMBER(10)    PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL
);
CREATE SEQUENCE grado_seq START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;
CREATE OR REPLACE TRIGGER trg_grado_bir
BEFORE INSERT ON grado FOR EACH ROW
BEGIN
  IF :NEW.id IS NULL THEN
    SELECT grado_seq.NEXTVAL INTO :NEW.id FROM dual;
  END IF;
END;
/

CREATE TABLE asignatura (
    id           NUMBER(10)    PRIMARY KEY,
    nombre       VARCHAR2(100) NOT NULL,
    creditos     NUMBER(4,1)   NOT NULL,
    tipo         VARCHAR2(12)  NOT NULL CHECK(tipo IN ('básica','obligatoria','optativa')),
    curso        NUMBER(3)     NOT NULL,
    cuatrimestre NUMBER(3)     NOT NULL,
    id_profesor  NUMBER(10),
    id_grado     NUMBER(10)    NOT NULL,
    CONSTRAINT fk_asig_profesor FOREIGN KEY(id_profesor) REFERENCES profesor(id_profesor),
    CONSTRAINT fk_asig_grado    FOREIGN KEY(id_grado)     REFERENCES grado(id)
);
CREATE SEQUENCE asignatura_seq START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;
CREATE OR REPLACE TRIGGER trg_asignatura_bir
BEFORE INSERT ON asignatura FOR EACH ROW
BEGIN
  IF :NEW.id IS NULL THEN
    SELECT asignatura_seq.NEXTVAL INTO :NEW.id FROM dual;
  END IF;
END;
/

CREATE TABLE curso_escolar (
    id          NUMBER(10) PRIMARY KEY,
    anyo_inicio NUMBER(4)  NOT NULL,
    anyo_fin    NUMBER(4)  NOT NULL
);
CREATE SEQUENCE curso_escolar_seq START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;
CREATE OR REPLACE TRIGGER trg_curso_escolar_bir
BEFORE INSERT ON curso_escolar FOR EACH ROW
BEGIN
  IF :NEW.id IS NULL THEN
    SELECT curso_escolar_seq.NEXTVAL INTO :NEW.id FROM dual;
  END IF;
END;
/

CREATE TABLE alumno_se_matricula_asignatura (
    id_alumno        NUMBER(10) NOT NULL,
    id_asignatura    NUMBER(10) NOT NULL,
    id_curso_escolar NUMBER(10) NOT NULL,
    PRIMARY KEY (id_alumno, id_asignatura, id_curso_escolar),
    CONSTRAINT fk_matri_persona    FOREIGN KEY(id_alumno)        REFERENCES persona(id),
    CONSTRAINT fk_matri_asignatura FOREIGN KEY(id_asignatura)    REFERENCES asignatura(id),
    CONSTRAINT fk_matri_curso      FOREIGN KEY(id_curso_escolar) REFERENCES curso_escolar(id)
);


-- ================================================
-- 2. INSERTS DEPARTAMENTO
-- ================================================
INSERT ALL
  INTO departamento(nombre) VALUES ('Informática')
  INTO departamento(nombre) VALUES ('Matemáticas')
  INTO departamento(nombre) VALUES ('Economía y Empresa')
  INTO departamento(nombre) VALUES ('Educación')
  INTO departamento(nombre) VALUES ('Agronomía')
  INTO departamento(nombre) VALUES ('Química y Física')
  INTO departamento(nombre) VALUES ('Filología')
  INTO departamento(nombre) VALUES ('Derecho')
  INTO departamento(nombre) VALUES ('Biología y Geología')
SELECT * FROM DUAL;

-- ================================================
-- 3. INSERTS PERSONA
-- ================================================
INSERT ALL
  INTO persona(nif,nombre,apellido1,apellido2,ciudad,direccion,telefono,fecha_nacimiento,sexo,tipo)
    VALUES ('26902806M','Salvador','Sánchez','Pérez','Almería','C/ Real del barrio alto','950254837',DATE '1991-03-28','H','alumno')
  INTO persona(nif,nombre,apellido1,apellido2,ciudad,direccion,telefono,fecha_nacimiento,sexo,tipo)
    VALUES ('89542419S','Juan','Saez','Vega','Almería','C/ Mercurio','618253876',DATE '1992-08-08','H','alumno')
  INTO persona(nif,nombre,apellido1,apellido2,ciudad,direccion,telefono,fecha_nacimiento,sexo,tipo)
    VALUES ('11105554G','Zoe','Ramirez','Gea','Almería','C/ Marte','618223876',DATE '1979-08-19','M','profesor')
  INTO persona(nif,nombre,apellido1,apellido2,ciudad,direccion,telefono,fecha_nacimiento,sexo,tipo)
    VALUES ('17105885A','Pedro','Heller','Pagac','Almería','C/ Estrella fugaz',NULL,DATE '2000-10-05','H','alumno')
  INTO persona(nif,nombre,apellido1,apellido2,ciudad,direccion,telefono,fecha_nacimiento,sexo,tipo)
    VALUES ('38223286T','David','Schmidt','Fisher','Almería','C/ Venus','678516294',DATE '1978-01-19','H','profesor')
  INTO persona(nif,nombre,apellido1,apellido2,ciudad,direccion,telefono,fecha_nacimiento,sexo,tipo)
    VALUES ('04233869Y','José','Koss','Bayer','Almería','C/ Júpiter','628349590',DATE '1998-01-28','H','alumno')
  INTO persona(nif,nombre,apellido1,apellido2,ciudad,direccion,telefono,fecha_nacimiento,sexo,tipo)
    VALUES ('97258166K','Ismael','Strosin','Turcotte','Almería','C/ Neptuno',NULL,DATE '1999-05-24','H','alumno')
  INTO persona(nif,nombre,apellido1,apellido2,ciudad,direccion,telefono,fecha_nacimiento,sexo,tipo)
    VALUES ('79503962T','Cristina','Lemke','Rutherford','Almería','C/ Saturno','669162534',DATE '1977-08-21','M','profesor')
  INTO persona(nif,nombre,apellido1,apellido2,ciudad,direccion,telefono,fecha_nacimiento,sexo,tipo)
    VALUES ('82842571K','Ramón','Herzog','Tremblay','Almería','C/ Urano','626351429',DATE '1996-11-21','H','alumno')
  INTO persona(nif,nombre,apellido1,apellido2,ciudad,direccion,telefono,fecha_nacimiento,sexo,tipo)
    VALUES ('61142000L','Esther','Spencer','Lakin','Almería','C/ Plutón',NULL,DATE '1977-05-19','M','profesor')
  INTO persona(nif,nombre,apellido1,apellido2,ciudad,direccion,telefono,fecha_nacimiento,sexo,tipo)
    VALUES ('46900725E','Daniel','Herman','Pacocha','Almería','C/ Andarax','679837625',DATE '1997-04-26','H','alumno')
  INTO persona(nif,nombre,apellido1,apellido2,ciudad,direccion,telefono,fecha_nacimiento,sexo,tipo)
    VALUES ('85366986W','Carmen','Streich','Hirthe','Almería','C/ Almanzora',NULL,DATE '1971-04-29','M','profesor')
  INTO persona(nif,nombre,apellido1,apellido2,ciudad,direccion,telefono,fecha_nacimiento,sexo,tipo)
    VALUES ('73571384L','Alfredo','Stiedemann','Morissette','Almería','C/ Guadalquivir','950896725',DATE '1980-02-01','H','profesor')
  INTO persona(nif,nombre,apellido1,apellido2,ciudad,direccion,telefono,fecha_nacimiento,sexo,tipo)
    VALUES ('82937751G','Manolo','Hamill','Kozey','Almería','C/ Duero','950263514',DATE '1977-01-02','H','profesor')
  INTO persona(nif,nombre,apellido1,apellido2,ciudad,direccion,telefono,fecha_nacimiento,sexo,tipo)
    VALUES ('80502866Z','Alejandro','Kohler','Schoen','Almería','C/ Tajo','668726354',DATE '1980-03-14','H','profesor')
  INTO persona(nif,nombre,apellido1,apellido2,ciudad,direccion,telefono,fecha_nacimiento,sexo,tipo)
    VALUES ('10485008K','Antonio','Fahey','Considine','Almería','C/ Sierra de los Filabres',NULL,DATE '1982-03-18','H','profesor')
  INTO persona(nif,nombre,apellido1,apellido2,ciudad,direccion,telefono,fecha_nacimiento,sexo,tipo)
    VALUES ('85869555K','Guillermo','Ruecker','Upton','Almería','C/ Sierra de Gádor',NULL,DATE '1973-05-05','H','profesor')
  INTO persona(nif,nombre,apellido1,apellido2,ciudad,direccion,telefono,fecha_nacimiento,sexo,tipo)
    VALUES ('04326833G','Micaela','Monahan','Murray','Almería','C/ Veleta','662765413',DATE '1976-02-25','H','profesor')
  INTO persona(nif,nombre,apellido1,apellido2,ciudad,direccion,telefono,fecha_nacimiento,sexo,tipo)
    VALUES ('11578526G','Inma','Lakin','Yundt','Almería','C/ Picos de Europa','678652431',DATE '1998-09-01','M','alumno')
  INTO persona(nif,nombre,apellido1,apellido2,ciudad,direccion,telefono,fecha_nacimiento,sexo,tipo)
    VALUES ('79221403L','Francesca','Schowalter','Muller','Almería','C/ Quinto pino',NULL,DATE '1980-10-31','H','profesor')
  INTO persona(nif,nombre,apellido1,apellido2,ciudad,direccion,telefono,fecha_nacimiento,sexo,tipo)
    VALUES ('79089577Y','Juan','Gutiérrez','López','Almería','C/ Los pinos','678652431',DATE '1998-01-01','H','alumno')
  INTO persona(nif,nombre,apellido1,apellido2,ciudad,direccion,telefono,fecha_nacimiento,sexo,tipo)
    VALUES ('41491230N','Antonio','Domínguez','Guerrero','Almería','C/ Cabo de Gata','626652498',DATE '1999-02-11','H','alumno')
  INTO persona(nif,nombre,apellido1,apellido2,ciudad,direccion,telefono,fecha_nacimiento,sexo,tipo)
    VALUES ('64753215G','Irene','Hernández','Martínez','Almería','C/ Zapillo','628452384',DATE '1996-03-12','M','alumno')
  INTO persona(nif,nombre,apellido1,apellido2,ciudad,direccion,telefono,fecha_nacimiento,sexo,tipo)
    VALUES ('85135690V','Sonia','Gea','Ruiz','Almería','C/ Mercurio','678812017',DATE '1995-04-13','M','alumno')
SELECT * FROM DUAL;

-- ================================================
-- 4. INSERTS PROFESOR
-- ================================================
INSERT ALL
  INTO profesor(id_profesor,id_departamento) VALUES (3,1)
  INTO profesor(id_profesor,id_departamento) VALUES (5,2)
  INTO profesor(id_profesor,id_departamento) VALUES (8,3)
  INTO profesor(id_profesor,id_departamento) VALUES (10,4)
  INTO profesor(id_profesor,id_departamento) VALUES (12,4)
  INTO profesor(id_profesor,id_departamento) VALUES (13,6)
  INTO profesor(id_profesor,id_departamento) VALUES (14,1)
  INTO profesor(id_profesor,id_departamento) VALUES (15,2)
  INTO profesor(id_profesor,id_departamento) VALUES (16,3)
  INTO profesor(id_profesor,id_departamento) VALUES (17,4)
  INTO profesor(id_profesor,id_departamento) VALUES (18,5)
  INTO profesor(id_profesor,id_departamento) VALUES (20,6)
SELECT * FROM DUAL;

-- ================================================
-- 5. INSERTS GRADO
-- ================================================
INSERT ALL
  INTO grado(nombre) VALUES ('Grado en Ingeniería Agrícola (Plan 2015)')
  INTO grado(nombre) VALUES ('Grado en Ingeniería Eléctrica (Plan 2014)')
  INTO grado(nombre) VALUES ('Grado en Ingeniería Electrónica Industrial (Plan 2010)')
  INTO grado(nombre) VALUES ('Grado en Ingeniería Informática (Plan 2015)')
  INTO grado(nombre) VALUES ('Grado en Ingeniería Mecánica (Plan 2010)')
  INTO grado(nombre) VALUES ('Grado en Ingeniería Química Industrial (Plan 2010)')
  INTO grado(nombre) VALUES ('Grado en Biotecnología (Plan 2015)')
  INTO grado(nombre) VALUES ('Grado en Ciencias Ambientales (Plan 2009)')
  INTO grado(nombre) VALUES ('Grado en Matemáticas (Plan 2010)')
  INTO grado(nombre) VALUES ('Grado en Química (Plan 2009)')
SELECT * FROM DUAL;

-- ================================================
-- INSERTS COMPLETOS DE ASIGNATURA (83 filas)
-- ================================================
INSERT ALL
  INTO asignatura(nombre,creditos,tipo,curso,cuatrimestre,id_profesor,id_grado) VALUES
    ('Álgegra lineal y matemática discreta',6,'básica',1,1,3,4)
  INTO asignatura(nombre,creditos,tipo,curso,cuatrimestre,id_profesor,id_grado) VALUES
    ('Cálculo',6,'básica',1,1,14,4)
  INTO asignatura(nombre,creditos,tipo,curso,cuatrimestre,id_profesor,id_grado) VALUES
    ('Física para informática',6,'básica',1,1,3,4)
  INTO asignatura(nombre,creditos,tipo,curso,cuatrimestre,id_profesor,id_grado) VALUES
    ('Introducción a la programación',6,'básica',1,1,14,4)
  INTO asignatura(nombre,creditos,tipo,curso,cuatrimestre,id_profesor,id_grado) VALUES
    ('Organización y gestión de empresas',6,'básica',1,1,3,4)
  INTO asignatura(nombre,creditos,tipo,curso,cuatrimestre,id_profesor,id_grado) VALUES
    ('Estadística',6,'básica',1,2,14,4)
  INTO asignatura(nombre,creditos,tipo,curso,cuatrimestre,id_profesor,id_grado) VALUES
    ('Estructura y tecnología de computadores',6,'básica',1,2,3,4)
  INTO asignatura(nombre,creditos,tipo,curso,cuatrimestre,id_profesor,id_grado) VALUES
    ('Fundamentos de electrónica',6,'básica',1,2,14,4)
  INTO asignatura(nombre,creditos,tipo,curso,cuatrimestre,id_profesor,id_grado) VALUES
    ('Lógica y algorítmica',6,'básica',1,2,3,4)
  INTO asignatura(nombre,creditos,tipo,curso,cuatrimestre,id_profesor,id_grado) VALUES
    ('Metodología de la programación',6,'básica',1,2,14,4)
  INTO asignatura(nombre,creditos,tipo,curso,cuatrimestre,id_profesor,id_grado) VALUES
    ('Arquitectura de Computadores',6,'básica',2,1,3,4)
  INTO asignatura(nombre,creditos,tipo,curso,cuatrimestre,id_profesor,id_grado) VALUES
    ('Estructura de Datos y Algoritmos I',6,'obligatoria',2,1,3,4)
  INTO asignatura(nombre,creditos,tipo,curso,cuatrimestre,id_profesor,id_grado) VALUES
    ('Ingeniería del Software',6,'obligatoria',2,1,14,4)
  INTO asignatura(nombre,creditos,tipo,curso,cuatrimestre,id_profesor,id_grado) VALUES
    ('Sistemas Inteligentes',6,'obligatoria',2,1,3,4)
  INTO asignatura(nombre,creditos,tipo,curso,cuatrimestre,id_profesor,id_grado) VALUES
    ('Sistemas Operativos',6,'obligatoria',2,1,14,4)
  INTO asignatura(nombre,creditos,tipo,curso,cuatrimestre,id_profesor,id_grado) VALUES
    ('Bases de Datos',6,'básica',2,2,14,4)
  INTO asignatura(nombre,creditos,tipo,curso,cuatrimestre,id_profesor,id_grado) VALUES
    ('Estructura de Datos y Algoritmos II',6,'obligatoria',2,2,14,4)
  INTO asignatura(nombre,creditos,tipo,curso,cuatrimestre,id_profesor,id_grado) VALUES
    ('Fundamentos de Redes de Computadores',6,'obligatoria',2,2,3,4)
  INTO asignatura(nombre,creditos,tipo,curso,cuatrimestre,id_profesor,id_grado) VALUES
    ('Planificación y Gestión de Proyectos Informáticos',6,'obligatoria',2,2,3,4)
  INTO asignatura(nombre,creditos,tipo,curso,cuatrimestre,id_profesor,id_grado) VALUES
    ('Programación de Servicios Software',6,'obligatoria',2,2,14,4)
  INTO asignatura(nombre,creditos,tipo,curso,cuatrimestre,id_profesor,id_grado) VALUES
    ('Desarrollo de interfaces de usuario',6,'obligatoria',3,1,14,4)
  INTO asignatura(nombre,creditos,tipo,curso,cuatrimestre,id_profesor,id_grado) VALUES
    ('Ingeniería de Requisitos',6,'optativa',3,1,NULL,4)
  INTO asignatura(nombre,creditos,tipo,curso,cuatrimestre,id_profesor,id_grado) VALUES
    ('Integración de las Tecnologías de la Información en las Organizaciones',6,'optativa',3,1,NULL,4)
  INTO asignatura(nombre,creditos,tipo,curso,cuatrimestre,id_profesor,id_grado) VALUES
    ('Modelado y Diseño del Software 1',6,'optativa',3,1,NULL,4)
  INTO asignatura(nombre,creditos,tipo,curso,cuatrimestre,id_profesor,id_grado) VALUES
    ('Multiprocesadores',6,'optativa',3,1,NULL,4)
  INTO asignatura(nombre,creditos,tipo,curso,cuatrimestre,id_profesor,id_grado) VALUES
    ('Seguridad y cumplimiento normativo',6,'optativa',3,1,NULL,4)
  INTO asignatura(nombre,creditos,tipo,curso,cuatrimestre,id_profesor,id_grado) VALUES
    ('Sistema de Información para las Organizaciones',6,'optativa',3,1,NULL,4)
  INTO asignatura(nombre,creditos,tipo,curso,cuatrimestre,id_profesor,id_grado) VALUES
    ('Tecnologías web',6,'optativa',3,1,NULL,4)
  INTO asignatura(nombre,creditos,tipo,curso,cuatrimestre,id_profesor,id_grado) VALUES
    ('Teoría de códigos y criptografía',6,'optativa',3,1,NULL,4)
  INTO asignatura(nombre,creditos,tipo,curso,cuatrimestre,id_profesor,id_grado) VALUES
    ('Administración de bases de datos',6,'optativa',3,2,NULL,4)
  INTO asignatura(nombre,creditos,tipo,curso,cuatrimestre,id_profesor,id_grado) VALUES
    ('Herramientas y Métodos de Ingeniería del Software',6,'optativa',3,2,NULL,4)
  INTO asignatura(nombre,creditos,tipo,curso,cuatrimestre,id_profesor,id_grado) VALUES
    ('Informática industrial y robótica',6,'optativa',3,2,NULL,4)
  INTO asignatura(nombre,creditos,tipo,curso,cuatrimestre,id_profesor,id_grado) VALUES
    ('Ingeniería de Sistemas de Información',6,'optativa',3,2,NULL,4)
  INTO asignatura(nombre,creditos,tipo,curso,cuatrimestre,id_profesor,id_grado) VALUES
    ('Modelado y Diseño del Software 2',6,'optativa',3,2,NULL,4)
  INTO asignatura(nombre,creditos,tipo,curso,cuatrimestre,id_profesor,id_grado) VALUES
    ('Negocio Electrónico',6,'optativa',3,2,NULL,4)
  INTO asignatura(nombre,creditos,tipo,curso,cuatrimestre,id_profesor,id_grado) VALUES
    ('Periféricos e interfaces',6,'optativa',3,2,NULL,4)
  INTO asignatura(nombre,creditos,tipo,curso,cuatrimestre,id_profesor,id_grado) VALUES
    ('Sistemas de tiempo real',6,'optativa',3,2,NULL,4)
  INTO asignatura(nombre,creditos,tipo,curso,cuatrimestre,id_profesor,id_grado) VALUES
    ('Tecnologías de acceso a red',6,'optativa',3,2,NULL,4)
  INTO asignatura(nombre,creditos,tipo,curso,cuatrimestre,id_profesor,id_grado) VALUES
    ('Tratamiento digital de imágenes',6,'optativa',3,2,NULL,4)
  INTO asignatura(nombre,creditos,tipo,curso,cuatrimestre,id_profesor,id_grado) VALUES
    ('Administración de redes y sistemas operativos',6,'optativa',4,1,NULL,4)
  INTO asignatura(nombre,creditos,tipo,curso,cuatrimestre,id_profesor,id_grado) VALUES
    ('Almacenes de Datos',6,'optativa',4,1,NULL,4)
  INTO asignatura(nombre,creditos,tipo,curso,cuatrimestre,id_profesor,id_grado) VALUES
    ('Fiabilidad y Gestión de Riesgos',6,'optativa',4,1,NULL,4)
  INTO asignatura(nombre,creditos,tipo,curso,cuatrimestre,id_profesor,id_grado) VALUES
    ('Líneas de Productos Software',6,'optativa',4,1,NULL,4)
  INTO asignatura(nombre,creditos,tipo,curso,cuatrimestre,id_profesor,id_grado) VALUES
    ('Procesos de Ingeniería del Software 1',6,'optativa',4,1,NULL,4)
  INTO asignatura(nombre,creditos,tipo,curso,cuatrimestre,id_profesor,id_grado) VALUES
    ('Tecnologías multimedia',6,'optativa',4,1,NULL,4)
  INTO asignatura(nombre,creditos,tipo,curso,cuatrimestre,id_profesor,id_grado) VALUES
    ('Análisis y planificación de las TI',6,'optativa',4,2,NULL,4)
  INTO asignatura(nombre,creditos,tipo,curso,cuatrimestre,id_profesor,id_grado) VALUES
    ('Desarrollo Rápido de Aplicaciones',6,'optativa',4,2,NULL,4)
  INTO asignatura(nombre,creditos,tipo,curso,cuatrimestre,id_profesor,id_grado) VALUES
    ('Gestión de la Calidad y de la Innovación Tecnológica',6,'optativa',4,2,NULL,4)
  INTO asignatura(nombre,creditos,tipo,curso,cuatrimestre,id_profesor,id_grado) VALUES
    ('Inteligencia del Negocio',6,'optativa',4,2,NULL,4)
  INTO asignatura(nombre,creditos,tipo,curso,cuatrimestre,id_profesor,id_grado) VALUES
    ('Procesos de Ingeniería del Software 2',6,'optativa',4,2,NULL,4)
  INTO asignatura(nombre,creditos,tipo,curso,cuatrimestre,id_profesor,id_grado) VALUES
    ('Seguridad Informática',6,'optativa',4,2,NULL,4)
  INTO asignatura(nombre,creditos,tipo,curso,cuatrimestre,id_profesor,id_grado) VALUES
    ('Biologia celular',6,'básica',1,1,NULL,7)
  INTO asignatura(nombre,creditos,tipo,curso,cuatrimestre,id_profesor,id_grado) VALUES
    ('Física',6,'básica',1,1,NULL,7)
  INTO asignatura(nombre,creditos,tipo,curso,cuatrimestre,id_profesor,id_grado) VALUES
    ('Matemáticas I',6,'básica',1,1,NULL,7)
  INTO asignatura(nombre,creditos,tipo,curso,cuatrimestre,id_profesor,id_grado) VALUES
    ('Química general',6,'básica',1,1,NULL,7)
  INTO asignatura(nombre,creditos,tipo,curso,cuatrimestre,id_profesor,id_grado) VALUES
    ('Química orgánica',6,'básica',1,1,NULL,7)
  INTO asignatura(nombre,creditos,tipo,curso,cuatrimestre,id_profesor,id_grado) VALUES
    ('Biología vegetal y animal',6,'básica',1,2,NULL,7)
  INTO asignatura(nombre,creditos,tipo,curso,cuatrimestre,id_profesor,id_grado) VALUES
    ('Bioquímica',6,'básica',1,2,NULL,7)
  INTO asignatura(nombre,creditos,tipo,curso,cuatrimestre,id_profesor,id_grado) VALUES
    ('Genética',6,'básica',1,2,NULL,7)
  INTO asignatura(nombre,creditos,tipo,curso,cuatrimestre,id_profesor,id_grado) VALUES
    ('Matemáticas II',6,'básica',1,2,NULL,7)
  INTO asignatura(nombre,creditos,tipo,curso,cuatrimestre,id_profesor,id_grado) VALUES
    ('Microbiología',6,'básica',1,2,NULL,7)
  INTO asignatura(nombre,creditos,tipo,curso,cuatrimestre,id_profesor,id_grado) VALUES
    ('Botánica agrícola',6,'obligatoria',2,1,NULL,7)
  INTO asignatura(nombre,creditos,tipo,curso,cuatrimestre,id_profesor,id_grado) VALUES
    ('Fisiología vegetal',6,'obligatoria',2,1,NULL,7)
  INTO asignatura(nombre,creditos,tipo,curso,cuatrimestre,id_profesor,id_grado) VALUES
    ('Genética molecular',6,'obligatoria',2,1,NULL,7)
  INTO asignatura(nombre,creditos,tipo,curso,cuatrimestre,id_profesor,id_grado) VALUES
    ('Ingeniería bioquímica',6,'obligatoria',2,1,NULL,7)
  INTO asignatura(nombre,creditos,tipo,curso,cuatrimestre,id_profesor,id_grado) VALUES
    ('Termodinámica y cinética química aplicada',6,'obligatoria',2,1,NULL,7)
  INTO asignatura(nombre,creditos,tipo,curso,cuatrimestre,id_profesor,id_grado) VALUES
    ('Biorreactores',6,'obligatoria',2,2,NULL,7)
  INTO asignatura(nombre,creditos,tipo,curso,cuatrimestre,id_profesor,id_grado) VALUES
    ('Biotecnología microbiana',6,'obligatoria',2,2,NULL,7)
  INTO asignatura(nombre,creditos,tipo,curso,cuatrimestre,id_profesor,id_grado) VALUES
    ('Ingeniería genética',6,'obligatoria',2,2,NULL,7)
  INTO asignatura(nombre,creditos,tipo,curso,cuatrimestre,id_profesor,id_grado) VALUES
    ('Inmunología',6,'obligatoria',2,2,NULL,7)
  INTO asignatura(nombre,creditos,tipo,curso,cuatrimestre,id_profesor,id_grado) VALUES
    ('Virología',6,'obligatoria',2,2,NULL,7)
  INTO asignatura(nombre,creditos,tipo,curso,cuatrimestre,id_profesor,id_grado) VALUES
    ('Bases moleculares del desarrollo vegetal',4.5,'obligatoria',3,1,NULL,7)
  INTO asignatura(nombre,creditos,tipo,curso,cuatrimestre,id_profesor,id_grado) VALUES
    ('Fisiología animal',4.5,'obligatoria',3,1,NULL,7)
  INTO asignatura(nombre,creditos,tipo,curso,cuatrimestre,id_profesor,id_grado) VALUES
    ('Metabolismo y biosíntesis de biomoléculas',6,'obligatoria',3,1,NULL,7)
  INTO asignatura(nombre,creditos,tipo,curso,cuatrimestre,id_profesor,id_grado) VALUES
    ('Operaciones de separación',6,'obligatoria',3,1,NULL,7)
  INTO asignatura(nombre,creditos,tipo,curso,cuatrimestre,id_profesor,id_grado) VALUES
    ('Patología molecular de plantas',4.5,'obligatoria',3,1,NULL,7)
  INTO asignatura(nombre,creditos,tipo,curso,cuatrimestre,id_profesor,id_grado) VALUES
    ('Técnicas instrumentales básicas',4.5,'obligatoria',3,1,NULL,7)
  INTO asignatura(nombre,creditos,tipo,curso,cuatrimestre,id_profesor,id_grado) VALUES
    ('Bioinformática',4.5,'obligatoria',3,2,NULL,7)
  INTO asignatura(nombre,creditos,tipo,curso,cuatrimestre,id_profesor,id_grado) VALUES
    ('Biotecnología de los productos hortofrutículas',4.5,'obligatoria',3,2,NULL,7)
  INTO asignatura(nombre,creditos,tipo,curso,cuatrimestre,id_profesor,id_grado) VALUES
    ('Biotecnología vegetal',6,'obligatoria',3,2,NULL,7)
  INTO asignatura(nombre,creditos,tipo,curso,cuatrimestre,id_profesor,id_grado) VALUES
    ('Genómica y proteómica',4.5,'obligatoria',3,2,NULL,7)
  INTO asignatura(nombre,creditos,tipo,curso,cuatrimestre,id_profesor,id_grado) VALUES
    ('Procesos biotecnológicos',6,'obligatoria',3,2,NULL,7)
  INTO asignatura(nombre,creditos,tipo,curso,cuatrimestre,id_profesor,id_grado) VALUES
    ('Técnicas instrumentales avanzadas',4.5,'obligatoria',3,2,NULL,7)
SELECT * FROM DUAL;

-- ================================================
-- INSERTS COMPLETOS DE CURSO_ESCOLAR (5 filas)
-- ================================================
INSERT ALL
  INTO curso_escolar(anyo_inicio,anyo_fin) VALUES (2014,2015)
  INTO curso_escolar(anyo_inicio,anyo_fin) VALUES (2015,2016)
  INTO curso_escolar(anyo_inicio,anyo_fin) VALUES (2016,2017)
  INTO curso_escolar(anyo_inicio,anyo_fin) VALUES (2017,2018)
  INTO curso_escolar(anyo_inicio,anyo_fin) VALUES (2018,2019)
SELECT * FROM DUAL;

-- ================================================
-- INSERTS COMPLETOS DE ALUMNO_SE_MATRICULA_ASIGNATURA (37 filas)
-- ================================================
INSERT ALL
  INTO alumno_se_matricula_asignatura VALUES (1,1,1)
  INTO alumno_se_matricula_asignatura VALUES (1,2,1)
  INTO alumno_se_matricula_asignatura VALUES (1,3,1)
  INTO alumno_se_matricula_asignatura VALUES (2,1,1)
  INTO alumno_se_matricula_asignatura VALUES (2,2,1)
  INTO alumno_se_matricula_asignatura VALUES (2,3,1)
  INTO alumno_se_matricula_asignatura VALUES (4,1,1)
  INTO alumno_se_matricula_asignatura VALUES (4,2,1)
  INTO alumno_se_matricula_asignatura VALUES (4,3,1)
  INTO alumno_se_matricula_asignatura VALUES (24,1,5)
  INTO alumno_se_matricula_asignatura VALUES (24,2,5)
  INTO alumno_se_matricula_asignatura VALUES (24,3,5)
  INTO alumno_se_matricula_asignatura VALUES (24,4,5)
  INTO alumno_se_matricula_asignatura VALUES (24,5,5)
  INTO alumno_se_matricula_asignatura VALUES (24,6,5)
  INTO alumno_se_matricula_asignatura VALUES (24,7,5)
  INTO alumno_se_matricula_asignatura VALUES (24,8,5)
  INTO alumno_se_matricula_asignatura VALUES (24,9,5)
  INTO alumno_se_matricula_asignatura VALUES (24,10,5)
  INTO alumno_se_matricula_asignatura VALUES (23,1,5)
  INTO alumno_se_matricula_asignatura VALUES (23,2,5)
  INTO alumno_se_matricula_asignatura VALUES (23,3,5)
  INTO alumno_se_matricula_asignatura VALUES (23,4,5)
  INTO alumno_se_matricula_asignatura VALUES (23,5,5)
  INTO alumno_se_matricula_asignatura VALUES (23,6,5)
  INTO alumno_se_matricula_asignatura VALUES (23,7,5)
  INTO alumno_se_matricula_asignatura VALUES (23,8,5)
  INTO alumno_se_matricula_asignatura VALUES (23,9,5)
  INTO alumno_se_matricula_asignatura VALUES (23,10,5)
  INTO alumno_se_matricula_asignatura VALUES (19,1,5)
  INTO alumno_se_matricula_asignatura VALUES (19,2,5)
  INTO alumno_se_matricula_asignatura VALUES (19,3,5)
  INTO alumno_se_matricula_asignatura VALUES (19,4,5)
  INTO alumno_se_matricula_asignatura VALUES (19,5,5)
  INTO alumno_se_matricula_asignatura VALUES (19,6,5)
  INTO alumno_se_matricula_asignatura VALUES (19,7,5)
  INTO alumno_se_matricula_asignatura VALUES (19,8,5)
  INTO alumno_se_matricula_asignatura VALUES (19,9,5)
  INTO alumno_se_matricula_asignatura VALUES (19,10,5)
SELECT * FROM DUAL;

