drop table DatosPersonales cascade constraints; --
drop table Director cascade constraints; --
drop table Comercial cascade constraints; --
drop table RestoEmpleados cascade constraints; --
drop table Autor cascade constraints; --
drop table Oficina cascade constraints; --
drop table Vendedor cascade constraints; --
drop table Cliente cascade constraints; --
drop table Venta cascade constraints; --
drop table Libro cascade constraints; --
drop table Contrato cascade constraints; --
drop table LibroPropio cascade constraints;
drop table LibroAutor cascade constraints; --
drop table Empresa cascade constraints; --
drop table Editorial cascade constraints; --
drop table Tecnica cascade constraints; --
drop table TecnicaLibro cascade constraints; --
drop table ContratoAutor cascade constraints; --
drop table LibroVenta cascade constraints; --
drop table EmpresaLibro cascade constraints; --
drop table Compra cascade constraints; --


-- Tabla DATOSPERSONALES -- BIEN
CREATE TABLE DatosPersonales (
    DNI VARCHAR(10) PRIMARY KEY,
    Nombre VARCHAR2(50),
    PrimerApellido VARCHAR2(50),
    SegundoApellido VARCHAR2(50),
    Domicilio VARCHAR2(100),
    Telefono VARCHAR2(15),
    Correo VARCHAR2(50)
);

-- DIRECTOR -- BIEN

CREATE TABLE Director (
    DNI VARCHAR2(10),
    CONSTRAINT Director_DNI_pk PRIMARY KEY (DNI),
    CONSTRAINT DP_dni_fk FOREIGN KEY (DNI) REFERENCES DatosPersonales(DNI)
);

-- COMERCIAL -- BIEN
CREATE TABLE Comercial (
    DNI VARCHAR2(10),
    comision INT,
    constraint FK_COMER_DP FOREIGN KEY (dni) REFERENCES DatosPersonales(dni)
);

-- RESTOEMPLEADOS --

CREATE TABLE RestoEmpleados (
    dni VARCHAR2(10),
    cargo VARCHAR2(10),
    constraint FK_RE_DP FOREIGN KEY (dni) REFERENCES DatosPersonales(dni)
);

-- AUTOR -- BIEN

CREATE TABLE Autor (
    cuenta VARCHAR2(100),
    dni VARCHAR2(10),
    constraint FK_AU_DP FOREIGN KEY (dni) REFERENCES DatosPersonales(dni),
    CONSTRAINT Autor_DNI_pk PRIMARY KEY (DNI)
);

-- OFICINA -- BIEN

CREATE TABLE Oficina (
    cod_oficina VARCHAR2(10),
    direccion VARCHAR2(100),
    telefono INT,
    dni_dir VARCHAR2(10), 
    dni_com VARCHAR2(10),  
    CONSTRAINT PK_OFI PRIMARY KEY (cod_oficina),
    CONSTRAINT FK_DIR_DP FOREIGN KEY (dni_dir) REFERENCES DatosPersonales(DNI),
    CONSTRAINT FK_COM2_DP FOREIGN KEY (dni_com) REFERENCES DatosPersonales(DNI)
);

-- VENDEDOR -- BIEN

CREATE TABLE Vendedor (
    turno VARCHAR2(100),
    dni_vendedor VARCHAR2(10),  
    cod_oficina VARCHAR2(10),  
    CONSTRAINT FK_VEN_DP FOREIGN KEY (dni_vendedor) REFERENCES DatosPersonales(dni),
    CONSTRAINT FK_CODOF_CODOF FOREIGN KEY (cod_oficina) REFERENCES Oficina(cod_oficina)
);

-- CLIENTE -- BIEN

CREATE TABLE Cliente (
    dni_cliente VARCHAR2(10) PRIMARY KEY,
    numTarjeta INT,
    constraint FK_CLI_DP FOREIGN KEY (dni_cliente) REFERENCES DatosPersonales(dni)
);

-- VENTA -- BIEN

CREATE TABLE Venta (
    cod_venta VARCHAR2(100),
    fecha DATE,
    cantlineas VARCHAR2(100),
    tipo VARCHAR2(10),
    dni_vendedor VARCHAR2(10),
    dni_cliente VARCHAR2(10),
    CONSTRAINT FK_VENT_DP FOREIGN KEY (dni_vendedor) REFERENCES DatosPersonales(dni),
    CONSTRAINT FK_CLI_VEN FOREIGN KEY (dni_cliente) REFERENCES DatosPersonales(dni) 
);
    
-- LIBRO -- BIEN

CREATE TABLE Libro (
    ISBN VARCHAR2(20),
    titulo VARCHAR2(100),
    npag INT,
    precio NUMBER(5,2),
    tematica VARCHAR2(50),
    tipo VARCHAR2(20),
    CONSTRAINT PK_LIB_ISBN PRIMARY KEY (ISBN)
);

