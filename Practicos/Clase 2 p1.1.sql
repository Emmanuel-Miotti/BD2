
create database practico1;

use practico1;


/* Parte 1 */
/* Creo las tablas */
CREATE TABLE Proveedores(prov_id NUMERIC(5),
                         prov_nombre VARCHAR(30),
						 prov_mail VARCHAR(30),
						 prov_tel VARCHAR(30),
						 prov_otros VARCHAR(100),
						 CONSTRAINT PK_Prov PRIMARY KEY(prov_id))

/* Agrego UNIQUE del mail por olvido */
ALTER TABLE Proveedores ADD CONSTRAINT UK_MailProv UNIQUE(prov_mail)


CREATE TABLE Categorias(cat_id NUMERIC(5),
                        cat_descrip VARCHAR(30),
						cat_tipo VARCHAR(20),
						CONSTRAINT PK_Categ PRIMARY KEY(cat_id),
						CONSTRAINT CK_TipCat CHECK(cat_tipo IN ('Elect','Vehic','Electrod','Otros')))

CREATE TABLE Marcas(marca_id NUMERIC(5),
                    marca_descrip VARCHAR(30),
					marca_region VARCHAR(20),
					CONSTRAINT PK_Marca PRIMARY KEY(marca_id),
					CONSTRAINT CK_RegionMarca CHECK (marca_region IN ('Asia','Europa','America','USA')))

CREATE TABLE Items(item_id CHARACTER(10),
                   item_descrip VARCHAR(30),
				   prom_mensual NUMERIC(9),
				   cant_reorden NUMERIC(9),
				   cat_id NUMERIC(5),
				   marca_id NUMERIC(5),
				   CONSTRAINT PK_Items PRIMARY KEY(item_id),
				   CONSTRAINT FK_CatItem FOREIGN KEY(cat_id) REFERENCES Categorias(cat_id),
				   CONSTRAINT FK_MarcItem FOREIGN KEY(marca_id) REFERENCES Marcas(marca_id),
				   CONSTRAINT CK_Promedio CHECK (prom_mensual >= 10))

CREATE TABLE Nivel_Stock(item_id CHARACTER(10),
                         stock_fch DATE,
						 cantidad NUMERIC(9),
						 CONSTRAINT PK_Nivel PRIMARY KEY(item_id,stock_fch),
						 CONSTRAINT FK_ItemNivel FOREIGN KEY(item_id) REFERENCES Items(item_id))


CREATE TABLE Compras(item_id CHARACTER(10),
                     prov_id NUMERIC(5),
					 fecha DATE,
					 cantidad NUMERIC(9),
					 fch_inic DATE,
					 fch_fin DATE,
					 precio NUMERIC(12,2),
					 descuento NUMERIC(10,2),
					 CONSTRAINT PK_Compras PRIMARY KEY(item_id,prov_id,fecha),
					 CONSTRAINT FK_ItemCompra FOREIGN KEY(item_id) REFERENCES Items(item_id),
					 CONSTRAINT FK_ProvCompra FOREIGN KEY(prov_id) REFERENCES Proveedores(prov_id),
					 CONSTRAINT CK_DtoCompra CHECK (descuento >= 10 AND descuento <= 25))



-- a. Eliminar el campo prov_otros de la tabla Proveedores
 alter table Proveedores drop column prov_otros;

--b. Agregar el tipo de categoría ‘Cocina’ a la tabla Categorías
 alter table Categorias DROP CONSTRAINT CK_TipCat; 
 alter table Categorias ADD CONSTRAINT CK_TipCat CHECK(cat_tipo IN ('Elect','Vehic','Electrod','Otros', 'Cocina'))

--c. Cambiar el tamaño de la descripción de marcas y llevarlo a 50 caracteres
 alter table Marcas alter column marca_descrip varchar(50); 

--d. En la tabla Items agregar el campo color de 10 caracteres y el campo peso de números con decimales.
alter table Items ADD color character(10), peso decimal(10,2);


--e. Asegurarse que los campos fch_inic y fch_fin sean del tipo datetime
alter table Compras alter column fch_inic datetime;

alter table Compras alter column fch_fin datetime;

--f. Crear la tabla Paises que tenga un código de país de 4 caracteres que lo identifica, una descripción de 40
--caracteres y un nombre de continente de 30 caracateres.

CREATE TABLE Paises(
					cod_pais CHARACTER (4), --CHARACTER ES MAS EFICAS
					pais_descrip VARCHAR(40),
					pais_nombre VARCHAR(30),
					CONSTRAINT PK_pais PRIMARY KEY(cod_pais)
)


--g. Modificar la tabla Proveedores para que también se registre el país del proveedor, se debe crear la
--restricción correspondiente.
 alter table Proveedores add cod_pais character(4);
 alter table Proveedores add CONSTRAINT FK_CcodPais FOREIGN KEY(cod_pais) REFERENCES Paises(cod_pais),

