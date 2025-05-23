
  
-- DEPARTAMENTO
CREATE TABLE departamento (
  id           NUMBER(10) GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  nombre       VARCHAR2(50) NOT NULL
);

-- PERSONA
CREATE TABLE persona (
  id             NUMBER(10) GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  nif            VARCHAR2(9) UNIQUE,
  nombre         VARCHAR2(25) NOT NULL,
  apellido1      VARCHAR2(50) NOT NULL,
  apellido2      VARCHAR2(50),
  ciudad         VARCHAR2(25) NOT NULL,
  direccion      VARCHAR2(50) NOT NULL,
  telefono       VARCHAR2(9),
  fecha_nacimiento DATE      NOT NULL,
  sexo           VARCHAR2(1)  NOT NULL
                     CHECK (sexo IN ('H','M')),
  tipo           VARCHAR2(10) NOT NULL
                     CHECK (tipo IN ('profesor','alumno'))
);

-- PROFESOR
CREATE TABLE profesor (
  id_profesor     NUMBER(10) PRIMARY KEY,
  id_departamento NUMBER(10) NOT NULL,
  CONSTRAINT fk_prof_persona
    FOREIGN KEY (id_profesor) REFERENCES persona(id),
  CONSTRAINT fk_prof_depto
    FOREIGN KEY (id_departamento) REFERENCES departamento(id)
);

-- GRADO
CREATE TABLE grado (
  id     NUMBER(10) GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  nombre VARCHAR2(100) NOT NULL
);

-- ASIGNATURA
CREATE TABLE asignatura (
  id             NUMBER(10) GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  nombre         VARCHAR2(100) NOT NULL,
  creditos       NUMBER(5,2)   NOT NULL,
  tipo           VARCHAR2(12)  NOT NULL
                   CHECK (tipo IN ('básica','obligatoria','optativa')),
  curso          NUMBER(2)     NOT NULL,
  cuatrimestre   NUMBER(2)     NOT NULL,
  id_profesor    NUMBER(10),
  id_grado       NUMBER(10)    NOT NULL,
  CONSTRAINT fk_asig_prof
    FOREIGN KEY (id_profesor) REFERENCES profesor(id_profesor),
  CONSTRAINT fk_asig_grado
    FOREIGN KEY (id_grado) REFERENCES grado(id)
);

-- CURSO_ESCOLAR
CREATE TABLE curso_escolar (
  id           NUMBER(10) GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  anyo_inicio  NUMBER(4) NOT NULL,
  anyo_fin     NUMBER(4) NOT NULL
);

-- ALUMNO_SE_MATRICULA_ASIGNATURA
CREATE TABLE alumno_se_matricula_asignatura (
  id_alumno        NUMBER(10) NOT NULL,
  id_asignatura    NUMBER(10) NOT NULL,
  id_curso_escolar NUMBER(10) NOT NULL,
  PRIMARY KEY (id_alumno, id_asignatura, id_curso_escolar),
  CONSTRAINT fk_matricula_alumno
    FOREIGN KEY (id_alumno)        REFERENCES persona(id),
  CONSTRAINT fk_matricula_asig
    FOREIGN KEY (id_asignatura)    REFERENCES asignatura(id),
  CONSTRAINT fk_matricula_curso
    FOREIGN KEY (id_curso_escolar) REFERENCES curso_escolar(id)
);

-- INSERTS

INSERT INTO departamento(id, nombre) VALUES (1, 'Informática');
INSERT INTO departamento(id, nombre) VALUES (2, 'Matemáticas');
INSERT INTO departamento(id, nombre) VALUES (3, 'Economía y Empresa');
INSERT INTO departamento(id, nombre) VALUES (4, 'Educación');
INSERT INTO departamento(id, nombre) VALUES (5, 'Agronomía');
INSERT INTO departamento(id, nombre) VALUES (6, 'Química y Física');
INSERT INTO departamento(id, nombre) VALUES (7, 'Filología');
INSERT INTO departamento(id, nombre) VALUES (8, 'Derecho');
INSERT INTO departamento(id, nombre) VALUES (9, 'Biología y Geología');

