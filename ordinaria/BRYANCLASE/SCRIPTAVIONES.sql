drop table Aviones cascade constraints; 
drop table Vuelos cascade constraints;
drop table Partes cascade constraints;
drop table Reservas cascade constraints;

-- TABLA AVIONES --
CREATE TABLE Aviones (
    ID_Avion INT,
    Combustible VARCHAR2(50),
    Tipo VARCHAR2(50),
    Capacidad INT,
    Longitud INT,
    Energetico VARCHAR2(50),
    Velocidad_Crucero INT,
    CONSTRAINT PK_AVIONES PRIMARY KEY (ID_Avion)
);

-- TABLA VUELOS --
CREATE TABLE Vuelos (
    Num_Vuelo INT,
    ID_Avion INT,
    Destino VARCHAR2(100),
    Hora_Salida INT,
    Hora_Llegada INT,
    Distancia INT,
    CONSTRAINT PK_NUM_VUELO PRIMARY KEY (Num_Vuelo),
    CONSTRAINT FK_AVVUELO FOREIGN KEY (ID_Avion) REFERENCES Aviones(ID_Avion)
);

-- TABLA PUERTOS --
CREATE TABLE Partes (
    Num_Partes INT,
    Num_Vuelo INT,
    Hora_Salida INT,
    Hora_Llegada INT,
    Combustible_Consumido INT,
    CONSTRAINT PK_PARTES PRIMARY KEY (Num_Partes),
    CONSTRAINT FK_NVVU FOREIGN KEY (Num_Vuelo) REFERENCES Vuelos(Num_Vuelo)
);

-- TABLA RESERVAS --
CREATE TABLE Reservas (
    ID_Reserva INT,
    Num_Vuelo INT,
    Fecha_Salida INT,
    Plataforma VARCHAR2(50),
    CONSTRAINT PK_RESERVAS PRIMARY KEY (ID_Reserva),
    CONSTRAINT FK_NVNV FOREIGN KEY (Num_Vuelo) REFERENCES Vuelos(Num_Vuelo)
);



