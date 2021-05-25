CREATE DATABASE Antisistemas
GO
USE Antisistemas
GO
-- Actos de protesta
CREATE TABLE ActosProtesta (
	ID UniqueIdentifier Not NULL Constraint PKActos Primary Key,
	Titulo VarChar(120) Not NULL,
	Fecha Date NULL,
	Ciudad VarChar(20) Not NULL
)

CREATE TABLE Incidentes (
	IDActo UniqueIdentifier Not NULL,
	Ord SmallInt Not NULL, 
	Hora Time Not NULL,
	Lugar VarChar(80),
	Descripcion VarChar(250)
	Constraint PKIncidentes Primary Key (IDActo,Ord),
	Constraint FKIncidentesActos Foreign Key (IDActo) REFERENCES ActosProtesta(ID) On Delete Cascade On Update Cascade
)
CREATE TABLE Categorias(
	ID TinyInt CONSTRAINT PKCategorias Primary Key,
	Nombre VarChar(30) Not NULL
)

CREATE TABLE Materiales (
	ID SmallInt Not NULL Identity Constraint PKMateriales Primary Key,
	Descripcion VarChar(50) Not NULL,
	Peligro TinyInt NULL,
	Categoria TinyInt NULL,
	CONSTRAINT FKMaterialesCategorias Foreign Key (Categoria) REFERENCES Categorias(ID) On Delete No Action On Update No Action,
	CONSTRAINT CKPeligrosidad Check (Peligro BETWEEN 1 AND 5)
)
CREATE TABLE Grupos (
	ID SmallInt Identity CONSTRAINT PKGrupos Primary Key,
	Nombre VarChar(40) Not NULL,
	FechaFundacion Date NULL,
	FechaDisolucion Date NULL,
	CONSTRAINT CKFechas CHECK (FechaFundacion < FechaDisolucion)
)

CREATE TABLE GruposProtestas(
	IDGrupo SmallInt Not NULL,
	IDActo UniqueIdentifier Not NULL,
	CONSTRAINT PKGruposIncidentes Primary Key (IDGrupo,IDActo),
	CONSTRAINT FKGruposProtestasGrupos Foreign Key (IDGrupo) REFERENCES Grupos(ID) On Delete No Action On Update No Action,
	CONSTRAINT FKGruposProtestasProtestas Foreign Key (IDActo) REFERENCES ActosProtesta(ID) On Delete No Action On Update No Action
)

CREATE TABLE MaterialesIncidentes(
	IDMaterial SmallInt Not NULL,
	IDActo UniqueIdentifier Not NULL,
	OrdIncidente SmallInt Not NULL,
	Cantidad SmallInt Not NULL CONSTRAINT DFCantidadMaterial DEFAULT 1,
	CONSTRAINT PKMAterialesIncidentes Primary Key (IDMaterial,IDActo,OrdIncidente),
	CONSTRAINT FKMaterialesIncidentesIncidentes Foreign Key (IDActo, OrdIncidente) REFERENCES Incidentes(IDActo,Ord) On Delete No Action On Update No Action,
	CONSTRAINT FKMaterialesIncidentesMateriales Foreign Key (IDMaterial) REFERENCES Materiales(ID) On Delete No Action On Update No Action
)
CREATE TABLE Activistas(
	ID UniqueIdentifier Not NULL CONSTRAINT PKActivistas Primary Key,
	Nombre VarChar (20) Not NULL,
	Apellidos VarChar (30) Not NULL,
	FechaNac Date NULL,
	Organizacion SmallInt NULL,
	CONSTRAINT FKActivistasGrupos Foreign Key (Organizacion) REFERENCES Grupos(ID) On Delete No Action On Update No Action,
)

CREATE TABLE ActivistasProtestas(
	IDActivista UniqueIdentifier Not NULL,
	IDActo UniqueIdentifier Not NULL,
	CONSTRAINT PKActivistasProtestas Primary Key (IDActivista, IDActo),
	CONSTRAINT FKActivistasProtestasActivistas Foreign Key (IDActivista) REFERENCES Activistas(ID) On Delete No Action On Update No Action,
	CONSTRAINT FKActivistasProtestasProtestas Foreign Key (IDActo) REFERENCES ActosProtesta(ID) On Delete No Action On Update No Action
)
CREATE TABLE Detenciones (
	ID Int Not NULL Identity CONSTRAINT PKDetenciones Primary Key,
	Hora Time NULL,
	Cargos VarChar(50) NULL,
	IDActivista UniqueIdentifier Not NULL,
	IDActo UniqueIdentifier Not NULL,
	OrdIncidente SmallInt Not NULL,
	CONSTRAINT FKDetencionesActivistas Foreign Key (IDActivista) REFERENCES Activistas(ID) On Delete No Action On Update No Action,
	CONSTRAINT FKDetencionesIncidentes Foreign Key (IDActo, OrdIncidente) REFERENCES Incidentes(IDActo,Ord) On Delete No Action On Update No Action
)
GO
-- Activistas
INSERT Activistas (ID, Nombre, Apellidos, FechaNac, Organizacion) VALUES 
(N'557c945e-1f4c-4a30-845b-00000b3700fd', N'Samuel', N'Alexander', CAST(N'2004-03-30' AS Date), NULL)
,(N'85d2daf2-3572-431d-8d07-000edbdd6e42', N'Cedric', N'C Lin', CAST(N'2003-12-08' AS Date), NULL)
,(N'0f60d1b1-4f66-43b2-b941-0010baade1e4', N'Krystal', N'D Hu', CAST(N'2002-10-21' AS Date), NULL)
,(N'e277d63d-4a5e-4f63-bdc5-0012b6972b96', N'Isabella', N'Anderson', CAST(N'2004-05-10' AS Date), NULL)
,(N'6fee684f-2554-44ea-ab63-0015d1cac869', N'Orlando', N'A Dominguez', CAST(N'2004-03-11' AS Date), NULL)
,(N'621d61ed-bb06-4afe-9c08-001bbc52c705', N'Marcus', N'W Morgan', CAST(N'2004-02-19' AS Date), NULL)
,(N'd0fad794-4ba0-4c3c-80a8-0021a9759e05', N'Luis', N'J Collins', CAST(N'2002-01-06' AS Date), NULL)
,(N'93c3fb65-c094-4877-8e56-00266af86fa5', N'Hannah', N'Jones', CAST(N'2004-07-07' AS Date), NULL)

INSERT Activistas (ID, Nombre, Apellidos, FechaNac, Organizacion) VALUES 
(N'd99d8121-8e02-4080-b5c8-002b159eb82a', N'Franklin', N'M Rai', CAST(N'2003-05-23' AS Date), NULL)
,(N'08b7daa4-8695-4128-98b5-002b3117675e', N'Jackson', N'Sharma', CAST(N'2003-10-26' AS Date), NULL)
,(N'e01b9e1e-f0c0-4a2c-9b4c-002c7de5ac15', N'Ana', N'Powell', CAST(N'2003-12-31' AS Date), NULL)
,(N'8eafcc4b-ad5d-44c7-bcca-002e2c4e0416', N'Theresa', N'F Vazquez', CAST(N'2002-11-11' AS Date), NULL)
,(N'd86ed72d-4ee4-4629-a1de-002ed113b324', N'Kristi', N'C Martin', CAST(N'2003-06-25' AS Date), NULL)
,(N'95aafbdd-1b1d-451f-a9a7-002fda3e4449', N'Anna', N'Thompson', CAST(N'2004-05-19' AS Date), NULL)
,(N'edf3d3cc-8fdc-4a3a-9bd3-003626e192bd', N'Edward', N'A Martinez', CAST(N'2004-01-26' AS Date), NULL)
,(N'2ed10c9e-84cb-4145-9541-003b59723900', N'Marissa', N'Wood', CAST(N'2003-04-13' AS Date), NULL)
,(N'6508c9a0-89d5-4eca-8abe-003d765b7a38', N'Jon', N'K Tang', CAST(N'2003-05-03' AS Date), NULL)

INSERT Activistas (ID, Nombre, Apellidos, FechaNac, Organizacion) VALUES 
(N'1ff48edd-9117-4efb-9738-003e8b366787', N'Albert', N'Vazquez', CAST(N'2004-02-17' AS Date), NULL)
,(N'edcee513-d9c9-40ca-be2c-004450e32069', N'Louis', N'S Anand', CAST(N'2004-05-10' AS Date), NULL)
,(N'a9fc8599-3023-4786-a0d3-00468de76e40', N'Devin', N'L Taylor', CAST(N'2002-06-12' AS Date), NULL)
,(N'ccbe46ac-dd4e-4009-9415-0046f08d093f', N'Ben', N'T Miller', CAST(N'2000-04-02' AS Date), NULL)
,(N'17105118-ef9f-4284-8a92-004882aacdc0', N'Zachary', N'S Moore', CAST(N'2002-03-27' AS Date), NULL)
,(N'311fbdb6-25f8-47cf-acc3-004a6b6ae6d3', N'Jason', N'R Lopez', CAST(N'2001-08-18' AS Date), NULL)
,(N'b840259a-d975-4f2c-ba30-004ca3e7132f', N'Janice', N'K Hows', CAST(N'2002-08-01' AS Date), NULL)
,(N'9c1b2829-7849-4582-bd2f-004dbdcf8eef', N'Meredith', N'B Ruiz', CAST(N'2002-09-12' AS Date), NULL)
,(N'd63e4c79-006c-4af5-9c83-004eedf0eca2', N'Robert', N'K Henderson', CAST(N'2003-02-12' AS Date), NULL)
,(N'ed06e5f4-d7a5-4681-bb80-0050c984506b', N'Stuart', N'Munson', CAST(N'2002-01-24' AS Date), NULL)
,(N'69867297-9fac-49c4-8255-005160845a8a', N'Charles', N'L King', CAST(N'2003-09-07' AS Date), NULL)

INSERT Activistas (ID, Nombre, Apellidos, FechaNac, Organizacion) VALUES 
(N'3bbbcffd-0c78-4fd0-a814-005654c4ea82', N'Clayton', N'L Wagner', CAST(N'2003-02-03' AS Date), NULL)
,(N'f87aa791-52a3-448a-bc93-0056add05cc3', N'Diana', N'F Hernandez', CAST(N'2001-08-10' AS Date), NULL)
,(N'250459fd-a041-41da-b195-005840e4fde3', N'Sunil', N'Koduri', CAST(N'1999-03-07' AS Date), NULL)
,(N'0ee4ca1a-b1a5-459d-90a9-0058ecd14488', N'Cory', N'E Rana', CAST(N'2003-08-28' AS Date), NULL)
,(N'fca2a566-f887-44b1-8e86-005a4d682516', N'Jonathan', N'Jenkins', CAST(N'2004-05-05' AS Date), NULL)
,(N'492bd356-e742-4dc0-a9ef-005c046b0bbf', N'Gabriel', N'L Green', CAST(N'2002-05-01' AS Date), NULL)
,(N'04fa243b-aa13-414f-b595-005d547b428c', N'Dylan', N'D Clark', CAST(N'2004-02-28' AS Date), NULL)
,(N'd5208b4b-7270-4cbe-a6f3-00650c39349a', N'Stephanie', N'R Edwards', CAST(N'2003-12-07' AS Date), NULL)
,(N'b7915cd5-d15e-43ba-b933-006526583f60', N'Donals', N'E Nilson', CAST(N'2002-01-24' AS Date), NULL)
,(N'35550616-f374-4eab-8a75-006638887dc6', N'Thomas', N'A Lopez', CAST(N'2004-05-14' AS Date), NULL)

INSERT Activistas (ID, Nombre, Apellidos, FechaNac, Organizacion) VALUES 
(N'd90737e8-b3c1-4daa-bad2-006f6f197351', N'Kathleen', N'C Diaz', CAST(N'2004-05-06' AS Date), NULL)
,(N'9db31555-e5b7-4687-8a5a-00712e125a0c', N'Logan', N'J nzalez', CAST(N'2003-09-22' AS Date), NULL)
,(N'0d854332-1527-4925-90d6-0073822dd377', N'Gabriel', N'Lopez', CAST(N'2003-10-31' AS Date), NULL)
,(N'4b9ba6e3-f436-4ff2-8601-0076adc6645e', N'Kristin', N'G Luo', CAST(N'2004-01-06' AS Date), NULL)
,(N'69065853-7866-4316-a4e8-008251d630fd', N'Crystal', N'Liu', CAST(N'2003-11-20' AS Date), NULL)
,(N'37e13215-71b5-4897-a90d-0084a62a410a', N'Max', N'C Moyer', CAST(N'2002-07-08' AS Date), NULL)
,(N'4cbe0aa0-b243-445d-9659-0085436e15ac', N'Steve', N'L Guo', CAST(N'2001-11-28' AS Date), NULL)
,(N'70ff77ae-f582-418b-a6b0-0087285fa4fc', N'Gabriel', N'R Phillips', CAST(N'2003-12-28' AS Date), NULL)
,(N'54570db9-dab6-4c01-b0ee-00892129af93', N'Sharon', N'Rai', CAST(N'2002-04-20' AS Date), NULL)
,(N'99e38def-3fd2-4389-8cd0-0089eaaf9515', N'Kendra', N'Carlson', CAST(N'2004-03-10' AS Date), NULL)
,(N'ba86e5ae-c979-4b90-94a7-008bbd9b0e73', N'Lee', N'Serrano', CAST(N'2004-01-09' AS Date), NULL)
GO

INSERT Activistas (ID, Nombre, Apellidos, FechaNac, Organizacion) VALUES 
(N'ed5649cb-90d1-4675-a1d2-008c0f0d4727', N'Mason', N'Ward', CAST(N'2004-05-25' AS Date), NULL)
,(N'c0284deb-7b66-4f89-bbbb-0092fc08fb62', N'Amy', N'E Ma', CAST(N'2001-09-02' AS Date), NULL)
,(N'67fc367d-c24c-47d2-89d8-00946405610a', N'Frederick', N'Srini', CAST(N'2003-08-12' AS Date), NULL)
,(N'c848ede0-3424-4acb-8af7-00953cc33df6', N'Jeffery', N'W Zheng', CAST(N'2003-04-27' AS Date), NULL)
,(N'c9b99dc2-dcfb-4a3f-a9e2-00961ee99218', N'Jacquelyn', N'J Hernandez', CAST(N'2002-09-04' AS Date), NULL)
,(N'5a524334-7c99-469b-b7ff-00971bbde7e7', N'Harold', N'K Chandra', CAST(N'2004-01-15' AS Date), NULL)
,(N'042c17f0-e14b-4e24-9ea0-0099fb2a42a4', N'Simon', N'Rapier', CAST(N'2002-02-25' AS Date), NULL)
,(N'8ba388ec-bc1f-4794-90bf-009d4e5a894f', N'Shane', N'E Malhotra', CAST(N'2004-06-20' AS Date), NULL)
,(N'7c42eaf9-1302-4282-8a8a-009f18f5fbdf', N'Katelyn', N'Parker', CAST(N'2002-04-30' AS Date), NULL)
,(N'b649c1f1-5fb3-4914-a4d0-00a074e322c6', N'Anne', N'Romero', CAST(N'2004-06-09' AS Date), NULL)
,(N'6fd55983-6e7b-48de-927f-00a1127ab948', N'Claudia', N'M Zeng', CAST(N'2001-08-07' AS Date), NULL)
,(N'ff5664bc-5df1-46ab-8e20-00a125c72c13', N'Deanna', N'H Schmidt', CAST(N'2002-05-08' AS Date), NULL)

INSERT Activistas (ID, Nombre, Apellidos, FechaNac, Organizacion) VALUES 
(N'30c28ecf-c6ea-414c-837a-00a548e65499', N'Warren', N'L Chow', CAST(N'2003-05-25' AS Date), NULL)
,(N'553c44c2-16bb-41c6-8ba6-00a57721324f', N'Stacy', N'Munoz', CAST(N'2004-04-14' AS Date), NULL)
,(N'541f7e54-0be6-4f0b-8482-00a57a2ee7c2', N'Grant', N'S Raje', CAST(N'2003-04-15' AS Date), NULL)
,(N'ca456bce-b210-419b-93dd-00afa90d787b', N'Paula', N'A Gutierrez', CAST(N'2002-01-30' AS Date), NULL)
,(N'e92adced-9af1-4d13-8426-00b59a7829d3', N'Wyatt', N'R Wright', CAST(N'2003-12-20' AS Date), NULL)
,(N'6ce2749d-7b58-478d-9aad-00b790549f22', N'Arturo', N'V Zhang', CAST(N'2004-02-21' AS Date), NULL)
,(N'b795a0f8-0782-4ad1-a4bb-00b946413e03', N'Megan', N'R Jenkins', CAST(N'2004-02-12' AS Date), NULL)
,(N'64571026-7000-483b-ae9c-00bc751011c2', N'Hunter', N'Campbell', CAST(N'2004-01-16' AS Date), NULL)
,(N'95848249-14a1-4e3b-ba65-00cd2c0f19e9', N'Edgar', N'A nzalez', CAST(N'2003-05-01' AS Date), NULL)
,(N'61998a67-ac33-453a-b774-00d25a0130ad', N'Lucas', N'Clark', CAST(N'2004-04-10' AS Date), NULL)
,(N'6bc6fabd-88f5-4ba8-afd0-00d4a3d2b055', N'Lauren', N'G Rogers', CAST(N'2004-06-24' AS Date), NULL)
,(N'1ef19fd1-426b-4580-be18-00e1531abd9a', N'Jonathan', N'A Miller', CAST(N'2003-10-20' AS Date), NULL)

INSERT Activistas (ID, Nombre, Apellidos, FechaNac, Organizacion) VALUES 
(N'76677c16-f9d9-450e-bd13-00e2e092e42b', N'Darrell', N'J Stone', CAST(N'2003-12-06' AS Date), NULL)
,(N'a7067f05-f698-4e88-9e36-00e745231f11', N'Hunter', N'P Rodriguez', CAST(N'2002-03-07' AS Date), NULL)
,(N'93a1d8b3-89e9-4428-ad33-00f01218aed8', N'Dalton', N'L Bennett', CAST(N'2003-08-27' AS Date), NULL)
,(N'219c190f-7dba-4060-b705-00f55866797b', N'Justin', N'Griffin', CAST(N'2002-02-13' AS Date), NULL)
,(N'a34a5dee-90a4-4c0d-a02b-00f758e748f9', N'Summer', N'M Rana', CAST(N'2003-08-30' AS Date), NULL)
,(N'ac6470ac-0870-48b9-91a9-00f7690f4719', N'Jared', N'Cook', CAST(N'2002-01-23' AS Date), NULL)
,(N'2d74f284-323c-460a-afe8-00f942bdf2a0', N'Jon', N'H Pal', CAST(N'2002-04-03' AS Date), NULL)
,(N'82e19065-ec0b-4c50-9b58-00fc98c9e7f2', N'Thomas', N'P Phillips', CAST(N'2003-01-31' AS Date), NULL)
,(N'1e64fc69-ee52-4e2c-a690-00fd1733ab44', N'Ashlee', N'R Moyer', CAST(N'2003-08-04' AS Date), NULL)
,(N'4b2b32e0-e2f5-421d-9730-01001f7cf834', N'Phillip', N'L Fernandez', CAST(N'2003-09-01' AS Date), NULL)
,(N'9db1c192-7b8c-436e-a47e-010211b1d630', N'Neil', N'Rubio', CAST(N'2004-05-21' AS Date), NULL)

INSERT Activistas (ID, Nombre, Apellidos, FechaNac, Organizacion) VALUES 
(N'205c5f7c-14a2-42dc-97e5-010242bb8ad6', N'Jaime', N'mez', CAST(N'2001-07-23' AS Date), NULL)
,(N'abd9ffd5-f891-4c77-a886-01057be936c1', N'Ethan', N'E Butler', CAST(N'2002-12-05' AS Date), NULL)
,(N'8b5e298d-c1b3-4e6e-af47-010842eb3472', N'Arianna', N'Cooper', CAST(N'2004-05-11' AS Date), NULL)
,(N'a2de11e1-ef1e-4a47-81ed-010b987cf788', N'Luke', N'nzales', CAST(N'2004-06-27' AS Date), NULL)
,(N'a6177370-a88e-437d-8d39-010ea18a2a93', N'Clinton', N'H Moreno', CAST(N'2001-07-22' AS Date), NULL)
,(N'4c0747a0-58a3-4fe4-9c17-010f64aa4073', N'James', N'White', CAST(N'2003-12-08' AS Date), NULL)
,(N'81a0f90f-aa49-4aef-8d45-011991f8cc40', N'Maurice', N'L Shen', CAST(N'2003-12-08' AS Date), NULL)
,(N'735862c3-81fe-4089-a1e8-0123f929da1e', N'Brandi', N'Suarez', CAST(N'2002-09-19' AS Date), NULL)
,(N'e4ab067f-91cc-4d73-adc3-012543e42e0c', N'Kris', N'R Bergin', CAST(N'2003-07-01' AS Date), NULL)
,(N'336a8f15-6578-417e-ab96-012fdba75ae6', N'Jeremiah', N'L Russell', CAST(N'2004-04-21' AS Date), NULL)
,(N'da86410b-f3ec-4f7d-ab1d-0133bd1980be', N'Lauren', N'Sanders', CAST(N'2003-08-01' AS Date), NULL)
,(N'e7c2349e-8ea3-4346-8d9c-01346f2394fc', N'Jackson', N'S Coleman', CAST(N'2003-06-23' AS Date), NULL)
,(N'42279b28-9b62-43f6-82e7-013553bd0ade', N'Mariah', N'Howard', CAST(N'2004-02-05' AS Date), NULL)

INSERT Activistas (ID, Nombre, Apellidos, FechaNac, Organizacion) VALUES 
(N'4a4c667d-5e6f-4ab4-be4e-013a36a04e41', N'Peter', N'L el', CAST(N'2003-09-21' AS Date), NULL)
,(N'607d1f35-3732-4119-abc6-013ab546d8f8', N'Willie', N'Yuan', CAST(N'2003-01-04' AS Date), NULL)
,(N'38234078-10ab-4f53-80c1-013c2704adcc', N'Abigail', N'nzales', CAST(N'2004-05-18' AS Date), NULL)
,(N'85ddaa78-a448-4c23-b485-01423bf3f20f', N'Glenn', N'J Track', CAST(N'2002-09-01' AS Date), NULL)
,(N'6b6299ed-0667-4727-be2f-0143aff3ccee', N'Shaun', N'N Xu', CAST(N'2004-03-28' AS Date), NULL)
,(N'2cc1c546-7d46-4fb0-8e13-014d4d133d12', N'Nicolas', N'J Jai', CAST(N'2003-10-22' AS Date), NULL)
,(N'd133daa8-acdf-42f7-9d61-014dbbd56d1b', N'Austin', N'M Jai', CAST(N'2003-08-30' AS Date), NULL)
,(N'45e3497d-b8a6-4c5d-88ec-015d1663ac16', N'Heather', N'Xu', CAST(N'2004-02-24' AS Date), NULL)
,(N'59b33e3f-a064-4a02-b48e-015d681998a7', N'Brandon', N'C Clark', CAST(N'2004-04-22' AS Date), NULL)
,(N'f4dca063-1bbb-4b84-a3b3-015db4380a1f', N'Michael', N'Allen', CAST(N'2001-08-01' AS Date), NULL)
,(N'14a8cdaf-b02d-4a4e-b310-015fd02519e3', N'Dawn', N'L Shen', CAST(N'2002-01-04' AS Date), NULL)
,(N'f0cc74df-71a6-45a1-9465-0160eef73181', N'Cameron', N'L Anderson', CAST(N'2002-11-19' AS Date), NULL)
,(N'da6d4611-e2c6-46e2-a48c-01683450141d', N'Roger', N'Andersen', CAST(N'2003-08-20' AS Date), NULL)

INSERT Activistas (ID, Nombre, Apellidos, FechaNac, Organizacion) VALUES 
(N'31e9a715-4c16-49d3-972e-0168745b610c', N'Johnathan', N'Srini', CAST(N'2004-01-26' AS Date), NULL)
,(N'5348dd10-28a3-490d-a6f8-016c0cbebbca', N'Krystal', N'F Wagner', CAST(N'2003-09-03' AS Date), NULL)
,(N'5fff522c-c098-47f3-8bf4-016d6e795f45', N'Gabriel', N'C Patterson', CAST(N'2003-12-17' AS Date), NULL)
,(N'a2f1b3b5-b1a3-425d-9b4c-016e542e4945', N'Courtney', N'Phillips', CAST(N'2001-11-08' AS Date), NULL)
,(N'a0734020-5fcd-4729-8677-017b2bc4ff87', N'Daisy', N'Ramos', CAST(N'2004-04-24' AS Date), NULL)
,(N'f437561e-be52-4599-a1fd-017cc07e1530', N'Olivia', N'B Powell', CAST(N'2004-03-12' AS Date), NULL)
,(N'81c39019-bc58-45b6-81b3-017d38ac2bc6', N'Brad', N'Xu', CAST(N'2004-03-30' AS Date), NULL)
,(N'46ea290f-c256-436b-852e-01806f2338b9', N'Ciam', N'Sawyer', CAST(N'1999-03-16' AS Date), NULL)
,(N'7c2f8861-0c6c-4142-8136-0183fe54e446', N'Nathaniel', N'M Rivera', CAST(N'2003-02-09' AS Date), NULL)
,(N'5c895115-7a13-4c32-b09b-01897d236b28', N'Heather', N'Yang', CAST(N'2001-11-14' AS Date), NULL)
,(N'c01216b0-f4c8-4427-b6b2-018ade7b38ed', N'Kelli', N'Zhao', CAST(N'2004-02-24' AS Date), NULL)
,(N'7c4ee324-e2bf-40b6-a03e-018cbdeb5338', N'Kaitlyn', N'R Howard', CAST(N'2003-09-13' AS Date), NULL)
GO

INSERT Activistas (ID, Nombre, Apellidos, FechaNac, Organizacion) VALUES 
(N'db32dcf3-080b-49eb-a293-019176f9af03', N'Allen', N'Smith', CAST(N'2004-01-24' AS Date), NULL)
,(N'83607e96-5d82-44f3-ada8-0192c017856a', N'Alejandro', N'J Cai', CAST(N'2003-05-31' AS Date), NULL)
,(N'd9b5faa7-0cb9-4cd6-9416-0195e932a30c', N'Ricky', N'M Navarro', CAST(N'2003-03-07' AS Date), NULL)
,(N'd69a30ee-1cde-4c81-8d68-019f652df78e', N'Darren', N'M Gill', CAST(N'2003-09-06' AS Date), NULL)
,(N'1e3612e5-0932-4ebf-acd0-01a060b0a16b', N'Hailey', N'Ramirez', CAST(N'2004-05-16' AS Date), NULL)
,(N'474abd06-836b-41a5-8eb4-01a7ac234fdf', N'Marcus', N'R Price', CAST(N'2003-07-27' AS Date), NULL)
,(N'2a9ef98c-7d8c-42a9-8c87-01a9a9f89882', N'Jessie', N'J Alonso', CAST(N'2002-04-29' AS Date), NULL)
,(N'efe7b963-e879-4083-9448-01ab3a486215', N'Hannah', N'C Ross', CAST(N'2004-07-07' AS Date), NULL)
,(N'7dd5d4b9-3773-4bb7-804d-01ac8dc6ba5b', N'Victoria', N'Gray', CAST(N'2002-11-22' AS Date), NULL)
,(N'7a3dbac0-b1ed-432b-af39-01acf6a552b3', N'John', N'E Ortiz', CAST(N'2002-02-25' AS Date), NULL)
,(N'bd2d5c40-63e9-4734-bba1-01ad64534aab', N'Taylor', N'Alexander', CAST(N'2003-09-07' AS Date), NULL)
,(N'2272d965-a307-4a9b-9db6-01ad8b301a19', N'Heidi', N'R Garcia', CAST(N'2004-07-14' AS Date), NULL)
,(N'0fd6d956-e20e-4dac-9c94-01b42cf4d939', N'Michelle', N'E Cox', CAST(N'2001-09-01' AS Date), NULL)

