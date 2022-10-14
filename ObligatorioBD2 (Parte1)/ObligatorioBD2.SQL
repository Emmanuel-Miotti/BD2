CREATE DATABASE ObligatorioBD2;

USE ObligatorioBD2;

/*
Se lleva registros de los Países y Cuidades que realizan competiciones. Para los países se quiere 
registrar Código y nombre datos que deben respetar la norma “ISO 3166-1 alfa-3”
Para las ciudades se debe tener el país a la que pertenece y el nombre de la ciudad. Tener en cuenta
que existen ciudades con igual nombre en distintos países
*/
Create table Pais (

	codigoPais int not null,
	nombre varchar(20) not null,

	constraint PK_Pais primary key (codigoPais),
	constraint UK_Nombre_Pais UNIQUE (nombre)
)

Create table Ciudad (

	--id?
	nombreCiudad varchar(20) not null,
	codigoPais int not null,

	constraint PK_Ciudad primary key (nombreCiudad),
	constraint FK_CodigoPais foreign key (codigoPais) references Pais(codigoPais)
)
/*
Sobre las Competencias se sabe que tienen un nombre que las identifica, un año en la que realizo, y 
el país que fue anfitrión de la misma.
*/
Create table Competencia (

	nombreCompetencia varchar(20)not null,
	anioRealizo date not null, --año en la que realizo FALTA
	codigoPais int not null,

	constraint PK_Competencia primary key (nombreCompetencia),
	constraint FK_Codigo_Pais_Competencia foreign key (codigoPais) references Pais(codigoPais),
)
/*
En cada competencia se presentan Federaciones de distintos Países. Las federaciones están
formadas por los participantes que la integran, se identifican por un nombre, y se registra el país al 
que representan. Además, las Federaciones llevan registro de la cantidad de días que les llevo la
preparación de cada participante para cada competencia, así como un importe estimado del costo de 
la preparación del participante
*/
Create table Federacion (

	nombreFederacion varchar(30) not null,
	cantidadDias int not null,
	costo decimal not null,
	codigoPais int not null,

	constraint PK_Federacion primary key (nombreFederacion),
	constraint FK_Codigo_Pais_Federacion foreign key (codigoPais) references Pais(codigoPais)

)
/*
De los participantes se sabe que tienen un pasaporte que los identifica (3 letras y 6 dígitos), y se sabe 
el nombre, país de origen (nacionalidad), sexo, fecha de nacimiento. Los participantes solo pueden 
competir como representante de su país
*/

Create table Participante (

	pasaporte varchar(9) not null, --pasaporte que los identifica (3 letras y 6 dígitos)
	nombre varchar(20) not null,
	sexo character(2) not null CHECK (sexo IN ('H','M','IN')),
	fechaNacimiento date not null,
	codigoPais int not null foreign key (codigoPais) references Pais(codigoPais),

	constraint PK_Participante primary key (pasaporte),
	--constraint UK_codigoPais UNIQUE codigoPais,
	--constraint CK_sexo CHECK (sexo IN ('H','M','IN')),
	--constraint FK_Codigo_Pais_nacionalidad foreign key (codigoPais) references Pais(codigoPais),

)
/*
Finalmente se necesita registrar los datos de las Pruebas de las Competencia. Las pruebas se 
identifican por un autonumérico y se sabe: el día, la hora de inicio, la hora de fin, la ciudad donde se 
realizó, el tipo de prueba (disciplina), los participantes que compitieron, y los resultados. Las pruebas 
son individuales (no por equipos) y se registra esta información una vez que termino cada Prueba, es 
decir se conocen todos los datos
*/
Create table Prueba (

	idPrueba int not null, --FALTA identifican por un autonumérico 
	dia date not null,
	horaInicio time not null, --time,'12:05:06.0000000'
	horaFin time not null, 
	disciplina varchar(20) not null,
	nombreCiudad varchar(20) not null,
	participante varchar(10) not null,
	resultado int, --????Falta

	constraint PK_Prueba primary key (idPrueba),
	constraint FK_Nombre_Ciudad foreign key (nombreCiudad) references Ciudad(nombreCiudad),
	constraint FK_Participante foreign key (participante) references Participante(pasaporte),
)

Select * From Pais
Select * From Ciudad
Select * From Competencia
Select * From Federacion
Select * From Participante
Select * From Prueba

INSERT INTO Pais(codigoPais, nombre) VALUES (1, 'Uruguay');
INSERT INTO Pais(codigoPais, nombre) VALUES (2, 'Australia');
INSERT INTO Pais(codigoPais, nombre) VALUES (3, 'Bolivia');
INSERT INTO Pais(codigoPais, nombre) VALUES (4, 'Argentina');
INSERT INTO Pais(codigoPais, nombre) VALUES (5, 'China');
INSERT INTO Pais(codigoPais, nombre) VALUES (6, 'Ecuador');
INSERT INTO Pais(codigoPais, nombre) VALUES (7, 'Chile');
INSERT INTO Pais(codigoPais, nombre) VALUES (8, 'Brasil');

INSERT INTO Ciudad
VALUES ('Montevideo', 1),
	   ('Canelones', 1),
	   ('Mercedes', 1),
	   ('Minas', 1),
	   ('Salto', 1);

INSERT INTO Competencia VALUES
('Atletismo',YEAR(2022),1),
('Ciclismo',YEAR(2022),2),
('Natación',YEAR(2022),3),
('Remo',YEAR(2022),1),
('Triatlón',YEAR(2022),2),
('Vela',YEAR(2022),3),
('Rugby',YEAR(2022),4),
('Voleibol',YEAR(2022),2),
('Salto',YEAR(2022),3),
('Golf',YEAR(2022),1),
('Baloncesto',YEAR(2022),4);

INSERT INTO Participante VALUES
('ABC123456','Emmanuel','H','1999-12-22', 1);

INSERT INTO Federacion VALUES
('URY',20 ,50000 , 1);
