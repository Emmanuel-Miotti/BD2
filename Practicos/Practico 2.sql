

--Con dicha BD se pide:
--1. Insert un registro en cada una de las siguientes tablas:
--a. Shippers
--b. Employees
--c. Products
--d. Customers


INSERT INTO Shippers VALUES ( 'Shippers1', '12345678'),
							( 'Shippers2', '12345679'),
							( 'Shippers3', '12345680'),
							( 'Shippers4', '12345681')

INSERT INTO Employees VALUES ('Emmamnuel', 'Miotti','Titulo1', 'TitleOfCourtesy', GETDATE (), GETDATE (), 'DB 1928', 'Uruguay', 'Region', '12000', 'Contry', '12345678', 'Extension')

INSERT INTO Products VALUES ('NombreProducto', 1, 2, 'QuantitiPerUnit', 12, 2, 2, 3 )

INSERT INTO Customers VALUES ('Name', 'name', 'Tittle', 'Address', 'City', 'Region', 1212 )


--2. Crear un script que permita dar de alta por lo menos 3 registros a la misma vez en dichas
--tablas.

INSERT INTO Region VALUES   (5,'Uruguay'),
							(6,'Argentina'),
							(7,'Chile'),
							(8,'Br')

Select *
from Region


--3. Insertar un registro en la tabla Orders que contenga por lo menos los siguientes campos:
--a. OrderDate
--b. CustomerID
--c. EmployeeID
--d. ShipperID

INSERT INTO Orders (OrderDate, CustomerID, EmployeeID, ShipVia) VALUES ('29/8/2002' , 30,1,1)



--4. Relacionado a la orden anterior, cargar 5 líneas de detalle.
INSERT INTO OrderDetails VALUES (11079,1,13,9,0),
								(11079,1,13,9,0),
								(11079,1,13,9,0),
								(11079,1,13,9,0)


--5. A partir de los datos que tienen las tablas OrdersTemp y OrderTempDetails cargar las tablas
--Orders y OrderDetails respectivamente.


CREATE TABLE OrdersTemp (
							Orderid int,
							customerID char(5),
							employeeid int,

							constraint PK_OrderTemp primary key (Orderid),
							constraint FK_customerid_OrdersTemp foreign key (customerID) references Customers (customerID)
)

SELECT * from Orders ORDER BY 1 DESC;

insert into OrdersTemp values (1,'WOLZA',1)
insert into OrdersTemp values (2,'WOLZA',1)


CREATE TABLE OrderTempDetails (
								OrderID int,
								ProductID int,
								UnitPrice decimal,
								Quantity smallint,
								Discount double


								)


insert into Orders (customerID, employeeid) select customerID ,employeeid from OrdersTemp



--6. Crear un nuevo Shipper, luego ingrese una Orden que utilice dicho Shipper.



--7. Crear una tabla ShippersTemp y luego cargar en ella todos los registros que tiene la tabla
--Shippers.



--8. Insertar un registro en la tabla Categories y luego ingresar un registro en la tabla Products que
--utilice la categoría antes creada 