INSERT Activistas (ID, Nombre, Apellidos, FechaNac, Organizacion) VALUES 
(N'7ea55c9a-fe69-44cf-936b-01b49fcce2f1', N'Ernest', N'She', CAST(N'2004-02-23' AS Date), NULL)
,(N'654ef396-ddb4-4474-ae66-01bb3be6d93c', N'Sabrina', N'Blanco', CAST(N'2002-06-07' AS Date), NULL)
,(N'953a389a-b387-4b14-aceb-01c39387bb9a', N'Jan', N'R Nelsen', CAST(N'2002-01-23' AS Date), NULL)
,(N'b0b904f0-4112-4338-8b20-01c4a66e27f3', N'Sierra', N'Roberts', CAST(N'2002-04-05' AS Date), NULL)
,(N'c5219e23-4156-496b-9130-01c4e4c7b48f', N'Gina', N'L Dominguez', CAST(N'2002-04-04' AS Date), NULL)
,(N'55957fea-a634-42c5-b5db-01c69e1e8e23', N'Chloe', N'L Ward', CAST(N'2003-07-08' AS Date), NULL)
,(N'2cfe7376-14b2-44b9-a9e6-01c8e90d267e', N'Cesar', N'L Subram', CAST(N'2003-10-25' AS Date), NULL)
,(N'1b629687-0152-455a-b4e1-01ce034c2e30', N'Melody', N'A Dominguez', CAST(N'2003-12-29' AS Date), NULL)
,(N'435e4474-75d0-4917-8bd9-01ce58fb4301', N'Micheal', N'W Alonso', CAST(N'2004-04-29' AS Date), NULL)
,(N'ac921c7c-cec1-47dc-bc07-01d1c853ecdc', N'Dalton', N'A Perry', CAST(N'2003-12-01' AS Date), NULL)
,(N'a491014d-7e0b-42d4-8036-01d3c18d8ddd', N'Bianca', N'A Zimmerman', CAST(N'2003-11-02' AS Date), NULL)
,(N'4ac5498a-97f9-4739-a473-01d4d656aca2', N'Sara', N'Gray', CAST(N'2003-08-19' AS Date), NULL)
,(N'd036ad6c-8e7d-484f-8a11-01d91f2d29dd', N'Stephanie', N'James', CAST(N'2004-04-15' AS Date), NULL)

INSERT Activistas (ID, Nombre, Apellidos, FechaNac, Organizacion) VALUES  
(N'19fd5eb6-9131-4319-ac3a-01db4cb7aae0', N'Isaiah', N'E Cox', CAST(N'2001-07-29' AS Date), NULL)
,(N'72d64d02-5618-4ae2-b33f-01de01d5f726', N'Victoria', N'J Cook', CAST(N'2002-06-21' AS Date), NULL)
,(N'729fea74-8ab6-4892-ba00-01df8fac4d67', N'Carol', N'P Xu', CAST(N'2001-09-23' AS Date), NULL)
,(N'9237bf0c-7f65-4c8d-a150-01e2c4c70fc6', N'Fernando', N'W Evans', CAST(N'2004-06-12' AS Date), NULL)
,(N'391a2666-148a-4785-928a-01ee7102a6fe', N'Devin', N'Hall', CAST(N'2004-01-28' AS Date), NULL)
,(N'3f266fec-c0de-4c73-906c-01f00dad1d3e', N'Monica', N'Smith', CAST(N'2003-11-25' AS Date), NULL)
,(N'f91e9cb8-17f5-484d-b1e2-01f6ce4e7230', N'Katie', N'L McAskill-White', CAST(N'1999-03-17' AS Date), NULL)
,(N'b672d0cb-57a6-465a-b272-01f7f67c62a4', N'Gabriella', N'M Young', CAST(N'2002-10-20' AS Date), NULL)
,(N'2f9721a3-fcc9-4094-afa1-01f83776a918', N'Dylan', N'Patterson', CAST(N'2004-05-07' AS Date), NULL)
,(N'1257cb26-c514-4da8-973a-01f855840a8b', N'Steven', N'Levy', CAST(N'1999-03-29' AS Date), NULL)
,(N'd2655b4b-54da-4dd2-ae20-01f8ecb11eab', N'Arturo', N'Shen', CAST(N'2002-11-03' AS Date), NULL)
,(N'8e64f1e7-d6c9-4b83-ac42-01f982af5fc1', N'Juan', N'T Murphy', CAST(N'2002-06-23' AS Date), NULL)

INSERT Activistas (ID, Nombre, Apellidos, FechaNac, Organizacion) VALUES 
(N'5adbf7ca-1f17-4e3a-8a1b-01fee4231df3', N'Tristan', N'E Hayes', CAST(N'2003-09-23' AS Date), NULL)
,(N'74abeede-fb35-4f93-b8fb-02029833a747', N'Grery', N'J Rai', CAST(N'2003-09-27' AS Date), NULL)
,(N'a723a902-8743-4a9d-9234-0203336d271e', N'Alisha', N'Cai', CAST(N'2003-10-07' AS Date), NULL)
,(N'ee6ca54b-0f90-4fd4-b37e-0204875bd74b', N'Gavin', N'Griffin', CAST(N'2004-02-23' AS Date), NULL)
,(N'1addd1ca-81a7-4c7a-bf43-02078c5237de', N'Willie', N'C Raje', CAST(N'2004-06-04' AS Date), NULL)
,(N'714f4fe8-2853-41ed-ac4a-0207f7f80413', N'Dana', N'S Schmidt', CAST(N'2003-07-03' AS Date), NULL)
,(N'9278756e-20c4-4dcd-b5cf-020b1afca4d5', N'Debra', N'Core', CAST(N'1999-01-29' AS Date), NULL)
,(N'cabfb4ab-53c0-4c35-b77e-0211720eeb90', N'Jillian', N'Sai', CAST(N'2004-05-18' AS Date), NULL)
,(N'6a365f39-60e0-4f7d-bcf0-02191ec29cd4', N'Alexander', N'L Williams', CAST(N'2003-12-15' AS Date), NULL)
,(N'b03f852b-5cd1-489e-8931-021e9d6b19d5', N'Christian', N'P Martinez', CAST(N'2004-04-05' AS Date), NULL)
,(N'2ef0a3b6-b189-4910-b946-0220c04c933f', N'Richard', N'L Hughes', CAST(N'2003-10-01' AS Date), NULL)
,(N'5f524631-f146-48fe-b459-02222d9f5d50', N'Kim', N'Ralls', CAST(N'1999-03-07' AS Date), NULL)
GO

INSERT Activistas (ID, Nombre, Apellidos, FechaNac, Organizacion) VALUES 
(N'1f9010f8-d9a2-4ad3-beed-0223250d7be3', N'Paul', N'West', CAST(N'2001-09-01' AS Date), NULL)
,(N'4f1d4368-834b-4af0-acfa-0223b7ddf776', N'Rachael', N'D Kapoor', CAST(N'2003-12-03' AS Date), NULL)
,(N'dd8c6879-6e78-4830-9cb1-0226bda5d470', N'Jake', N'Lin', CAST(N'2003-04-08' AS Date), NULL)
,(N'230f3c51-c066-484d-aca1-022767eb1efa', N'Ursilinio', N'Remello', CAST(N'1978-02-12' AS Date), NULL)
,(N'8f94b8f2-80ac-46da-ac83-022bda0440a7', N'Arthur', N'Blanco', CAST(N'2004-06-24' AS Date), NULL)
,(N'9de3dfd1-2d5e-4634-903a-02345d98bff3', N'David', N'G Clark', CAST(N'2003-08-08' AS Date), NULL)
,(N'320146ad-21c7-4d9d-ba92-0237677c8f19', N'Makayla', N'D Watson', CAST(N'2004-05-16' AS Date), NULL)
,(N'ab140130-db03-4043-88db-023a70cf1ea1', N'Zachary', N'A Walker', CAST(N'2004-03-23' AS Date), NULL)
,(N'f025a75f-a5dc-44c8-9873-023d726dd67e', N'Marcus', N'Perez', CAST(N'2004-04-19' AS Date), NULL)
,(N'e33beeb6-ff29-4d85-a9f9-023d84c26bb5', N'Adrienne', N'Sanz', CAST(N'2002-11-11' AS Date), NULL)
,(N'bfd1ddef-e9be-4c9f-bbc3-023e253404fe', N'Madison', N'A Ross', CAST(N'2004-03-20' AS Date), NULL)
,(N'4e737155-eac3-4a2d-8ba0-02403655e119', N'Mason', N'Young', CAST(N'2003-05-31' AS Date), NULL)
,(N'47d60ebb-4890-47fb-b22c-024064c6558c', N'Imtiaz', N'Khan', CAST(N'1999-03-28' AS Date), NULL)
,(N'f27b5edd-d7f0-4812-bff2-02430fa4e002', N'Latasha', N'Carlson', CAST(N'2004-06-22' AS Date), NULL)
,(N'cd82f121-15cf-40bb-9f4a-024851b52f77', N'Andre', N'H Garcia', CAST(N'2002-10-01' AS Date), NULL)

INSERT Activistas (ID, Nombre, Apellidos, FechaNac, Organizacion) VALUES 
(N'9fba862a-bc18-4194-b1e9-024b8a0ed4c1', N'Rebecca', N'F Lopez', CAST(N'2003-06-10' AS Date), NULL)
,(N'4501ca08-2ba3-41b8-8271-024d467da0f9', N'Rebekah', N'R Patel', CAST(N'2004-02-11' AS Date), NULL)
,(N'6ec8d2b2-66cf-4dcf-9381-024edce364cd', N'Jackson', N'S nzalez', CAST(N'2004-02-13' AS Date), NULL)
,(N'82018ed8-d2d5-45fb-acd0-0252b834eb51', N'Michele', N'E Jai', CAST(N'2002-08-09' AS Date), NULL)
,(N'7939d8f9-39ce-4163-a07d-0255f1ebc922', N'Jesse', N'Morris', CAST(N'2003-09-13' AS Date), NULL)
,(N'1a16fd63-9570-4449-a81f-02584ebac839', N'Alvin', N'Yang', CAST(N'2004-01-08' AS Date), NULL)
,(N'92880c8e-1512-4762-ac54-025a012f652f', N'Nancy', N'A Anderson', CAST(N'1999-01-27' AS Date), NULL)
,(N'74bc605f-70eb-44ae-b01a-025a3900a916', N'Paige', N'Foster', CAST(N'2003-12-31' AS Date), NULL)
,(N'ad81c3bd-0f24-428f-968b-025ac5368184', N'Luis', N'A Campbell', CAST(N'2003-07-20' AS Date), NULL)
,(N'fbf21038-f4d2-427e-8f6f-025d212f88c0', N'Johnny', N'S Raji', CAST(N'2003-06-30' AS Date), NULL)
,(N'5fff1109-8b5a-4465-9817-025e031603fe', N'Dalton', N'A Rogers', CAST(N'2003-11-08' AS Date), NULL)
,(N'f0116cc1-874f-4235-8bcd-025e4870647f', N'Devin', N'S Howard', CAST(N'2004-05-01' AS Date), NULL)
,(N'c628c032-a8c2-4fab-89fe-025e7d5042b6', N'Mihail', N'Frintu', CAST(N'2002-09-01' AS Date), NULL)
,(N'2fc87265-bcbb-44d9-a42b-0261c37ec188', N'Tom', N'Getzinger', CAST(N'2003-08-01' AS Date), NULL)
,(N'e53a3a46-1ed2-4f82-9dbd-0261f782b63c', N'Garrett', N'Sanders', CAST(N'2004-01-02' AS Date), NULL)

INSERT Activistas (ID, Nombre, Apellidos, FechaNac, Organizacion) VALUES 
(N'143323a1-0666-40df-81dc-0263b9895846', N'Kelli', N'M Yang', CAST(N'2003-10-18' AS Date), NULL)
,(N'dcc8a711-2518-4d59-82ff-0267d6c317b7', N'Tengiz', N'N Kharatishvili', CAST(N'1999-01-10' AS Date), NULL)
,(N'5b9db1dc-b09e-4054-a3c6-026b96d1d8fa', N'Alan', N'Brewer', CAST(N'2001-11-01' AS Date), NULL)
,(N'b97758df-732c-484b-9086-026ba1e91093', N'Jan', N'J Green', CAST(N'2003-01-17' AS Date), NULL)
,(N'bedabdc3-7f75-4161-a9c2-026edb27dd81', N'Jonathan', N'C Thomas', CAST(N'2004-01-29' AS Date), NULL)
,(N'509464a5-0902-42d4-921c-0273e7eab253', N'Katrina', N'J Luo', CAST(N'2003-05-31' AS Date), NULL)
,(N'7b53d8b7-9919-43ab-aa33-027446541bd2', N'Tom', N'M Vande Velde', CAST(N'2000-04-03' AS Date), NULL)
,(N'4209d806-9d02-4bd8-aa65-02750ece1815', N'Steve', N'Masters', CAST(N'2001-08-01' AS Date), NULL)
,(N'7af4b71a-0358-4861-b78c-0275133ef11c', N'Carrie', N'E Hernandez', CAST(N'2002-05-25' AS Date), NULL)
,(N'416869cf-d527-4f71-9124-02771492ef57', N'Adrienne', N'C Torres', CAST(N'2002-03-11' AS Date), NULL)
,(N'ed8c15d9-c335-43bc-b2c5-02777359e47c', N'Janet', N'L Sheperdigian', CAST(N'1999-03-26' AS Date), NULL)
,(N'b29af893-cf86-4be3-b155-0278956cfd28', N'Kok-Ho', N'T Loh', CAST(N'1999-01-21' AS Date), NULL)
,(N'bb6801dd-7ac9-46ef-a98b-027c85ad49fc', N'Jose', N'Davis', CAST(N'2004-03-16' AS Date), NULL)
,(N'65946cd5-b5e1-43ce-9c0f-027d6f089024', N'Nathan', N'Jones', CAST(N'2003-10-11' AS Date), NULL)
,(N'e436c762-f7e4-4289-b62d-0282446f9afc', N'Hector', N'Moreno', CAST(N'2002-07-08' AS Date), NULL)
,(N'8792efee-c73a-4be1-8020-028c9f1ffa75', N'Michael', N'Ruggiero', CAST(N'2004-03-12' AS Date), NULL)
,(N'deda1651-71cd-4d20-9fb7-028ebe573bfb', N'Renee', N'Jimenez', CAST(N'2001-12-14' AS Date), NULL)

INSERT Activistas (ID, Nombre, Apellidos, FechaNac, Organizacion) VALUES 
(N'd21c2cc0-3af7-4ede-975e-0295c41c6942', N'Bryce', N'I Torres', CAST(N'2004-05-15' AS Date), NULL)
,(N'60ec6197-a0b7-4950-964d-029ba4e290f6', N'Donald', N'M Sara', CAST(N'2003-04-07' AS Date), NULL)
,(N'3c677112-70cb-42ed-b2c3-029c32de04c5', N'Abigail', N'Alexander', CAST(N'2003-10-08' AS Date), NULL)
,(N'a0c79a30-386c-47d5-9f16-029fa3a14729', N'Marshall', N'Chander', CAST(N'2003-08-24' AS Date), NULL)
,(N'49b2878c-16c8-489a-abe4-02a0b634f49d', N'Miranda', N'Price', CAST(N'2001-08-19' AS Date), NULL)
,(N'a7876b72-2daa-479f-b0cd-02a187d60465', N'Christy', N'Rai', CAST(N'2003-11-30' AS Date), NULL)
,(N'243bd184-b785-4df2-9d7b-02a2c3cadefb', N'Larry', N'Serrano', CAST(N'2003-06-21' AS Date), NULL)
,(N'95819d25-2979-47c3-be50-02a377311b2d', N'Abby', N'L Sai', CAST(N'2001-10-30' AS Date), NULL)
,(N'4692978a-7dce-48fc-91ed-02a536513dfb', N'Melinda', N'Ramos', CAST(N'2004-02-06' AS Date), NULL)
,(N'1c8ab37e-6855-4ca4-8fad-02a9c085b093', N'Carrie', N'R Munoz', CAST(N'2004-07-31' AS Date), NULL)
,(N'3976c0d0-1679-48a4-9999-02ade92e3074', N'Kelvin', N'V Raje', CAST(N'2002-10-12' AS Date), NULL)
,(N'08ed1191-8763-41ab-8714-02ae598c5207', N'Damien', N'A Deng', CAST(N'2004-01-24' AS Date), NULL)
,(N'1752c42d-afa3-4d24-9b03-02b2912fb0cd', N'Jay', N'M Rodriguez', CAST(N'2003-08-29' AS Date), NULL)
,(N'9b8dc39c-6471-4969-af0f-02b2dd4a4464', N'Haley', N'R Sanchez', CAST(N'2004-07-08' AS Date), NULL)
,(N'def7e70e-47d9-45bc-8a39-02b70a8bf568', N'Bailey', N'L Ward', CAST(N'2004-05-09' AS Date), NULL)

INSERT Activistas (ID, Nombre, Apellidos, FechaNac, Organizacion) VALUES 
(N'ef5589a0-899c-4f86-9b34-02bc47129379', N'David', N'M Henderson', CAST(N'2004-04-05' AS Date), NULL)
,(N'c360490f-ff6d-4997-8c85-02bf09dbba56', N'Danielle', N'Sanchez', CAST(N'2004-03-15' AS Date), NULL)
,(N'f5863efb-dcfb-4378-8a29-02c06d54a245', N'Roy', N'Vazquez', CAST(N'2002-08-26' AS Date), NULL)
,(N'29d692b0-a580-4b7f-94fe-02c8b0a2dfbf', N'Lacey', N'A She', CAST(N'2004-03-28' AS Date), NULL)
,(N'3e7c5568-55d9-4d6e-b941-02d16d9416a2', N'Kaitlyn', N'J Young', CAST(N'2003-10-14' AS Date), NULL)
,(N'1194bb9a-82d5-4bcf-8be6-02d45df54451', N'Marco', N'Vance', CAST(N'2004-05-02' AS Date), NULL)
,(N'd6ae3bf3-f76f-4b8e-af61-02d7448f87ab', N'Linda', N'Reisner', CAST(N'1999-01-26' AS Date), NULL)
,(N'953c2aa1-406b-470c-aa6c-02dae4a458a5', N'Nancy', N'Buchanan', CAST(N'2003-07-01' AS Date), NULL)
,(N'0a58d769-85ce-4bcb-8eb4-02e23918d2af', N'Anna', N'Barnes', CAST(N'2004-01-31' AS Date), NULL)
,(N'a60f28af-704e-45d4-9c9b-02e4b7cc3601', N'Cristina', N'J Sharma', CAST(N'2004-07-07' AS Date), NULL)
,(N'b5ec9adb-8532-489a-8d69-02e5ab15fff7', N'Albert', N'A Diaz', CAST(N'2003-12-18' AS Date), NULL)
,(N'1c644f44-6b56-49b2-ad73-02e8acd30f49', N'Caleb', N'Edwards', CAST(N'2003-08-31' AS Date), NULL)
,(N'22452502-c1ad-4adc-864f-02f864f1ed79', N'Savannah', N'M Green', CAST(N'1987-12-18' AS Date), NULL)
,(N'd553e777-3208-4219-9e18-02fc9b4d273c', N'Brandi', N'J Sanz', CAST(N'2003-11-17' AS Date), NULL)
,(N'8af671dd-f5e7-4baa-a530-030060630a62', N'Raul', N'L Shan', CAST(N'2004-06-11' AS Date), NULL)
,(N'bacc1950-12fd-4431-9847-0300f7015868', N'Carlos', N'L Cox', CAST(N'2004-01-18' AS Date), NULL)

INSERT Activistas (ID, Nombre, Apellidos, FechaNac, Organizacion) VALUES 
(N'98d50d69-5c2b-4155-aae3-0302a25f7dd6', N'Gerald', N'nzalez', CAST(N'2003-09-26' AS Date), NULL)
,(N'dc66e494-9e3e-45cb-ad4e-030946a67747', N'Stephanie', N'Perez', CAST(N'2004-01-28' AS Date), NULL)
,(N'0053cff7-8936-4027-b945-030b24763729', N'Leonino', N'Escobilla', CAST(N'1964-01-06' AS Date), NULL)
,(N'872ae23d-875d-4945-96a2-030ca7e295eb', N'Charles', N'D Martinez', CAST(N'2004-05-15' AS Date), NULL)
,(N'9d2900d0-ceca-4db3-9557-030cf1f45f29', N'Wyatt', N'Washington', CAST(N'2003-01-11' AS Date), NULL)
,(N'c28e331d-e1a6-4afb-afad-030d2d716b79', N'Kirk', N'J Koenigsbauer', CAST(N'1999-01-09' AS Date), NULL)
,(N'f85859f5-1737-47af-ba4d-030d8f3dc21b', N'Grace', N'Wilson', CAST(N'2004-02-21' AS Date), NULL)
,(N'430de8d1-1a2a-412c-bc6c-03100c661171', N'Trisha', N'Lu', CAST(N'2001-08-19' AS Date), NULL)
,(N'cac4eca4-ec91-45fd-8cf3-03159ea19422', N'Yolanda', N'C Yuan', CAST(N'2003-08-08' AS Date), NULL)
,(N'ab6c5243-207a-4a46-99ec-031b6f4cf7af', N'Bruce', N'D Srini', CAST(N'2004-02-02' AS Date), NULL)
,(N'eca18649-796c-4edd-88a1-031de2d4fd2d', N'Jacqueline', N'Powell', CAST(N'2002-02-24' AS Date), NULL)
,(N'2de717db-ac33-4749-b7f5-03214db46bc5', N'Bryan', N'Walton', CAST(N'2003-09-01' AS Date), NULL)
,(N'7727c597-4e57-4e7f-bbdf-032533d13158', N'Richard', N'L Moore', CAST(N'2003-11-30' AS Date), NULL)
,(N'143f5232-c195-4b04-baf3-0326ab314777', N'Cassie', N'el', CAST(N'2004-04-23' AS Date), NULL)
,(N'4cfaf582-734b-4f78-ba4e-032813141aa3', N'Brittney', N'R Liang', CAST(N'2004-05-03' AS Date), NULL)