-- CONTRATO -- BIEN

CREATE TABLE Contrato (
    cod_contrato VARCHAR2(100),
    fecha DATE,
    durabilidad VARCHAR2(20),
    num_act VARCHAR2(100),
    porcent VARCHAR2(100),
    tipo VARCHAR2(100),
    npago VARCHAR2(100),
    ISBN VARCHAR2(100), 
    CONSTRAINT PK_CON PRIMARY KEY (cod_contrato),
    CONSTRAINT FK_LIB_CONT2 FOREIGN KEY (ISBN) REFERENCES Libro(ISBN)
);

-- LIBRO PROPIO -- BIEN

CREATE TABLE LibroPropio (
    ISBN VARCHAR2(100), 
    num_ejemplo VARCHAR2(100),
    CONSTRAINT FK_LIB_CONT FOREIGN KEY (ISBN) REFERENCES Libro(ISBN)
);
-- LIBRO AUTOR -- BIEN

CREATE TABLE LibroAutor (
    ISBN VARCHAR2(100), 
    CONSTRAINT FK_LIB_AUTOR FOREIGN KEY (ISBN) REFERENCES Libro(ISBN) 
);

-- EMPRESA -- BIEN

CREATE TABLE Empresa (
    CIF INT PRIMARY KEY,
    RazonSocial VARCHAR2(10),
    Direccion VARCHAR2(10),
    Correo VARCHAR2(20),
    telefono NUMBER,
    tipo VARCHAR2(10)
);

-- EDITORIAL -- BIEN

CREATE TABLE Editorial (
    CIF INT,
    num_ejemplo VARCHAR2(100),
    CONSTRAINT FK_EMPRESA_CIF FOREIGN KEY (CIF) REFERENCES Empresa(CIF)
);

-- TECNICA -- BIEN

CREATE TABLE Tecnica (
    CIF INT PRIMARY KEY,
    preContrato VARCHAR2(100),
    CONSTRAINT FK_EMPRESA_TECNICA FOREIGN KEY (CIF) REFERENCES Empresa(CIF) 
);

-- TECNICA LIBRO -- BIEN

CREATE TABLE TecnicaLibro (
    cod_contrato VARCHAR2(100),
    dni_empleado VARCHAR2(100),
    categoria VARCHAR2(100),
    CONSTRAINT FK_TL_DP FOREIGN KEY (dni_empleado) REFERENCES DatosPersonales(dni), 
    CONSTRAINT FK_TECNICA_LIBRO_CONTRATO FOREIGN KEY (cod_contrato) REFERENCES Contrato(cod_contrato) 
);

-- CONTRATO AUTOR -- BIEN

CREATE TABLE ContratoAutor (
    dni_autor VARCHAR2(10),
    cod_contrato VARCHAR2(100),
    CONSTRAINT FK_CONTRATO_AUTOR_CONTRATO FOREIGN KEY (cod_contrato) REFERENCES Contrato(cod_contrato), 
    CONSTRAINT FK_CONTRATO_AUTOR_DP FOREIGN KEY (dni_autor) REFERENCES DatosPersonales(dni) 
);


-- LIBRO VENTA -- BIEN

CREATE TABLE LibroVenta (
    cod_venta VARCHAR2(100),
    ISBN VARCHAR2(100), -- Cambiar a INT si es necesario
    dni_autor VARCHAR2(10), -- Cambiar a INT si es necesario
    cantidad VARCHAR2(100),
    CONSTRAINT FK_LIBRO_VENTA_AUTOR FOREIGN KEY (dni_autor) REFERENCES DatosPersonales(dni),
    CONSTRAINT FK_LIBRO_VENTA_ISBN FOREIGN KEY (ISBN) REFERENCES Libro(ISBN)
);

-- EMPRESA LIBRO -- BIEN 

CREATE TABLE EmpresaLibro (
    ISBN VARCHAR2(100),
    CIF INT,
    CONSTRAINT FK_EMPRESALIBRO_ISBN FOREIGN KEY (ISBN) REFERENCES Libro(ISBN), 
    CONSTRAINT FK_EMPRESALIBRO_CIF FOREIGN KEY (CIF) REFERENCES Empresa(CIF) 
);

-- COMPRA -- BIEN

CREATE TABLE Compra (
    ISBN VARCHAR2(100),
    CIF INT,
    fecha DATE,
    cantidad VARCHAR2(100),
    CONSTRAINT COMPRA_PK PRIMARY KEY (ISBN, CIF),
    CONSTRAINT FK_COMPRA_ISBN FOREIGN KEY (ISBN) REFERENCES Libro(ISBN), -- Cambia el nombre de la restricción
    CONSTRAINT FK_COMPRA_CIF FOREIGN KEY (CIF) REFERENCES Empresa(CIF) -- Cambia el nombre de la restricción
);




