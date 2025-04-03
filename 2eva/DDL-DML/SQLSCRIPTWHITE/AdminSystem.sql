alter session set "_ORACLE_SCRIPT"= true;
create user FuncionesFila  identified by "123456";
grant "CONNECT" To FuncionesFila;

alter session set "_ORACLE_SCRIPT"= true;
create user TiposConversiones  identified by "123456";
grant "CONNECT" To TiposConversiones;

alter session set "_ORACLE_SCRIPT"= true;
create user UnionTablas  identified by "123456";
grant "CONNECT" To UnionTablas;

alter session set "_ORACLE_SCRIPT"= true;
create user FuncionesGrupo  identified by "123456";
grant "CONNECT" To FuncionesGrupo;

alter session set "_ORACLE_SCRIPT"= true;
create user Subconsultas  identified by "123456";
grant "CONNECT" To Subconsultas;

alter session set "_ORACLE_SCRIPT"= true;
create user OperadoresConjunto  identified by "123456";
grant "CONNECT" To OperadoresConjunto;

alter session set "_ORACLE_SCRIPT"= true;
create user Transacciones  identified by "123456";
grant "CONNECT" To Transacciones;