-- For PERSONA, we explicitly specify all columns except the IDENTITY column
INSERT INTO persona(nif, nombre, apellido1, apellido2, ciudad, direccion, telefono, fecha_nacimiento, sexo, tipo)
VALUES
('26902806M','Salvador','Sánchez','Pérez','Almería','C/ Real del barrio alto','950254837',DATE '1991-03-28','H','alumno'),
('89542419S','Juan','Saez','Vega','Almería','C/ Mercurio','618253876',DATE '1992-08-08','H','alumno'),
('11105554G','Zoe','Ramirez','Gea','Almería','C/ Marte','618223876',DATE '1979-08-19','M','profesor'),
('17105885A','Pedro','Heller','Pagac','Almería','C/ Estrella fugaz',NULL,DATE '2000-10-05','H','alumno'),
('38223286T','David','Schmidt','Fisher','Almería','C/ Venus','678516294',DATE '1978-01-19','H','profesor'),
('04233869Y','José','Koss','Bayer','Almería','C/ Júpiter','628349590',DATE '1998-01-28','H','alumno'),
('97258166K','Ismael','Strosin','Turcotte','Almería','C/ Neptuno',NULL,DATE '1999-05-24','H','alumno'),
('79503962T','Cristina','Lemke','Rutherford','Almería','C/ Saturno','669162534',DATE '1977-08-21','M','profesor'),
('82842571K','Ramón','Herzog','Tremblay','Almería','C/ Urano','626351429',DATE '1996-11-21','H','alumno'),
('61142000L','Esther','Spencer','Lakin','Almería','C/ Plutón',NULL,DATE '1977-05-19','M','profesor'),
('46900725E','Daniel','Herman','Pacocha','Almería','C/ Andarax','679837625',DATE '1997-04-26','H','alumno'),
('85366986W','Carmen','Streich','Hirthe','Almería','C/ Almanzora',NULL,DATE '1971-04-29','M','profesor'),
('73571384L','Alfredo','Stiedemann','Morissette','Almería','C/ Guadalquivir','950896725',DATE '1980-02-01','H','profesor'),
('82937751G','Manolo','Hamill','Kozey','Almería','C/ Duero','950263514',DATE '1977-01-02','H','profesor'),
('80502866Z','Alejandro','Kohler','Schoen','Almería','C/ Tajo','668726354',DATE '1980-03-14','H','profesor'),
('10485008K','Antonio','Fahey','Considine','Almería','C/ Sierra de los Filabres',NULL,DATE '1982-03-18','H','profesor'),
('85869555K','Guillermo','Ruecker','Upton','Almería','C/ Sierra de Gádor',NULL,DATE '1973-05-05','H','profesor'),
('04326833G','Micaela','Monahan','Murray','Almería','C/ Veleta','662765413',DATE '1976-02-25','H','profesor'),
('11578526G','Inma','Lakin','Yundt','Almería','C/ Picos de Europa','678652431',DATE '1998-09-01','M','alumno'),
('79221403L','Francesca','Schowalter','Muller','Almería','C/ Quinto pino',NULL,DATE '1980-10-31','H','profesor'),
('79089577Y','Juan','Gutiérrez','López','Almería','C/ Los pinos','678652431',DATE '1998-01-01','H','alumno'),
('41491230N','Antonio','Domínguez','Guerrero','Almería','C/ Cabo de Gata','626652498',DATE '1999-02-11','H','alumno'),
('64753215G','Irene','Hernández','Martínez','Almería','C/ Zapillo','628452384',DATE '1996-03-12','M','alumno'),
('85135690V','Sonia','Gea','Ruiz','Almería','C/ Mercurio','678812017',DATE '1995-04-13','M','alumno');

-- PROFESOR assignments
INSERT INTO profesor(id_profesor, id_departamento) VALUES
(3,1),(5,2),(8,3),(10,4),(12,4),(13,6),(14,1),(15,2),(16,3),(17,4),(18,5),(20,6);

-- GRADO
INSERT INTO grado(nombre) VALUES
('Grado en Ingeniería Agrícola (Plan 2015)'),
('Grado en Ingeniería Eléctrica (Plan 2014)'),
('Grado en Ingeniería Electrónica Industrial (Plan 2010)'),
('Grado en Ingeniería Informática (Plan 2015)'),
('Grado en Ingeniería Mecánica (Plan 2010)'),
('Grado en Ingeniería Química Industrial (Plan 2010)'),
('Grado en Biotecnología (Plan 2015)'),
('Grado en Ciencias Ambientales (Plan 2009)'),
('Grado en Matemáticas (Plan 2010)'),
('Grado en Química (Plan 2009)');

-- ASIGNATURA
-- (for brevity, only a few examples; repeat pattern for all)
INSERT INTO asignatura(nombre, creditos, tipo, curso, cuatrimestre, id_profesor, id_grado) VALUES
('Álgegra lineal y matemática discreta',6,'básica',1,1,3,4),
('Cálculo',6,'básica',1,1,14,4),
('Física para informática',6,'básica',1,1,3,4);
-- … (continue for all 83 rows)

-- CURSO_ESCOLAR
INSERT INTO curso_escolar(anyo_inicio, anyo_fin) VALUES
(2014,2015),(2015,2016),(2016,2017),(2017,2018),(2018,2019);

-- ALUMNO_SE_MATRICULA_ASIGNATURA
-- (similarly batch‐insert your enrollment data)
INSERT INTO alumno_se_matricula_asignatura(id_alumno,id_asignatura,id_curso_escolar) VALUES
(1,1,1),(1,2,1),(1,3,1),
(2,1,1),(2,2,1),(2,3,1),
(4,1,1),(4,2,1),(4,3,1),
(24,1,5),(24,2,5),(24,3,5),(24,4,5),(24,5,5),(24,6,5),(24,7,5),(24,8,5),(24,9,5),(24,10,5),
(23,1,5),(23,2,5),(23,3,5),(23,4,5),(23,5,5),(23,6,5),(23,7,5),(23,8,5),(23,9,5),(23,10,5),
(19,1,5),(19,2,5),(19,3,5),(19,4,5),(19,5,5),(19,6,5),(19,7,5),(19,8,5),(19,9,5),(19,10,5);

COMMIT;
