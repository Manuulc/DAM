CREATE DATABASE Laboratorio Quimico
GO
USE [Laboratorio Quimico]
GO

CREATE TABLE LQ_Elementos (

Simbolo char(2) Constraint PK_LQ_Elementos Primary Key Not NULL
,Nombre varChar(15)  Not NULL

)

CREATE TABLE LQ_Tipos_Compuesto (

Tipo SmallInt Constraint PK_LQ_Tipos_Compuesto Primary Key Not Null Identity
,Denominacion varChar(30) Not NULL UNIQUE

)

CREATE TABLE LQ_Moleculas (

nombreClasico varChar(30) Not NULL
,nombreIUPAC varChar(30) Not NULL
,Color varChar(20) NULL
,Densidad decimal (5,3) NULL
,puntoFusion float Constraint LQ_Moleculas CHECK (puntoFusion>0.0) Not NULL
,puntoEbullicion float Constraint LQ_Moleculas CHECK (puntoEbullicion>0.0 AND puntoEbullicion>puntoFusion) Not NULL

)

ALTER TABLE LQ_Elementos 

ADD numeroAtomico SmallInt Constraint LQ_Elementos CHECK (numeroAtomico BETWEEN 1 AND 300) Not NULL UNIQUE
,masaAtomica decimal (8,5) NULL

ALTER TABLE LQ_Moleculas 

ADD codigo int Constraint PK_LQ_Moleculas Primary Key NULL

CREATE TABLE LQ_MoleculasElementos (

Numero TinyInt Constraint LQ_MoleculasElementos CHECK (Numero>=1) Not NULL
,codigo int Constraint FK_LQ_Moleculas Foreign Key REFERENCES LQ_Moleculas(Simbolo) NULL Identity
,Simbolo char(2) Constraint FK_LQ_Elementos Foreign Key REFERENCES LQ_Elementos(Codigo) Not NULL
,Constraint PK_LQ_MoleculasElementos Primary Key (Simbolo,Codigo)
)

ALTER TABLE LQ_Moleculas

ADD Tipo SmallInt Constraint FK_LQ_Moleculas Foreign Key REFERENCES LQ_Tipos_Compuesto (Tipo) Not Null

ALTER TABLE LQ_Elementos 

ADD Tipo varChar(11) Constraint LQ_Elementos CHECK (Tipo IN ('Metal','No Metal','Gas Noble','Tierra Rara'))