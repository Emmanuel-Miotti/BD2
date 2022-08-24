create database practico1P2;

use practico1P2;

DROP DATABASE practico1Parte2;



create table CategoriaCliente (

	idCategoriaCliente int, 
	nombre varchar (20) not null, 
	descripcion varchar(30),

	constraint PK_CategoriaCliente primary key (idCategoriaCliente),  
	constraint UK_Nombre_CategoriaCliente UNIQUE (nombre)
)

create table Cliente (

idCliente int, 
RUT varchar(12) not null, 
nombreCompleto varchar (50) not null, 
idCategoria int not null, 

	constraint PK_Cliente primary key (idCliente), 
	constraint UK_rut unique (RUT),
	constraint FK_idCategoria_Cliente foreign key (idCategoria) 
	references CategoriaCliente(idCategoriaCliente)

)

Create table Producto (

	idProducto int, 
	nombre varchar(40) not null, 
	precio money not null, 
	descripcion varchar(50)

	constraint PK_Producto primary key(idProducto), 
	constraint UK_NombreProducto unique (nombre),
	constraint CK_PrecioProducto CHECK (precio > 0)
)

create table FacturaCabezal (

	idFactura int , 
	idCliente int not null,
	fecha date not null, 
	tipo character(2) not null, 

	constraint PK_FacturaCabezal primary key (idFactura),
	CONSTRAINT CK_TipoFacturaCabezal CHECK (tipo IN ('CR','CO')),
	constraint FK_idCliente_FC foreign key (idCliente) 
	references Cliente (idCliente)
)

create table FacturaDetalle (

	idFactura int , 
	idProducto int , 
	cantidad int not null, 
	importe numeric (5,3) not null, 
	
	constraint PK_FacturaDetalle primary key (idFactura, idProducto),
	constraint CK_Cantidad check (cantidad >0 and cantidad <10),
	constraint FK_IdFactura foreign key (idFactura) 
	references FacturaCabezal(idFactura), 
	constraint FK_IdProducto foreign key (idProducto) 
	references producto(idProducto)
)

--2. Modificar la tabla cliente agregando un campo dirección de hasta 30 caracteres

 alter table Cliente ADD direccion VARCHAR(30);

--3. Modificar la tabla facturacabezal de tal manera que permita tener el estado DE
--(Debito).

 alter table FacturaCabezal DROP CONSTRAINT CK_TipoFacturaCabezal;
 alter table FacturaCabezal ADD CONSTRAINT CK_TipoFacturaCabezal CHECK (tipo IN ('CR','CO','DE'));

--4. Crear una tabla Telefonos con la ci como identificador y una descripción de hasta 30
--caracteres, luego incluir la relación de esta tabla con la tabla cliente.

CREATE TABLE Telefonos(

ci int,
descripción varchar(30),
idCliente int,
CONSTRAINT PK_ci_Telefono PRIMARY KEY(ci),
CONSTRAINT FK_idCliente FOREIGN KEY(idCliente) REFERENCES Cliente(idCliente),
)


--5. Crear los índices de todas las claves foráneas

CREATE INDEX I_id_CategoriaCliente ON CategoriaCliente (idCategoriaCliente)

CREATE INDEX I_id_Cliente ON Cliente (idCliente)

CREATE INDEX I_id_FacturaCabezal ON FacturaCabezal (idFactura)

CREATE INDEX I_id_Producto ON Producto (idProducto)

--6. Script que permite dar de alta a por lo menos 2 registros de cada tabla, debe
--tenerse en cuenta el orden de ingreso de cada dato para cumplir con las restricciones
--de integridad

INSERT INTO producto VALUES (1, 'Emmanuel', 1000.00, 'Persona');
INSERT INTO producto VALUES (2, 'Nahuel', 1000.00, 'Persona');
INSERT INTO producto VALUES (3, 'noc', 1000.00, 'Persona');
INSERT INTO producto VALUES (4, 'fffff', 1000.00, 'Persona');
SELECT * FROM producto

INSERT INTO FacturaDetalle VALUES (1, 1, 5, 0);
INSERT INTO FacturaDetalle VALUES (2, 2, 5, 0);
INSERT INTO FacturaDetalle VALUES (3, 1, 5, 0);
INSERT INTO FacturaDetalle VALUES (4, 2, 5, 0);
SELECT * FROM FacturaDetalle


INSERT INTO FacturaCabezal VALUES (1,280110, GETDATE (), 'CR'); 
INSERT INTO FacturaCabezal VALUES (2,280111, GETDATE (), 'CR'); 
INSERT INTO FacturaCabezal VALUES (3,2801103, '2014-03-11', 'CR'); 
INSERT INTO FacturaCabezal VALUES (4,2801113, '2014-03-11', 'CR'); 
SELECT * FROM FacturaCabezal

INSERT INTO Cliente VALUES(280110, 203423411, 'Emmanuel Miotti', 1 , 'Defensa 1827' ); 
INSERT INTO Cliente VALUES(280111, 203423111, 'Nahuel Miotti', 2 , 'Defensa 1827' ); 
INSERT INTO Cliente VALUES(2801103, 2034233411, 'NOSE Miotti', 1 , 'Defensa 1827' ); 
INSERT INTO Cliente VALUES(2801113, 2034233111, 'F Miotti', 2 , 'Defensa 1827' ); 
SELECT * FROM Cliente

INSERT INTO CategoriaCliente VALUES(1, 'SA', 'Sociedad Anónima');
INSERT INTO CategoriaCliente VALUES(2, 'SRL', 'Sociedad'); 
SELECT * FROM CategoriaCliente

INSERT INTO Telefonos VALUES (097777777, 'Personal', 1 );
INSERT INTO Telefonos VALUES (097777778, 'Empresa', 2 );
SELECT * FROM Telefonos

--7. Script para cambiar a DE el estado de las facturas que están en CR y que tuvieron
--por lo menos un producto facturado.

UPDATE FacturaCabezal SET tipo = 'CO' WHERE tipo = 'CR'


--8. Obtener la información de los productos facturados/vendido en el mes de marzo del
--2014, la consulta debe retornar factura, nombre de los productos, cantidad y precio.

SELECT fd.idFactura AS 'Id Factura',fd.cantidad,p.descripcion, fd.importe, fc.fecha
FROM producto p
INNER JOIN FacturaDetalle fd ON fd.idProducto = p.idproducto
INNER JOIN FacturaCabezal fc ON fc.idFactura = fd.idProducto
WHERE YEAR(fc.fecha) = 2014 AND MONTH(fc.fecha) = 03

UPDATE FacturaCabezal SET fecha = '2014-03-23' WHERE fecha = '2022-08-23'

--9. Optimizar la consulta del punto 8 con la creación de los índices que crea necesarios