INSERT Activistas (ID, Nombre, Apellidos, FechaNac, Organizacion) VALUES 
(N'b4d22ca9-0930-42c4-b30c-03291ad6699e', N'Kaitlyn', N'Powell', CAST(N'2002-02-09' AS Date), NULL)
,(N'f47f04b0-0da6-4ba5-9036-032a5a17e54b', N'Dominique', N'S Lopez', CAST(N'2002-02-06' AS Date), NULL)
,(N'0745aa8d-527a-4012-be8b-032afb50118c', N'Dustin', N'Xu', CAST(N'2003-12-27' AS Date), NULL)
,(N'db3c8f4c-4930-4e71-bb54-0331206a815d', N'Shane', N'Arun', CAST(N'2004-05-23' AS Date), NULL)
,(N'24e6fa09-f0a4-49c8-be41-03316bb9a979', N'Warren', N'N Raje', CAST(N'2003-03-05' AS Date), NULL)
,(N'9adb0d8b-0a86-45be-a535-0333bbf06b23', N'Victoria', N'H Brooks', CAST(N'2003-11-27' AS Date), NULL)
,(N'28cf03cf-31e0-4559-8a3f-033453be563d', N'Fernando', N'A Rodriguez', CAST(N'2003-12-11' AS Date), NULL)
,(N'4c0dff7b-bfa3-40e5-a262-033b37968294', N'Gabe', N'B Mares', CAST(N'1999-04-02' AS Date), NULL)
,(N'b682ed59-afe6-42f6-8f5f-0341300d71c9', N'Calvin', N'Shan', CAST(N'2002-09-04' AS Date), NULL)
,(N'ef57798e-adbd-48fe-b0ff-0344226e475f', N'Cheryl', N'M Carlson', CAST(N'2004-05-04' AS Date), NULL)
,(N'18cdd0f0-a641-4e2f-bc10-034658d5d9b0', N'Isaac', N'L Scott', CAST(N'2004-07-29' AS Date), NULL)
,(N'9e27e989-8c7a-444f-8a91-034a55ee79fd', N'Fernando', N'Phillips', CAST(N'2004-05-03' AS Date), NULL)
,(N'e079d684-5873-4b37-ba3f-034dd7eddb64', N'Brooke', N'Reed', CAST(N'2004-05-20' AS Date), NULL)
,(N'dba72a41-97c1-4245-9298-0351f925e1b9', N'Cara', N'B Gao', CAST(N'2003-05-04' AS Date), NULL)
INSERT [dbo].[Activistas] ([ID], [Nombre], [Apellidos], [FechaNac], [Organizacion]) VALUES 
(N'b487ed94-5e99-4add-a3d0-03548f144b54', N'Bruce', N'Mehta', CAST(N'2004-06-23' AS Date), NULL)
,(N'45dfb52a-0861-44be-9abe-035568c5c82b', N'Tai', N'Yee', CAST(N'1998-12-26' AS Date), NULL)
,(N'b9ba0c0a-18e8-4c45-8788-0356f4ad7839', N'Adrienne', N'Martin', CAST(N'2003-09-07' AS Date), NULL)
,(N'5de89d56-f5c9-4c93-bad4-0357808f3ade', N'Dustin', N'Raji', CAST(N'2003-11-29' AS Date), NULL)
,(N'42882529-17e6-4e7d-ac0a-0359c4084455', N'Christy', N'Nara', CAST(N'2003-08-11' AS Date), NULL)
,(N'82ebd27e-bd38-49ab-9dd4-035c524029bb', N'Patrick', N'B Blue', CAST(N'2004-07-25' AS Date), NULL)
,(N'25bb3b5a-1fb0-48e8-b80e-035e3c6f83a9', N'Anna', N'M Butler', CAST(N'2004-05-29' AS Date), NULL)
,(N'685d498e-e97c-4f02-9997-03623363f467', N'Gilbert', N'Raje', CAST(N'2001-08-03' AS Date), NULL)
,(N'2458cd85-5bcb-4e63-a200-03623ee8af34', N'Joy', N'A Ruiz', CAST(N'2001-12-28' AS Date), NULL)
,(N'2f62fcf3-7a88-4f7b-bc2c-036254c3907d', N'Walter', N'Ortega', CAST(N'2003-11-08' AS Date), NULL)
,(N'ebcecb5c-5b1a-46d6-94ba-0366d75ef0d8', N'Javier', N'P Ortega', CAST(N'2004-01-29' AS Date), NULL)
,(N'729e8bc4-002d-4e16-9c66-037397de555e', N'Gail', N'Griffin', CAST(N'2002-09-13' AS Date), NULL)
,(N'5e26323f-7c40-40b6-a15b-0373f226ab5c', N'Katherine', N'James', CAST(N'2002-02-06' AS Date), NULL)
,(N'd731a403-fc21-42bb-b806-03775c3a7576', N'Jack', N'S Richins', CAST(N'1999-03-18' AS Date), NULL)
INSERT [dbo].[Activistas] ([ID], [Nombre], [Apellidos], [FechaNac], [Organizacion]) VALUES 
(N'6da17a28-6d02-46c6-9748-0378d01a3270', N'Candace', N'D Patel', CAST(N'2004-01-17' AS Date), NULL)
,(N'28d91186-048e-4a0e-8494-037f3959a82c', N'Samantha', N'Walker', CAST(N'2003-09-23' AS Date), NULL)
,(N'2a55364c-5c24-4a22-882f-038303c18eda', N'Gavin', N'Long', CAST(N'2003-09-28' AS Date), NULL)
,(N'6efa74c5-b914-4eec-a1a5-038ac9627607', N'David', N'P White', CAST(N'2003-12-13' AS Date), NULL)
,(N'5a38621f-784b-4ae9-b43b-038d55795de0', N'Dawn', N'M Nara', CAST(N'2002-09-18' AS Date), NULL)
,(N'bbd65043-f777-4e9a-a705-039b5b94911f', N'Brianna', N'Taylor', CAST(N'2003-08-06' AS Date), NULL)
,(N'0344bb14-3c1a-454e-85f8-03a38363e161', N'Mari', N'B Caldwell', CAST(N'2003-08-01' AS Date), NULL)
,(N'121f6545-5cec-42e9-ad06-03a3f1e349d4', N'Maria', N'D Coleman', CAST(N'2003-05-14' AS Date), NULL)
,(N'dd1a0ae9-75d2-4c00-a061-03a42fadeb1e', N'Judy', N'R Storjohann', CAST(N'2003-09-01' AS Date), NULL)
,(N'cb69c30a-c54b-473b-b59c-03a504b3dfba', N'Ryan', N'S Clark', CAST(N'2004-05-18' AS Date), NULL)
,(N'ac1ae167-0475-4126-b7df-03ad20b13f8f', N'Veronica', N'G Vance', CAST(N'2002-10-12' AS Date), NULL)
,(N'5c29cc2c-59a3-47d9-8a3d-03ba8775d81e', N'Alyssa', N'O Murphy', CAST(N'2004-06-20' AS Date), NULL)
,(N'd18bfa90-b328-4e6f-ac46-03bb5a931a71', N'Naomi', N'K Blanco', CAST(N'2004-03-15' AS Date), NULL)
,(N'd74c9e4d-6439-49fc-8348-03c8f8c28cb7', N'Jeremy', N'Brooks', CAST(N'2003-08-31' AS Date), NULL)
INSERT [dbo].[Activistas] ([ID], [Nombre], [Apellidos], [FechaNac], [Organizacion]) VALUES 
(N'65d48266-8449-4fd8-b678-03c98f00255d', N'Cole', N'M Cox', CAST(N'2004-06-08' AS Date), NULL)
,(N'c8e86bcb-29b3-4839-90a3-03c9bbbc2f57', N'Roberto', N'Tamburello', CAST(N'1997-12-05' AS Date), NULL)
,(N'c3ed9132-cafe-47ac-a9fd-03d0c54c2904', N'Alicia', N'Pal', CAST(N'2004-04-14' AS Date), NULL)
,(N'3e3572d3-881f-4979-9714-03d391a1e763', N'Chloe', N'V Miller', CAST(N'2002-01-24' AS Date), NULL)
,(N'22d3ef06-7b51-4dd0-9dea-03e0412476d7', N'Ramona', N'J Antrim', CAST(N'2003-08-01' AS Date), NULL)
,(N'30c31fea-2d39-4d20-918d-03e208b5352b', N'Miranda', N'Ross', CAST(N'2003-12-05' AS Date), NULL)
,(N'630793c3-79ce-481b-865d-03e46397ed94', N'Tommy', N'Pal', CAST(N'2002-08-28' AS Date), NULL)
,(N'48d246d9-b644-43a5-95b2-03e81bd8cd88', N'Kellie', N'L Serrano', CAST(N'2002-12-31' AS Date), NULL)
,(N'95aa8949-bdbb-4152-add8-03ea09672e8f', N'Pat', N'H Coleman', CAST(N'2000-02-21' AS Date), NULL)
,(N'aeb69835-ff8a-45c8-878c-03ec9a6054c4', N'Ruth', N'Ellerbrock', CAST(N'2000-03-27' AS Date), NULL)
,(N'20fea04a-9888-4d93-a2c4-03ed6679b6e4', N'Justin', N'M Lee', CAST(N'2004-01-16' AS Date), NULL)
,(N'286bc995-3b17-47c4-afbd-03f101ef8840', N'Lucas', N'Baker', CAST(N'2003-10-15' AS Date), NULL)
,(N'9c183f63-2d49-49fd-b209-03f11e4f959f', N'Donna', N'D She', CAST(N'2003-08-06' AS Date), NULL)
,(N'1ee55f03-cd75-4055-b0a4-03f1831f3e01', N'Emmanuel', N'Fernandez', CAST(N'2004-06-30' AS Date), NULL)
,(N'90a4d2f7-d568-4382-ae4c-03f246e786d2', N'Ryan', N'E Chen', CAST(N'2004-02-25' AS Date), NULL)
,(N'1072bd2c-9668-4f79-8e5c-03f44d0d6d0e', N'Dominic', N'F Madan', CAST(N'2004-01-25' AS Date), NULL)
INSERT Activistas (ID, Nombre, Apellidos, FechaNac, Organizacion) VALUES 
(N'3bd259c5-4736-4529-b83b-03f831937651', N'Janet', N'D Romero', CAST(N'2004-04-22' AS Date), NULL)
,(N'9f58b744-8060-43f6-b93a-03fa0218270c', N'Catherine', N'S Howard', CAST(N'2003-09-02' AS Date), NULL)
,(N'a18d140f-2463-4883-ab06-03fa0a201e83', N'Beth', N'Gill', CAST(N'2002-02-12' AS Date), NULL)
,(N'8534d95b-42e2-4c0c-b55e-03fca375f66c', N'Joel', N'Martinez', CAST(N'2004-01-24' AS Date), NULL)
,(N'97352f13-3e25-445e-92fc-0400311901d4', N'Gavin', N'Coleman', CAST(N'2003-08-31' AS Date), NULL)
,(N'b93ac608-3997-4a04-953a-04046677c630', N'Shane', N'R Sai', CAST(N'2004-06-04' AS Date), NULL)
,(N'c76b2ea5-6cbc-4ca8-88b6-04048902d433', N'Frances', N'J Giglio', CAST(N'2002-08-01' AS Date), NULL)
,(N'f1fba0d1-884d-4e7f-9937-0405d4a0fdb8', N'Paula', N'Blanco', CAST(N'2003-11-28' AS Date), NULL)
,(N'1afecde2-d8af-4402-9211-040c9e6d036d', N'Eduardo', N'Walker', CAST(N'2004-07-26' AS Date), NULL)
,(N'13e20826-a90b-49af-b31f-040f3df0066f', N'Omar', N'Deng', CAST(N'2003-11-17' AS Date), NULL)
,(N'fc23c86d-f857-4dd5-aaee-04108eda9c1a', N'Nancy', N'F Kovar', CAST(N'2002-12-17' AS Date), NULL)
,(N'd230df95-745e-4cc7-94e6-0410cde89599', N'Lenore', N'J Yasi', CAST(N'2002-02-17' AS Date), NULL)
,(N'7bac3024-d9a0-4fcf-824b-04127a9f6c46', N'Amanda', N'Rivera', CAST(N'2004-04-20' AS Date), NULL)
,(N'e735bf13-b4db-47c1-b33e-041998d3b990', N'Sydney', N'Hall', CAST(N'2003-10-13' AS Date), NULL)
,(N'82573b37-2bb4-4212-aad0-041cf0937a0f', N'Jeremiah', N'M Taylor', CAST(N'2004-04-25' AS Date), NULL)
GO
INSERT Activistas (ID, Nombre, Apellidos, FechaNac, Organizacion) VALUES 
(N'a640839a-06c9-461a-92ac-0420817dd064', N'Louis', N'Rai', CAST(N'2003-09-01' AS Date), NULL)
,(N'143e8e9e-b169-4024-b067-042283d66b38', N'Caroline', N'Perry', CAST(N'2003-12-14' AS Date), NULL)
,(N'3b71e1b2-a5b0-4757-b672-04266734b493', N'James', N'M Young', CAST(N'2004-05-26' AS Date), NULL)
,(N'c077c3ae-b972-47f0-ace1-0429f43977db', N'Drew', N'el', CAST(N'2001-10-18' AS Date), NULL)
,(N'c054f681-958a-417c-b2ab-042be20ac8df', N'Armando', N'S mez', CAST(N'2004-01-22' AS Date), NULL)
,(N'12673767-c122-47fc-8c76-04342f9c9b07', N'Jason', N'Bryant', CAST(N'2002-10-03' AS Date), NULL)
,(N'90ab7075-4b36-4c02-9921-043907d521f5', N'Dennis', N'K Sun', CAST(N'2003-06-14' AS Date), NULL)
,(N'3cb27638-5f6e-4458-8e5e-04390ef6e6fa', N'Hailey', N'G Morgan', CAST(N'2004-01-30' AS Date), NULL)
,(N'0cf8cf82-2aa7-432a-8ec4-043f4cd2591d', N'Blake', N'Lewis', CAST(N'2003-11-09' AS Date), NULL)
,(N'3deff6e8-26cd-4502-9d6c-044d225dc3f5', N'Autumn', N'I Xu', CAST(N'2003-09-19' AS Date), NULL)
,(N'7be7466a-33a7-4497-94aa-0453d50303d9', N'Taylor', N'Cook', CAST(N'2003-07-19' AS Date), NULL)
,(N'04ea19e8-321a-49a9-b181-045a603e0f1c', N'Evan', N'J Phillips', CAST(N'2002-08-15' AS Date), NULL)
,(N'd0c6f7db-367b-4a26-b668-045f222eb27a', N'Tyler', N'T Martinez', CAST(N'2003-07-23' AS Date), NULL)
,(N'484b42a9-aa26-4c6b-8f47-0460381e9dbb', N'Erica', N'A Liu', CAST(N'2003-11-11' AS Date), NULL)
,(N'f663f9c5-957c-4e44-81da-04641f964849', N'Erik', N'H Jimenez', CAST(N'2003-09-27' AS Date), NULL)
,(N'95979f82-4d36-4e07-8535-04678836cc93', N'Gabriella', N'L Mitchell', CAST(N'2004-05-21' AS Date), NULL)
,(N'9436e7ec-6b84-4ce6-9d5e-046c510c81eb', N'Jacqueline', N'Rivera', CAST(N'2004-06-18' AS Date), NULL)
,(N'8e4e0605-7686-4344-8f23-04745db8d243', N'Kellie', N'Torres', CAST(N'2004-02-18' AS Date), NULL)
INSERT Activistas (ID, Nombre, Apellidos, FechaNac, Organizacion) VALUES 
(N'47048ddd-7af1-4cd5-bea4-0474aaf90f83', N'Frederick', N'J Garcia', CAST(N'2003-09-17' AS Date), NULL)
,(N'c983c42b-3a17-40ae-a63f-047835bad88c', N'Mario', N'J Sharma', CAST(N'2002-05-06' AS Date), NULL)
,(N'e2ff4335-c5ff-488f-861a-047e326c6ddf', N'Kelly', N'M Washington', CAST(N'2004-01-16' AS Date), NULL)
,(N'10444a73-9c02-4da0-ab4b-0483b15fc866', N'Andrew', N'N Rodriguez', CAST(N'2002-04-05' AS Date), NULL)
,(N'5904ae96-8106-4695-ad3c-048620a96060', N'Heather', N'L Lin', CAST(N'2004-03-19' AS Date), NULL)
,(N'52e1cbc0-408e-49a7-802b-0486a7cf503b', N'Robertson', N'Lee', CAST(N'2003-08-01' AS Date), NULL)
,(N'80b543ec-1b41-4a8a-a177-048d0f248afc', N'Jessica', N'M Peterson', CAST(N'2003-08-06' AS Date), NULL)
,(N'da6698cf-0f08-4643-b6a0-048f97053a37', N'Amy', N'Liang', CAST(N'2003-06-21' AS Date), NULL)
,(N'6f43e69b-abf8-43b7-af48-0490559a5d07', N'Norimichi', N'Yonekura', CAST(N'2004-05-19' AS Date), NULL)
,(N'421bcc42-b61d-4f33-8f24-049108f23d32', N'Shawn', N'L Lal', CAST(N'2004-01-10' AS Date), NULL)
,(N'b043ada4-1eec-460c-8254-049416374325', N'Bridget', N'C Nath', CAST(N'2003-04-19' AS Date), NULL)
,(N'0c7c11d2-3bb8-4db3-af3f-04992e825d8c', N'Grant', N'S el', CAST(N'2003-06-20' AS Date), NULL)
,(N'880f448c-f324-4067-afc0-049a224c7d4f', N'Jeffrey', N'Kurtz', CAST(N'2002-09-01' AS Date), NULL)
,(N'94da69b3-7fd3-4c2d-907f-049a42f668f8', N'Tyler', N'Jones', CAST(N'2003-05-15' AS Date), NULL)
,(N'2888d544-611f-4ff3-8d7d-049aacb6f8a3', N'Guy', N'R Gilbert', CAST(N'1996-07-24' AS Date), NULL)
,(N'cfcd412b-d772-45cd-b973-049d73e7acf1', N'Richard', N'Smith', CAST(N'2004-02-04' AS Date), NULL)
,(N'3882e8d9-0eac-4b3a-a826-049f5c91d564', N'Kyle', N'M Foster', CAST(N'2002-03-01' AS Date), NULL)
INSERT Activistas (ID, Nombre, Apellidos, FechaNac, Organizacion) VALUES 
(N'2d95e5f6-a153-4007-ab5b-049fd9474184', N'Caleb', N'C Young', CAST(N'2003-08-26' AS Date), NULL)
,(N'6b151028-4e8f-4585-8f93-04a3dd50d427', N'Taylor', N'M Miller', CAST(N'2004-04-12' AS Date), NULL)
,(N'e743e3eb-cca5-4eee-8898-04a52083341b', N'Deanna', N'Suarez', CAST(N'2004-06-05' AS Date), NULL)
,(N'66ea54e6-b0a2-41de-935a-04a6da129c36', N'Stephanie', N'Cooper', CAST(N'2002-07-05' AS Date), NULL)
,(N'cfcebf20-f9d5-4fac-8531-04a7edc0a275', N'Katelyn', N'I Allen', CAST(N'2001-07-28' AS Date), NULL)
,(N'40c45258-9bd0-4f4f-89ac-04b58670e6af', N'Robert', N'J Perry', CAST(N'2003-12-11' AS Date), NULL)
,(N'619af7e5-840a-4b3e-bf19-04bb1c0051c5', N'Cheryl', N'Suarez', CAST(N'2002-01-15' AS Date), NULL)
,(N'c418974d-ecc0-4030-a57a-04bb3bc18e9e', N'Luis', N'Sharma', CAST(N'2004-07-16' AS Date), NULL)
,(N'd5c792e4-02c7-40b4-93f6-04bd915c5743', N'Monica', N'J Mehta', CAST(N'2001-12-05' AS Date), NULL)
,(N'1dae489e-cf80-421d-86c5-04bfc140e349', N'Bailey', N'Cook', CAST(N'2003-11-01' AS Date), NULL)
,(N'3ff644ec-6510-43e2-8e33-04bfc9023141', N'Shawna', N'A Tang', CAST(N'2003-11-17' AS Date), NULL)
,(N'7dcf70dc-bbe0-495e-b705-04c5115a63d5', N'K.', N'Saravan', CAST(N'2003-10-02' AS Date), NULL)
,(N'6638a785-7c1d-4cd2-8b2c-04c5794c7dd6', N'Amber', N'Parker', CAST(N'2003-08-28' AS Date), NULL)
,(N'177bff68-d5aa-4d5e-bec0-04c5cea99c98', N'James', N'L Sharma', CAST(N'2004-01-17' AS Date), NULL)
,(N'7750914d-d3be-4d1b-b1be-04c70225b3ee', N'Bridget', N'el', CAST(N'2002-08-04' AS Date), NULL)
,(N'09a2f467-2201-4995-a239-04cbc531cbf6', N'Nichole', N'Black', CAST(N'2004-03-21' AS Date), NULL)
INSERT Activistas (ID, Nombre, Apellidos, FechaNac, Organizacion) VALUES 
(N'b1843504-8ad0-4cd0-88aa-04cce6dec02a', N'Alexandra', N'K Campbell', CAST(N'2004-05-31' AS Date), NULL)
,(N'72673aef-44e1-43f3-b2d8-04cd08141383', N'Corey', N'E Anand', CAST(N'2003-01-24' AS Date), NULL)
,(N'385eea37-1adb-4986-9de7-04cec53ed54c', N'James', N'Anderson', CAST(N'2003-04-15' AS Date), NULL)
,(N'34916003-ade6-4f7a-9060-04cf8611777f', N'Sariya', N'E Harnpadoungsataya', CAST(N'1999-01-06' AS Date), NULL)
,(N'b0cd4251-a473-4369-8f79-04d03eac0b16', N'Dawn', N'L Beck', CAST(N'2004-05-01' AS Date), NULL)
,(N'6774ceda-a820-47cb-b174-04d0f976ee43', N'Cassie', N'Nath', CAST(N'2002-07-24' AS Date), NULL)
,(N'96ce29a1-b57e-42c8-b9d3-04d5c5356240', N'Dawn', N'W Kumar', CAST(N'2003-09-04' AS Date), NULL)
,(N'f35552f4-9b30-4e55-81a0-04d8ee419a2e', N'Melanie', N'B Russell', CAST(N'2003-08-03' AS Date), NULL)
,(N'46c05bd0-658a-4324-b579-04e09ff8f098', N'Susan', N'Zhou', CAST(N'2003-03-12' AS Date), NULL)
,(N'397a04bd-11c9-4a16-8847-04e30eb0dfe2', N'Brenda', N'D Suri', CAST(N'2003-08-26' AS Date), NULL)
,(N'ea2242d0-b051-4036-83dd-04ed83baf8a5', N'Miguel', N'Bryant', CAST(N'2004-02-24' AS Date), NULL)
,(N'4843eaf5-84c0-4341-b490-04f44f8796b1', N'Clarence', N'M Li', CAST(N'2003-11-17' AS Date), NULL)
,(N'62515198-663c-4518-8a73-04fe5b91c6f3', N'Kelvin', N'Tang', CAST(N'2002-09-04' AS Date), NULL)
,(N'689e5ce1-c76d-41ad-a377-050093f790f7', N'Kevin', N'F Browne', CAST(N'2001-09-01' AS Date), NULL)
,(N'36809cc7-61ae-47d9-892c-050122666955', N'Luis', N'Hayes', CAST(N'2003-11-14' AS Date), NULL)
,(N'd09e5446-abb1-49a5-af19-0506ac1eb545', N'Grace', N'Smith', CAST(N'2004-07-07' AS Date), NULL)
,(N'2fcb3a4f-3481-4bef-b965-0507f66f3962', N'Gabriella', N'Allen', CAST(N'2004-06-08' AS Date), NULL)
GO
INSERT Activistas (ID, Nombre, Apellidos, FechaNac, Organizacion) VALUES 
(N'2d752e02-a69a-439a-8a8d-0509403ef044', N'Maurice', N'Pal', CAST(N'2004-02-27' AS Date), NULL)
,(N'93ac201b-988d-4fea-858a-050e8c0e2fab', N'Nathan', N'Williams', CAST(N'2004-06-27' AS Date), NULL)
,(N'9f87ffb8-e6f6-40e5-bd16-05181d6de23b', N'Gabrielle', N'B Henderson', CAST(N'2003-10-06' AS Date), NULL)
,(N'b3d4917c-dcef-4b48-b419-051a3ebfc8ca', N'Lacey', N'Ye', CAST(N'2004-02-28' AS Date), NULL)
,(N'616c8be0-a1e2-4984-9e14-05272a928679', N'Monica', N'H Chandra', CAST(N'2003-09-09' AS Date), NULL)
,(N'693371df-1f9f-415d-88ad-05281901e3e7', N'Shawna', N'P Anand', CAST(N'2003-10-10' AS Date), NULL)
,(N'bb9df90e-8101-4283-8ece-05297d3f790b', N'Cassidy', N'Diaz', CAST(N'2003-12-30' AS Date), NULL)
,(N'b2c54186-cea9-45fa-b6f8-0529903e1b6e', N'Hannah', N'L Coleman', CAST(N'2004-03-19' AS Date), NULL)
,(N'7e8fbe00-c85b-4b33-afba-052a47c1c70e', N'Dakota', N'L Bryant', CAST(N'2004-03-28' AS Date), NULL)
,(N'f2ba3fc9-a44b-4f5e-a80e-052b83497a01', N'Valerie', N'Liang', CAST(N'2004-05-28' AS Date), NULL)
,(N'8a4ee797-6475-43d4-b8d4-0534e0506c23', N'Kaitlyn', N'Long', CAST(N'2002-04-30' AS Date), NULL)
,(N'a9ff62d2-1326-4837-bec2-0536a4aae3e0', N'Renee', N'E Romero', CAST(N'2001-08-07' AS Date), NULL)
,(N'c7b23e23-e333-45fd-aaf6-0536fcc0192b', N'Charles', N'Hall', CAST(N'2004-01-30' AS Date), NULL)
,(N'b5cc2f4b-02dc-44e0-a684-053725236bc0', N'Sharon', N'Nara', CAST(N'2001-12-22' AS Date), NULL)
,(N'46a01589-7896-413c-b7ee-053be4a73b3b', N'Jenny', N'Nath', CAST(N'2003-05-29' AS Date), NULL)
,(N'ff376a04-95c7-4591-8d7a-053c0c165f78', N'Michelle', N'R Sanchez', CAST(N'2002-12-17' AS Date), NULL)
,(N'9615755d-55a6-4814-b506-053c29ad9f84', N'Bradley', N'Lal', CAST(N'2002-12-20' AS Date), NULL)
INSERT Activistas (ID, Nombre, Apellidos, FechaNac, Organizacion) VALUES 
(N'01df7bbb-6334-423c-afd7-053d844482be', N'Andrew', N'B Taylor', CAST(N'2003-09-24' AS Date), NULL)
,(N'9db37c5d-dfda-4a53-b2d4-0547005c9986', N'Angelica', N'M Wood', CAST(N'2003-12-20' AS Date), NULL)
,(N'25ce51f5-1bd1-4ef0-804b-0547f6f27f42', N'Jodi', N'Deng', CAST(N'2003-06-18' AS Date), NULL)
,(N'd3239205-a9bb-464c-ab1f-054b77688987', N'Leslie', N'T Serrano', CAST(N'2003-11-21' AS Date), NULL)
,(N'1ffcd940-350c-47ee-8c84-05516af1737b', N'Nathan', N'Phillips', CAST(N'2004-04-24' AS Date), NULL)
,(N'a196dfdc-68a9-4642-bf39-055359c71d99', N'Tim', N'O''Brien', CAST(N'2002-03-21' AS Date), NULL)
,(N'7a2118d4-c3d5-4fa6-9453-055716301b31', N'Kaitlyn', N'Simmons', CAST(N'2001-12-07' AS Date), NULL)
,(N'880ab7c3-c6e4-4142-b989-055a32cb63b1', N'Mario', N'J Andersen', CAST(N'2003-07-22' AS Date), NULL)
,(N'ad4779ba-d453-4f3f-8428-056091e6bf9c', N'Abigail', N'Howard', CAST(N'2002-05-01' AS Date), NULL)
,(N'f9e99d8d-fcea-4c99-bbe3-0560af1c89e8', N'Jorge', N'Zheng', CAST(N'2004-05-16' AS Date), NULL)
,(N'c1adc59f-65e2-4728-a901-05625842bd10', N'Kelli', N'L Xu', CAST(N'2003-09-03' AS Date), NULL)
,(N'e6b860d4-5678-4e52-989d-056848d17672', N'Susan', N'E Yang', CAST(N'2004-04-17' AS Date), NULL)
,(N'8cdba4e9-32bd-42e7-8fd2-05687ffce0dd', N'Mindy', N'A Raje', CAST(N'2003-12-20' AS Date), NULL)
,(N'9251815c-18e4-442a-ae5c-056b1cb269e5', N'Joseph', N'E Davis', CAST(N'2003-12-23' AS Date), NULL)
,(N'8c63d8e6-f126-4a95-b58b-056df73d6bf5', N'Michele', N'L Yuan', CAST(N'2004-07-18' AS Date), NULL)
,(N'9f42757f-46ad-4b08-a558-0570a190b18b', N'Karen', N'L Gao', CAST(N'2004-07-05' AS Date), NULL)
,(N'4b5b4799-071c-4f42-874a-0575acbbc078', N'Ricardo', N'K Kumar', CAST(N'2003-02-12' AS Date), NULL)
INSERT Activistas (ID, Nombre, Apellidos, FechaNac, Organizacion) VALUES 
(N'4925f7c9-cd3b-44e7-90e6-0576ef2cb25a', N'Summer', N'Suri', CAST(N'2003-11-18' AS Date), NULL)
,(N'c3bdf02f-581f-4f1a-9f91-05775d1967d7', N'Danny', N'Rubio', CAST(N'2003-10-06' AS Date), NULL)
,(N'91ebdeb2-0ff5-457e-9352-057948707519', N'Lucas', N'A Reed', CAST(N'2004-04-28' AS Date), NULL)
,(N'59f84d65-76b1-426e-a77f-057bd0848dc6', N'Darren', N'Rubio', CAST(N'2003-06-19' AS Date), NULL)
,(N'91ef0d38-687c-43a2-b486-058085860b92', N'Rafael', N'I She', CAST(N'2002-04-15' AS Date), NULL)
,(N'1f600424-5be5-4eac-a88e-0582e8685673', N'Fernando', N'G Nelson', CAST(N'2001-11-15' AS Date), NULL)
,(N'eb4e921a-a0c9-4c71-8ecc-058532fa9525', N'Paula', N'L Alonso', CAST(N'2004-05-18' AS Date), NULL)
,(N'37b84cb3-b83e-4daa-9807-05869a582d76', N'Jessie', N'R Xu', CAST(N'2004-01-31' AS Date), NULL)
,(N'312f2bf9-d7bc-453e-9c72-0586a6214720', N'Katelyn', N'C Bailey', CAST(N'2001-11-24' AS Date), NULL)
,(N'438657f5-5e77-463e-9d01-0589647c1e7b', N'Susan', N'Gao', CAST(N'2003-06-21' AS Date), NULL)
,(N'76d12e1e-d1e3-4e19-a29f-058b484206b3', N'Jim', N'Stewart', CAST(N'2002-09-01' AS Date), NULL)
,(N'dcd849c8-2ea4-4a89-9a58-058d7b81f935', N'Natalie', N'V Coleman', CAST(N'2003-12-10' AS Date), NULL)
,(N'6cba786b-e04d-40af-bfef-05900b88d98a', N'Elizabeth', N'A Thomas', CAST(N'2004-04-08' AS Date), NULL)
,(N'f29894cb-7568-49ac-84d6-0590135a2e8b', N'Gilbert', N'J Jai', CAST(N'2004-07-03' AS Date), NULL)
,(N'e6c35ec7-cff7-42dd-8662-059430ff1e13', N'Desiree', N'A Ortega', CAST(N'2002-11-06' AS Date), NULL)
,(N'c562f703-823b-427e-a46a-0594329e14be', N'Mary', N'Baker', CAST(N'2003-11-02' AS Date), NULL)
,(N'202e99ea-e1ff-4f8a-a402-0595afe20a6e', N'Yvonne', N'Schleger', CAST(N'2002-07-17' AS Date), NULL)
INSERT Activistas (ID, Nombre, Apellidos, FechaNac, Organizacion) VALUES 
(N'b49466a6-7f8b-4a57-8207-059629ee3819', N'Eduardo', N'A Peterson', CAST(N'2003-12-26' AS Date), NULL)
,(N'412738fd-7522-46a2-8087-059dfb40af56', N'Tasha', N'W Ashe', CAST(N'2003-12-14' AS Date), NULL)
,(N'8926bc2c-e75b-4e3e-8763-059f9e058762', N'David', N'Washington', CAST(N'2001-12-21' AS Date), NULL)
,(N'1176091b-74b9-40b8-a182-05a1600ab171', N'Abigail', N'H Wood', CAST(N'2004-06-28' AS Date), NULL)
,(N'a0cd080c-f985-4f1b-b88e-05a17970e36b', N'Virginia', N'Mehta', CAST(N'2001-08-08' AS Date), NULL)
,(N'a32bca9e-5e61-4930-a95f-05a2ce17b102', N'Carlos', N'J Evans', CAST(N'2003-02-23' AS Date), NULL)
,(N'2e77af65-8366-4b95-bf9e-05ac891944e1', N'Gabriella', N'Cook', CAST(N'2004-07-19' AS Date), NULL)
,(N'73cfe2aa-88d0-4cab-8bef-05b29017779d', N'Damien', N'S Raje', CAST(N'2004-03-07' AS Date), NULL)
,(N'f3de0aa1-2fb1-4a55-ab0f-05b364f57b4e', N'Raymond', N'Fernandez', CAST(N'2004-05-02' AS Date), NULL)
,(N'acb12539-d5ea-4a51-a617-05b3b54a71fa', N'Brad', N'Tang', CAST(N'2004-06-28' AS Date), NULL)
,(N'c52a2fa2-fe8a-42a6-8d64-05b3cb7c0718', N'Arturo', N'M Zhu', CAST(N'2004-06-11' AS Date), NULL)
,(N'90a6e955-1c92-4fae-ac96-05b7b619af8e', N'Victoria', N'C Alexander', CAST(N'2003-11-10' AS Date), NULL)
,(N'a2e0fdcc-7bee-4291-996f-05b9120a948a', N'Jason', N'D Green', CAST(N'2003-09-28' AS Date), NULL)
,(N'b205ed96-86db-456f-8422-05bb2aea43c7', N'Douglas', N'M Arun', CAST(N'2004-04-25' AS Date), NULL)
,(N'922e425b-e92c-46ec-8af2-05bca1af9b11', N'Megan', N'C Coleman', CAST(N'2003-09-07' AS Date), NULL)
,(N'cf5ab30c-c654-4542-982d-05bda53c8045', N'Kelvin', N'Alan', CAST(N'2003-09-14' AS Date), NULL)
,(N'c81d99f3-0c87-4455-8c36-05bedb0de4c0', N'Jeffery', N'B Lu', CAST(N'2002-04-30' AS Date), NULL)
INSERT Activistas (ID, Nombre, Apellidos, FechaNac, Organizacion) VALUES 
(N'9369b8de-5d2c-4721-af8e-05c070d97254', N'Amber', N'B Scott', CAST(N'2004-07-15' AS Date), NULL)
,(N'3c8e54d4-a502-43bd-9d5f-05c08bfb4502', N'Aaron', N'Edwards', CAST(N'2003-12-04' AS Date), NULL)
,(N'c008cb9c-a997-4f81-9504-05c52c3a1da4', N'Seth', N'E Evans', CAST(N'2001-12-12' AS Date), NULL)
,(N'eabf0328-d591-437d-b0e7-05c6a975ca95', N'Arif', N'A Rizaldy', CAST(N'2004-06-23' AS Date), NULL)
,(N'7ec28e65-0cf3-4e01-b633-05c953595518', N'Allen', N'L Rodriguez', CAST(N'2001-10-08' AS Date), NULL)
,(N'8716653d-314b-4367-a49e-05ccbc53cac2', N'Damien', N'M Liang', CAST(N'2003-09-12' AS Date), NULL)
,(N'f0f7252f-e208-4b89-8e05-05cccc4611a9', N'Morgan', N'B Rogers', CAST(N'2003-12-01' AS Date), NULL)
,(N'176b2310-9596-40e7-8d92-05cfbd8a762e', N'Katie', N'Pal', CAST(N'2004-05-14' AS Date), NULL)
,(N'0d420a91-0850-4858-88fd-05d06970be6a', N'Mathew', N'A Carlson', CAST(N'2004-03-10' AS Date), NULL)
,(N'f9ddef09-b599-4d7f-97b1-05d66c5559da', N'Pamela', N'O Ansman-Wolfe', CAST(N'2001-06-24' AS Date), NULL)
,(N'c482fe48-6b7f-4a3f-b446-05d8c9fb6150', N'Maria', N'E Bryant', CAST(N'2004-02-24' AS Date), NULL)
,(N'2770ec1e-8c1b-4772-802e-05dab62a9435', N'Raquel', N'A Dominguez', CAST(N'2003-06-22' AS Date), NULL)
,(N'882f5273-b0e4-4fa0-a3ef-05dbd4892376', N'Isaiah', N'Ramirez', CAST(N'2002-03-01' AS Date), NULL)
,(N'99e7c756-9782-45cb-80ba-05ddb93b3259', N'Dana', N'D Ramos', CAST(N'2002-04-10' AS Date), NULL)
,(N'809a0785-5eac-43ed-9dd8-05e04aff3730', N'Seth', N'Flores', CAST(N'2003-11-27' AS Date), NULL)
INSERT Activistas (ID, Nombre, Apellidos, FechaNac, Organizacion) VALUES 
(N'a9723bba-6644-45fb-8550-05ea8a1a3210', N'Hailey', N'Reed', CAST(N'2004-05-28' AS Date), NULL)
,(N'4dce7adb-77de-45a1-941d-05f3f5351766', N'Justin', N'W Brown', CAST(N'2002-02-25' AS Date), NULL)
,(N'4ef7cba3-6653-4121-8454-05f53a366c31', N'Abigail', N'L Peterson', CAST(N'2004-05-19' AS Date), NULL)
,(N'0059ab36-27b9-41da-8ee3-05f9095485b0', N'Brian', N'E Cox', CAST(N'2003-05-06' AS Date), NULL)
,(N'5a14275b-a103-40c1-8f35-05f93f5a8c47', N'Tina', N'L Arthur', CAST(N'2003-09-13' AS Date), NULL)
,(N'c4cb4c7b-4037-4caf-8da0-05fa81e5dab6', N'Amber', N'Green', CAST(N'2001-12-08' AS Date), NULL)
,(N'613f8b49-1b33-4e26-be2d-0600ab1c3b45', N'Zoe', N'Rivera', CAST(N'2003-12-28' AS Date), NULL)
,(N'5d93900e-1ead-4690-851b-06031f0e54a0', N'Louis', N'el', CAST(N'2004-01-22' AS Date), NULL)
,(N'1c29ae08-c11b-4ca8-839a-0605c2a528ce', N'Jason', N'M Simmons', CAST(N'2004-04-04' AS Date), NULL)
,(N'7c0478f4-cf64-48bc-a34a-0608b9338914', N'Adam', N'R Parker', CAST(N'2004-04-06' AS Date), NULL)
,(N'e0ae97ef-d2b6-47cc-980c-060cef8f020d', N'Makayla', N'W Torres', CAST(N'2004-03-13' AS Date), NULL)
,(N'b846dcad-283a-4f4a-87b9-060e09ad7285', N'Ernest', N'Wang', CAST(N'2004-05-05' AS Date), NULL)
,(N'bc482d3a-5a36-4d5f-b614-06154be64dec', N'Evelina', N'Desconchon', CAST(N'1991-05-05' AS Date), NULL)
,(N'd764bbd6-0bde-4990-9a9c-06177eb99fb1', N'Arturo', N'Yang', CAST(N'2004-01-23' AS Date), NULL)
,(N'e62995c6-6a63-4417-8a64-061bd0fe0b05', N'Lindsay', N'A el', CAST(N'2004-05-04' AS Date), NULL)
,(N'62462686-a8d2-4aa7-9263-061e26196ba7', N'Taylor', N'Watson', CAST(N'2001-09-23' AS Date), NULL)
,(N'a35fb8a6-ecf1-4841-912a-061f56a6f67d', N'Marcus', N'Morris', CAST(N'2003-05-26' AS Date), NULL)
INSERT Activistas (ID, Nombre, Apellidos, FechaNac, Organizacion) VALUES 
(N'f9270370-2456-4a66-b40e-061fc66b6219', N'George', N'L Kapoor', CAST(N'2003-09-28' AS Date), NULL)
,(N'b93dec7c-49ed-4189-9712-0620e0d4f146', N'Jenna', N'M Lopez', CAST(N'2002-01-03' AS Date), NULL)
,(N'2f0736ec-8143-4269-89da-0622f375cb22', N'Sergio', N'A Chandra', CAST(N'2004-03-15' AS Date), NULL)
,(N'bae8953e-9036-41f3-8aaf-06259b8e3571', N'Aimee', N'Wu', CAST(N'2004-03-15' AS Date), NULL)
,(N'7ad21add-25f0-48a6-a14c-062896569018', N'Ashley', N'J Barnes', CAST(N'2002-01-22' AS Date), NULL)
,(N'd6d06c1f-020d-4ddc-a26b-062a4b9c8c80', N'Timothy', N'Sneath', CAST(N'2004-05-16' AS Date), NULL)
,(N'98e874eb-3d60-465f-af7e-062d4ad0fb05', N'Jada', N'W Bailey', CAST(N'2004-02-02' AS Date), NULL)
,(N'7db93c39-5c40-4eff-84b2-062d4cf29500', N'Caroline', N'Alexander', CAST(N'2004-05-19' AS Date), NULL)
,(N'2fdd0b57-5884-4ee8-93f2-062f1960f0ca', N'Lawrence', N'Torres', CAST(N'2003-09-01' AS Date), NULL)
,(N'1312eb5b-cd5a-43ea-aecb-062f4287a9f1', N'Joe', N'Rubio', CAST(N'2003-12-16' AS Date), NULL)
,(N'30a8b4ba-0747-46a1-baa1-0630109a4100', N'Mayra', N'J Kovar', CAST(N'2001-09-15' AS Date), NULL)
,(N'4180af75-98dc-4dac-89a4-0633719ac070', N'Benjamin', N'Anderson', CAST(N'2004-02-28' AS Date), NULL)
,(N'0840c193-206a-416b-8926-063dce1fed96', N'Marcus', N'L Bailey', CAST(N'2003-08-03' AS Date), NULL)
,(N'2c3e4fd1-39d4-4d89-b27b-063efeafc446', N'Noah', N'Yang', CAST(N'2002-12-10' AS Date), NULL)
,(N'2a8bd620-d8f6-4e94-9108-063ffbd680e0', N'Lydia', N'Suri', CAST(N'2002-12-09' AS Date), NULL)
,(N'343b6ad3-5a39-4bb4-b76a-0641ea19b763', N'Isaiah', N'Sanchez', CAST(N'2002-07-02' AS Date), NULL)
INSERT Activistas (ID, Nombre, Apellidos, FechaNac, Organizacion) VALUES 
(N'ee1acd6f-be49-4dbb-80d2-064298db50b8', N'Randall', N'A Ruiz', CAST(N'2003-12-07' AS Date), NULL)
,(N'effcc09c-ac8f-4b76-8c30-0648efbe7f1a', N'Christy', N'D Gao', CAST(N'2002-10-12' AS Date), NULL)
,(N'19ee54ca-ff01-43aa-8cdb-064918a31e1e', N'Christina', N'K Rivera', CAST(N'2004-07-05' AS Date), NULL)
,(N'1e381454-dd1b-4de0-907f-0653e93e0db2', N'Alicia', N'Lal', CAST(N'2003-06-28' AS Date), NULL)
,(N'13ed5791-12ca-4d21-b76d-0654c95c6e68', N'Joe', N'A Prasad', CAST(N'2003-11-01' AS Date), NULL)
,(N'25d95183-6802-45a5-9fc7-065eb92e7166', N'Andrea', N'D Hernandez', CAST(N'2003-08-04' AS Date), NULL)
,(N'c6122c05-2b24-4901-927c-06615cf019ba', N'Martin', N'Rienstra', CAST(N'2004-03-23' AS Date), NULL)
,(N'd0efc65f-046b-4d22-8d12-066c0fbc2931', N'Xavier', N'K King', CAST(N'2004-04-23' AS Date), NULL)
,(N'c82e82a1-fea6-41b3-8798-066f642a6657', N'Diane', N'P Hernandez', CAST(N'2003-05-23' AS Date), NULL)
,(N'a4c0e8b2-77f3-49c9-b5c5-067beddff2d7', N'Steven', N'L Stewart', CAST(N'2004-02-05' AS Date), NULL)
,(N'cdb261b8-339b-49fa-80f2-067df97b8817', N'Latasha', N'C Gutierrez', CAST(N'2003-04-05' AS Date), NULL)
,(N'7887a77f-782d-41be-b7fe-068a78cbf6d1', N'Emma', N'A Anderson', CAST(N'2003-10-15' AS Date), NULL)
,(N'ce920993-59fb-4f73-ac7d-068ac2f5867f', N'Janelle', N'Suri', CAST(N'2003-09-29' AS Date), NULL)
,(N'c4f7d936-f2ad-4503-a742-068ca37c9b0a', N'Christian', N'D Chen', CAST(N'2003-11-28' AS Date), NULL)
,(N'cdb85848-9125-4fed-8a1a-068e68362034', N'Lauren', N'M Barnes', CAST(N'2002-12-23' AS Date), NULL)
,(N'1239d582-1d30-46cc-969e-068f1c4acd38', N'Anna', N'E Sanders', CAST(N'2004-06-27' AS Date), NULL)
,(N'10c22ef2-a5d3-4e78-a452-06950d12c4b5', N'Ryan', N'G Jackson', CAST(N'2003-11-21' AS Date), NULL)
,(N'0b78560d-aa35-41e0-b6b9-06958e826ed7', N'Victor', N'M Muñoz', CAST(N'2004-02-23' AS Date), NULL)
INSERT Activistas (ID, Nombre, Apellidos, FechaNac, Organizacion) VALUES 
(N'9bbbbecc-7784-4b7c-832d-0698d58c6195', N'Micheal', N'Travers', CAST(N'2004-05-11' AS Date), NULL)
,(N'3723e20d-2fdc-4538-a49c-0699bc8c5f20', N'Jerry', N'Deng', CAST(N'2004-04-29' AS Date), NULL)
,(N'962b8f8b-fa78-4f4c-bfb9-069f6940efd5', N'Kelly', N'E Perry', CAST(N'2004-03-12' AS Date), NULL)
,(N'25a046f2-9d36-4f39-b500-06a47faae7d8', N'Christy', N'Ye', CAST(N'2003-02-16' AS Date), NULL)
,(N'31738606-fa8a-4547-8716-06aa7f9488b7', N'Cheryl', N'Jiménez', CAST(N'2003-03-28' AS Date), NULL)
,(N'3f1b7bbf-57b1-44fd-bdf8-06ac55dd34cd', N'Emma', N'S Butler', CAST(N'2004-01-04' AS Date), NULL)
,(N'1e507d84-9cc9-4447-9458-06af1f9cc58b', N'Kelsey', N'K Nath', CAST(N'2002-08-15' AS Date), NULL)
,(N'3e19cbc4-9aca-4e9e-94ff-06afd3f9eff9', N'Rachel', N'S Martin', CAST(N'2002-08-15' AS Date), NULL)
,(N'93bbe94f-5da7-4513-a71e-06b327ee4ae6', N'Ernest', N'Gao', CAST(N'2003-09-24' AS Date), NULL)
,(N'c762426e-9e92-4bb6-bbc5-06b54f4dc894', N'Alfredo', N'Romero', CAST(N'2003-09-04' AS Date), NULL)
,(N'8dd96fb3-ae02-475e-acc0-06c11d596c39', N'Pilar', N'G Ackerman', CAST(N'1999-01-27' AS Date), NULL)
,(N'10bdec0c-ba59-4d4c-a847-06c70a5312fd', N'Jesse', N'Scott', CAST(N'2003-05-08' AS Date), NULL)
,(N'f82cead1-7730-4684-8c2e-06c89e01db76', N'Alexandra', N'J Adams', CAST(N'2002-01-03' AS Date), NULL)
,(N'51f019ed-e42e-491e-9fcd-06c9e95a706d', N'Haley', N'T Allen', CAST(N'2003-08-24' AS Date), NULL)
,(N'5ff36104-35e6-4a34-9d27-06ccda10d3b8', N'Rachel', N'Bryant', CAST(N'2003-08-31' AS Date), NULL)
,(N'31b0c312-2a86-414f-a804-06d896610bbf', N'Xavier', N'M Garcia', CAST(N'2004-03-28' AS Date), NULL)
,(N'5c05d00f-ea4c-4283-8d1b-06dd865ccbff', N'Logan', N'A Carter', CAST(N'2003-03-07' AS Date), NULL)
,(N'39924b39-f77f-4749-9d4e-06e325ae6fad', N'Grant', N'D Xie', CAST(N'2003-03-18' AS Date), NULL)
INSERT Activistas (ID, Nombre, Apellidos, FechaNac, Organizacion) VALUES 
(N'16845735-d7f7-4117-9e40-06e3fa37fa3d', N'Sheila', N'Munoz', CAST(N'2003-06-03' AS Date), NULL)
,(N'26857d9b-1c69-4d46-b07a-06e6f6499990', N'Alyssa', N'A Richardson', CAST(N'2004-04-28' AS Date), NULL)
,(N'7161a737-47ff-429b-95ea-06e992e7dc2d', N'Kaitlyn', N'Flores', CAST(N'2004-07-01' AS Date), NULL)
,(N'3375b14c-503d-44cb-a8a5-06e9d3c7396c', N'Raul', N'el', CAST(N'2004-04-15' AS Date), NULL)
,(N'15b3b086-efea-47f7-b520-06ea35379cc6', N'Jerry', N'C Sharma', CAST(N'2003-01-07' AS Date), NULL)
,(N'1c0bddb7-ccec-4def-8bda-06ebdc8f82d3', N'Mallory', N'Munoz', CAST(N'2002-09-14' AS Date), NULL)
,(N'07f04a45-6ac3-44e7-8048-06f90423ec13', N'Rosa', N'Zeng', CAST(N'2003-10-25' AS Date), NULL)
,(N'd2df0763-03e7-4c4a-b8b6-06fac7735436', N'Todd', N'Ma', CAST(N'2004-03-22' AS Date), NULL)
,(N'd1665bc2-3947-42f5-87b0-06fbcc522ee0', N'Nicholas', N'D Rodriguez', CAST(N'2003-08-08' AS Date), NULL)
,(N'ad988bad-6fa3-4e57-90cf-06fdb797cc17', N'Sabrina', N'L Moreno', CAST(N'2003-09-16' AS Date), NULL)
,(N'b44709d2-6749-45e3-943e-07009e399fda', N'Ed', N'Meadows', CAST(N'1999-01-19' AS Date), NULL)
,(N'7f9d5a25-02a8-47f5-8458-0703596fd935', N'José', N'S Miller', CAST(N'2003-04-24' AS Date), NULL)
,(N'5d21c1f9-d686-4484-a273-070392539cec', N'Tabitha', N'Serrano', CAST(N'2003-08-19' AS Date), NULL)
,(N'8357f65f-5241-4d51-9990-07064a0ab0e1', N'Rebekah', N'L Sara', CAST(N'2003-04-30' AS Date), NULL)
,(N'f18900e3-9bdb-49eb-b9b8-07082661fc0d', N'Aimee', N'She', CAST(N'2002-04-18' AS Date), NULL)
,(N'189558c4-fe8c-4808-aaba-07087afc4cc7', N'Courtney', N'nzalez', CAST(N'2004-05-16' AS Date), NULL)
,(N'd99b876f-09d9-4100-9fa3-0709c8b319e9', N'Marcus', N'H Diaz', CAST(N'2002-10-05' AS Date), NULL)
,(N'929b76e8-fc2a-4db3-bb7b-070aeba4f4f5', N'Brandy', N'I Kapoor', CAST(N'2003-09-30' AS Date), NULL)
,(N'f15acbc8-fe7d-47b9-b793-070c8b09c8a6', N'Noah', N'K Edwards', CAST(N'2004-01-11' AS Date), NULL)
GO
INSERT Activistas (ID, Nombre, Apellidos, FechaNac, Organizacion) VALUES 
(N'f5bea5a6-85cc-4f97-8062-070f838d79bc', N'Francis', N'D Ruiz', CAST(N'2004-05-16' AS Date), NULL)
,(N'10189de4-54c5-4ff6-89b5-071072e9ae4a', N'Damien', N'Tang', CAST(N'2004-07-15' AS Date), NULL)
,(N'8378f691-a244-48c4-947b-0710fbe7ab97', N'Alex', N'M Morgan', CAST(N'2003-10-12' AS Date), NULL)
,(N'6215e0b1-9c5e-44c0-a1e3-0711cf9c49c2', N'Gloria', N'G Serrano', CAST(N'2002-08-07' AS Date), NULL)
,(N'4dcaf3d5-c816-43a6-b80d-0711d6ef9103', N'Melardo', N'Pino', CAST(N'2001-01-08' AS Date), NULL)
,(N'dd980318-a25c-42e3-93c5-071bf9d01e3f', N'Natalie', N'J Bailey', CAST(N'2003-08-03' AS Date), NULL)
,(N'165b84cc-f822-457f-a8a5-071f0e4e16c6', N'Mariah', N'Simmons', CAST(N'2001-11-04' AS Date), NULL)
,(N'c472242e-76b9-42e7-b7a4-0723faa391b2', N'Casey', N'Browning', CAST(N'2003-09-26' AS Date), NULL)
,(N'd0b64e4a-a983-4c3b-8838-0724111b472b', N'Olivia', N'Griffin', CAST(N'2003-10-30' AS Date), NULL)
,(N'438dde5b-be09-4537-88ff-07299dd97400', N'Jessie', N'E Vazquez', CAST(N'2002-09-19' AS Date), NULL)
,(N'f2857881-a4ae-4eb3-94bd-072c9055e859', N'Margaret', N'M Zeng', CAST(N'2004-04-23' AS Date), NULL)
,(N'4a3ef51a-f2b3-4cfe-9e15-072d50af43fb', N'Brad', N'S Andersen', CAST(N'2004-01-24' AS Date), NULL)
,(N'3f655b3e-287e-4cae-b819-0731bd533dc5', N'Patricia', N'Doyle', CAST(N'2002-11-01' AS Date), NULL)
,(N'22284055-fac0-40a0-b890-0731d9b7a27d', N'Dale', N'K Chande', CAST(N'2001-09-03' AS Date), NULL)
,(N'043e1e3f-a254-444f-89de-07334101938f', N'Lori', N'Oviatt', CAST(N'2001-05-26' AS Date), NULL)
,(N'34291db7-27af-4ce7-8f54-0735810e7220', N'Alexandria', N'Diaz', CAST(N'2003-10-08' AS Date), NULL)
,(N'3ef568eb-ed00-4264-9bf0-073e4dbe55d8', N'Raymond', N'K Sam', CAST(N'1999-01-17' AS Date), NULL)
,(N'4d05946b-3f9f-4f38-9bf2-07419e7c28cf', N'Benjamin', N'H Sharma', CAST(N'2004-06-18' AS Date), NULL)
,(N'5b5b3b25-baca-4eda-90d3-0742d2cd877d', N'Jonathan', N'Carter', CAST(N'2003-12-30' AS Date), NULL)
,(N'065a38f1-7561-4942-a367-0743d20cc659', N'Rafael', N'N Xu', CAST(N'2002-07-16' AS Date), NULL)
,(N'8b0194f8-37be-48f2-ba67-0746c5c51e94', N'Jennifer', N'Wright', CAST(N'2003-08-08' AS Date), NULL)
,(N'4502c9c4-4ac2-49b5-8339-0746d483d40b', N'Jessica', N'Murphy', CAST(N'2003-12-29' AS Date), NULL)
,(N'f2924165-bc12-4c5a-af34-074b91b8c643', N'Charles', N'B Brooks', CAST(N'2003-07-31' AS Date), NULL)
INSERT Activistas (ID, Nombre, Apellidos, FechaNac, Organizacion) VALUES 
(N'c413ed7a-940e-4c5d-95b0-0755204372ae', N'Gilbert', N'Liang', CAST(N'2002-06-18' AS Date), NULL)
,(N'6acadb70-d329-48d4-b083-075d4b75f2ab', N'Andrea', N'Lopez', CAST(N'2003-08-19' AS Date), NULL)
,(N'fb9c7439-80a1-4d4b-bbda-076649323575', N'Marcus', N'L Jenkins', CAST(N'2004-06-16' AS Date), NULL)
,(N'a3dd2311-cee8-4fd6-a048-0767d68f17ca', N'Ann', N'Beebe', CAST(N'1999-03-30' AS Date), NULL)
,(N'3cbc39bf-0e6b-45d6-b416-0767e8d18d57', N'Leah', N'E Chen', CAST(N'2004-02-03' AS Date), NULL)
,(N'd5504cef-5e7b-48c3-a6e2-076ea6c7d46f', N'Isaac', N'Sanchez', CAST(N'2003-10-08' AS Date), NULL)
,(N'3431f6a3-30ea-4808-98de-077609ce3bd0', N'Chase', N'J Murphy', CAST(N'2003-11-20' AS Date), NULL)
,(N'8cfe2b37-5ce8-43b1-8664-0779b63f0d50', N'Gabrielle', N'Cook', CAST(N'2004-01-05' AS Date), NULL)
,(N'190132da-357e-4827-be1e-077b77d0ebd9', N'Filomena', N'T Visser', CAST(N'2003-09-01' AS Date), NULL)
,(N'4901ad7c-6d6f-4198-ac77-077b9559524b', N'Julia', N'J Young', CAST(N'2004-01-19' AS Date), NULL)
,(N'cc48bc0c-70c1-4c5d-a344-077c0c6230e0', N'Martha', N'Wu', CAST(N'2003-10-22' AS Date), NULL)
,(N'd308faea-2252-43cc-a573-077d9b16527d', N'Nancy', N'Suri', CAST(N'2004-05-05' AS Date), NULL)
,(N'1d389f4b-56fe-4669-8c1d-078076ba8003', N'Jackson', N'Evans', CAST(N'2004-05-17' AS Date), NULL)
,(N'db4c422b-a3b2-4f41-b2e2-0783126782b5', N'Mario', N'She', CAST(N'2003-12-25' AS Date), NULL)
,(N'c182d542-058f-4d7a-84b8-078905c3973d', N'Christy', N'L Zeng', CAST(N'2003-10-05' AS Date), NULL)
,(N'3d409d5d-a3e6-4006-ab59-078aa8d6eaee', N'Emmanuel', N'E Chandra', CAST(N'2004-05-14' AS Date), NULL)
,(N'10a963de-f495-4883-81f6-078cdd9009b2', N'Seth', N'A Mitchell', CAST(N'2002-04-07' AS Date), NULL)
,(N'4c7d498c-57f9-40cc-b3ec-078f73ad3e69', N'Jonathan', N'Patterson', CAST(N'2003-12-17' AS Date), NULL)
INSERT Activistas (ID, Nombre, Apellidos, FechaNac, Organizacion) VALUES 
(N'3449aae4-8c1c-4ba6-9fd5-079883ebd60d', N'Krystal', N'D Liu', CAST(N'2003-01-16' AS Date), NULL)
,(N'025f47b1-fab7-4f95-8d5b-07a2476984c4', N'Gabrielle', N'J Hall', CAST(N'2001-09-01' AS Date), NULL)
,(N'9981ca9f-f6a3-4ef6-948c-07a3883658da', N'Jon', N'Wu', CAST(N'2003-08-07' AS Date), NULL)
,(N'411004b5-ae83-45c7-b145-07ae1d45440f', N'Peter', N'L Raji', CAST(N'2003-11-01' AS Date), NULL)
,(N'bb48cb95-32d9-454a-89a0-07afbb087539', N'Nathan', N'Long', CAST(N'2004-02-13' AS Date), NULL)
,(N'9ab4f302-3020-4010-994c-07b5125c2201', N'Micheal', N'Gill', CAST(N'2004-01-20' AS Date), NULL)
,(N'f809a338-70cf-4253-a77a-07bccf313095', N'Jésus', N'Sanz', CAST(N'2004-05-10' AS Date), NULL)
,(N'b24f8e01-e401-4be5-af7a-07bf64d2dc79', N'Barbara', N'Decker', CAST(N'1999-01-11' AS Date), NULL)
,(N'41abeb53-0099-4def-b619-07bf7f86930d', N'Sergio', N'S Sánchez', CAST(N'2004-06-19' AS Date), NULL)
,(N'ff0138c5-3b34-4a4f-aa41-07c421e951cf', N'Deanna', N'Perez', CAST(N'2002-06-07' AS Date), NULL)
,(N'41d609ea-0543-42f9-9ae8-07c9d19d47e6', N'Casey', N'Moreno', CAST(N'2003-10-12' AS Date), NULL)
,(N'26a5b7f9-c5c3-45e9-8d75-07ca229acc41', N'Mariah', N'C Henderson', CAST(N'2002-08-05' AS Date), NULL)
,(N'dd36655b-bde4-45d4-b8a4-07ca85e1a34d', N'Carla', N'C Van', CAST(N'2003-08-22' AS Date), NULL)
,(N'4a7ad0f4-fccd-4f40-9f0c-07cf9b8f24f9', N'Ramon', N'Gao', CAST(N'2004-02-03' AS Date), NULL)
,(N'af4e935e-8385-4614-b84e-07d0c5c7c9e9', N'Angela', N'Hayes', CAST(N'2003-10-26' AS Date), NULL)
,(N'26a5de81-b56e-4dbe-a892-07d12dfc9a7e', N'Alexandra', N'R Brown', CAST(N'2003-06-01' AS Date), NULL)
,(N'2b4b5097-7652-4f63-ac5f-07d1a16f6a53', N'Jerome', N'A Gill', CAST(N'2004-03-23' AS Date), NULL)
,(N'ca381d5b-8c86-4f68-8d27-07d40bbb7b97', N'Miguel', N'T Brown', CAST(N'2004-06-08' AS Date), NULL)
INSERT Activistas (ID, Nombre, Apellidos, FechaNac, Organizacion) VALUES 
(N'284c3ae4-0a00-4fc8-ab83-07d74fb52b0e', N'Kari', N'L Perez', CAST(N'2004-07-13' AS Date), NULL)
,(N'8810d520-ee77-495f-9639-07d8612b024c', N'Tentudia', N'Melocoton', CAST(N'1952-07-06' AS Date), NULL)
,(N'2efdf14f-e51f-4ef2-81c9-07d9cadf5dad', N'Linda', N'Martin', CAST(N'1999-02-21' AS Date), NULL)
,(N'8fa2c613-ac38-4224-8e97-07dbc2fbcc3f', N'Mary', N'M Hill', CAST(N'2003-12-17' AS Date), NULL)
,(N'7959e186-63d1-42bc-963a-07dc67bbb8cb', N'Jessica', N'Taylor', CAST(N'2003-12-08' AS Date), NULL)
,(N'0271c4a3-b04f-423d-8eec-07e2d710e370', N'James', N'J Jai', CAST(N'2004-07-22' AS Date), NULL)
,(N'611f5218-a4cb-4495-9942-07e45e978b07', N'Lawrence', N'C Romero', CAST(N'2001-08-06' AS Date), NULL)
,(N'b36c0261-44e8-4101-8305-07e4a3f53362', N'Nicole', N'J Blue', CAST(N'2003-08-25' AS Date), NULL)
,(N'8d689642-3eea-4436-af51-07e54d641a4b', N'Devin', N'J Rivera', CAST(N'2003-11-28' AS Date), NULL)
,(N'e0a932b8-b6e4-4bc2-94a6-07eaed63b93b', N'Clifford', N'Rodriguez', CAST(N'2003-09-30' AS Date), NULL)
,(N'edc0b00c-f89f-480d-96bf-07f003983a02', N'Deborah', N'W Raje', CAST(N'2004-04-10' AS Date), NULL)
,(N'36b8dda8-27b8-4028-9f1b-07f34f477049', N'Aaron', N'Jenkins', CAST(N'2003-09-21' AS Date), NULL)
,(N'217812b2-ba8e-4f43-8802-07f92a7ed0c7', N'Brooke', N'A Peterson', CAST(N'2003-12-18' AS Date), NULL)
,(N'f2c95b32-54f2-41a9-9acd-07ff238a5994', N'Louis', N'M Pal', CAST(N'2003-12-04' AS Date), NULL)
,(N'0860b691-48c7-42ac-84dd-0805983ecc7e', N'Karen', N'Huang', CAST(N'2004-02-28' AS Date), NULL)
,(N'0a710714-c8d2-4e5e-aba3-080b287172a0', N'Albert', N'W Suarez', CAST(N'2003-11-07' AS Date), NULL)
,(N'483a72bf-4850-4cab-b543-080e1c7424d8', N'Megan', N'Morris', CAST(N'2003-12-09' AS Date), NULL)
,(N'2889704f-4076-4c44-be6b-080f58843487', N'Angela', N'Cooper', CAST(N'2003-12-05' AS Date), NULL)
,(N'02918a37-f8e1-4eaf-8994-08169978ea4c', N'Kristi', N'S Malhotra', CAST(N'2003-12-17' AS Date), NULL)
,(N'5329c1a2-495e-4403-af93-08222e44ecb1', N'Alex', N'Campbell', CAST(N'2003-08-19' AS Date), NULL)
INSERT Activistas (ID, Nombre, Apellidos, FechaNac, Organizacion) VALUES 
(N'0c36ae1b-af2c-4f59-9b81-0823c75a6f7e', N'Justin', N'G Taylor', CAST(N'2001-08-01' AS Date), NULL)
,(N'845ffaeb-ef19-4e9a-8de5-0824aaea4846', N'Craig', N'R Gill', CAST(N'2003-10-27' AS Date), NULL)
,(N'914c5e3d-f4e5-46ff-941d-0824fa76c9cd', N'Julia', N'N Richardson', CAST(N'2003-08-06' AS Date), NULL)
,(N'f655006a-8ef4-49b4-88f1-08288977a208', N'Logan', N'A Bryant', CAST(N'2003-05-20' AS Date), NULL)
,(N'7c25505b-06cf-4807-8905-08296e48a4f0', N'Cassandra', N'S Srini', CAST(N'2003-09-30' AS Date), NULL)
,(N'563d9a3e-afff-4262-9329-082e652e2799', N'Lucas', N'F Robinson', CAST(N'2003-12-01' AS Date), NULL)
,(N'02298c75-63f1-46cd-8e88-0834d78a17ec', N'Brandon', N'A Lewis', CAST(N'2003-11-08' AS Date), NULL)
,(N'9ff5f5d2-4a8c-4e4f-bbd2-083575b3f2f3', N'Jay', N'Fluegel', CAST(N'2004-06-01' AS Date), NULL)
,(N'a131243a-c5a9-4e13-90fe-0840bcf806a3', N'Samuel', N'Jenkins', CAST(N'2004-04-01' AS Date), NULL)
,(N'c7868a52-3001-442e-bd59-0840c5da7513', N'Melvin', N'Raje', CAST(N'2003-10-18' AS Date), NULL)
,(N'bfc100c7-8c26-496e-87f9-084116589dcb', N'Carson', N'Hughes', CAST(N'2004-04-28' AS Date), NULL)
,(N'74af8c37-3c5e-41f8-9d05-08431aa6a17d', N'Patricia', N'Doyle', CAST(N'2000-03-01' AS Date), NULL)
,(N'5fda8e65-5939-4ed6-a115-084955e7850c', N'Casey', N'G Carlson', CAST(N'2002-08-01' AS Date), NULL)
,(N'aae886ac-3035-4cc9-9dc8-08498c864dc3', N'Kaitlin', N'J Sai', CAST(N'2003-10-15' AS Date), NULL)
,(N'66e8dc54-0a26-44ff-9d67-0849e0c6833a', N'Blake', N'A Russell', CAST(N'2004-02-20' AS Date), NULL)
,(N'd87c78d7-bf21-4c96-8aa3-084a1451bff8', N'Dorothy', N'J Myer', CAST(N'2002-03-05' AS Date), NULL)
,(N'65246690-3d8b-4df0-93a5-0854864f2c1d', N'Isaac', N'Campbell', CAST(N'2003-10-21' AS Date), NULL)
,(N'fa4cecdd-a9bf-45b0-b879-0857711402a7', N'Evan', N'Wright', CAST(N'2003-11-01' AS Date), NULL)
,(N'230b320e-5bcc-4cc3-ac9f-085794a322ee', N'Renee', N'K Ramos', CAST(N'2003-06-23' AS Date), NULL)
,(N'3a648664-9aeb-4395-abf2-0859ab9d01bd', N'Chloe', N'J Lee', CAST(N'2004-07-02' AS Date), NULL)
,(N'8a8eaa7b-d6b2-42ca-bd06-08601eeb747b', N'Roberto', N'A Vazquez', CAST(N'2003-02-25' AS Date), NULL)
GO
INSERT Activistas (ID, Nombre, Apellidos, FechaNac, Organizacion) VALUES 
(N'f04511a7-dcaa-4303-a49c-0861a42008f7', N'Paul', N'L Alcorn', CAST(N'2003-07-01' AS Date), NULL)
,(N'17bbedef-8402-4024-a1ce-0864de8cf314', N'Isaiah', N'Carter', CAST(N'2003-06-12' AS Date), NULL)
,(N'ecfd7a81-90cb-412f-9dd9-087f77c348b6', N'Meredith', N'M Martinez', CAST(N'2002-02-22' AS Date), NULL)
,(N'b2d2fa03-c8e1-46e4-94e8-08815062068e', N'Stacey', N'L Zhou', CAST(N'2003-09-12' AS Date), NULL)
,(N'dcba3a85-dfd5-4d4c-aeb7-0886c9a939ab', N'Anna', N'S Bryant', CAST(N'2002-01-08' AS Date), NULL)
,(N'36136904-9493-4f9f-9e92-08892792bca6', N'Angel', N'A Howard', CAST(N'2003-08-19' AS Date), NULL)
,(N'1b09c91a-ddd4-4311-8875-088c52941cdb', N'Marshall', N'A Rai', CAST(N'2001-10-11' AS Date), NULL)
,(N'aa6b37c8-8782-49fe-85a2-088c9a49b5ba', N'Erin', N'I Reed', CAST(N'2003-09-17' AS Date), NULL)
,(N'df08dfad-f67e-41c2-b16a-0893ef5cee31', N'Lawrence', N'Vazquez', CAST(N'2003-08-25' AS Date), NULL)
,(N'd64ce0cd-44b6-47c0-96a4-089786a48e25', N'Cassidy', N'Hayes', CAST(N'2003-11-21' AS Date), NULL)
,(N'46b3f4ef-e0fe-4eac-bcda-089e64194e2d', N'Ana', N'D Diaz', CAST(N'2004-07-26' AS Date), NULL)
,(N'ce502eda-f79e-464f-961e-08a5af563cca', N'Jaime', N'R Deng', CAST(N'2002-10-13' AS Date), NULL)
,(N'49fb99b1-4526-459f-ba87-08a7285e3ea8', N'Billy', N'Schmidt', CAST(N'2004-04-20' AS Date), NULL)
,(N'0604e79b-6e2d-4e45-abeb-08accbdfa9d7', N'Kelli', N'Nath', CAST(N'2004-04-07' AS Date), NULL)
,(N'01d9a66c-35e0-473b-89b1-08b126fe1d3c', N'Carol', N'Scott', CAST(N'2004-07-24' AS Date), NULL)
,(N'8f7abc5b-46fd-4d91-8884-08b56d4ec09d', N'Jessie', N'A Hernandez', CAST(N'2003-04-17' AS Date), NULL)
,(N'd2f60d2b-90fe-4516-a367-08ba5c6cddec', N'Martha', N'R Espinoza', CAST(N'2001-09-01' AS Date), NULL)
,(N'3c0fa02f-d0d9-4b4d-9d08-08bbe181ebb5', N'Roger', N'Zhao', CAST(N'2003-11-04' AS Date), NULL)
,(N'cb758c6c-d18e-43a8-8408-08bbe1e62bc0', N'Mindy', N'A Simpson', CAST(N'2002-08-14' AS Date), NULL)
,(N'ee5ca729-6b2b-4d5e-8a8f-08bc8260cbb0', N'Megan', N'A Griffin', CAST(N'2003-08-22' AS Date), NULL)
,(N'2c6367e1-de41-4c1b-b7a1-08c1249c254f', N'Isaiah', N'K Rivera', CAST(N'2004-01-01' AS Date), NULL)
,(N'47d2f599-1c35-4106-bec0-08c8d921c9d2', N'Alexandra', N'Roberts', CAST(N'2004-02-12' AS Date), NULL)
,(N'9e12013d-3548-40aa-ba9b-08cab51ee96b', N'Ian', N'R Patterson', CAST(N'2003-11-28' AS Date), NULL)
,(N'91ef2b30-8a5f-40ba-99ab-08d3580dbd09', N'Nicolas', N'Raje', CAST(N'2003-06-11' AS Date), NULL)
INSERT Activistas (ID, Nombre, Apellidos, FechaNac, Organizacion) VALUES 
(N'615795d7-cd7a-499a-81f0-08d55927af34', N'Dick', N'Dievendorff', CAST(N'2003-08-01' AS Date), NULL)
,(N'8b73da6a-4452-4ed6-8175-08d9d599461f', N'Kristopher', N'M Garcia', CAST(N'2003-06-18' AS Date), NULL)
,(N'02d9a60d-9aa1-42bb-863f-08dd8f477661', N'Marie', N'Reinhart', CAST(N'1999-02-01' AS Date), NULL)
,(N'3a6b110b-3c87-4692-b717-08eb04bc8288', N'Samuel', N'P Jones', CAST(N'2004-03-07' AS Date), NULL)
,(N'dc7632f9-c3a6-43b9-beb1-08ec8b137452', N'Judith', N'B Frazier', CAST(N'2001-07-01' AS Date), NULL)
,(N'390f1d7d-9a6d-43d6-bed3-08f4fffa74a0', N'Benjamin', N'Wilson', CAST(N'2003-09-22' AS Date), NULL)
,(N'97699a08-4ed0-4a94-a244-08f5b0a7c8be', N'Jennifer', N'A Cox', CAST(N'2004-02-20' AS Date), NULL)
,(N'd452be75-6903-4cd8-9e87-08f8e70e5e4a', N'Jay', N'Suri', CAST(N'2003-03-18' AS Date), NULL)
,(N'4201300e-b015-4f52-b76d-08fd15bc5970', N'Terry', N'Xie', CAST(N'2003-01-02' AS Date), NULL)
,(N'6d05d3ed-ddab-4762-8e2d-08fe4ce3944b', N'Lucas', N'L Rivera', CAST(N'2003-08-30' AS Date), NULL)
,(N'3195ccac-c2f2-4ff0-9e6f-08fef8aa6325', N'Fernando', N'K Wood', CAST(N'2004-04-11' AS Date), NULL)
,(N'9ea51e7c-8ce0-4436-8a97-0900ebaeacbd', N'Autumn', N'He', CAST(N'2004-02-28' AS Date), NULL)
,(N'70426775-3c17-497b-9a93-09041a2d3c45', N'Louis', N'C Zhou', CAST(N'2001-10-09' AS Date), NULL)
,(N'7b477016-9943-4ca4-a2ad-0904ccdda1d7', N'Julia', N'Thompson', CAST(N'2002-02-15' AS Date), NULL)
,(N'a5ce330d-b3cf-4872-b824-09060e782dab', N'Eric', N'Wang', CAST(N'2004-01-02' AS Date), NULL)
,(N'fdf7e2ab-7e72-4a20-9313-090b73521136', N'Warren', N'Zhao', CAST(N'2004-03-03' AS Date), NULL)
,(N'f57d7073-ce3e-4774-bbfa-090ce25e3ce9', N'Catherine', N'Ward', CAST(N'2003-12-03' AS Date), NULL)
,(N'cdfe3386-78b8-4207-905b-090f3f8dbe82', N'Jack', N'Green', CAST(N'2003-09-20' AS Date), NULL)
,(N'01cab68b-9257-4d3c-bb97-0911dd1e2bfc', N'Nelson', N'Hernandez', CAST(N'2002-08-06' AS Date), NULL)
INSERT Activistas (ID, Nombre, Apellidos, FechaNac, Organizacion) VALUES 
(N'55d2f076-4236-4e45-90fe-0916b4baec0e', N'Thomas', N'Patterson', CAST(N'2004-05-15' AS Date), NULL)
,(N'008689ce-eeef-4c14-b1cb-0917593ff729', N'Hailey', N'F Murphy', CAST(N'2004-06-06' AS Date), NULL)
,(N'd5b525e4-4ba3-415a-8a40-0925b3f13df8', N'Carly', N'C Chander', CAST(N'2003-12-26' AS Date), NULL)
,(N'e3a54cec-236f-41c0-9bee-09262f55678e', N'Tara', N'L Andersen', CAST(N'2003-06-01' AS Date), NULL)
,(N'e307b829-5571-4e3a-bb6e-092902e253f9', N'Christina', N'C Gray', CAST(N'2003-10-19' AS Date), NULL)
,(N'd508a88c-aac8-4b49-9639-0937be94ddb8', N'Nathan', N'W Campbell', CAST(N'2003-03-13' AS Date), NULL)
,(N'c82e38cf-85d3-4a25-887d-094202c3ee5d', N'Sara', N'T Reed', CAST(N'2002-05-26' AS Date), NULL)
,(N'877554b8-2c72-4a0f-a351-0942dc97f9c7', N'Jaclyn', N'Andersen', CAST(N'2002-02-08' AS Date), NULL)
,(N'93f3eb9e-0214-4f3e-aa02-09430064a314', N'Byron', N'Jiménez', CAST(N'2003-06-08' AS Date), NULL)
,(N'c30d5c7d-455e-4a84-8415-0943aeecaa64', N'Marco', N'Kapoor', CAST(N'2003-10-12' AS Date), NULL)
,(N'93dd266a-c9b0-4f62-941e-0943ff3c5d3e', N'Rodney', N'L Serrano', CAST(N'2002-06-12' AS Date), NULL)
,(N'f6988b2a-a246-49d8-b683-094bed902b02', N'Isaac', N'J Peterson', CAST(N'2002-06-14' AS Date), NULL)
,(N'7c934a3e-5955-46c4-b933-094e6757ac8d', N'Wayne', N'T Rai', CAST(N'2003-09-21' AS Date), NULL)
,(N'fd5c4742-2bf5-4681-ba81-094f9a0e718b', N'Hector', N'A mez', CAST(N'2003-11-16' AS Date), NULL)
,(N'4bbd9847-693e-4d86-8111-095265c7a01e', N'Russell', N'L Jai', CAST(N'2003-02-06' AS Date), NULL)
,(N'ec136ce2-eac4-4114-93e0-095493f6b5c7', N'Karen', N'F Hu', CAST(N'2003-12-14' AS Date), NULL)
,(N'a3d115f3-1973-4409-ae03-095e8af12a94', N'Garrett', N'M Ramirez', CAST(N'2004-03-06' AS Date), NULL)
,(N'b3c92305-7b33-47bf-bf01-096712dc7ed5', N'Ashley', N'M Harris', CAST(N'2003-10-29' AS Date), NULL)
,(N'84b64eb9-45fe-4949-be0b-0969fbe78b06', N'Margie', N'Shoop', CAST(N'1998-12-26' AS Date), NULL)
,(N'cce7d590-3b2a-4f12-8d75-096f1c882193', N'Alexandra', N'McDonald', CAST(N'2003-09-03' AS Date), NULL)
,(N'4b752927-5fd0-40ac-9712-096f3006acd0', N'Rebecca', N'Evans', CAST(N'2004-04-27' AS Date), NULL)
,(N'daeddf11-178e-46da-bc60-09762a2bb102', N'Alicia', N'Xie', CAST(N'2004-05-23' AS Date), NULL)
,(N'dcce0fe2-ba6f-405f-be12-097ca8bd0367', N'Alan', N'Xu', CAST(N'2001-08-04' AS Date), NULL)
INSERT Activistas (ID, Nombre, Apellidos, FechaNac, Organizacion) VALUES 
(N'3b468eda-210e-418b-81e1-097de9f66701', N'Kristine', N'W Romero', CAST(N'2003-09-30' AS Date), NULL)
,(N'47fc074c-9cbb-4687-a0ea-0980efabc092', N'James', N'Perry', CAST(N'2004-06-16' AS Date), NULL)
,(N'560b57f1-94a4-4d6f-a3e8-09822901ff63', N'Zoe', N'R James', CAST(N'2004-03-07' AS Date), NULL)
,(N'97ed1ab7-a932-4b75-8f21-0986c66a402f', N'Brent', N'E Gao', CAST(N'2003-11-24' AS Date), NULL)
,(N'664c3968-1702-431a-b8b2-098b65fdc2d9', N'Tristan', N'L Bennett', CAST(N'2003-09-13' AS Date), NULL)
,(N'8a122fc8-9a90-458c-87dd-098c6b8200b4', N'Peter', N'Rai', CAST(N'2004-05-14' AS Date), NULL)
,(N'7ce36d0e-917d-45d6-9335-098faaf55567', N'Jeremy', N'Cox', CAST(N'2003-11-30' AS Date), NULL)
,(N'7abd3ee0-30bb-4092-b10a-09974d5cef0f', N'Caleb', N'M Simmons', CAST(N'2003-09-30' AS Date), NULL)
,(N'10312d97-073e-4f48-9bfc-09994456ad55', N'Ian', N'Ramirez', CAST(N'2003-09-08' AS Date), NULL)
,(N'8037e12d-14a6-4a35-a2c9-09a2b12aca94', N'Mohamed', N'D Pal', CAST(N'2002-09-14' AS Date), NULL)
,(N'cc7f8435-ab84-4f2b-8c16-09aedce7cd41', N'Cesar', N'Srini', CAST(N'2004-01-06' AS Date), NULL)
,(N'7755901e-f70e-45c8-80d7-09af5bdcd0e6', N'Meredith', N'Garcia', CAST(N'2003-10-02' AS Date), NULL)
,(N'6754303a-c639-4e18-82f4-09b2ca4cf481', N'Chloe', N'nzales', CAST(N'2003-09-20' AS Date), NULL)
,(N'c6581b60-3874-4d05-abb4-09bc126acec7', N'Zoe', N'E Torres', CAST(N'2003-11-27' AS Date), NULL)
,(N'a6d96c35-51e9-48dd-8252-09be6c0273a5', N'Morgan', N'Ward', CAST(N'2003-03-20' AS Date), NULL)
,(N'a8a17c2e-574a-4e3d-9601-09c0e141e27f', N'Jeremy', N'D Ward', CAST(N'2004-01-31' AS Date), NULL)
,(N'49559aca-bdb2-4ea2-b1f8-09c1aae29fe4', N'Tyler', N'A Davis', CAST(N'2004-07-08' AS Date), NULL)
,(N'e705a706-f3db-49bc-a473-09c3ce7f523e', N'Naomi', N'E mez', CAST(N'2003-05-24' AS Date), NULL)
,(N'a293c4d1-947f-4362-86e4-09c5508c1b6b', N'Laura', N'L Cai', CAST(N'2004-07-05' AS Date), NULL)
GO
INSERT Activistas (ID, Nombre, Apellidos, FechaNac, Organizacion) VALUES 
(N'3e5788e1-765a-4fdf-b3ba-09c76017affb', N'Randall', N'M Dominguez', CAST(N'2001-08-24' AS Date), NULL)
,(N'cfe5e1ea-4fbd-41b5-865c-09c90865dda3', N'Laura', N'Norman', CAST(N'1999-02-16' AS Date), NULL)
,(N'b2facb02-6db0-4b5d-bf3e-09ca22a97a0d', N'Hector', N'Ruiz', CAST(N'2004-02-11' AS Date), NULL)
,(N'0a47b4a4-e253-4c35-8d93-09cf23b96b27', N'Nathan', N'Mitchell', CAST(N'2004-07-26' AS Date), NULL)
,(N'fd392975-d078-4cd1-9461-09d217f813b6', N'Jésus', N'Carlson', CAST(N'2003-09-19' AS Date), NULL)
,(N'698bdf3f-258e-4bbe-b16e-09d627179edb', N'Jo', N'Brown', CAST(N'2002-08-01' AS Date), NULL)
,(N'2f6d0756-400b-42e8-a489-09db2a67f845', N'Ebony', N'S Hernandez', CAST(N'2003-02-20' AS Date), NULL)
,(N'c91de0cb-a6e5-4356-9f3f-09df5a79571f', N'Max', N'S Gutierrez', CAST(N'2004-04-03' AS Date), NULL)
,(N'c795c9c4-af4a-4ee4-82ba-09e27c76d804', N'Carolyn', N'M Malhotra', CAST(N'2004-03-28' AS Date), NULL)
,(N'd42f15f7-2c5f-4936-9559-09e39be7f574', N'Gavin', N'nzales', CAST(N'2004-06-24' AS Date), NULL)
,(N'e156ca21-cc1b-4794-823c-09ec30e5ee38', N'Brian', N'T Morgan', CAST(N'2003-09-18' AS Date), NULL)
,(N'61f30a09-e16f-4159-9f25-09ed9b5bdd2c', N'Melissa', N'A Morris', CAST(N'2003-08-26' AS Date), NULL)
,(N'539201d5-7555-4ef6-8b5c-09ee6e5aab06', N'Christy', N'C Lal', CAST(N'2002-09-10' AS Date), NULL)
,(N'4bde72e7-6972-48a2-93ab-09f74fc1121e', N'Destiny', N'S Brooks', CAST(N'2003-09-27' AS Date), NULL)
,(N'464a3339-5474-4cc1-9684-09fbcac9f621', N'Randall', N'F Moreno', CAST(N'2004-03-10' AS Date), NULL)
,(N'71cbcf9e-35a8-410b-9a07-0a000ff9bfbb', N'Deepak', N'Kumar', CAST(N'2003-08-01' AS Date), NULL)
,(N'53ec284e-4392-4080-b795-0a01a1a53745', N'Ben', N'Smith', CAST(N'1999-02-12' AS Date), NULL)
,(N'04d51f3c-a537-4890-b610-0a046714923d', N'Ethan', N'Thomas', CAST(N'2003-10-15' AS Date), NULL)
,(N'be15d721-cb6b-448b-985c-0a05ae53c4ae', N'Isaiah', N'H Bailey', CAST(N'2003-11-18' AS Date), NULL)
,(N'b3dc686f-b4b4-47e1-a8c6-0a0764ce68fb', N'Thomas', N'nzales', CAST(N'2004-07-27' AS Date), NULL)
,(N'cd550231-e612-4327-a3b6-0a089e906f63', N'Carlos', N'James', CAST(N'2001-10-18' AS Date), NULL)
INSERT Activistas (ID, Nombre, Apellidos, FechaNac, Organizacion) VALUES 
(N'ebd8c911-048a-4805-baaf-0a09e8df58b8', N'Alisha', N'N Oliver', CAST(N'2003-09-04' AS Date), NULL)
,(N'e857f9e0-2b94-4233-af92-0a09ef1c4f36', N'Madeline', N'Green', CAST(N'2004-07-05' AS Date), NULL)
,(N'dcab3ca7-7eba-4918-bd6e-0a0a610563b6', N'Nelson', N'F Torres', CAST(N'2003-09-06' AS Date), NULL)
,(N'083e24de-86cb-4eac-a869-0a0d10ab902b', N'Nathan', N'D Chen', CAST(N'2003-11-15' AS Date), NULL)
,(N'89dc89f1-3711-4363-a812-0a10d94cc2e5', N'Ronald', N'nzalez', CAST(N'2004-06-02' AS Date), NULL)
,(N'cb34fb89-035a-4a00-a647-0a16a6d534b3', N'Samuel', N'A Johnson', CAST(N'2001-08-01' AS Date), NULL)
,(N'd57c7d6d-0b8d-4ee5-9244-0a16e2ed3fbc', N'Devin', N'A Flores', CAST(N'2003-08-16' AS Date), NULL)
,(N'ee5730c2-9f7c-42e3-a34f-0a1bd4fee79c', N'Theodore', N'T Vazquez', CAST(N'2002-11-25' AS Date), NULL)
,(N'6cde10fc-40d4-4562-9e3a-0a1f8fa3cb3d', N'Angel', N'N Mitchell', CAST(N'2001-11-08' AS Date), NULL)
,(N'50ca3e54-9b59-4b87-9cff-0a2486e13ace', N'Bryan', N'T Sanders', CAST(N'2004-05-26' AS Date), NULL)
,(N'9ab9f862-57f9-449d-bf9c-0a29331aabbf', N'Micah', N'C Wang', CAST(N'2003-03-18' AS Date), NULL)
,(N'b2d1f136-cd3c-4105-bba1-0a30831640ed', N'Austin', N'L Taylor', CAST(N'2004-04-08' AS Date), NULL)
,(N'125b1371-c5cc-4e53-b8f0-0a373bafe2bf', N'Claire', N'O''Donnell', CAST(N'1999-02-25' AS Date), NULL)
,(N'27d2ef14-afbf-4165-8eb1-0a37ef52734a', N'Shelby', N'Peterson', CAST(N'2003-05-22' AS Date), NULL)
,(N'c3925581-f86d-45f4-9ca5-0a38b08435f2', N'Gary', N'L Martin', CAST(N'2004-02-25' AS Date), NULL)
,(N'ae19684e-e35b-473c-8a68-0a3efa477a6d', N'Jay', N'M Sara', CAST(N'2002-10-20' AS Date), NULL)
,(N'61a243b5-45d8-41e0-b9ce-0a42b5307ddc', N'Andy', N'H Navarro', CAST(N'2004-02-01' AS Date), NULL)
,(N'3b0bc4e9-6b29-4ff3-ad43-0a42f215ee9d', N'Sergio', N'Arun', CAST(N'2003-11-30' AS Date), NULL)
INSERT Activistas (ID, Nombre, Apellidos, FechaNac, Organizacion) VALUES 
(N'e44bcb7c-c9d5-4847-bde6-0a4af5b735e6', N'Riley', N'M Butler', CAST(N'2003-08-12' AS Date), NULL)
,(N'28aac072-40e3-4bf6-9f02-0a4eabee6b4e', N'Shannon', N'Sun', CAST(N'2002-06-09' AS Date), NULL)
,(N'5e7f0daa-7709-4888-99f8-0a4f1d4d003d', N'Katherine', N'L Moore', CAST(N'2004-06-22' AS Date), NULL)
,(N'1f7fb793-0310-45fb-8d26-0a525b8cf8b3', N'Leonard', N'Andersen', CAST(N'2003-01-13' AS Date), NULL)
,(N'0da8084d-929a-48c3-9449-0a5444c82c16', N'Vincent', N'M Wang', CAST(N'2004-03-26' AS Date), NULL)
,(N'ffacfef9-55be-4352-952d-0a56c56eb8bd', N'Noah', N'Ross', CAST(N'2002-10-04' AS Date), NULL)
,(N'4b20d4ef-55b3-4263-b9a5-0a5a1f1ba5e1', N'Jackson', N'H Adams', CAST(N'2003-09-13' AS Date), NULL)
,(N'2d3d9730-4f50-471e-9930-0a5eaa58704c', N'Katherine', N'Cox', CAST(N'2004-01-24' AS Date), NULL)
,(N'a0abb5c7-123d-4cd8-afa8-0a5f1b582ff3', N'Jaime', N'G Yuan', CAST(N'2003-04-12' AS Date), NULL)
,(N'3f2b1e27-da90-4704-914a-0a6041a5120a', N'Hunter', N'A Sharma', CAST(N'2003-08-02' AS Date), NULL)
,(N'59e563af-6f55-4c9c-aa7a-0a61937264aa', N'Andre', N'M Sara', CAST(N'2001-08-08' AS Date), NULL)
,(N'0a4be101-123a-4afa-ad81-0a6aa238c38a', N'Rachael', N'M Prasad', CAST(N'2004-05-19' AS Date), NULL)
,(N'93b25d17-edab-4dd5-951e-0a6bac536bf1', N'Don', N'Funk', CAST(N'2003-09-01' AS Date), NULL)
,(N'f2924c20-82b5-4609-9265-0a6c9bfc2859', N'Denise', N'W Perez', CAST(N'2004-01-20' AS Date), NULL)
,(N'e3c36ba1-7c5c-493c-819c-0a6edec6b17d', N'Candace', N'Kapoor', CAST(N'2003-08-17' AS Date), NULL)
,(N'21b4be4c-b9a3-4822-9690-0a71d4739ecc', N'Morgan', N'T Hughes', CAST(N'2003-08-13' AS Date), NULL)
,(N'7f017692-9e89-40b9-ab4f-0a7295242c3d', N'Valerie', N'R Li', CAST(N'2004-07-10' AS Date), NULL)
,(N'a45758e1-24d0-4fee-a75a-0a74ad37e0f7', N'Douglas', N'M Srini', CAST(N'2004-02-05' AS Date), NULL)
,(N'd525a1d4-c378-4378-ae08-0a75368de24d', N'Danny', N'Martin', CAST(N'2004-05-21' AS Date), NULL)
,(N'232d456a-fe2f-4969-8c54-0a78aae0d178', N'Abby', N'Madan', CAST(N'2004-06-02' AS Date), NULL)
,(N'26bfa75d-8ada-48f4-9287-0a7a5bd5284e', N'Alisha', N'I Kumar', CAST(N'2002-12-29' AS Date), NULL)
,(N'010bb5e8-b7bd-4803-b616-0a7b8aef5679', N'Megan', N'Jones', CAST(N'2003-09-04' AS Date), NULL)
,(N'd951873a-d141-44a2-b96e-0a7d81802ee9', N'Wyatt', N'Thompson', CAST(N'2004-01-24' AS Date), NULL)
,(N'b8f69b5b-435b-465b-89fe-0a7dc2d9b9c5', N'Wayne', N'Shan', CAST(N'2001-12-22' AS Date), NULL)
,(N'1bba3b79-e3cd-4324-a706-0a7e595ec300', N'Maria', N'M Sanders', CAST(N'2003-09-18' AS Date), NULL)
INSERT Activistas (ID, Nombre, Apellidos, FechaNac, Organizacion) VALUES 
(N'e0580ea3-6071-41e0-bfa3-0a86c51f9ef7', N'Kayla', N'A Jenkins', CAST(N'2001-12-03' AS Date), NULL)
,(N'079c0974-7da7-4350-8132-0a8c8a0f609c', N'Rachel', N'S White', CAST(N'2004-02-23' AS Date), NULL)
,(N'a47f572d-f8b9-41c8-9beb-0a90bb039a73', N'Rachael', N'G Patel', CAST(N'2003-09-16' AS Date), NULL)
,(N'5c77d0fd-6d2f-4ed7-b461-0a935cc9d0bb', N'Marie', N'L Mehta', CAST(N'2003-10-03' AS Date), NULL)
,(N'753d2bc1-adde-434c-8cb0-0a965b4d2026', N'Stephanie', N'A Ward', CAST(N'2003-04-26' AS Date), NULL)
,(N'fd724cd1-61a4-4d25-b3a6-0a9da61a6ea9', N'Jonathan', N'Phillips', CAST(N'2002-03-19' AS Date), NULL)
,(N'8841ee57-97dd-4a1d-a12b-0a9e46ceb967', N'Christina', N'Howard', CAST(N'2003-10-29' AS Date), NULL)
,(N'b6261d4d-f161-4089-a55f-0aa0d16552fe', N'Johnny', N'Shan', CAST(N'2002-05-13' AS Date), NULL)
,(N'78de9198-d31f-44cd-9e47-0aa52b270fa3', N'Haley', N'F Washington', CAST(N'2003-10-21' AS Date), NULL)
,(N'89f08272-bc17-410c-b1cb-0aaa7aca339f', N'Shawn', N'J She', CAST(N'2003-11-24' AS Date), NULL)
,(N'dec97e6b-e336-4675-9441-0ab322f52b4c', N'Pedro', N'Suri', CAST(N'2002-11-18' AS Date), NULL)
,(N'200ae623-dcc8-4040-a494-0abb9dc64771', N'Eddie', N'A Alvarez', CAST(N'2003-09-07' AS Date), NULL)
,(N'14be9e36-6519-479f-86be-0abc65cceb5b', N'Mayra', N'M Suri', CAST(N'2003-06-30' AS Date), NULL)
,(N'986be600-27bb-4c16-9eb2-0abea2cd3a2c', N'Briana', N'Diaz', CAST(N'2002-12-25' AS Date), NULL)
,(N'44f657c6-f13e-4856-aa26-0ac1da798fe9', N'Lucas', N'Butler', CAST(N'2001-10-18' AS Date), NULL)
,(N'10880781-3760-4f32-b276-0ac4a779bf13', N'Candice', N'Liu', CAST(N'2003-08-06' AS Date), NULL)
,(N'7c7c8876-1dea-4562-90e5-0ac7b39f6ea3', N'Brian', N'Stewart', CAST(N'2003-04-25' AS Date), NULL)
,(N'9c55a0e3-f07e-4211-8b06-0acd6d431945', N'Ian', N'V Baker', CAST(N'2003-03-30' AS Date), NULL)
,(N'97a347e1-87dd-4166-8e6d-0ace7da5f18b', N'Norma', N'N Barrera', CAST(N'2002-07-01' AS Date), NULL)
,(N'cb39bd1c-2200-4af3-b2fe-0ad96d72abf0', N'Holly', N'J Holt', CAST(N'2003-07-01' AS Date), NULL)
INSERT Activistas (ID, Nombre, Apellidos, FechaNac, Organizacion) VALUES 
(N'95b05b59-50fa-4916-96b6-0add4331f1c6', N'Kelvin', N'K Xu', CAST(N'2002-08-18' AS Date), NULL)
,(N'4206bfde-99e2-4662-9386-0ae583e14288', N'Benjamin', N'C Willett', CAST(N'2002-02-25' AS Date), NULL)
,(N'ad66b20e-f4ce-48fd-ab27-0aeec5c9cd5d', N'Jon', N'Hu', CAST(N'2004-04-21' AS Date), NULL)
,(N'469af85c-fbb7-49e6-b389-0aeee11bfc51', N'Tai', N'Yee', CAST(N'1999-01-08' AS Date), NULL)
,(N'e4d70a48-b240-4a71-88bd-0af28fd745fa', N'Marvin', N'J Torres', CAST(N'2004-03-31' AS Date), NULL)
,(N'fb897585-24f3-4bbb-9022-0af63066d922', N'Jordan', N'L Scott', CAST(N'2003-02-24' AS Date), NULL)
,(N'9dabe23e-ec1c-41f8-ab32-0af91411a71b', N'Edgar', N'B Martinez', CAST(N'2004-05-20' AS Date), NULL)
,(N'accd3fc0-aa7f-43d1-9d17-0af9a40a886c', N'Eddie', N'Ortega', CAST(N'2002-12-12' AS Date), NULL)
,(N'4867b08e-120e-4fcf-872c-0afea316c5d4', N'Joanna', N'Gill', CAST(N'2004-05-23' AS Date), NULL)
,(N'4ee67a53-581c-4d38-9dc0-0b01bec2c6f1', N'Gina', N'E Martin', CAST(N'2003-08-19' AS Date), NULL)
,(N'6e127da3-ba40-40fa-af31-0b02211f9b97', N'Tristan', N'M Wood', CAST(N'2003-09-12' AS Date), NULL)
,(N'a67a81d9-bbea-469a-b63a-0b0aa7819040', N'Michele', N'J Ramos', CAST(N'2003-10-22' AS Date), NULL)
,(N'f5d3a261-8452-41ce-9ab2-0b13fab906fe', N'Dana', N'K Martin', CAST(N'2003-07-15' AS Date), NULL)
,(N'f362a050-bbe3-4f4d-ac1c-0b1a1e64a5c6', N'Brent', N'Zhou', CAST(N'2003-11-02' AS Date), NULL)
,(N'603c0ac5-13ca-4219-9888-0b1cbe7f3451', N'Carlos', N'A Murphy', CAST(N'2003-08-14' AS Date), NULL)
,(N'a00a048c-0ebd-480e-8be2-0b212bd38730', N'Kaitlyn', N'G Kelly', CAST(N'2004-01-06' AS Date), NULL)
,(N'20328a7e-870a-4501-96c4-0b214bb7677c', N'Kelly', N'Focht', CAST(N'2001-09-01' AS Date), NULL)
,(N'fed1bd94-bb13-408b-bb15-0b22b2757eb2', N'Kimberly', N'L Brooks', CAST(N'2003-08-30' AS Date), NULL)
,(N'9e3ae690-b121-4707-baf0-0b23d8f55ba3', N'Andre', N'Rana', CAST(N'2003-08-28' AS Date), NULL)
,(N'b340af7d-6644-4c5d-8306-0b25aff53d0b', N'Devin', N'A Garcia', CAST(N'2003-09-03' AS Date), NULL)
GO
INSERT Activistas (ID, Nombre, Apellidos, FechaNac, Organizacion) VALUES 
(N'700cf108-7cd6-468a-80b9-0b28780221a6', N'Michael', N'M Thompson', CAST(N'2002-09-12' AS Date), NULL)
,(N'5dbb223b-235e-4e29-a179-0b32548bce9d', N'Monique', N'C Jimenez', CAST(N'2003-08-19' AS Date), NULL)
,(N'4825b107-4fbd-402a-8474-0b342783ce10', N'Jarred', N'Martin', CAST(N'2003-08-24' AS Date), NULL)
,(N'e289a518-aa97-4477-8433-0b3484ec240c', N'Logan', N'D Garcia', CAST(N'2002-07-06' AS Date), NULL)
,(N'23c0dcce-4b06-4933-8b52-0b376671d5cf', N'Arturo', N'V Chen', CAST(N'2003-10-23' AS Date), NULL)
,(N'ea6d6aed-8fcb-4e4c-94e0-0b3c2d058795', N'Denise', N'Sanchez', CAST(N'2001-08-12' AS Date), NULL)
,(N'73d1069d-1841-47b3-b443-0b408a2d0b87', N'Mariah', N'K Rogers', CAST(N'2004-05-05' AS Date), NULL)
,(N'c6fdd997-cd6b-4b95-92ab-0b42a4f6cc2c', N'Kristi', N'E Perez', CAST(N'2002-02-11' AS Date), NULL)
,(N'd3e47ae0-e23c-4bfa-9268-0b430db0059a', N'Alex', N'W Howard', CAST(N'2004-03-10' AS Date), NULL)
,(N'008b14d1-5ae3-48cc-8765-0b45afc92c5d', N'Benjamin', N'A Alexander', CAST(N'2003-08-02' AS Date), NULL)
,(N'54992035-4045-4e23-bf08-0b48410edf65', N'Logan', N'J Sharma', CAST(N'2004-05-02' AS Date), NULL)
,(N'adf50851-43bc-4ec9-ab1b-0b4880378842', N'Lucas', N'Williams', CAST(N'2004-02-19' AS Date), NULL)
,(N'cd32daa7-a810-491e-91ae-0b54a7a86d06', N'Gustavo', N'Achong', CAST(N'2005-05-16' AS Date), NULL)
,(N'a2b72c14-24e1-45e6-bc9e-0b627f416e3e', N'Xavier', N'Thomas', CAST(N'2003-12-31' AS Date), NULL)
,(N'f83d2b72-aa7b-4500-8cf7-0b631c153452', N'Jenna', N'Mitchell', CAST(N'2002-07-07' AS Date), NULL)
,(N'ad6d59e6-395a-4c42-a0b3-0b63c0d50ef1', N'Jose', N'J Hall', CAST(N'2003-08-13' AS Date), NULL)
,(N'ef17a6db-7fe6-40ec-9b0a-0b671f4622db', N'Russell', N'E Anand', CAST(N'2003-12-06' AS Date), NULL)
,(N'4f9c9ac3-d7b7-4fbe-ac83-0b6977ede8f1', N'Josh', N'Barnhill', CAST(N'2001-08-01' AS Date), NULL)
,(N'2f80f3c1-9bab-4348-81d3-0b6aa8ebed43', N'Whitney', N'Raman', CAST(N'2004-04-13' AS Date), NULL)
,(N'6d4ab6d4-647a-4a64-a8b7-0b6be371a4e1', N'Samantha', N'F Perry', CAST(N'2003-08-24' AS Date), NULL)
INSERT Activistas (ID, Nombre, Apellidos, FechaNac, Organizacion) VALUES 
(N'2d5728f7-fdd7-433e-a721-0b6ceb40109d', N'Charles', N'H Lopez', CAST(N'2004-05-28' AS Date), NULL)
,(N'75fea65e-7edc-4b02-a01a-0b70e1b43d46', N'Lauren', N'Davis', CAST(N'2004-03-22' AS Date), NULL)
,(N'57476c3a-cbbf-4479-a30f-0b761125a4e0', N'Raymond', N'E Sara', CAST(N'2003-11-13' AS Date), NULL)
,(N'8e89dd79-a7a8-4476-b50b-0b77abf304c6', N'Megan', N'Russell', CAST(N'2004-01-25' AS Date), NULL)
,(N'a2bfba00-ae7a-400c-b855-0b797eca85db', N'Ken', N'L Myer', CAST(N'1999-03-21' AS Date), NULL)
,(N'55fe9f07-032b-4be8-b477-0b7b3837eb1d', N'Cole', N'A Watson', CAST(N'2001-07-01' AS Date), NULL)
,(N'd5360ed7-22be-40bb-8c94-0b7bb4f20236', N'Keith', N'Harris', CAST(N'2002-08-01' AS Date), NULL)
,(N'50bad560-2121-4027-a2c7-0b7fd72d2db5', N'Curtis', N'E Zeng', CAST(N'2003-11-16' AS Date), NULL)
,(N'2d98a210-6fdd-4a25-8eb2-0b842b7d5f88', N'Victor', N'L Diaz', CAST(N'2003-09-09' AS Date), NULL)
,(N'143b619b-797b-4fc1-9643-0b85aa6c328a', N'Jackson', N'S Wang', CAST(N'2004-06-08' AS Date), NULL)
,(N'e9f4c1be-bbcf-4661-a236-0b8ed22cc209', N'Anna', N'L Murphy', CAST(N'2003-12-13' AS Date), NULL)
,(N'acc1be78-11e2-47cb-a2e6-0b8fc3fb6e1d', N'Eddie', N'J Gill', CAST(N'2003-09-13' AS Date), NULL)
,(N'eb40bf5c-0a8d-441a-9693-0b91746013f0', N'Roger', N'E Raje', CAST(N'2004-04-03' AS Date), NULL)
,(N'ecd5d10e-e365-487e-930f-0b9204fdbce2', N'Richard', N'Hill', CAST(N'2004-01-08' AS Date), NULL)
,(N'2972e84b-3735-464d-9c2b-0b9e3b002802', N'Justin', N'J Thomas', CAST(N'2004-03-29' AS Date), NULL)
,(N'a07e835b-507a-4958-84a0-0b9f70b930fd', N'Joanna', N'M Alonso', CAST(N'2004-06-23' AS Date), NULL)
,(N'e9016d52-3212-4856-a440-0ba15cbb5081', N'Ebony', N'J Blanco', CAST(N'2004-03-26' AS Date), NULL)
,(N'f08f4716-f1cf-45eb-862f-0ba219a62426', N'Candice', N'W Xu', CAST(N'2004-06-11' AS Date), NULL)
,(N'6ba91418-f427-4e81-b3b1-0ba35939f826', N'Jack', N'Russell', CAST(N'2004-06-12' AS Date), NULL)
,(N'39be7896-bfea-4c3f-aa01-0ba3fd6dfa64', N'Jo', N'Brown', CAST(N'1999-03-10' AS Date), NULL)
,(N'a6a9c766-dc6f-4788-a8ca-0ba7ccb93ea4', N'Phillip', N'P Prasad', CAST(N'2003-09-28' AS Date), NULL)
,(N'6e09434f-b018-4e7a-9f91-0bad725060d3', N'Teresa', N'L Carlson', CAST(N'2003-06-08' AS Date), NULL)
,(N'46bb3338-a8f9-4704-8830-0bae1973e2e6', N'Alexandra', N'Baker', CAST(N'2004-01-17' AS Date), NULL)
,(N'0e9cdf19-9db7-4800-82d6-0bb5195a01b2', N'Capitolino', N'Sanchez', CAST(N'1991-02-07' AS Date), NULL)
,(N'8b0d2218-dbbf-415d-b043-0bb9d727a86e', N'Arturo', N'Raji', CAST(N'2003-03-08' AS Date), NULL)
,(N'3070091d-34b4-4118-99ce-0bc6ab397f1f', N'Emma', N'Ramirez', CAST(N'2004-06-26' AS Date), NULL)
,(N'173bac0c-5baa-4754-88fa-0bc6e95285a6', N'Joan', N'R Long', CAST(N'2003-12-10' AS Date), NULL)
INSERT Activistas (ID, Nombre, Apellidos, FechaNac, Organizacion) VALUES 
(N'cc283625-2b89-475b-986a-0bc831a008ab', N'Alexis', N'Diaz', CAST(N'2004-04-07' AS Date), NULL)
,(N'79bff488-a2a9-4f97-924a-0bcb2e1b98f0', N'Alexandria', N'C Hayes', CAST(N'2004-01-16' AS Date), NULL)
,(N'69950dd9-d911-4387-be23-0bd00ba27f13', N'Anne', N'Vazquez', CAST(N'2003-06-10' AS Date), NULL)
,(N'38129ccc-3890-4493-9832-0bd2a9ea6062', N'Brett', N'D Srini', CAST(N'2004-05-10' AS Date), NULL)
,(N'46c467ff-2bc2-4cef-8a6f-0bd2f57f9bd2', N'Zosima', N'Melocoton', CAST(N'1982-12-06' AS Date), NULL)
,(N'348c5d2e-5c8e-4c2b-a54e-0bd941aff7c3', N'Catherine', N'M Reed', CAST(N'2003-10-23' AS Date), NULL)
,(N'2e02bd5f-5b83-41e7-92f6-0bddf1985e90', N'David', N'J Ortiz', CAST(N'1999-01-09' AS Date), NULL)
,(N'be9c9266-6a19-475e-b218-0be0dc1da9ca', N'Susan', N'Cai', CAST(N'2004-01-19' AS Date), NULL)
,(N'8e0e436b-c089-4d59-95bb-0bedfcdc520c', N'Jessica', N'G Jones', CAST(N'2004-07-23' AS Date), NULL)
,(N'27f72cc3-0f3f-48b5-ab0b-0bf70cf5f795', N'Steven', N'Watson', CAST(N'2003-05-06' AS Date), NULL)
,(N'0348ebfd-7c27-4db7-910c-0bfbd0067856', N'Henry', N'L Sara', CAST(N'2003-01-02' AS Date), NULL)
,(N'b8b7e81b-fcd8-4c51-bc2a-0bfc6f6b45f1', N'Kathleen', N'E Munoz', CAST(N'2004-07-17' AS Date), NULL)
,(N'7006c9cf-3315-4891-8af7-0bfd1dce17bd', N'Sarah', N'K Rodriguez', CAST(N'2004-04-01' AS Date), NULL)
,(N'0d860f59-fecf-4dfb-bfce-0bfd495873ec', N'Sheila', N'C Moreno', CAST(N'2003-07-30' AS Date), NULL)
,(N'5abdabf2-dcdc-4557-8134-0bfe28c4f971', N'Edgar', N'O Lopez', CAST(N'2003-11-19' AS Date), NULL)
,(N'9175b614-aee4-4ea4-ac95-0bfefa1725b2', N'Ryan', N'Danner', CAST(N'2003-07-01' AS Date), NULL)
,(N'95daa4ac-c118-4527-b57b-0c05d6af70c6', N'Cory', N'A Mehta', CAST(N'2003-03-21' AS Date), NULL)
,(N'a34f1a78-6329-44d7-9eda-0c07c2577ff2', N'Jenny', N'Andersen', CAST(N'2002-05-04' AS Date), NULL)
,(N'4a9055d5-d984-4f4c-a5dd-0c0fac5b2845', N'Alisha', N'R He', CAST(N'2003-05-02' AS Date), NULL)
,(N'b4732a2b-7e99-4e45-af5d-0c1307825410', N'Daisy', N'Sanz', CAST(N'2003-12-24' AS Date), NULL)
,(N'937b5aee-4ff3-482b-be89-0c1420ffbfa4', N'Carrie', N'mez', CAST(N'2004-03-24' AS Date), NULL)
INSERT Activistas (ID, Nombre, Apellidos, FechaNac, Organizacion) VALUES 
(N'814ffc52-2e36-4749-a9b2-0c178fe01cdb', N'Hunter', N'H Baker', CAST(N'2004-01-04' AS Date), NULL)
,(N'9c28c794-181a-42d6-9b27-0c1aa159d9cd', N'Sydney', N'Carter', CAST(N'2004-01-10' AS Date), NULL)
,(N'bdcc3298-a94d-4716-9772-0c1cd3468146', N'Kara', N'Raji', CAST(N'2003-03-19' AS Date), NULL)
,(N'fac3dc2d-9af0-477c-a600-0c1decb5e5ce', N'David', N'M Bradley', CAST(N'1998-01-13' AS Date), NULL)
,(N'8151a233-28a3-4185-836d-0c1e2c34e6e1', N'Ebony', N'A Srini', CAST(N'2003-03-16' AS Date), NULL)
,(N'275c0e35-2f07-47eb-afe1-0c202762a315', N'Marcel', N'Truempy', CAST(N'2001-07-28' AS Date), NULL)
,(N'6b8385e3-a64b-4366-9b0e-0c25a75afa9f', N'Gina', N'Blanco', CAST(N'2003-08-26' AS Date), NULL)
,(N'69e4c3a3-1fff-4c66-ab0a-0c2b744f73d8', N'Jonathan', N'E Li', CAST(N'2004-05-20' AS Date), NULL)
,(N'a9399e67-ea73-46b7-bc23-0c2c0480b2d3', N'Ricky', N'S Carlson', CAST(N'2004-03-13' AS Date), NULL)
,(N'f292430a-6da9-4c30-9e0c-0c2f4c507caa', N'Tracy', N'Raje', CAST(N'2004-04-25' AS Date), NULL)
,(N'263702b5-b8a6-4e33-80f3-0c30859049dc', N'Martin', N'L Sai', CAST(N'2004-01-30' AS Date), NULL)
,(N'b06be5d3-6454-4fda-8089-0c32223dc8b0', N'Brad', N'S Rai', CAST(N'2001-12-19' AS Date), NULL)
,(N'49a74f67-d42a-433a-8fd3-0c3e6bec3d30', N'Brianna', N'Flores', CAST(N'2004-03-11' AS Date), NULL)
,(N'c09028d0-1b9f-4b7b-a164-0c42f476a556', N'Erik', N'I Sanz', CAST(N'2003-10-29' AS Date), NULL)
,(N'5422ba3b-aa4a-4454-b0d3-0c44c48e6492', N'Zheng', N'Mu', CAST(N'2002-03-06' AS Date), NULL)
,(N'5abe16d5-1ab9-4145-a796-0c45599f6764', N'Tina', N'Rodriguez', CAST(N'2004-06-19' AS Date), NULL)
,(N'6e16fc7b-02ce-4661-8df9-0c4690f39a9c', N'Chloe', N'C Rodriguez', CAST(N'2002-08-01' AS Date), NULL)
,(N'204de5d0-4499-4a96-84ee-0c47177ce2ea', N'Jorge', N'M Wang', CAST(N'2004-06-05' AS Date), NULL)
,(N'a1dd4b36-f27f-4141-842f-0c520f1eb93b', N'Arthur', N'Gill', CAST(N'2004-02-06' AS Date), NULL)
GO
INSERT Activistas (ID, Nombre, Apellidos, FechaNac, Organizacion) VALUES 
(N'7c50665e-bfaa-4275-9346-0c582f200214', N'Rafael', N'J Nara', CAST(N'2003-10-22' AS Date), NULL)
,(N'4c8e8337-c5dc-4e6f-a3a4-0c5e1c3d6846', N'Kelvin', N'Lal', CAST(N'2002-12-12' AS Date), NULL)
,(N'f74f46ab-f689-49fa-b289-0c61d571ce3c', N'Eugene', N'N Lu', CAST(N'2004-06-09' AS Date), NULL)
,(N'0544b21b-027b-472e-a389-0c669db591a1', N'Rostislav', N'E Shabalin', CAST(N'1999-03-16' AS Date), NULL)
,(N'd01af6fd-b469-4f32-9121-0c6db17cbef1', N'Blake', N'Butler', CAST(N'2001-07-24' AS Date), NULL)
,(N'7be4469d-84b5-4fee-9b40-0c6e37b95e6f', N'Alisha', N'G Zhang', CAST(N'2001-08-26' AS Date), NULL)
,(N'c3e717e1-d3b8-4c9c-8b03-0c765416936b', N'Melvin', N'A Pal', CAST(N'2004-01-17' AS Date), NULL)
,(N'81bbe8cc-baa8-49c3-b737-0c7f046be5a2', N'H.', N'B Valentine', CAST(N'2003-06-01' AS Date), NULL)
,(N'a5ad6e97-53c6-407f-914d-0c8c0c3b8ba4', N'Julia', N'M Wright', CAST(N'2002-02-06' AS Date), NULL)
,(N'06a3ceb6-4c29-4bfd-b4a5-0c9662bde193', N'Brittney', N'B Guo', CAST(N'2004-04-19' AS Date), NULL)
,(N'5fd7f396-8250-4e49-b9c5-0c97b790afbc', N'Natalie', N'Roberts', CAST(N'2002-02-13' AS Date), NULL)
,(N'69ea3f8f-0fcc-4174-ad60-0ca2040ac866', N'Brenda', N'Lopez', CAST(N'2003-11-27' AS Date), NULL)
,(N'd0e0f658-b383-4497-b92e-0ca266ae8b43', N'Curtis', N'Cai', CAST(N'2002-08-10' AS Date), NULL)
,(N'b90e0414-9d2d-4844-96ae-0ca297d355c1', N'Gilbert', N'A Zheng', CAST(N'2004-04-17' AS Date), NULL)
,(N'1f743aa5-4705-467f-9b4e-0ca4a6989657', N'Robyn', N'J Gill', CAST(N'2003-09-19' AS Date), NULL)
,(N'ab49dc62-1e53-47bd-844f-0ca73f1dfae2', N'Armando', N'Torres', CAST(N'2003-12-15' AS Date), NULL)
,(N'06b8fe37-dadf-4b14-88bc-0cab02d41704', N'Mae', N'M Black', CAST(N'2001-07-01' AS Date), NULL)
,(N'188f8a9e-5115-4af3-bbf7-0cabdb59a4cf', N'Blake', N'Brown', CAST(N'2003-08-14' AS Date), NULL)
INSERT Activistas (ID, Nombre, Apellidos, FechaNac, Organizacion) VALUES 
(N'2f3232c5-7377-4f36-a682-0cacf1394608', N'Benjamin', N'F Powell', CAST(N'2004-05-21' AS Date), NULL)
,(N'95d2324c-4b20-4f45-afd7-0cad7b1f52a7', N'Noah', N'L Thompson', CAST(N'2004-05-26' AS Date), NULL)
,(N'dc64519a-79b1-4b22-89f2-0cb023a114d0', N'Nathan', N'Powell', CAST(N'2003-09-16' AS Date), NULL)
,(N'38483545-f808-4df1-9e4f-0cb3e41b2115', N'Brandi', N'L Blanco', CAST(N'2004-04-07' AS Date), NULL)
,(N'75645445-91be-4b60-ac71-0cb9903bd1b9', N'Orlando', N'J Carlson', CAST(N'2002-03-03' AS Date), NULL)
,(N'a17e3d88-3957-406a-9ec5-0cb9be99183c', N'Kendra', N'Romero', CAST(N'2003-07-03' AS Date), NULL)
,(N'6659c8f2-9846-4400-9d75-0cbd7a2979c6', N'Lolan', N'Song', CAST(N'2003-06-21' AS Date), NULL)
,(N'cc631653-15d7-484c-9068-0cbd918cf622', N'Maurice', N'Nara', CAST(N'2004-05-18' AS Date), NULL)
,(N'7ab41073-c5a0-41bc-a834-0cbfb817744b', N'Ramon', N'Huang', CAST(N'2002-07-20' AS Date), NULL)
,(N'0446ae32-63ea-4070-984c-0cc0e692d11d', N'Katherine', N'R nzales', CAST(N'2003-06-17' AS Date), NULL)
,(N'95448c49-6300-4f52-95a5-0cc5a752384a', N'Andy', N'L Dominguez', CAST(N'2003-08-31' AS Date), NULL)
,(N'729c867c-8dd8-49aa-91b3-0cd0b4bc7a1f', N'Stacey', N'M Cereghino', CAST(N'2001-07-01' AS Date), NULL)
,(N'09bb05b7-5aa2-4ce2-9e4a-0cd51152ea17', N'Dylan', N'C Hughes', CAST(N'2004-03-29' AS Date), NULL)
,(N'16d562da-0d36-41af-b41f-0cd5c0b63abf', N'Blake', N'Hill', CAST(N'2003-12-09' AS Date), NULL)
,(N'2ebee4e3-4a7f-4915-bb61-0cdb7f4721bf', N'Kenneth', N'Becker', CAST(N'2004-04-27' AS Date), NULL)
,(N'846c2787-1481-48a8-a09e-0cdf15728cb9', N'Willie', N'J Xu', CAST(N'2001-10-11' AS Date), NULL)
,(N'265204ec-91c9-446b-8f8a-0ce8eac6a8d3', N'Spencer', N'Price', CAST(N'2004-02-11' AS Date), NULL)
,(N'778d1e90-c76d-4e29-bd67-0ceac718b622', N'Misty', N'A Raje', CAST(N'2003-02-27' AS Date), NULL)
,(N'ec2b7b9b-2e39-47f1-a767-0cedc725a8d3', N'Janelle', N'A Kapoor', CAST(N'2003-08-02' AS Date), NULL)
,(N'9d755a82-3575-4741-ad1c-0cef356bfeff', N'Ross', N'Patel', CAST(N'2004-03-13' AS Date), NULL)
INSERT Activistas (ID, Nombre, Apellidos, FechaNac, Organizacion) VALUES 
(N'581c3421-f8c4-4a00-b977-0cfc1f2e7c25', N'Ashley', N'Washington', CAST(N'2001-07-19' AS Date), NULL)
,(N'a042bdab-9f6e-4f35-9144-0cfe192664bb', N'Casey', N'A Rubio', CAST(N'2004-05-26' AS Date), NULL)
,(N'78e459d6-21e1-4039-8718-0cfe7846ec20', N'Mayra', N'R Patel', CAST(N'2003-04-15' AS Date), NULL)
,(N'6d7fffb1-5611-4ed2-80cd-0d011e751c79', N'Cameron', N'M Thompson', CAST(N'2001-07-21' AS Date), NULL)
,(N'508881cb-8947-418a-9d47-0d099f860036', N'Hunter', N'A Butler', CAST(N'2003-09-29' AS Date), NULL)
,(N'9c10bfd4-c917-4330-8ba4-0d0e750cffa5', N'Vincent', N'Ye', CAST(N'2004-03-30' AS Date), NULL)
,(N'a36e3887-6cd9-4f3f-bd3a-0d0fc63f7aea', N'Natalie', N'Watson', CAST(N'2003-12-09' AS Date), NULL)
,(N'7b0441e4-0d83-4d39-b7f2-0d123cf01295', N'Robin', N'L Sanz', CAST(N'2002-03-24' AS Date), NULL)
,(N'f3680376-f261-4973-9d8e-0d13f7735855', N'Angela', N'E Bell', CAST(N'2003-10-02' AS Date), NULL)
,(N'94583a0d-fb70-4c04-aba8-0d14ac3335d9', N'Eric', N'L Yang', CAST(N'2004-04-22' AS Date), NULL)
,(N'6f5c7bb4-abef-4475-89a4-0d1674c2c957', N'Donna', N'Lal', CAST(N'2004-06-02' AS Date), NULL)
,(N'7b6f032d-9e8f-4b92-a7f3-0d18883e849c', N'Renee', N'L mez', CAST(N'2002-08-17' AS Date), NULL)
,(N'e82c2312-8f8b-404a-9d5e-0d1e17354f67', N'Brianna', N'P Sanchez', CAST(N'2003-02-08' AS Date), NULL)
,(N'f085aab9-adf9-423e-bffd-0d1f90e94cd1', N'Evelyn', N'Perez', CAST(N'2003-03-30' AS Date), NULL)
,(N'cf507ff7-5746-41a0-9fd7-0d24e26275af', N'Jaclyn', N'Guo', CAST(N'2002-12-13' AS Date), NULL)
,(N'35031bc4-2a46-4af0-9d0e-0d269e466ede', N'Randall', N'H Hernandez', CAST(N'2003-09-22' AS Date), NULL)
,(N'd3ac48e6-1430-4044-8046-0d275f758bdc', N'Connor', N'J Green', CAST(N'2003-12-03' AS Date), NULL)
INSERT Activistas (ID, Nombre, Apellidos, FechaNac, Organizacion) VALUES 
(N'93bc1b7e-53c2-4520-a8f0-0d2777e64bf6', N'Warren', N'Chande', CAST(N'2003-08-26' AS Date), NULL)
,(N'1a4555bc-8a68-43ee-8a36-0d27e8c044fa', N'Nicole', N'E Flores', CAST(N'2004-03-01' AS Date), NULL)
,(N'813176a8-7433-4dae-9d71-0d286dd74625', N'Faith', N'L Griffin', CAST(N'2003-05-06' AS Date), NULL)
,(N'ead9af47-af82-4e38-bfaf-0d28cad870e8', N'Nathan', N'L Wilson', CAST(N'2003-11-24' AS Date), NULL)
,(N'20a8ab66-0103-4f24-8d37-0d2f10720a9f', N'Melanie', N'A Howard', CAST(N'2004-05-17' AS Date), NULL)
,(N'3e4cd23b-2632-4905-b480-0d30f5b2210e', N'Kathryn', N'I She', CAST(N'2002-11-17' AS Date), NULL)
,(N'04126e7d-e1a2-4bfa-a6a5-0d32a10b07e7', N'Noah', N'B Williams', CAST(N'2003-12-16' AS Date), NULL)
,(N'eb401e9b-d434-4b98-b343-0d3309cedf47', N'Hailey', N'Phillips', CAST(N'2004-04-03' AS Date), NULL)
,(N'17b3d2a4-5f03-463e-9141-0d34e785ab7a', N'Jermaine', N'A Kapoor', CAST(N'2004-05-09' AS Date), NULL)
,(N'19564592-7e48-4f9b-b19d-0d37af8be7c3', N'Sean', N'A Evans', CAST(N'2003-09-26' AS Date), NULL)
,(N'4d7d77f0-eda8-419f-b092-0d3a0f037f7f', N'Elijah', N'L Adams', CAST(N'2002-07-14' AS Date), NULL)
,(N'77ae9615-01bb-48ee-b206-0d3b63def315', N'Clifford', N'Arun', CAST(N'2002-06-18' AS Date), NULL)
,(N'9927acb4-2326-4cdf-841c-0d3cafbfb81f', N'Sheena', N'Rai', CAST(N'2003-08-02' AS Date), NULL)
,(N'89ca3b50-eab0-4b5e-a68e-0d3cdae34abf', N'Francisco', N'L nzalez', CAST(N'2002-06-14' AS Date), NULL)
,(N'6747b1d0-b9bc-4859-810b-0d3ec23c073d', N'Veronica', N'A Sanchez', CAST(N'2004-03-07' AS Date), NULL)
,(N'fd928977-bc91-4d2c-a666-0d4347e0e995', N'Devin', N'Murphy', CAST(N'2002-07-30' AS Date), NULL)
,(N'bd6cee5d-a909-4fae-bc24-0d452618529b', N'Javier', N'R Serrano', CAST(N'2002-05-13' AS Date), NULL)
,(N'8614ea97-23b8-4612-b8a4-0d4744f85ed0', N'Krystal', N'Holt', CAST(N'2001-07-18' AS Date), NULL)
INSERT Activistas (ID, Nombre, Apellidos, FechaNac, Organizacion) VALUES 
(N'fe7db8df-e240-483e-8216-0d483cd8e396', N'Christopher', N'A Robinson', CAST(N'2004-02-24' AS Date), NULL)
,(N'452ced12-fadc-4b86-aebb-0d49eb13e051', N'Andrew', N'W Williams', CAST(N'2004-05-12' AS Date), NULL)
,(N'c1dfaab9-6181-49fa-bc0f-0d4d534f0374', N'Ronnie', N'Zhao', CAST(N'2004-05-17' AS Date), NULL)
,(N'adcec0c2-851b-40d7-9d15-0d4ecee5b653', N'Carlos', N'Bailey', CAST(N'2004-03-08' AS Date), NULL)
,(N'17cd7ecf-54bf-4d57-b4c3-0d5239640323', N'Esther', N'K Valle', CAST(N'2002-07-01' AS Date), NULL)
,(N'3c240f86-ff19-4858-82ca-0d52cf52ddb2', N'Xavier', N'Long', CAST(N'2004-04-20' AS Date), NULL)
,(N'c4c1706d-70d2-44cd-bca2-0d53c0e2b399', N'Michele', N'E Raje', CAST(N'2003-11-23' AS Date), NULL)
,(N'291d1fcb-28a5-4188-9014-0d544b96c1bf', N'Sydney', N'Ward', CAST(N'2002-12-10' AS Date), NULL)
,(N'041ebe73-0fad-401a-9375-0d5494945b92', N'Daniel', N'P Thompson', CAST(N'2003-09-01' AS Date), NULL)
,(N'af9de8ff-b24b-4beb-becd-0d583250e942', N'Alicia', N'Shan', CAST(N'2003-11-05' AS Date), NULL)
,(N'20f6686e-c740-4706-926a-0d5bef495dc3', N'Roy', N'H Garcia', CAST(N'2003-05-25' AS Date), NULL)
,(N'3344ed38-6af8-44d9-bbaf-0d63068e0a76', N'Samantha', N'Griffin', CAST(N'2004-06-02' AS Date), NULL)
,(N'3167e480-d16d-4787-91bb-0d65cbc2b3d8', N'Aidan', N'O Perry', CAST(N'2002-05-11' AS Date), NULL)
,(N'168f13a2-24b9-4cc1-a612-0d6e51496b69', N'Sara', N'A Lopez', CAST(N'2004-05-08' AS Date), NULL)
,(N'932946f4-ea4d-4d61-934a-0d6f556edc3a', N'Gina', N'Diaz', CAST(N'2003-12-27' AS Date), NULL)
,(N'dc63a442-7e84-4a0f-9c7f-0d6fc58379e8', N'Rodney', N'J Gutierrez', CAST(N'2002-06-15' AS Date), NULL)
,(N'1aa4f74c-6435-4068-9e82-0d70038be6bc', N'Jodi', N'E Raje', CAST(N'2003-11-24' AS Date), NULL)
,(N'14280bed-2b98-4cb3-a665-0d73561a8db0', N'Craig', N'C Ruiz', CAST(N'2004-05-15' AS Date), NULL)
GO
INSERT Activistas (ID, Nombre, Apellidos, FechaNac, Organizacion) VALUES 
(N'a50ef79b-0af0-4381-b483-0d768f7d7029', N'Timothy', N'A Rivera', CAST(N'2004-05-06' AS Date), NULL)
,(N'c6a16b50-cebc-47f6-aa73-0d77fc2466e5', N'Emma', N'L Jenkins', CAST(N'2004-01-07' AS Date), NULL)
,(N'46d0ccaf-e812-4551-9f5b-0d7aeeb7960d', N'Gerald', N'Martinez', CAST(N'2004-02-20' AS Date), NULL)
,(N'6d9dde28-fe9d-451d-8ff7-0d7be7ec0a0e', N'Ian', N'C Long', CAST(N'2002-04-28' AS Date), NULL)
,(N'a7be42de-400b-4838-868b-0d84dd95487c', N'Meredith', N'Dominguez', CAST(N'2003-04-08' AS Date), NULL)
,(N'200d0810-9cbb-40b5-b7f8-0d86933fd012', N'Maurice', N'C Xu', CAST(N'2004-05-28' AS Date), NULL)
,(N'8e51cb08-8419-4557-bc0a-0d8803ca944d', N'Barbara', N'Li', CAST(N'2003-06-20' AS Date), NULL)
,(N'5f587f6a-3a28-4dd7-8b7d-0d8c42035b1e', N'Neil', N'M Ortega', CAST(N'2003-12-11' AS Date), NULL)
,(N'ea1530c2-2e91-48b8-9033-0d8de56060e7', N'Gabriella', N'Sanders', CAST(N'2002-03-13' AS Date), NULL)
,(N'e7f2f165-cd99-4cb9-bd9a-0d8fb5cc2b9a', N'Sean', N'L Cooper', CAST(N'2003-09-11' AS Date), NULL)
,(N'81dd8ddf-412b-4ef3-9ad7-0d937fdcad5e', N'Jacquelyn', N'Saunders', CAST(N'2004-04-19' AS Date), NULL)
,(N'87ce36dc-3cfa-478a-8aeb-0d940ef81fdc', N'Luis', N'A Scott', CAST(N'2003-11-18' AS Date), NULL)
,(N'86701c13-98e5-42cd-a2b0-0d96e24ea7ea', N'Cole', N'W Cook', CAST(N'2004-01-31' AS Date), NULL)
,(N'b457c717-5af0-4988-bfbc-0d9ef9fbf1b1', N'Caitlin', N'C Morgan', CAST(N'2003-07-05' AS Date), NULL)
,(N'e871ef11-397b-42c0-a431-0daa3a4b2922', N'Pamela', N'L Rana', CAST(N'2004-05-31' AS Date), NULL)
,(N'223192c3-ebfc-4b95-851f-0daae6b175a9', N'Rafael', N'Zhu', CAST(N'2004-06-13' AS Date), NULL)
,(N'4f94d811-ee67-4334-af9b-0dad2bf59f50', N'Isabella', N'A Davis', CAST(N'2002-12-08' AS Date), NULL)
,(N'e37a1b9f-64fa-4176-8d13-0daf0383ea76', N'Emma', N'Torres', CAST(N'2003-11-12' AS Date), NULL)
,(N'34ef42e0-b39c-4701-9355-0db505ebade7', N'Kristina', N'A Perez', CAST(N'2003-08-12' AS Date), NULL)
INSERT Activistas (ID, Nombre, Apellidos, FechaNac, Organizacion) VALUES 
(N'2a68f984-3ba6-4336-8a70-0db562524ab9', N'Blake', N'C nzales', CAST(N'2002-08-08' AS Date), NULL)
,(N'f36af2d3-b90b-4a9f-aabc-0db7cf078e7b', N'Daniel', N'Jackson', CAST(N'2004-01-07' AS Date), NULL)
,(N'1c616df1-5e5a-417a-8817-0dba66ad7c40', N'Audrey', N'mez', CAST(N'2004-05-16' AS Date), NULL)
,(N'29dce64a-2225-464d-bfaf-0dc3d3eadbce', N'Douglas', N'Vance', CAST(N'2004-03-16' AS Date), NULL)
,(N'de9ffba1-856a-4748-b528-0dcb0fbfb630', N'Ethan', N'A Lal', CAST(N'2003-11-28' AS Date), NULL)
,(N'c389d19f-05cd-43ca-b876-0dcba3281fdf', N'Gilbert', N'J Cai', CAST(N'2003-08-31' AS Date), NULL)
,(N'56beb5ae-c610-46c0-a0ac-0dcc1e46207a', N'Warren', N'F Rai', CAST(N'2003-06-01' AS Date), NULL)
,(N'ae81ca70-420b-470c-b0e4-0dd5e2ff4f70', N'Justin', N'Foster', CAST(N'2003-07-03' AS Date), NULL)
,(N'320690dd-a619-4261-865e-0dd779e861e3', N'Keith', N'M Kumar', CAST(N'2003-10-04' AS Date), NULL)
,(N'0c4d055d-91d9-405f-9e90-0dd9d2679f0a', N'Sharon', N'A Xu', CAST(N'2003-01-03' AS Date), NULL)
,(N'37f6a930-3358-4069-a65b-0de1f4a79a74', N'Kurt', N'Andersen', CAST(N'2004-03-20' AS Date), NULL)
,(N'e0fe0a49-e00a-44e3-acee-0de5b0fd006e', N'Jessica', N'Stewart', CAST(N'2003-08-03' AS Date), NULL)
,(N'623327ea-c651-4880-ac5b-0de888d00534', N'Dawn', N'J Shan', CAST(N'2004-05-29' AS Date), NULL)
,(N'e0124144-d494-47b4-802d-0de91fd7909a', N'Emily', N'Flores', CAST(N'2003-08-21' AS Date), NULL)
,(N'0a3ad03e-2306-49c1-af94-0df07ab1bd62', N'Franklin', N'M Huang', CAST(N'2004-02-08' AS Date), NULL)
,(N'0093269b-1e3a-4541-b0a0-0df363f31c7a', N'Timothy', N'Watson', CAST(N'2003-11-04' AS Date), NULL)
,(N'6d109b5f-f192-4af7-9181-0df5e9465342', N'Barry', N'A Raman', CAST(N'2004-03-20' AS Date), NULL)
INSERT Activistas (ID, Nombre, Apellidos, FechaNac, Organizacion) VALUES 
(N'884476da-b79f-4555-be38-0dfac04e9e3c', N'Dylan', N'E Rodriguez', CAST(N'2003-08-21' AS Date), NULL)
,(N'c8f05cda-90a1-4f4a-a1fb-0dfc265f5928', N'Adam', N'M Green', CAST(N'2002-07-17' AS Date), NULL)
,(N'82eee5c0-885e-4150-b5c7-0e010b822338', N'Hector', N'Navarro', CAST(N'2003-11-06' AS Date), NULL)
,(N'06487e2d-6a99-4323-97d9-0e01866dcc1e', N'Erin', N'Torres', CAST(N'2003-09-15' AS Date), NULL)
,(N'67d69795-95ad-4b71-9dd8-0e02a89804c1', N'Taylor', N'M Henderson', CAST(N'2002-06-18' AS Date), NULL)
,(N'f0bbf08a-a18f-4a15-9a3d-0e049520fba3', N'Pedro', N'S Gill', CAST(N'2004-07-18' AS Date), NULL)
,(N'bd614a96-c240-4de7-859b-0e07bc52b303', N'Jordyn', N'L Barnes', CAST(N'2004-06-25' AS Date), NULL)
,(N'5e6d48a5-4f00-4912-bc16-0e08bff46385', N'Katherine', N'R Cook', CAST(N'2004-04-09' AS Date), NULL)
,(N'9effb984-38fd-4569-a190-0e090cfbeda0', N'Elena', N'Velez Amezaga', CAST(N'2004-02-13' AS Date), NULL)
,(N'264d154c-435b-4c3b-a1ed-0e0b03a79afc', N'Adrian', N'Cooper', CAST(N'2002-06-18' AS Date), NULL)
,(N'91b70e98-0660-4383-a4e2-0e0b7a68799e', N'Ruben', N'Alvarez', CAST(N'2003-11-05' AS Date), NULL)
,(N'9568a500-0a85-43f9-98df-0e0c5f8b42db', N'Jada', N'Nelson', CAST(N'2004-04-01' AS Date), NULL)
,(N'f57778bd-a7f3-4269-884e-0e0db3b48c87', N'Sylvia', N'N Spencer', CAST(N'2004-07-14' AS Date), NULL)
,(N'aa74c8b6-9c22-4926-9e40-0e124e714cc6', N'Isaiah', N'G Hernandez', CAST(N'2004-01-18' AS Date), NULL)
,(N'85db0848-d999-4868-aa56-0e1e79493493', N'Hunter', N'Perry', CAST(N'2003-08-29' AS Date), NULL)
,(N'30e1dc15-163f-42fd-9db8-0e2082e9df43', N'Thomas', N'A Lee', CAST(N'2004-01-09' AS Date), NULL)
,(N'bf5233f3-91a3-4592-9f37-0e20df122883', N'Jimmy', N'V Travers', CAST(N'2002-08-23' AS Date), NULL)
,(N'5a96ca0e-f8df-4066-a0a3-0e211e1e76a5', N'Arthur', N'K Jiménez', CAST(N'2003-03-08' AS Date), NULL)
,(N'8b38b139-c444-410f-964b-0e291f5407b9', N'Dale', N'B Nath', CAST(N'2004-01-07' AS Date), NULL)
,(N'c1bf7089-28fb-40d4-91be-0e2d1ee12491', N'Wyatt', N'L Powell', CAST(N'2003-09-02' AS Date), NULL)
INSERT Activistas (ID, Nombre, Apellidos, FechaNac, Organizacion) VALUES 
(N'28eeec92-56c3-489d-9246-0e2ef8ab5631', N'Ronald', N'K Heymsfield', CAST(N'2002-08-01' AS Date), NULL)
,(N'bf67ab96-769e-4b57-a0af-0e2f267df410', N'Alvin', N'R Kumar', CAST(N'2002-12-23' AS Date), NULL)
,(N'afe5580a-8918-4fc2-8999-0e2ff6ddc08f', N'Isaiah', N'Nelson', CAST(N'2004-05-13' AS Date), NULL)
,(N'6c7fba92-2a36-48df-9295-0e329c8b9b9f', N'Hailey', N'R Bennett', CAST(N'2004-04-13' AS Date), NULL)
,(N'0de18bdf-d324-4b35-91e3-0e32ec2f2781', N'Julian', N'Powell', CAST(N'2002-09-10' AS Date), NULL)
,(N'414f7e21-e364-491c-8d3e-0e484a499ee3', N'Adam', N'G Washington', CAST(N'2004-06-26' AS Date), NULL)
,(N'4e1eaaea-b564-484f-8e75-0e48776f4bdf', N'Tony', N'M She', CAST(N'2004-03-26' AS Date), NULL)
,(N'ccb81da9-c886-4e92-943e-0e49cbb2e0d0', N'Kenneth', N'J Lal', CAST(N'2001-12-19' AS Date), NULL)
,(N'db7022f9-1156-4efe-a01a-0e4a420f484c', N'Sydney', N'L Scott', CAST(N'2004-07-24' AS Date), NULL)
,(N'b6f3830a-cb23-4791-9632-0e4c21ee0966', N'Sandra', N'Reátegui Alayo', CAST(N'1999-01-20' AS Date), NULL)
,(N'90df44fd-d0be-4410-a9e7-0e4e51aa109a', N'Jessie', N'Liu', CAST(N'2001-11-18' AS Date), NULL)
,(N'22dee058-a53e-42db-b30e-0e4f5f03fec4', N'Bryant', N'Subram', CAST(N'2004-03-24' AS Date), NULL)
,(N'78036708-244e-470c-8a9e-0e53453b3418', N'Miranda', N'Long', CAST(N'2002-04-16' AS Date), NULL)
,(N'90c4d7ef-250f-4198-8d5d-0e53f1d2b7e5', N'Bobby', N'W Prasad', CAST(N'2003-09-28' AS Date), NULL)
,(N'a89a7b64-4651-45c0-87f3-0e55cbe1a9b3', N'John', N'Evans', CAST(N'2002-07-01' AS Date), NULL)
,(N'bdef86be-4e68-4311-9b9e-0e57260741c7', N'Lucas', N'Hill', CAST(N'2001-07-06' AS Date), NULL)
,(N'8cf12ba4-6b51-4739-b351-0e6137f667f4', N'Kimberly', N'Rivera', CAST(N'2004-03-22' AS Date), NULL)
,(N'f3854ae4-0554-41bc-a5ba-0e633ddf10a5', N'Louis', N'Li', CAST(N'2003-10-23' AS Date), NULL)
,(N'e5045a71-c364-4888-94ea-0e63e85c9a17', N'Lauren', N'D Lee', CAST(N'2003-06-07' AS Date), NULL)
,(N'aa4cc3f1-2aec-4c98-81ef-0e64109e7620', N'Tina', N'J Lopez', CAST(N'2004-02-02' AS Date), NULL)
INSERT Activistas (ID, Nombre, Apellidos, FechaNac, Organizacion) VALUES 
(N'2db84ae9-f0d8-4cc4-884d-0e673452aff5', N'Kevin', N'Diaz', CAST(N'2003-09-05' AS Date), NULL)
,(N'90a6c04a-a66b-4462-8af4-0e742b178a05', N'Sebastian', N'Watson', CAST(N'2002-12-31' AS Date), NULL)
,(N'78a20b57-2e1b-43f3-9152-0e74c190a457', N'Gabrielle', N'Rivera', CAST(N'2004-02-21' AS Date), NULL)
,(N'72fc55f7-b561-4e8c-83eb-0e75bf94a424', N'Cheryl', N'T Torres', CAST(N'2003-09-21' AS Date), NULL)
,(N'ee22ff0b-5933-4ede-b9dc-0e75cfbe84d4', N'Joe', N'Blanco', CAST(N'2003-08-19' AS Date), NULL)
,(N'0aad7405-9126-4e22-bee2-0e76cb3415fb', N'Martha', N'C Hu', CAST(N'2002-10-21' AS Date), NULL)
,(N'997ccd68-df18-4f94-a495-0e7acb54fc84', N'Alvin', N'B Ye', CAST(N'2003-05-02' AS Date), NULL)
,(N'0c9f074b-6108-479f-95fe-0e7c51dd8adc', N'Greg', N'C White', CAST(N'2004-03-01' AS Date), NULL)
,(N'fc05582f-5616-4952-baff-0e7e77a6d865', N'Donna', N'Nath', CAST(N'2004-04-15' AS Date), NULL)
,(N'5fedb1f4-385b-45fc-9265-0e83a5f39ea9', N'Billy', N'L Gill', CAST(N'2003-12-20' AS Date), NULL)
,(N'511d5a13-0f16-4935-8de5-0e8c4042f5f5', N'Robyn', N'C Alonso', CAST(N'2004-01-18' AS Date), NULL)
,(N'54491641-efbf-46f5-a2fd-0e8d298235d3', N'Samuel', N'M Harris', CAST(N'2003-09-03' AS Date), NULL)
,(N'cf992a78-4e2f-40e2-b263-0e92a4e752c2', N'Jason', N'nzales', CAST(N'2002-07-21' AS Date), NULL)
,(N'c4bd8d14-67b7-4fc7-9707-0e93b7665782', N'Kari', N'T Sanchez', CAST(N'2003-08-16' AS Date), NULL)
,(N'9bd3f3f4-f76d-448e-8563-0e97c8448c7e', N'Calvin', N'L Kumar', CAST(N'2003-01-20' AS Date), NULL)
,(N'001d3710-5728-45cb-bfad-0e9899c1b38e', N'Kathryn', N'Ashe', CAST(N'2003-08-25' AS Date), NULL)
,(N'bcf14b7c-ae40-4e34-b077-0e991e8f9baa', N'Colin', N'Ye', CAST(N'2003-12-21' AS Date), NULL)
,(N'ea1c389b-cb78-4a4c-a887-0e9debbcd249', N'Cameron', N'J Henderson', CAST(N'2002-02-22' AS Date), NULL)
,(N'e39decb4-d041-443c-9460-0e9e3c6b5fd8', N'Jacqueline', N'J Alexander', CAST(N'2004-05-12' AS Date), NULL)
,(N'4315ea39-51c4-4827-8616-0ea0c32abd53', N'Dana', N'S Serrano', CAST(N'2003-09-26' AS Date), NULL)
GO
INSERT Activistas (ID, Nombre, Apellidos, FechaNac, Organizacion) VALUES 
(N'53c271a3-34df-4477-9b60-0ea7a94ecbff', N'Lucas', N'A Kelly', CAST(N'2004-05-05' AS Date), NULL)
,(N'1b60a3db-952f-4c03-912b-0ea80efab210', N'Kristopher', N'Subram', CAST(N'2004-06-12' AS Date), NULL)
,(N'e0f226cb-c50d-4ff1-af47-0eae448083ce', N'Trevor', N'Russell', CAST(N'2004-04-21' AS Date), NULL)
,(N'fff1bbf2-fa13-4358-bb38-0eaef8f9e00d', N'Steven', N'Reed', CAST(N'2004-01-31' AS Date), NULL)
,(N'8acaf1a2-fd2f-4e50-8516-0eaf1a2ffffb', N'Kari', N'K Schmidt', CAST(N'2003-08-19' AS Date), NULL)
,(N'a906b09f-b424-43e3-9797-0eb5770c4786', N'Timothy', N'E Mitchell', CAST(N'2004-02-26' AS Date), NULL)
,(N'9fbbcf36-2532-484c-aa6b-0eb69f2a0349', N'Katherine', N'E Jenkins', CAST(N'2004-01-19' AS Date), NULL)
,(N'f8ee2cee-ef65-464b-8677-0eb6e307311c', N'Michael', N'M Clark', CAST(N'2004-06-07' AS Date), NULL)
,(N'e3c20001-c1dc-43c4-8127-0eb76539b6e5', N'Gabrielle', N'S Cooper', CAST(N'2002-11-23' AS Date), NULL)
,(N'7042fa2a-0baa-4698-9edc-0ebc5b7d0550', N'Samantha', N'Martin', CAST(N'2003-06-10' AS Date), NULL)
,(N'98a49b32-5279-4f39-9960-0ebf2698fb6e', N'Haley', N'Alexander', CAST(N'2002-04-15' AS Date), NULL)
,(N'b04b5724-2c55-47b2-be3a-0ec11aa9e231', N'Zachary', N'Foster', CAST(N'2004-07-20' AS Date), NULL)
,(N'e3528ac0-8f5f-4266-85c9-0ec4913266e1', N'Wyatt', N'C Foster', CAST(N'2003-12-04' AS Date), NULL)
,(N'f3c5d9b8-5bfa-4da5-811a-0ecea652ffed', N'Calvin', N'E Chande', CAST(N'2003-06-25' AS Date), NULL)
,(N'7c1a43ec-afa9-47c6-8e29-0ed7478211b6', N'Kaylee', N'M Cooper', CAST(N'2004-02-06' AS Date), NULL)
,(N'b61319df-8fe8-48ca-b033-0ed9b958d060', N'James', N'Hughes', CAST(N'2004-06-30' AS Date), NULL)
,(N'4d84ca26-dce8-4245-afe8-0edb39ca87f0', N'Chase', N'Cooper', CAST(N'2003-11-03' AS Date), NULL)
,(N'898859bb-6798-4a22-b1e4-0edf477132bb', N'Christy', N'Zheng', CAST(N'2001-09-12' AS Date), NULL)
,(N'801f859e-6f89-4dd4-ac23-0ee7bd64bc8d', N'Gilbert', N'N Huang', CAST(N'2002-09-08' AS Date), NULL)
,(N'c3d63c4b-e1a0-41aa-878a-0ee7f60e9ade', N'Sean', N'nzalez', CAST(N'2001-10-08' AS Date), NULL)
,(N'e1cdb1fa-2dc7-4a8b-8aed-0ef4e2d3327f', N'Rafael', N'A Zhou', CAST(N'2003-08-04' AS Date), NULL)
,(N'dea015a0-4376-4901-bf19-0ef9bfc0dfac', N'Jackson', N'S Chen', CAST(N'2002-09-23' AS Date), NULL)
INSERT Activistas (ID, Nombre, Apellidos, FechaNac, Organizacion) VALUES 
(N'c892595e-2327-4672-9fd6-0efc43160975', N'Brianna', N'H Martinez', CAST(N'2003-10-17' AS Date), NULL)
,(N'061d13a8-6621-4af1-a04d-0f0125038bdf', N'Robert', N'E Allen', CAST(N'2003-12-12' AS Date), NULL)
,(N'0dfc7bac-d1fc-4adc-b640-0f0207c16eec', N'Mandy', N'A Cai', CAST(N'2003-09-15' AS Date), NULL)
,(N'7b66516f-c35d-46a7-91aa-0f06dab264bf', N'Tracy', N'J el', CAST(N'2003-12-10' AS Date), NULL)
,(N'98f04665-83e8-44d1-875a-0f08f1164029', N'Dalton', N'C Powell', CAST(N'2004-04-23' AS Date), NULL)
,(N'c7c5b1c1-5edf-404c-8e5b-0f0b6d6d5813', N'Morgan', N'E James', CAST(N'2003-12-24' AS Date), NULL)
,(N'e7b6282d-a2a6-407a-a43d-0f0e6b551907', N'Armando', N'E Muñoz', CAST(N'2004-02-10' AS Date), NULL)
,(N'284974ce-bca1-42c9-a3f3-0f10d98aff32', N'Jennifer', N'J Ward', CAST(N'2004-01-26' AS Date), NULL)
,(N'4debe26c-e16e-4b17-9533-0f112798e874', N'Deborah', N'A Anand', CAST(N'2003-09-22' AS Date), NULL)
,(N'b4c821f2-26a6-4a0e-9bd3-0f1825986b3b', N'Rebecca', N'R Barley', CAST(N'2003-09-01' AS Date), NULL)
,(N'5beafc42-bcf8-4ba7-9011-0f18ac3155f3', N'Misty', N'A Jai', CAST(N'2003-12-24' AS Date), NULL)
,(N'391d5601-5ed1-43b4-aae6-0f19a6e22aec', N'Alexia', N'Washington', CAST(N'2003-06-07' AS Date), NULL)
,(N'c745a41a-9a38-4d69-9a90-0f1b9bee3652', N'James', N'Fine', CAST(N'2003-11-01' AS Date), NULL)
,(N'3b59b462-a2c5-4286-9fb5-0f1eface4073', N'Sharon', N'Anand', CAST(N'2003-12-27' AS Date), NULL)
,(N'9a583fd2-611f-4261-82b5-0f1f7474057a', N'Whitney', N'C Sanchez', CAST(N'2003-12-18' AS Date), NULL)
,(N'ef2b8669-1ac4-43cf-81a2-0f2052c23bc8', N'Juan', N'Reed', CAST(N'2004-06-12' AS Date), NULL)
,(N'e33f1154-a9e2-4764-872e-0f217d4b52f8', N'Abigail', N'E Bailey', CAST(N'2003-06-15' AS Date), NULL)
,(N'7aea0f4c-b612-4272-a573-0f2279f8dce6', N'Miguel', N'Perry', CAST(N'2004-07-20' AS Date), NULL)
,(N'57e3feee-aeed-4fad-bd76-0f2657fe205e', N'Luke', N'Hernandez', CAST(N'2004-01-30' AS Date), NULL)

