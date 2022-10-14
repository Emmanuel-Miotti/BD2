CREATE DATABASE ObligatorioBD2;

USE ObligatorioBD2;

/*
Se lleva registros de los Pa�ses y Cuidades que realizan competiciones. Para los pa�ses se quiere 
registrar C�digo y nombre datos que deben respetar la norma �ISO 3166-1 alfa-3�
Para las ciudades se debe tener el pa�s a la que pertenece y el nombre de la ciudad. Tener en cuenta
que existen ciudades con igual nombre en distintos pa�ses
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
Sobre las Competencias se sabe que tienen un nombre que las identifica, un a�o en la que realizo, y 
el pa�s que fue anfitri�n de la misma.
*/
Create table Competencia (

	nombreCompetencia varchar(20),
	anioRealizo date, --a�o en la que realizo FALTA
	codigoPais int,

	constraint PK_Competencia primary key (nombreCompetencia),
	constraint FK_Codigo_Pais_Competencia foreign key (codigoPais) references Pais(codigoPais),
)
/*
En cada competencia se presentan Federaciones de distintos Pa�ses. Las federaciones est�n
formadas por los participantes que la integran, se identifican por un nombre, y se registra el pa�s al 
que representan. Adem�s, las Federaciones llevan registro de la cantidad de d�as que les llevo la
preparaci�n de cada participante para cada competencia, as� como un importe estimado del costo de 
la preparaci�n del participante
*/
Create table Federacion (

	nombreFederacion varchar(30),
	cantidadDias int,
	costo decimal,
	codigoPais int,

	constraint PK_Federacion primary key (nombreFederacion),
	constraint FK_Codigo_Pais_Federacion foreign key (codigoPais) references Pais(codigoPais)

)
/*
De los participantes se sabe que tienen un pasaporte que los identifica (3 letras y 6 d�gitos), y se sabe 
el nombre, pa�s de origen (nacionalidad), sexo, fecha de nacimiento. Los participantes solo pueden 
competir como representante de su pa�s
*/

Create table Participante (

	pasaporte varchar(9), --pasaporte que los identifica (3 letras y 6 d�gitos)
	nombre varchar(20),
	sexo character(2) CHECK (sexo IN ('H','M','IN')),
	fechaNacimiento date,
	codigoPais int foreign key (codigoPais) references Pais(codigoPais),

	constraint PK_Participante primary key (pasaporte),
	--constraint UK_codigoPais UNIQUE codigoPais,
	--constraint CK_sexo CHECK (sexo IN ('H','M','IN')),
	--constraint FK_Codigo_Pais_nacionalidad foreign key (codigoPais) references Pais(codigoPais),

)
/*
Finalmente se necesita registrar los datos de las Pruebas de las Competencia. Las pruebas se 
identifican por un autonum�rico y se sabe: el d�a, la hora de inicio, la hora de fin, la ciudad donde se 
realiz�, el tipo de prueba (disciplina), los participantes que compitieron, y los resultados. Las pruebas 
son individuales (no por equipos) y se registra esta informaci�n una vez que termino cada Prueba, es 
decir se conocen todos los datos
*/
Create table Prueba (

	idPrueba int, --FALTA identifican por un autonum�rico 
	dia date,
	horaInicio time, --time,'12:05:06.0000000'
	horaFin time,
	disciplina varchar(20),
	nombreCiudad varchar(20),
	participante varchar(10),
	resultado int,

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
('Nataci�n',YEAR(2022),3),
('Remo',YEAR(2022),1),
('Triatl�n',YEAR(2022),2),
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