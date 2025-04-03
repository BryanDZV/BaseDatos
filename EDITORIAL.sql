--------------------------------------------------------
-- Archivo creado  - miércoles-noviembre-27-2024   
--------------------------------------------------------
DROP TABLE "EDITORIAL"."AUTOR" cascade constraints;
DROP TABLE "EDITORIAL"."COMERCIAL" cascade constraints;
DROP TABLE "EDITORIAL"."DATOS_PERSONALES" cascade constraints;
DROP TABLE "EDITORIAL"."DIRECTOR" cascade constraints;
DROP TABLE "EDITORIAL"."OFICINA" cascade constraints;
DROP TABLE "EDITORIAL"."RESTO_EMPLEADOS" cascade constraints;
DROP TABLE "EDITORIAL"."DATOS_PERSONALES" cascade constraints;
DROP TABLE "EDITORIAL"."DIRECTOR" cascade constraints;
DROP TABLE "EDITORIAL"."AUTOR" cascade constraints;
DROP TABLE "EDITORIAL"."COMERCIAL" cascade constraints;
DROP TABLE "EDITORIAL"."OFICINA" cascade constraints;
DROP TABLE "EDITORIAL"."RESTO_EMPLEADOS" cascade constraints;
--------------------------------------------------------
--  DDL for Table AUTOR
--------------------------------------------------------

  CREATE TABLE "EDITORIAL"."AUTOR" 
   (	"DNI" VARCHAR2(9 BYTE), 
	"CUENTA" NUMBER(*,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table COMERCIAL
--------------------------------------------------------

  CREATE TABLE "EDITORIAL"."COMERCIAL" 
   (	"DNI" VARCHAR2(9 BYTE), 
	"COMISION" NUMBER(8,2)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table DATOS_PERSONALES
--------------------------------------------------------

  CREATE TABLE "EDITORIAL"."DATOS_PERSONALES" 
   (	"DNI" VARCHAR2(10 BYTE), 
	"NOMBRE" VARCHAR2(50 BYTE), 
	"PRIMER_APELLIDO" VARCHAR2(50 BYTE), 
	"SEGUNDO_APELLIDO" VARCHAR2(50 BYTE), 
	"DOMICILIO" VARCHAR2(50 BYTE), 
	"TELEFONO" NUMBER(*,0), 
	"CORREO" VARCHAR2(50 BYTE)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table DIRECTOR
--------------------------------------------------------

  CREATE TABLE "EDITORIAL"."DIRECTOR" 
   (	"DNI" VARCHAR2(50 BYTE)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table OFICINA
--------------------------------------------------------

  CREATE TABLE "EDITORIAL"."OFICINA" 
   (	"CODOFICINA" NUMBER(*,0), 
	"DIRECTOR" VARCHAR2(20 BYTE), 
	"TELEFONO" NUMBER(*,0), 
	"DNIDIRECTOR" VARCHAR2(9 BYTE), 
	"DNICOMERCIAL" VARCHAR2(9 BYTE)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table RESTO_EMPLEADOS
--------------------------------------------------------

  CREATE TABLE "EDITORIAL"."RESTO_EMPLEADOS" 
   (	"DNI" VARCHAR2(9 BYTE), 
	"CARGO" VARCHAR2(20 BYTE)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table DATOS_PERSONALES
--------------------------------------------------------

  CREATE TABLE "EDITORIAL"."DATOS_PERSONALES" 
   (	"DNI" VARCHAR2(10 BYTE), 
	"NOMBRE" VARCHAR2(50 BYTE), 
	"PRIMER_APELLIDO" VARCHAR2(50 BYTE), 
	"SEGUNDO_APELLIDO" VARCHAR2(50 BYTE), 
	"DOMICILIO" VARCHAR2(50 BYTE), 
	"TELEFONO" NUMBER(*,0), 
	"CORREO" VARCHAR2(50 BYTE)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table DIRECTOR
--------------------------------------------------------

  CREATE TABLE "EDITORIAL"."DIRECTOR" 
   (	"DNI" VARCHAR2(50 BYTE)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table AUTOR
--------------------------------------------------------

  CREATE TABLE "EDITORIAL"."AUTOR" 
   (	"DNI" VARCHAR2(9 BYTE), 
	"CUENTA" NUMBER(*,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table COMERCIAL
--------------------------------------------------------

  CREATE TABLE "EDITORIAL"."COMERCIAL" 
   (	"DNI" VARCHAR2(9 BYTE), 
	"COMISION" NUMBER(8,2)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table OFICINA
--------------------------------------------------------

  CREATE TABLE "EDITORIAL"."OFICINA" 
   (	"CODOFICINA" NUMBER(*,0), 
	"DIRECTOR" VARCHAR2(20 BYTE), 
	"TELEFONO" NUMBER(*,0), 
	"DNIDIRECTOR" VARCHAR2(9 BYTE), 
	"DNICOMERCIAL" VARCHAR2(9 BYTE)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table RESTO_EMPLEADOS
--------------------------------------------------------

  CREATE TABLE "EDITORIAL"."RESTO_EMPLEADOS" 
   (	"DNI" VARCHAR2(9 BYTE), 
	"CARGO" VARCHAR2(20 BYTE)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
REM INSERTING into EDITORIAL.AUTOR
SET DEFINE OFF;
REM INSERTING into EDITORIAL.COMERCIAL
SET DEFINE OFF;
REM INSERTING into EDITORIAL.DATOS_PERSONALES
SET DEFINE OFF;
REM INSERTING into EDITORIAL.DIRECTOR
SET DEFINE OFF;
REM INSERTING into EDITORIAL.OFICINA
SET DEFINE OFF;
REM INSERTING into EDITORIAL.RESTO_EMPLEADOS
SET DEFINE OFF;
--------------------------------------------------------
--  DDL for Index PK_AUTOR_DNI
--------------------------------------------------------

  CREATE UNIQUE INDEX "EDITORIAL"."PK_AUTOR_DNI" ON "EDITORIAL"."AUTOR" ("DNI") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index PK_CODOFICINA
--------------------------------------------------------

  CREATE UNIQUE INDEX "EDITORIAL"."PK_CODOFICINA" ON "EDITORIAL"."OFICINA" ("CODOFICINA") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index PK_COMERCIAL_DNI
--------------------------------------------------------

  CREATE UNIQUE INDEX "EDITORIAL"."PK_COMERCIAL_DNI" ON "EDITORIAL"."COMERCIAL" ("DNI") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index PK_DIRECTOR_DNI
--------------------------------------------------------

  CREATE UNIQUE INDEX "EDITORIAL"."PK_DIRECTOR_DNI" ON "EDITORIAL"."DIRECTOR" ("DNI") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index PK_DNI
--------------------------------------------------------

  CREATE UNIQUE INDEX "EDITORIAL"."PK_DNI" ON "EDITORIAL"."DATOS_PERSONALES" ("DNI") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index PK_RESTO_EMPLEADOS_DNI
--------------------------------------------------------

  CREATE UNIQUE INDEX "EDITORIAL"."PK_RESTO_EMPLEADOS_DNI" ON "EDITORIAL"."RESTO_EMPLEADOS" ("DNI") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index PK_AUTOR_DNI
--------------------------------------------------------

  CREATE UNIQUE INDEX "EDITORIAL"."PK_AUTOR_DNI" ON "EDITORIAL"."AUTOR" ("DNI") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index PK_COMERCIAL_DNI
--------------------------------------------------------

  CREATE UNIQUE INDEX "EDITORIAL"."PK_COMERCIAL_DNI" ON "EDITORIAL"."COMERCIAL" ("DNI") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index PK_DNI
--------------------------------------------------------

  CREATE UNIQUE INDEX "EDITORIAL"."PK_DNI" ON "EDITORIAL"."DATOS_PERSONALES" ("DNI") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index PK_DIRECTOR_DNI
--------------------------------------------------------

  CREATE UNIQUE INDEX "EDITORIAL"."PK_DIRECTOR_DNI" ON "EDITORIAL"."DIRECTOR" ("DNI") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index PK_CODOFICINA
--------------------------------------------------------

  CREATE UNIQUE INDEX "EDITORIAL"."PK_CODOFICINA" ON "EDITORIAL"."OFICINA" ("CODOFICINA") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index PK_RESTO_EMPLEADOS_DNI
--------------------------------------------------------

  CREATE UNIQUE INDEX "EDITORIAL"."PK_RESTO_EMPLEADOS_DNI" ON "EDITORIAL"."RESTO_EMPLEADOS" ("DNI") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  Constraints for Table AUTOR
--------------------------------------------------------

  ALTER TABLE "EDITORIAL"."AUTOR" ADD CONSTRAINT "PK_AUTOR_DNI" PRIMARY KEY ("DNI")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "USERS"  ENABLE;
--------------------------------------------------------
--  Constraints for Table COMERCIAL
--------------------------------------------------------

  ALTER TABLE "EDITORIAL"."COMERCIAL" ADD CONSTRAINT "PK_COMERCIAL_DNI" PRIMARY KEY ("DNI")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "USERS"  ENABLE;
--------------------------------------------------------
--  Constraints for Table DATOS_PERSONALES
--------------------------------------------------------

  ALTER TABLE "EDITORIAL"."DATOS_PERSONALES" MODIFY ("NOMBRE" NOT NULL ENABLE);
  ALTER TABLE "EDITORIAL"."DATOS_PERSONALES" ADD CONSTRAINT "PK_DNI" PRIMARY KEY ("DNI")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "USERS"  ENABLE;
--------------------------------------------------------
--  Constraints for Table DIRECTOR
--------------------------------------------------------

  ALTER TABLE "EDITORIAL"."DIRECTOR" ADD CONSTRAINT "PK_DIRECTOR_DNI" PRIMARY KEY ("DNI")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "USERS"  ENABLE;
--------------------------------------------------------
--  Constraints for Table OFICINA
--------------------------------------------------------

  ALTER TABLE "EDITORIAL"."OFICINA" ADD CONSTRAINT "PK_CODOFICINA" PRIMARY KEY ("CODOFICINA")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "USERS"  ENABLE;
--------------------------------------------------------
--  Constraints for Table RESTO_EMPLEADOS
--------------------------------------------------------

  ALTER TABLE "EDITORIAL"."RESTO_EMPLEADOS" ADD CONSTRAINT "PK_RESTO_EMPLEADOS_DNI" PRIMARY KEY ("DNI")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "USERS"  ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table AUTOR
--------------------------------------------------------

  ALTER TABLE "EDITORIAL"."AUTOR" ADD CONSTRAINT "FK_AUTOR_DNI" FOREIGN KEY ("DNI")
	  REFERENCES "EDITORIAL"."DATOS_PERSONALES" ("DNI") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table COMERCIAL
--------------------------------------------------------

  ALTER TABLE "EDITORIAL"."COMERCIAL" ADD CONSTRAINT "FK_COMERCIAL_DNI" FOREIGN KEY ("DNI")
	  REFERENCES "EDITORIAL"."DATOS_PERSONALES" ("DNI") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table DIRECTOR
--------------------------------------------------------

  ALTER TABLE "EDITORIAL"."DIRECTOR" ADD CONSTRAINT "FK_PERSONAL_DNI" FOREIGN KEY ("DNI")
	  REFERENCES "EDITORIAL"."DATOS_PERSONALES" ("DNI") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table OFICINA
--------------------------------------------------------

  ALTER TABLE "EDITORIAL"."OFICINA" ADD CONSTRAINT "FK_OFICINA_DIRECTOR" FOREIGN KEY ("DNIDIRECTOR")
	  REFERENCES "EDITORIAL"."DIRECTOR" ("DNI") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table RESTO_EMPLEADOS
--------------------------------------------------------

  ALTER TABLE "EDITORIAL"."RESTO_EMPLEADOS" ADD CONSTRAINT "FK_RESTO_EMPLEADOS_DNI" FOREIGN KEY ("DNI")
	  REFERENCES "EDITORIAL"."DATOS_PERSONALES" ("DNI") ENABLE;