GO
-- Actos de protesta
INSERT INTO ActosProtesta (ID,Titulo,Fecha ,Ciudad)
     VALUES (NewID(),'Por unas pensiones dignas',DateFromParts(2020,07,01),'Sevilla'),
	(NewID(),'Por unas pensiones dignas',DateFromParts(2020,07,02),'Córdoba'),
	(NewID(),'Por unas pensiones dignas',DateFromParts(2020,07,03),'Bilbao'),
	(NewID(),'Por unas pensiones dignas',DateFromParts(2020,07,04),'Madrid'),
	(NewID(),'Por unas pensiones dignas',DateFromParts(2020,07,05),'Barcelona'),
	(NewID(),'Por unas pensiones dignas',DateFromParts(2020,07,06),'Valencia'),
	(NewID(),'Por unas pensiones dignas',DateFromParts(2020,07,07),'A Coruña'),
	(NewID(),'Por unas pensiones dignas',DateFromParts(2020,07,08),'Granada')

INSERT INTO ActosProtesta (ID,Titulo,Fecha ,Ciudad)
     VALUES (NewID(),'Empleo estable y de calidad',DateFromParts(2018,09,21),'Sevilla'),
	(NewID(),'Empleo estable y de calidad',DateFromParts(2018,09,22),'Zaragoza'),
	(NewID(),'Empleo estable y de calidad',DateFromParts(2018,09,23),'Santander'),
	(NewID(),'Empleo estable y de calidad',DateFromParts(2018,09,24),'Málaga'),
	(NewID(),'Empleo estable y de calidad',DateFromParts(2018,09,25),'Cádiz'),
	(NewID(),'Empleo estable y de calidad',DateFromParts(2018,09,26),'Valencia'),
	(NewID(),'Empleo estable y de calidad',DateFromParts(2020,07,05),'Toledo'),
	(NewID(),'Empleo estable y de calidad',DateFromParts(2018,09,24),'Granada')
