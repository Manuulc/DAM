Create Database Ejemplos
GO
USE Ejemplos
GO

CREATE TABLE DatosRestrictivos(
ID SmallInt CONSTRAINT PK_ID Primary Key CHECK (ID%2!=0) NOT NULL Identity (1,2),
Nombre varChar(15) CONSTRAINT CK_Nombre Unique CHECK (Nombre Not LIKE '[NX]%') Not NULL,
Numpelos int CONSTRAINT CK_Numpelos CHECK (Numpelos BETWEEN 0 AND 150000) Not NULL,
TipoRopa Char(1) CONSTRAINT CK_TipoRopa CHECK (TipoRopa IN ('C','F','E','P','B','N')) Not NULL,
NumSuerte TinyInt CONSTRAINT CK_NumSuerte CHECK (NumSuerte BETWEEN 10 AND 40 AND NumSuerte%3=0) Not NULL,
Minutos TinyInt CONSTRAINT CK_Minutos CHECK (Minutos BETWEEN 20 AND 80 OR Minutos BETWEEN 120 AND 185) Not NULL,
)