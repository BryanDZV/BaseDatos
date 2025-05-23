drop table DatosDeCoches cascade constraints;
drop table DatosDeConcesionarios cascade constraints;
drop table DatosDeTiene cascade constraints;
drop table DatosDeVenta cascade constraints;
drop table DatosDeVendedor cascade constraints;

-- DatosDeCoches --
CREATE TABLE DatosDeCoches (
    ma VARCHAR2(10) PRIMARY KEY,
    mo VARCHAR2(10),
    precio NUMBER(5)    
);

-- DatosDeConcesionarios --
CREATE TABLE DatosDeConcesionarios (
    idc NUMBER(10) PRIMARY KEY,
    ciu VARCHAR2(10),
    total_ganado NUMBER(10)
);

-- DatosDeTiene --
CREATE TABLE DatosDeTiene (
    ID_TIENE VARCHAR2(10) PRIMARY KEY,
    ma VARCHAR2(10), 
    mo VARCHAR2(10),
    idc NUMBER(10),
    num_coches_vendidos NUMBER(10)
);

-- DatosDeVenta --
CREATE TABLE DatosDeVenta (
    ma VARCHAR2(10),
    mo VARCHAR2(10),
    idc NUMBER(10),
    num_coches_vendidos NUMBER(10),
    fecha_venta DATE,
    cod_vendedor VARCHAR2(10) PRIMARY KEY
);

-- DatosDeVendedores --
CREATE TABLE DatosDeVendedores (
    cod_vendedor VARCHAR2(10),
    dni VARCHAR2(9) PRIMARY KEY,
    nombre VARCHAR2(10),
    telefono NUMBER(9),
    salario NUMBER(10),
    CONSTRAINT FK_CDV_DV FOREIGN KEY (cod_vendedor) REFERENCES DatosDeVenta(cod_vendedor)
);
    
    