INSERT INTO ActosProtesta (ID,Titulo,Fecha ,Ciudad)
     VALUES (NewID(),'Queremos sombrita en verano',DateFromParts(2016,05,05),'Sevilla'),
	(NewID(),'Queremos sombrita en verano',DateFromParts(2017,05,05),'Mérida'),
	(NewID(),'Queremos sombrita en verano',DateFromParts(2017,05,04),'Córdoba'),
	(NewID(),'Queremos sombrita en verano',DateFromParts(2016,05,03),'Jaén'),
	(NewID(),'Queremos sombrita en verano',DateFromParts(2016,02,08),'Toledo')
INSERT INTO ActosProtesta (ID,Titulo,Fecha ,Ciudad)
	 VALUES (NewID(),'Que el Betis gane la liga',DateFromParts(2019,11,6),'Sevilla'),
	(NewID(),'Que el Trebujena C.F. juegue en primera',DateFromParts(2019,02,15),'Trebujena'),
	(NewID(),'Que el Cádiz gane la Copa',DateFromParts(2019,01,20),'Cádiz')
INSERT INTO ActosProtesta (ID,Titulo,Fecha ,Ciudad)
	 VALUES (NewID(),'Referendum',DateFromParts(2020,10,1),'Barcelona'),
	(NewID(),'Referendum',DateFromParts(2019,10,1),'Gerona'),
	(NewID(),'Referendum',DateFromParts(2018,10,1),'Tarragona')
