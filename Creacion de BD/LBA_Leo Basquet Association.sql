create database LBA_Leo_Basket_Association
go
use LBA_Leo_Basket_Association
go

create table LBA_Paises
	(
		ID CHAR(3) NOT NULL CONSTRAINT PK_Paises PRIMARY KEY,
		DENOMINACION VARCHAR(25) NOT NULL,
		UE BIT NOT NULL
	)

CREATE TABLE LBA_Jugadores
	(
		Licencia CHAR(10) NOT NULL CONSTRAINT PK_LBA_Jugadores PRIMARY KEY,
		Nombre VARCHAR(20) NOT NULL,
		Apellidos VARCHAR(30) NOT NULL,
		FechaNac DATE NULL,
		Dorsal TINYINT NOT NULL,
		Posicion CHAR(1) NULL,
		Nacionalidad CHAR(3),
		CONSTRAINT FK_LBA_Paises FOREIGN KEY (Nacionalidad) REFERENCES LBA_Paises (ID)
	)

CREATE TABLE LBA_Canchas
	(
		ID TINYINT IDENTITY NOT NULL CONSTRAINT LBA_Canchas PRIMARY KEY,
		Denominacion VARCHAR(30) NOT NULL,
		Direccion VARCHAR(30),
		Localidad VARCHAR(25) NOT NULL
	)

CREATE TABLE LBA_Equipos
	(
		Codigo CHAR(3) NOT NULL CONSTRAINT PK_LBA_Equipos PRIMARY KEY,
		Nombre VARCHAR(30) NOT NULL,
		Fecha_Fundacion DATE,
		Localidad VARCHAR(25) NOT NULL,
		ID_Cancha TINYINT,
		CONSTRAINT FK_LBA_Canchas FOREIGN KEY (ID_Cancha) REFERENCES LBA_Canchas (ID),
	)

CREATE TABLE LBA_Partidos
	(
		ID SMALLINT NOT NULL CONSTRAINT PK_LBA_Partidos PRIMARY KEY,
		Fecha_Hora SMALLDATETIME NOT NULL,
		ID_Local CHAR(3) NOT NULL,
		ID_Visitante CHAR(3) NOT NULL,
		Puntos_Local TINYINT,
		Puntos_Visitante TINYINT,
		CONSTRAINT FK_LBA_EquipoLocal FOREIGN KEY (ID_Local) REFERENCES LBA_Equipos(CODIGO),
		CONSTRAINT FK_LBA_EquipoVis FOREIGN KEY (ID_Visitante) REFERENCES LBA_Equipos(CODIGO)
	)

CREATE TABLE LBA_Juega
	(
		Licencia CHAR(10) NOT NULL,
		ID_Partido SMALLINT NOT NULL,
		Minutos INT,
		Tiros1 TINYINT,
		Tiros2 TINYINT,
		Tiros3 TINYINT,
		Puntos1 TINYINT,
		Puntos2 TINYINT,
		Puntos3 TINYINT,
		Personales TINYINT,
		CONSTRAINT FK_LBA_Jugadores FOREIGN KEY (Licencia) REFERENCES LBA_Jugadores (Licencia),
		CONSTRAINT FK_LBA_Partidos FOREIGN KEY (ID_Partido) references LBA_Partidos (ID)
	)

