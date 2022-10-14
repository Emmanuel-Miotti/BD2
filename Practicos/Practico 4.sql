--1. Implementar un procedimiento almacenado que reciba n parámetros (a ser definidos por el
--alumno) e inserte un registro en la tabla Shippers si dicho S h i p p e r no existe, si
--existe que modifique sus datos con los nuevos datos enviados, luego modifique dicho
--procedimiento de tal manera que retorne como parámetro de salida el código asignado a
--los nuevos shippers (puede utilizar @@IDENTITY o SCOPE_IDENTITY())


--ALTER PROCEDURE procedimientoN @ID int,@Nombre varchar(40), @Numero int OUT

CREATE PROCEDURE procedimientoN @ID int,@Nombre varchar(40), @Numero int OUT
AS
	BEGIN
			if exists (Select * from Suppliers s where s.SupplierID = @ID )

				update Shippers set CompanyName = @Nombre Where ShipperID = @ID

			else

				BEGIN
					INSERT INTO Suppliers(SupplierID,CompanyName) VALUES (@ID,@Nombre)
					SET @Numero = @@IDENTITY
				END


	END
				DECLARE @num int
				EXEC procedimientoN 1,'ANA', @num OUT


--2. Realizar un procedimiento almacenado que le baje un x% (recibido com o parámetro)
--el precio unitario a los 10 productos menos pedidos de un año dado.


CREATE PROCEDURE Descuento @



--3. Mediante un procedimiento almacenado que reciba un código de empleado y un rango de
--fechas, cambiar los países de entrega de las órdenes para que coincida con el país del
--empleado dado.




--4. Crear un procedimiento almacenado que reciba un rango de fechas y un número de la lista
--(10, 20, 30, 40), el procedimiento debe mostrar los nombres
--de los clientes que tengan más de n órdenes en el rango de fechas, siendo n uno de los 4
--números recibidos como parámetro, el procedimiento debe validar que los números sean
--uno de los 4 solicitados.




--5. Crear un procedimiento almacenado que para un producto dado, verifique si tiene
--cantidad en stock, si la tiene verificar que no esté marcado como discontinuado
--(discontinued=1), de ser así desmarcarlo (discontinued=0).




--6. Crear una función que reciba como parámetro un código de producto y retorne el valor de
--inventario de dicho producto de acuerdo a su precio unitario y a su cantidad




--7. Crear una función que para un rango de fechas dado y un cliente, retorne el mayor
--importe total de las órdenes para dicho cliente y rango de fechas.





--8. Dado un número de orden, realizar una función que retorne el precio total a
--pagar por el cliente por dicha orden, el precio total debe incluir el precio del producto
--(unitprice) por la cantidad (quantity) menos el descuento (discount) mas los costos de
--envío (freight)




--9. Dado un rango de fechas, implementar una función que retorne el nombre del país al cual
--se le envió la orden de menor precio.






--10. Dado un empleado, una vía de transporte y un producto, retornar la cantidad de órdenes de
--dicho empleado, vía de transporte y producto.