INSERT INTO ActosProtesta (ID,Titulo,Fecha ,Ciudad)
	 VALUES (NewID(),'Netflix gratis para todos',DateFromParts(2018,12,8),'Madrid'),
	(NewID(),'Netflix gratis para todos',DateFromParts(2018,12,15),'Toledo'),
	(NewID(),'Netflix gratis para todos',DateFromParts(2018,12,7),'Valencia')

GO
-- Grupos
INSERT INTO Grupos ([Nombre],[FechaFundacion],[FechaDisolucion])
     VALUES ('Frente Popular Revolucionario',DATEFROMPARTS(1978,03,14), NULL),
	 ('Frente Revolucionario Popular',DATEFROMPARTS(1983,04,21),DATEFROMPARTS(2020,08,6)),
	 ('Hermandad Obrera',DATEFROMPARTS(1998,11,17),DATEFROMPARTS(2020,12,24)),
	 ('Club del Pollo Frito',DATEFROMPARTS(1953,2,11),NULL),
	 ('Yayoflautas',DATEFROMPARTS(1990,6,1),NULL),
	 ('Frente Patriótico Alpujarreño',DATEFROMPARTS(2004,09,10),NULL),
	 ('Amics del Baix Llobregat',DATEFROMPARTS(2007,10,9),NULL),
	 ('Federación de Peñas Béticas',DATEFROMPARTS(1920,12,17),NULL),
	 ('Ecologistas Reunidos',DATEFROMPARTS(2002,04,30),NULL),
	 ('Movimiento por la Cultura libre',DATEFROMPARTS(1995,02,14),NULL),
	 ('Club de fans de El Fari',DATEFROMPARTS(1983,08,1),NULL)
