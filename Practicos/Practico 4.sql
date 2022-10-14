--1. Implementar un procedimiento almacenado que reciba n par�metros (a ser definidos por el
--alumno) e inserte un registro en la tabla Shippers si dicho S h i p p e r no existe, si
--existe que modifique sus datos con los nuevos datos enviados, luego modifique dicho
--procedimiento de tal manera que retorne como par�metro de salida el c�digo asignado a
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


--2. Realizar un procedimiento almacenado que le baje un x% (recibido com o par�metro)
--el precio unitario a los 10 productos menos pedidos de un a�o dado.


CREATE PROCEDURE Descuento @



--3. Mediante un procedimiento almacenado que reciba un c�digo de empleado y un rango de
--fechas, cambiar los pa�ses de entrega de las �rdenes para que coincida con el pa�s del
--empleado dado.




--4. Crear un procedimiento almacenado que reciba un rango de fechas y un n�mero de la lista
--(10, 20, 30, 40), el procedimiento debe mostrar los nombres
--de los clientes que tengan m�s de n �rdenes en el rango de fechas, siendo n uno de los 4
--n�meros recibidos como par�metro, el procedimiento debe validar que los n�meros sean
--uno de los 4 solicitados.




--5. Crear un procedimiento almacenado que para un producto dado, verifique si tiene
--cantidad en stock, si la tiene verificar que no est� marcado como discontinuado
--(discontinued=1), de ser as� desmarcarlo (discontinued=0).




--6. Crear una funci�n que reciba como par�metro un c�digo de producto y retorne el valor de
--inventario de dicho producto de acuerdo a su precio unitario y a su cantidad




--7. Crear una funci�n que para un rango de fechas dado y un cliente, retorne el mayor
--importe total de las �rdenes para dicho cliente y rango de fechas.





--8. Dado un n�mero de orden, realizar una funci�n que retorne el precio total a
--pagar por el cliente por dicha orden, el precio total debe incluir el precio del producto
--(unitprice) por la cantidad (quantity) menos el descuento (discount) mas los costos de
--env�o (freight)




--9. Dado un rango de fechas, implementar una funci�n que retorne el nombre del pa�s al cual
--se le envi� la orden de menor precio.






--10. Dado un empleado, una v�a de transporte y un producto, retornar la cantidad de �rdenes de
--dicho empleado, v�a de transporte y producto.

