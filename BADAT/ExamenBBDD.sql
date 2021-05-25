CREATE database Agua

-- He tenido que crear ID en algunas tablas ya que no tenían atributo identificador (PK).
 


--CONFEDERACIONES: ID(PK), titulo, texto,fechaHoraPresentacion
CREATE TABLE Confederaciones(
IDConfederaciones int Constraint PK_Confederaciones Primary Key 
,titulo varChar(30)
,texto varChar(30)
,fechaHoraPresentacion varChar(20)
)

--ACUAITEMS: ID (PK), nombre, IDConfederaciones (FK Confederaciones Not NULL)
CREATE TABLE Acuaitems(
IDAcuaitems int Constraint PK_Acuaitems Primary Key 
,nombre varChar(15)
,IDConfederaciones int Constraint FK_Acuaitems Foreign Key REFERENCES Confederaciones Not NULL
)

--CANALES: ID (PK), longitud, caudalMaximo,fechaInauguracion IDAcuaitems (FK Acuaitems Not NULL) 
CREATE TABLE Canales(
IDCanales int Constraint PK_Canales Primary Key
,longitud float
,caudalMaximo varChar (5)
,caudalMinimo varChar(5)
,fechaInauguracion date
,IDAcuaitems int Constraint FK_Canales Foreign Key REFERENCES Acuaitems Not NULL
)

--RESERVAS: ID (PK), nivelMaximo, nivelMinimo, cantidadAlmacenada, capacidadMaxima
CREATE TABLE Reservas(
IDReservas int Constraint PK_Reservas Primary Key
,nivelMaximo varChar(5)
,nivelMinimo varChar(5)
,cantidadAlmacenada float
,capacidadMaxima float
)

--CENRALESHIDROELECTRICAS: ID(PK), nombre, potencia, empresa
CREATE TABLE CentralesHidroelectricas(
IDCentralHidroelectrica int Constraint PK_CentralesHidroelectricas Primary Key 
,nombre varChar(15)
,potencia float
,empresa varChar(15)
)

--EDAR: nombre(PK), direccion. empresaGestora,capacidad IDCanales (FK Canales NULL) 
CREATE TABLE Edar (
Nombre varChar(15) Constraint PK_Edar Primary Key
,direccion varChar (30)
,empresaGestora varChar(15)
,capacidad float
,IDCanales int Constraint FK_Edar Foreign Key REFERENCES Canales NULL
)

--POTABILIZADORAS: ID (PK) capacidad, empresaGestora
CREATE TABLE Potabilizadoras (
IDPotabilizadoras int Constraint PK_Potabilizadoras Primary Key
,capacidad float
,empresaGestora varChar(15)
)

--POBLACIONES: nombre(PK),provincia(PK), numHabitantes, compañiaSuministradora
CREATE TABLE Poblaciones (
Nombre varChar(15) Constraint PK_Poblaciones Primary Key 
,Provincia varChar(10) Constraint PK_Poblaciones Primary Key
,numHabitantes int
,compañiaSuministradora varChar(15)
)

--COMUNIDADREGRANTES: ID (PK) localidad, numeroSocios, hectareasRegadio
CREATE TABLE ComunidadRegantes(
IDComunidadRegantes int Constraint PK_ComunidadRegantes Primary Key
,localidad varChar(15)
,numeroSocios int
,hectareasRegadio float
)

--REDES: ID(PK), nombre
CREATE TABLE Redes (
IDRedes int Constraint PK_Redes Primary Key
,nombre varChar(15)
)

--TOMA: ID(PK), latitud, longitud, potencia, caudal, IDRedes (FK Red NULL)
CREATE TABLE Toma(
IDToma int Constraint PK_Toma Primary Key
,latitud float
,longitud float
,potencia float
,caudal float
,IDRedes int Constraint FK_Toma Foreign Key REFERENCES Redes NULL
)

--EdarPoblaciones: nombreEdar(FK Edar) nombrePoblaciones (FK Poblaciones) provinciaPoblaciones (FK Poblaciones)
CREATE TABLE EdarPoblaciones (
nombreEdar varChar(15) Constraint FK_EdarPoblaciones REFERENCES Edar
,nombrePoblaciones varChar(15) Constraint FK_EdarPoblaciones REFERENCES Poblaciones
,provinciaPoblaciones varChar(10) Constraint FK_EdarPoblaciones REFERENCES Poblaciones
)

--EdarComunidadregantes: nombreEdar (FK Edar) IDComunidadregantes (FK Comunidadregantes)
CREATE TABLE EdarComunidadregantes(
nombreEdar varChar(15) Constraint FK_EdarComunidadregantes REFERENCES Edar
,IDComunidadregantes int Constraint FK_EdarComunidadRegantes REFERENCES ComunidadRegantes
)

--PoblacionPotabilizadora: nombrePoblaciones(FK Poblaciones) provinciaPoblaciones(FK Poblaciones) IDPotabilizadoras (FK Potabilizadoras) 
CREATE TABLE PoblacionPotabilizadora(
nombrePoblaciones varChar(15) Constraint FK_PoblacionPotabilizadora REFERENCES Poblaciones
,provinciaPoblaciones varChar(10) Constraint FK_PoblacionPotabilizadora REFERENCES Poblaciones
,IDPotabilizadoras int Constraint FK_PoblacionPotabilizadora REFERENCES Potabilizadoras
)