INSERT INTO Grupos ([Nombre],[FechaFundacion],[FechaDisolucion])
    VALUES ('Cayetanos en plan osea',DATEFROMPARTS(2005,08,14), NULL),
	('Movimiento por el cannabis',DATEFROMPARTS(2001,10,16), NULL)
GO
-- Categorias
INSERT INTO Categorias (ID,Nombre)
     VALUES (1,'Explosivos'), (2,'Armas blancas'), (3,'Protecciones'), (4,'Arrojadizas'), (5, 'Propaganda'), 
	 (6,'Pancartas'), (7,'Altavoces'), (8,'Banderas'), (9,'Instrumentos'), (10,'Vestimentas'), (11,'Decoración')

-- Materiales
INSERT INTO Materiales (Descripcion,Peligro,Categoria)
     VALUES ('Coctel molotov',5,1),('Pincho',4,2),('Cúter',5,2),('Mochila',1,3),('Escudo',2,3),('Pedrusco',3,4),('Adoquín',3,4),('Huevo',2,4),('Spray pintura',2,11),('Octavillas',1,5),('Pegatinas',1,5),('Pines',1,5),('Pancarta individual cutre',2,6),('Pancarta individual cita',2,6),('Pancarta individual currada',2,6),('Pancarta grande palos',2,6),('Pancarta grande cabecera',1,6),('Megáfono del chino',1,7),('Altavoz baterias peq',1,7),('Altavoz baterias grande',1,7)
