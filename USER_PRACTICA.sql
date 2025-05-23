--------------------------------------------------------
-- Archivo creado  - miércoles-noviembre-27-2024   
--------------------------------------------------------
DROP TABLE "USER_PRACTICA"."ALUMNO" cascade constraints;
DROP TABLE "USER_PRACTICA"."ASIGNATURA" cascade constraints;
DROP TABLE "USER_PRACTICA"."AULA" cascade constraints;
DROP TABLE "USER_PRACTICA"."CURSO" cascade constraints;
DROP TABLE "USER_PRACTICA"."HORARIOAULAASIGNATURA" cascade constraints;
DROP TABLE "USER_PRACTICA"."MATRICULA" cascade constraints;
DROP TABLE "USER_PRACTICA"."PROFESOR" cascade constraints;
DROP TABLE "USER_PRACTICA"."TUTOR" cascade constraints;
DROP TABLE "USER_PRACTICA"."CURSO" cascade constraints;
DROP TABLE "USER_PRACTICA"."PROFESOR" cascade constraints;
DROP TABLE "USER_PRACTICA"."ASIGNATURA" cascade constraints;
DROP TABLE "USER_PRACTICA"."AULA" cascade constraints;
DROP TABLE "USER_PRACTICA"."ALUMNO" cascade constraints;
DROP TABLE "USER_PRACTICA"."HORARIOAULAASIGNATURA" cascade constraints;
DROP TABLE "USER_PRACTICA"."MATRICULA" cascade constraints;
DROP TABLE "USER_PRACTICA"."TUTOR" cascade constraints;
--------------------------------------------------------
--  DDL for Table ALUMNO
--------------------------------------------------------

  CREATE TABLE "USER_PRACTICA"."ALUMNO" 
   (	"ALUMNO_ID" NUMBER(*,0), 
	"NOMBRE" VARCHAR2(50 BYTE), 
	"APELLIDO" VARCHAR2(50 BYTE), 
	"DIRECCION" VARCHAR2(100 BYTE), 
	"POBLACION" VARCHAR2(100 BYTE), 
	"DNI" VARCHAR2(10 BYTE)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table ASIGNATURA
--------------------------------------------------------

  CREATE TABLE "USER_PRACTICA"."ASIGNATURA" 
   (	"ASIGNATURA_ID" NUMBER(*,0), 
	"CODIGO" VARCHAR2(10 BYTE), 
	"NOMBRE" VARCHAR2(50 BYTE), 
	"HORAS_SEMANALES" NUMBER(*,0), 
	"CURSO_ID" NUMBER(*,0), 
	"PROFESOR_ID" NUMBER(*,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table AULA
--------------------------------------------------------

  CREATE TABLE "USER_PRACTICA"."AULA" 
   (	"AULA_ID" NUMBER(*,0), 
	"CODIGO" VARCHAR2(10 BYTE), 
	"PISO" NUMBER(*,0), 
	"NUMERO_PUPITRES" NUMBER(*,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table CURSO
--------------------------------------------------------

  CREATE TABLE "USER_PRACTICA"."CURSO" 
   (	"CURSO_ID" NUMBER(*,0), 
	"NOMBRE" VARCHAR2(50 BYTE)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table HORARIOAULAASIGNATURA
--------------------------------------------------------

  CREATE TABLE "USER_PRACTICA"."HORARIOAULAASIGNATURA" 
   (	"HORARIO_ID" NUMBER(*,0), 
	"ASIGNATURA_ID" NUMBER(*,0), 
	"AULA_ID" NUMBER(*,0), 
	"MES" NUMBER(*,0), 
	"DIA" NUMBER(*,0), 
	"HORA" DATE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table MATRICULA
--------------------------------------------------------

  CREATE TABLE "USER_PRACTICA"."MATRICULA" 
   (	"MATRICULA_ID" NUMBER(*,0), 
	"ALUMNO_ID" NUMBER(*,0), 
	"ASIGNATURA_ID" NUMBER(*,0), 
	"NOTA" NUMBER(4,2), 
	"INCIDENCIAS" VARCHAR2(255 BYTE)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table PROFESOR
--------------------------------------------------------

  CREATE TABLE "USER_PRACTICA"."PROFESOR" 
   (	"PROFESOR_ID" NUMBER(*,0), 
	"NOMBRE" VARCHAR2(50 BYTE), 
	"APELLIDOS" VARCHAR2(50 BYTE), 
	"DIRECCION" VARCHAR2(50 BYTE), 
	"POBLACION" VARCHAR2(50 BYTE), 
	"DNI" VARCHAR2(10 BYTE), 
	"FECHA_NACIMIENTO" DATE, 
	"CODIGO_POSAL" VARCHAR2(10 BYTE), 
	"TELEFONO" VARCHAR2(15 BYTE)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table TUTOR
--------------------------------------------------------

  CREATE TABLE "USER_PRACTICA"."TUTOR" 
   (	"TUTOR_ID" NUMBER(*,0), 
	"CURSO_ID" NUMBER(*,0), 
	"PROFESOR_ID" NUMBER(*,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table CURSO
--------------------------------------------------------

  CREATE TABLE "USER_PRACTICA"."CURSO" 
   (	"CURSO_ID" NUMBER(*,0), 
	"NOMBRE" VARCHAR2(50 BYTE)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table PROFESOR
--------------------------------------------------------

  CREATE TABLE "USER_PRACTICA"."PROFESOR" 
   (	"PROFESOR_ID" NUMBER(*,0), 
	"NOMBRE" VARCHAR2(50 BYTE), 
	"APELLIDOS" VARCHAR2(50 BYTE), 
	"DIRECCION" VARCHAR2(50 BYTE), 
	"POBLACION" VARCHAR2(50 BYTE), 
	"DNI" VARCHAR2(10 BYTE), 
	"FECHA_NACIMIENTO" DATE, 
	"CODIGO_POSAL" VARCHAR2(10 BYTE), 
	"TELEFONO" VARCHAR2(15 BYTE)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table ASIGNATURA
--------------------------------------------------------

  CREATE TABLE "USER_PRACTICA"."ASIGNATURA" 
   (	"ASIGNATURA_ID" NUMBER(*,0), 
	"CODIGO" VARCHAR2(10 BYTE), 
	"NOMBRE" VARCHAR2(50 BYTE), 
	"HORAS_SEMANALES" NUMBER(*,0), 
	"CURSO_ID" NUMBER(*,0), 
	"PROFESOR_ID" NUMBER(*,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table AULA
--------------------------------------------------------

  CREATE TABLE "USER_PRACTICA"."AULA" 
   (	"AULA_ID" NUMBER(*,0), 
	"CODIGO" VARCHAR2(10 BYTE), 
	"PISO" NUMBER(*,0), 
	"NUMERO_PUPITRES" NUMBER(*,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table ALUMNO
--------------------------------------------------------

  CREATE TABLE "USER_PRACTICA"."ALUMNO" 
   (	"ALUMNO_ID" NUMBER(*,0), 
	"NOMBRE" VARCHAR2(50 BYTE), 
	"APELLIDO" VARCHAR2(50 BYTE), 
	"DIRECCION" VARCHAR2(100 BYTE), 
	"POBLACION" VARCHAR2(100 BYTE), 
	"DNI" VARCHAR2(10 BYTE)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table HORARIOAULAASIGNATURA
--------------------------------------------------------

  CREATE TABLE "USER_PRACTICA"."HORARIOAULAASIGNATURA" 
   (	"HORARIO_ID" NUMBER(*,0), 
	"ASIGNATURA_ID" NUMBER(*,0), 
	"AULA_ID" NUMBER(*,0), 
	"MES" NUMBER(*,0), 
	"DIA" NUMBER(*,0), 
	"HORA" DATE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table MATRICULA
--------------------------------------------------------

  CREATE TABLE "USER_PRACTICA"."MATRICULA" 
   (	"MATRICULA_ID" NUMBER(*,0), 
	"ALUMNO_ID" NUMBER(*,0), 
	"ASIGNATURA_ID" NUMBER(*,0), 
	"NOTA" NUMBER(4,2), 
	"INCIDENCIAS" VARCHAR2(255 BYTE)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table TUTOR
--------------------------------------------------------

  CREATE TABLE "USER_PRACTICA"."TUTOR" 
   (	"TUTOR_ID" NUMBER(*,0), 
	"CURSO_ID" NUMBER(*,0), 
	"PROFESOR_ID" NUMBER(*,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
REM INSERTING into USER_PRACTICA.ALUMNO
SET DEFINE OFF;
REM INSERTING into USER_PRACTICA.ASIGNATURA
SET DEFINE OFF;
REM INSERTING into USER_PRACTICA.AULA
SET DEFINE OFF;
REM INSERTING into USER_PRACTICA.CURSO
SET DEFINE OFF;
REM INSERTING into USER_PRACTICA.HORARIOAULAASIGNATURA
SET DEFINE OFF;
REM INSERTING into USER_PRACTICA.MATRICULA
SET DEFINE OFF;
REM INSERTING into USER_PRACTICA.PROFESOR
SET DEFINE OFF;
REM INSERTING into USER_PRACTICA.TUTOR
SET DEFINE OFF;
--------------------------------------------------------
--  DDL for Index OK_CURO
--------------------------------------------------------

  CREATE UNIQUE INDEX "USER_PRACTICA"."OK_CURO" ON "USER_PRACTICA"."CURSO" ("CURSO_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index PK_ALUMNO
--------------------------------------------------------

  CREATE UNIQUE INDEX "USER_PRACTICA"."PK_ALUMNO" ON "USER_PRACTICA"."ALUMNO" ("ALUMNO_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index PK_ASIGNATURA
--------------------------------------------------------

  CREATE UNIQUE INDEX "USER_PRACTICA"."PK_ASIGNATURA" ON "USER_PRACTICA"."ASIGNATURA" ("ASIGNATURA_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index PK_AULA
--------------------------------------------------------

  CREATE UNIQUE INDEX "USER_PRACTICA"."PK_AULA" ON "USER_PRACTICA"."AULA" ("AULA_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index PK_HORARIO
--------------------------------------------------------

  CREATE UNIQUE INDEX "USER_PRACTICA"."PK_HORARIO" ON "USER_PRACTICA"."HORARIOAULAASIGNATURA" ("HORARIO_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index PK_MATRICULA
--------------------------------------------------------

  CREATE UNIQUE INDEX "USER_PRACTICA"."PK_MATRICULA" ON "USER_PRACTICA"."MATRICULA" ("MATRICULA_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index PK_PROFESOR
--------------------------------------------------------

  CREATE UNIQUE INDEX "USER_PRACTICA"."PK_PROFESOR" ON "USER_PRACTICA"."PROFESOR" ("PROFESOR_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index PK_TUTOR
--------------------------------------------------------

  CREATE UNIQUE INDEX "USER_PRACTICA"."PK_TUTOR" ON "USER_PRACTICA"."TUTOR" ("TUTOR_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index UNIQUE_CODIGO_ASIGNATURA
--------------------------------------------------------

  CREATE UNIQUE INDEX "USER_PRACTICA"."UNIQUE_CODIGO_ASIGNATURA" ON "USER_PRACTICA"."ASIGNATURA" ("CODIGO") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index UNIQUE_CODIGO_AULA
--------------------------------------------------------

  CREATE UNIQUE INDEX "USER_PRACTICA"."UNIQUE_CODIGO_AULA" ON "USER_PRACTICA"."AULA" ("CODIGO") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index UNIQUE_DNI
--------------------------------------------------------

  CREATE UNIQUE INDEX "USER_PRACTICA"."UNIQUE_DNI" ON "USER_PRACTICA"."PROFESOR" ("DNI") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index UNIQUE_DNI_ALUMNO
--------------------------------------------------------

  CREATE UNIQUE INDEX "USER_PRACTICA"."UNIQUE_DNI_ALUMNO" ON "USER_PRACTICA"."ALUMNO" ("DNI") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index UNIQUE_MATRICULA
--------------------------------------------------------

  CREATE UNIQUE INDEX "USER_PRACTICA"."UNIQUE_MATRICULA" ON "USER_PRACTICA"."MATRICULA" ("ALUMNO_ID", "ASIGNATURA_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index PK_ALUMNO
--------------------------------------------------------

  CREATE UNIQUE INDEX "USER_PRACTICA"."PK_ALUMNO" ON "USER_PRACTICA"."ALUMNO" ("ALUMNO_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index UNIQUE_DNI_ALUMNO
--------------------------------------------------------

  CREATE UNIQUE INDEX "USER_PRACTICA"."UNIQUE_DNI_ALUMNO" ON "USER_PRACTICA"."ALUMNO" ("DNI") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index PK_ASIGNATURA
--------------------------------------------------------

  CREATE UNIQUE INDEX "USER_PRACTICA"."PK_ASIGNATURA" ON "USER_PRACTICA"."ASIGNATURA" ("ASIGNATURA_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index UNIQUE_CODIGO_ASIGNATURA
--------------------------------------------------------

  CREATE UNIQUE INDEX "USER_PRACTICA"."UNIQUE_CODIGO_ASIGNATURA" ON "USER_PRACTICA"."ASIGNATURA" ("CODIGO") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index PK_AULA
--------------------------------------------------------

  CREATE UNIQUE INDEX "USER_PRACTICA"."PK_AULA" ON "USER_PRACTICA"."AULA" ("AULA_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index UNIQUE_CODIGO_AULA
--------------------------------------------------------

  CREATE UNIQUE INDEX "USER_PRACTICA"."UNIQUE_CODIGO_AULA" ON "USER_PRACTICA"."AULA" ("CODIGO") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index OK_CURO
--------------------------------------------------------

  CREATE UNIQUE INDEX "USER_PRACTICA"."OK_CURO" ON "USER_PRACTICA"."CURSO" ("CURSO_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index PK_HORARIO
--------------------------------------------------------

  CREATE UNIQUE INDEX "USER_PRACTICA"."PK_HORARIO" ON "USER_PRACTICA"."HORARIOAULAASIGNATURA" ("HORARIO_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index PK_MATRICULA
--------------------------------------------------------

  CREATE UNIQUE INDEX "USER_PRACTICA"."PK_MATRICULA" ON "USER_PRACTICA"."MATRICULA" ("MATRICULA_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index UNIQUE_MATRICULA
--------------------------------------------------------

  CREATE UNIQUE INDEX "USER_PRACTICA"."UNIQUE_MATRICULA" ON "USER_PRACTICA"."MATRICULA" ("ALUMNO_ID", "ASIGNATURA_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index PK_PROFESOR
--------------------------------------------------------

  CREATE UNIQUE INDEX "USER_PRACTICA"."PK_PROFESOR" ON "USER_PRACTICA"."PROFESOR" ("PROFESOR_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index UNIQUE_DNI
--------------------------------------------------------

  CREATE UNIQUE INDEX "USER_PRACTICA"."UNIQUE_DNI" ON "USER_PRACTICA"."PROFESOR" ("DNI") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index PK_TUTOR
--------------------------------------------------------

  CREATE UNIQUE INDEX "USER_PRACTICA"."PK_TUTOR" ON "USER_PRACTICA"."TUTOR" ("TUTOR_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  Constraints for Table ALUMNO
--------------------------------------------------------

  ALTER TABLE "USER_PRACTICA"."ALUMNO" MODIFY ("ALUMNO_ID" NOT NULL ENABLE);
  ALTER TABLE "USER_PRACTICA"."ALUMNO" MODIFY ("NOMBRE" NOT NULL ENABLE);
  ALTER TABLE "USER_PRACTICA"."ALUMNO" MODIFY ("APELLIDO" NOT NULL ENABLE);
  ALTER TABLE "USER_PRACTICA"."ALUMNO" MODIFY ("DNI" NOT NULL ENABLE);
  ALTER TABLE "USER_PRACTICA"."ALUMNO" ADD CONSTRAINT "PK_ALUMNO" PRIMARY KEY ("ALUMNO_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "USERS"  ENABLE;
  ALTER TABLE "USER_PRACTICA"."ALUMNO" ADD CONSTRAINT "UNIQUE_DNI_ALUMNO" UNIQUE ("DNI")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "USERS"  ENABLE;
--------------------------------------------------------
--  Constraints for Table ASIGNATURA
--------------------------------------------------------

  ALTER TABLE "USER_PRACTICA"."ASIGNATURA" MODIFY ("ASIGNATURA_ID" NOT NULL ENABLE);
  ALTER TABLE "USER_PRACTICA"."ASIGNATURA" MODIFY ("CODIGO" NOT NULL ENABLE);
  ALTER TABLE "USER_PRACTICA"."ASIGNATURA" MODIFY ("NOMBRE" NOT NULL ENABLE);
  ALTER TABLE "USER_PRACTICA"."ASIGNATURA" MODIFY ("HORAS_SEMANALES" NOT NULL ENABLE);
  ALTER TABLE "USER_PRACTICA"."ASIGNATURA" MODIFY ("CURSO_ID" NOT NULL ENABLE);
  ALTER TABLE "USER_PRACTICA"."ASIGNATURA" MODIFY ("PROFESOR_ID" NOT NULL ENABLE);
  ALTER TABLE "USER_PRACTICA"."ASIGNATURA" ADD CONSTRAINT "PK_ASIGNATURA" PRIMARY KEY ("ASIGNATURA_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "USERS"  ENABLE;
  ALTER TABLE "USER_PRACTICA"."ASIGNATURA" ADD CONSTRAINT "UNIQUE_CODIGO_ASIGNATURA" UNIQUE ("CODIGO")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "USERS"  ENABLE;
--------------------------------------------------------
--  Constraints for Table AULA
--------------------------------------------------------

  ALTER TABLE "USER_PRACTICA"."AULA" MODIFY ("AULA_ID" NOT NULL ENABLE);
  ALTER TABLE "USER_PRACTICA"."AULA" MODIFY ("CODIGO" NOT NULL ENABLE);
  ALTER TABLE "USER_PRACTICA"."AULA" ADD CONSTRAINT "PK_AULA" PRIMARY KEY ("AULA_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "USERS"  ENABLE;
  ALTER TABLE "USER_PRACTICA"."AULA" ADD CONSTRAINT "UNIQUE_CODIGO_AULA" UNIQUE ("CODIGO")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "USERS"  ENABLE;
--------------------------------------------------------
--  Constraints for Table CURSO
--------------------------------------------------------

  ALTER TABLE "USER_PRACTICA"."CURSO" MODIFY ("CURSO_ID" NOT NULL ENABLE);
  ALTER TABLE "USER_PRACTICA"."CURSO" ADD CONSTRAINT "OK_CURO" PRIMARY KEY ("CURSO_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "USERS"  ENABLE;
--------------------------------------------------------
--  Constraints for Table HORARIOAULAASIGNATURA
--------------------------------------------------------

  ALTER TABLE "USER_PRACTICA"."HORARIOAULAASIGNATURA" MODIFY ("HORARIO_ID" NOT NULL ENABLE);
  ALTER TABLE "USER_PRACTICA"."HORARIOAULAASIGNATURA" MODIFY ("ASIGNATURA_ID" NOT NULL ENABLE);
  ALTER TABLE "USER_PRACTICA"."HORARIOAULAASIGNATURA" MODIFY ("AULA_ID" NOT NULL ENABLE);
  ALTER TABLE "USER_PRACTICA"."HORARIOAULAASIGNATURA" ADD CONSTRAINT "PK_HORARIO" PRIMARY KEY ("HORARIO_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "USERS"  ENABLE;
--------------------------------------------------------
--  Constraints for Table MATRICULA
--------------------------------------------------------

  ALTER TABLE "USER_PRACTICA"."MATRICULA" MODIFY ("MATRICULA_ID" NOT NULL ENABLE);
  ALTER TABLE "USER_PRACTICA"."MATRICULA" MODIFY ("ALUMNO_ID" NOT NULL ENABLE);
  ALTER TABLE "USER_PRACTICA"."MATRICULA" MODIFY ("ASIGNATURA_ID" NOT NULL ENABLE);
  ALTER TABLE "USER_PRACTICA"."MATRICULA" ADD CONSTRAINT "CHECK_NOTA" CHECK (nota >= 0 AND nota <= 10) ENABLE;
  ALTER TABLE "USER_PRACTICA"."MATRICULA" ADD CONSTRAINT "PK_MATRICULA" PRIMARY KEY ("MATRICULA_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "USERS"  ENABLE;
  ALTER TABLE "USER_PRACTICA"."MATRICULA" ADD CONSTRAINT "UNIQUE_MATRICULA" UNIQUE ("ALUMNO_ID", "ASIGNATURA_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "USERS"  ENABLE;
--------------------------------------------------------
--  Constraints for Table PROFESOR
--------------------------------------------------------

  ALTER TABLE "USER_PRACTICA"."PROFESOR" MODIFY ("PROFESOR_ID" NOT NULL ENABLE);
  ALTER TABLE "USER_PRACTICA"."PROFESOR" MODIFY ("NOMBRE" NOT NULL ENABLE);
  ALTER TABLE "USER_PRACTICA"."PROFESOR" MODIFY ("APELLIDOS" NOT NULL ENABLE);
  ALTER TABLE "USER_PRACTICA"."PROFESOR" MODIFY ("DIRECCION" NOT NULL ENABLE);
  ALTER TABLE "USER_PRACTICA"."PROFESOR" MODIFY ("DNI" NOT NULL ENABLE);
  ALTER TABLE "USER_PRACTICA"."PROFESOR" ADD CONSTRAINT "PK_PROFESOR" PRIMARY KEY ("PROFESOR_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "USERS"  ENABLE;
  ALTER TABLE "USER_PRACTICA"."PROFESOR" ADD CONSTRAINT "UNIQUE_DNI" UNIQUE ("DNI")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "USERS"  ENABLE;
--------------------------------------------------------
--  Constraints for Table TUTOR
--------------------------------------------------------

  ALTER TABLE "USER_PRACTICA"."TUTOR" MODIFY ("TUTOR_ID" NOT NULL ENABLE);
  ALTER TABLE "USER_PRACTICA"."TUTOR" MODIFY ("CURSO_ID" NOT NULL ENABLE);
  ALTER TABLE "USER_PRACTICA"."TUTOR" MODIFY ("PROFESOR_ID" NOT NULL ENABLE);
  ALTER TABLE "USER_PRACTICA"."TUTOR" ADD CONSTRAINT "PK_TUTOR" PRIMARY KEY ("TUTOR_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "USERS"  ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table ASIGNATURA
--------------------------------------------------------

  ALTER TABLE "USER_PRACTICA"."ASIGNATURA" ADD CONSTRAINT "FK_ASIGNATURA_CURSO" FOREIGN KEY ("CURSO_ID")
	  REFERENCES "USER_PRACTICA"."CURSO" ("CURSO_ID") ENABLE;
  ALTER TABLE "USER_PRACTICA"."ASIGNATURA" ADD CONSTRAINT "FK_ASIGNATURA_PROFESOR" FOREIGN KEY ("PROFESOR_ID")
	  REFERENCES "USER_PRACTICA"."PROFESOR" ("PROFESOR_ID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table HORARIOAULAASIGNATURA
--------------------------------------------------------

  ALTER TABLE "USER_PRACTICA"."HORARIOAULAASIGNATURA" ADD CONSTRAINT "FK_HORARIO_ASIGNATURA" FOREIGN KEY ("ASIGNATURA_ID")
	  REFERENCES "USER_PRACTICA"."ASIGNATURA" ("ASIGNATURA_ID") ENABLE;
  ALTER TABLE "USER_PRACTICA"."HORARIOAULAASIGNATURA" ADD CONSTRAINT "FK_HORARIO_AULA" FOREIGN KEY ("AULA_ID")
	  REFERENCES "USER_PRACTICA"."AULA" ("AULA_ID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table MATRICULA
--------------------------------------------------------

  ALTER TABLE "USER_PRACTICA"."MATRICULA" ADD CONSTRAINT "FK_MATRICULA_ALUMNO" FOREIGN KEY ("ALUMNO_ID")
	  REFERENCES "USER_PRACTICA"."ALUMNO" ("ALUMNO_ID") ENABLE;
  ALTER TABLE "USER_PRACTICA"."MATRICULA" ADD CONSTRAINT "FK_MATRICULA_ASIGNATURA" FOREIGN KEY ("ASIGNATURA_ID")
	  REFERENCES "USER_PRACTICA"."ASIGNATURA" ("ASIGNATURA_ID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table TUTOR
--------------------------------------------------------

  ALTER TABLE "USER_PRACTICA"."TUTOR" ADD CONSTRAINT "FK_TUTOR_CURSO" FOREIGN KEY ("CURSO_ID")
	  REFERENCES "USER_PRACTICA"."CURSO" ("CURSO_ID") ENABLE;
  ALTER TABLE "USER_PRACTICA"."TUTOR" ADD CONSTRAINT "FK_TUTOR_PROFESOR" FOREIGN KEY ("PROFESOR_ID")
	  REFERENCES "USER_PRACTICA"."PROFESOR" ("PROFESOR_ID") ENABLE;
