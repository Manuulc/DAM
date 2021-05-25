Create Database Ejemplos
GO
USE Ejemplos
GO

CREATE TABLE CriaturitasRaras(
	ID tinyint Not NULL,
	Nombre nvarchar(30) Not NULL,
	FechaNac Date  CONSTRAINT CK_FechaNac CHECK (FechaNac < CURRENT_TIMESTAMP)  NULL, 
	NumeroPie SmallInt CONSTRAINT CK_NumeroPie CHECK (NumeroPie BETWEEN 25 AND 60) NULL,
	NivelIngles NChar(2) CONSTRAINT CK_NivelIngles CHECK (NivelIngles IN ('A0','A1','A2','B1','B2','C1','C2')) NULL,
	Historieta VarChar(300) CONSTRAINT CK_Historieta CHECK (Historieta NOT LIKE '%oscuro%' AND Historieta NOT LIKE '%apocalipsis%') NULL,
	NumeroChico TinyInt CONSTRAINT CK_NumeroChico CHECK (NumeroChico<1000) NULL,
	NumeroGrande BigInt CONSTRAINT CK_NumeroGrande CHECK (NumeroGrande>(NumeroChico*100))NULL,
	NumeroIntermedio SmallInt CONSTRAINT CK_NumeroIntermedio CHECK ((NumeroIntermedio%2=0 AND (NumeroIntermedio BETWEEN NumeroChico AND NumeroGrande) NULL,
	Temperatura Decimal(3,1) CONSTRAINT CK_Temperatura CHECK (Temperatura BETWEEN 32.5 AND 44) NULL,
	CONSTRAINT [PK_CriaturitasEx] PRIMARY KEY(ID)
) 

GO