INSERT INTO Materiales (Descripcion,Peligro,Categoria)
     VALUES ('Bandera Andalucía',2,8),('Bandera roja',2,8),('Bandera pollo',2,8),('Bandera republicana',2,8),('Bandera Cataluña',3,8),('Tambor peq',1,9),('Tambor grande',1,9),('Trompeta',1,9),('Piano de cola',1,9),('Gaita',1,9),('Peto amarillo',1,10),('Disfraz banquero',1,10),('Disfraz pirata',1,10),('Guirnaldas',2,11),('Petardos',3,1),('Cohetes',3,1)

-- Insertar GruposProtestas
Begin Transaction
DECLARE CURActos CURSOR FOR SELECT ID From ActosProtesta
Declare @IDActo UniqueIdentifier
Declare @IDGrupo SmallInt, @cont TinyInt, @NumConvocantes TinyInt

Open CurActos
Fetch Next From CurActos Into @IDActo
While @@FETCH_STATUS = 0
	BEGIN
		Set @NumConvocantes = Floor(RAND()*5)+1
		Set @cont = 0
		While @cont < @NumConvocantes
			BEGIN
			Set @IDGrupo = Floor(RAND()*13)+1
			IF Not EXISTS (SELECT * FROM GruposProtestas WHERE IDActo = @IDActo AND IDGrupo = @IDGrupo)
				BEGIN
				INSERT INTO GruposProtestas (IDGrupo,IDActo) VALUES (@IDGrupo,@IDActo)
				Set @cont += 1
				END
			END
		Fetch Next From CurActos Into @IDActo
	END
Close CurActos
Deallocate CurActos
Commit

GO
-- Insertar ActivistasProtestas
Begin Transaction
DECLARE CURActos CURSOR FOR SELECT ID From ActosProtesta
Declare @IDActivista UniqueIdentifier, @IDActo UniqueIdentifier
Declare @cont SmallInt, @NumAsistentes SmallInt

Open CurActos
Fetch Next From CurActos Into @IDActo
While @@FETCH_STATUS = 0
	BEGIN
		Set @NumAsistentes = Floor(RAND()*420)+30
		Set @cont = 0
		While @cont < @NumAsistentes
			BEGIN
			SET  @IDActivista =  (SELECT TOP 1 ID FROM Activistas ORDER BY NEWID())
			IF Not EXISTS (SELECT * FROM ActivistasProtestas WHERE IDActo = @IDActo AND IDActivista = @IDActivista)
				BEGIN
				INSERT INTO ActivistasProtestas (IDActivista,IDActo) VALUES (@IDActivista,@IDActo)
				Set @cont += 1
				END
			END
		Print 'Insertados ' + Cast(@cont AS VarChar) +' asistentes'
		Fetch Next From CurActos Into @IDActo
	END
Close CurActos
Deallocate CurActos
Commit
GO
-- Insertar incidentes
Begin Transaction
DECLARE CURActos CURSOR FOR SELECT ID From ActosProtesta
Declare @IDActo UniqueIdentifier, @Hora Time, @Incremento SmallInt
Declare @cont SmallInt, @NumIncidentes SmallInt

Open CurActos
Fetch Next From CurActos Into @IDActo
While @@FETCH_STATUS = 0
BEGIN
	Set @NumIncidentes = Floor(RAND()*5)
	Set @cont = 1
	While @cont <= @NumIncidentes
	BEGIN
		SET @Hora = DATEADD (minute,Floor(RAND()*360),TimeFromParts(20,0,0,0,0))
		INSERT INTO Incidentes (IDActo,Ord,Hora,Lugar,Descripcion) VALUES(@IDActo, @cont,@Hora,'Allí mismo','Corte del tráfico')
		Set @cont += 1
	END
	Fetch Next From CurActos Into @IDActo
END
Close CurActos
Deallocate CurActos
Commit
GO
Begin transaction
UPDATE Incidentes SET Descripcion = 'Quema de contenedores'
	Where (convert(bigint, convert (varbinary(8), IDActo, 1))+Ord)%4 = 1
UPDATE Incidentes SET Descripcion = 'Lanzamiento de objetos a la policia'
	Where (convert(bigint, convert (varbinary(8), IDActo, 1))+Ord)%4 = 2
UPDATE Incidentes SET Descripcion = 'Destrozos en el mobiliario urbano'
	Where (convert(bigint, convert (varbinary(8), IDActo, 1))+Ord)%4 = 3
GO
Commit
CREATE Table Cargos (
	ID TinyInt Not NULL, 
	Cargo VarChar(30) Not NULL
)
GO
INSERT INTO Cargos (ID,	Cargo) VALUES (1,'Desordenes públicos'), (2,'Atentado a la autoridad'), (3,'Desobediencia'), (4,'Daños'), (5,'Lesiones')
GO
-- Insertar Detenciones
Begin Transaction
DECLARE CURIncidentes CURSOR FOR SELECT IDActo, Hora, Ord From Incidentes
Declare @IDActivista UniqueIdentifier, @IDActo UniqueIdentifier, @Hora Time, @Ord SmallInt
Declare @cont SmallInt, @NumDetenciones SmallInt, @Cargo TinyInt

Open CurIncidentes
Fetch Next From CurIncidentes Into @IDActo, @Hora, @Ord
While @@FETCH_STATUS = 0
BEGIN
	Set @NumDetenciones = Floor(RAND()*25)
	Set @cont = 1
	While @cont <= @NumDetenciones
	BEGIN
		SET  @IDActivista =  (SELECT TOP 1 IDActivista FROM ActivistasProtestas Where IDActo = @IDActo ORDER BY NEWID())
		IF Not Exists (SELECT * FROM Detenciones Where IDActo = @IDActo AND OrdIncidente = @Ord AND IDActivista = @IDActivista)
			BEGIN
			SET @Cargo = Floor(RAND()*5)+1
			SET @Hora = DATEADD (minute,Floor(RAND()*60),@Hora)
			INSERT INTO Detenciones (Hora,Cargos,IDActivista,IDActo,OrdIncidente)
				VALUES (@Hora,(SELECT Cargo FROM Cargos Where ID = @Cargo),@IDActivista, @IDActo, @Ord)
			Set @cont += 1
			END
	END
	Fetch Next From CurIncidentes Into @IDActo, @Hora, @Ord
END
Close CurIncidentes
Deallocate CurIncidentes
Commit
GO
-- Insertar MaterialesIncidentes
Begin Transaction
DECLARE CURIncidentes CURSOR FOR SELECT IDActo, Ord From Incidentes
Declare @IDMaterial SmallInt, @IDActo UniqueIdentifier, @Ord SmallInt
Declare @cont SmallInt, @NumMateriales SmallInt

Open CurIncidentes
Fetch Next From CurIncidentes Into @IDActo, @Ord
While @@FETCH_STATUS = 0
BEGIN
	Set @NumMateriales = Floor(RAND()*5)
	Set @cont = 1
	While @cont <= @NumMateriales
	BEGIN
		SET  @IDMaterial =  (SELECT TOP 1 ID FROM Materiales ORDER BY NEWID())
		IF Not Exists (SELECT * FROM MaterialesIncidentes Where IDActo = @IDActo AND OrdIncidente = @Ord AND IDMaterial = @IDMaterial)
			BEGIN
			INSERT INTO MaterialesIncidentes (IDMaterial,IDActo,OrdIncidente,Cantidad)
				VALUES (@IDMaterial,@IDActo,@Ord,Floor(RAND()*20)+5)
			Set @cont += 1
			END
	END
	Fetch Next From CurIncidentes Into @IDActo, @Ord
END
Close CurIncidentes
Deallocate CurIncidentes
Commit



