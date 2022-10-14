





--1. Ejecutar el script NorthWind.sql y verificar que se crearon todas las estructuras con sus datos
--correspondientes


--2. Mostrar los datos de los clientes (CUSTOMERS) para todas las ordenes con
--destino a Brasil (Brazil)

Select *
From Customers
Where Country = 'Brazil';

--3. Mostrar los nombres de las compañías de envío (SHIPPERS) utilizadas para envíos de ordenes a
--Francia (France)

Select CompanyName
From Shippers

--4. Mostrar el nombre del comprador (ShipName) , el nombre del producto (ProductName) y el
--descuento otorgado (Discount) para todas las ordenes con un descuento menor o igual a 0,15

Select o.ShipName, p.ProductName, od.Discount
From Orders o
INNER JOIN OrderDetails od ON od.OrderID = o.OrderID AND od.Discount <= 0.15
INNER JOIN Products p ON p.ProductID = od.ProductID


--5. Mostrar numero de orden, fecha de envío y datos de la región donde se
--enviaron ordenes en el año 1997

Select OrderID, Year(ShippedDate) as Anio, MONTH(ShippedDate) as Mes, DAY(ShippedDate) AS Dia, ShipRegion
From Orders
Where YEAR(ShippedDate) = 1997


--6. Mostrar el nombre de los empleados que prepararon ordenes con destino
--Alemania (Germany) cuyo precio unitario es superior a 20 o cuya cantidad es mayor a 30.

Select e.LastName, o.ShipCountry as Destino, o.Freight as Precio, od.Quantity as Cantidad
From Employees e
INNER JOIN Orders o ON o.EmployeeID = E.EmployeeID
INNER JOIN OrderDetails od ON od.OrderID = o.OrderID
Where o.ShipCountry = 'Germany' AND o.Freight > 20 OR od.Quantity > 30

--7. Mostrar los nombres de los proveedores (Supplier) que venden productos que no superen las 10 
--unidades en las órdenes en las que figuran. 

Select s.CompanyName
From Suppliers s
INNER JOIN Products p ON p.SupplierID = s.SupplierID
INNER JOIN OrderDetails o ON o.ProductID = p.ProductID
--??????????????????
Select *
From Suppliers


--8. Mostrar la descripción de las categorias de productos que están en ordenes que no tienen
--descuentos (discount=0).

Select c.Description, od.Discount as Descuentos
From Orders o
INNER JOIN OrderDetails od ON od.OrderID = o.OrderID AND od.discount = 0
INNER JOIN Products p ON p.ProductID = od.ProductID
INNER JOIN Categories c ON c.CategoryID = p.CategoryID

--9. Mostrar numero de orden, nombre de la compañía cliente, contacto del cliente, código de
--producto, nombre de producto fecha de la orden,
--cantidad, precio unitario y precio total para todas las ordenes solicitadas en julio de 1996.

Select o.OrderID, c.CompanyName, c.Phone, p.ProductID, p.ProductName, o.shippedDate, od.Quantity, od.UnitPrice
From Customers c
INNER JOIN Orders o ON o.CustomerID = c.CustomerID
INNER JOIN OrderDetails od ON od.OrderID = o.OrderID 
INNER JOIN Products p ON p.ProductID = od.ProductID
Where YEAR(o.shippedDate) = 1996 AND MONTH(o.shippedDate) = 07 --FALTAA  precio total



--10. Mostar los nombres de los proveedores que proveen productos que están en
--ordenes del año 1998 con destino USA.

Select s.ContactName
From Suppliers s
INNER JOIN Products p ON p.SupplierID = s.SupplierID
INNER JOIN OrderDetails od ON od.ProductID = p.ProductID
INNER JOIN Orders o ON o.OrderID = od.OrderID
WHERE YEAR(o.ShippedDate) = 1998 AND o.ShipCountry = 'USA';


select *
from Orders

--11. Mostrar los datos de las regiones a las que pertenecen los empleados que hicieron ordenes con
--destino a Rio de Janeiro.


select *
from Orders o
INNER JOIN Employees e ON e.EmployeeID = o.EmployeeID
WHERE o.ShipCity = 'Rio de Janeiro';


--12. Mostrar todos los datos de los productos que se ordenaron a un precio
--diferente al establecido para cada uno.


Select od.UnitPrice, p.UnitPrice
From Orders o
INNER JOIN OrderDetails od ON od.OrderID = o.OrderID 
INNER JOIN Products p ON p.ProductID = od.ProductID

--FALTAAAAAAAAAAAAAAAAAAA

--13. Mostrar el importe total de las ordenes del año 1996.

SELECT COUNT(od.UnitPrice)
FROM Orders o
INNER JOIN OrderDetails od ON od.OrderID = o.OrderID
WHERE YEAR(o.ShippedDate) = 1996

--14. Mostrar la cantidad promedio de las ordenes del año 1997.

SELECT AVG(OD.Quantity)
FROM Orders o
INNER JOIN OrderDetails od ON od.OrderID = o.OrderID
WHERE YEAR(o.ShippedDate) = 1996

--15. Mostrar el mayor importe unitario, el menor importe unitario, la mayor cantidad y la menor
--cantidad de las ordenes de los años 1996 y 1997.


--16. Mostrar la menor fecha de envío de todas las ordenes de 1998 con destino a
--Bélgica (Belgium).


--17. Mostrar la cantidad de países diferentes a los que se le envían ordenes.


--18. Mostrar para cada cliente su nombre, la cantidad de ordenes procesadas y el importe total de las
--mismas en el año 1996 (ordenar los resultados de mayor importe a menor importe)


--19. Mostrar los datos de los productos y el mayor descuento aplicado a cada uno de ellos.


--20. Mostrar la cantidad enviada por día para el mes de noviembre de 1996.


--21. Mostrar los nombres de los productos y la cantidad de ordenes en las que cada uno aparece.

--22. Mostrar los nombres de los productos cuya cantidad de órdenes es mayor a 50


--23. Mostrar los datos de los productos cuyo mayor descuento aplicado supera el 0.20


--24. Mostrar nombre de cliente y contacto para todos los clientes que hicieron más de 8 pedidos en el
--año 1998


--25. Mostrar nombre de cliente, contacto y país para todos los clientes que tienen un promedio de
--cantidad ordenada mayor a 30 en el segundo semestre de 1997


--26. Obtener todos los datos de los empleados que prepararon las órdenes en la fecha más reciente

Select e.*
From Employees e
Inner join Orders o ON o.EmployeeID = e.EmployeeID
Where o.OrderDate in (Select MAX(o.OrderDate)
					   From Orders o 
					   --Where o.EmployeeID = e.EmployeeID
					   )

--27. Mostrar los datos de las categorías que no están en ninguna orden


--28. Mostrar el nombre de las empresas que tienen órdenes destino Brazil que tengan productos con
--un promedio de descuento superior al promedio de los descuentos de todas las órdenes


--29. Mostrar los nombres de todos los empleados, su cantidad de ordenes realizadas en los
--10 primeros días de julio de 1997 y la fecha de la última orden realizada en los primeros 10 días de julio
--de 1997. En caso que el empleado no preparara ninguna orden en dicha fecha, igual deben mostrarse sus
--datos
Select e.LastName, e.FirstName, (SELECT count(o.OrderID) --su cantidad de ordenes realizadas en los 10 primeros días de julio de 1997
								 from Orders o , Employees e
								 where o.OrderDate >= '01/07/1997' and o.OrderDate <= '10/07/1997' 
								 and e.EmployeeID = o.EmployeeID ) as 'Cantidad de Ordenes',
								 --la fecha de la última orden realizada en los primeros 10 días de julio de 1997.
								 (Select MAX(O.OrderDate)
								  From Orders o , Employees e
								  Where o.OrderDate >= '01/07/1997' and o.OrderDate <= '10/07/1997'
								  and e.EmployeeID = o.EmployeeID ) as 'Ultima Fecha'

From Employees e


--30. Mostrar los datos de los clientes que tengan órdenes con más de 2 productos y que no tengan más
--de 3 órdenes con menos de 7 productos

Select *
from Customers c
Inner join Orders o ON o.CustomerID = c.CustomerID

--31. Mostrar los datos de los Shippers que nuca enviaron órdenes a la región oeste (Western)
--pero que si enviaron órdenes a la región este (Eastern)

--32. Obtener los datos de los clientes de ‘USA’ que en el 1997 hayan tenido en algún mes una
--orden de cantidad superior a 100 y que también hayan tenido algún mes con una inferior a
--20.

--33. Mostrar los datos de los clientes que tengan mas de 2 ordenes y que la cantidad total de
--productos del año 1997 supere los 50

--34. Implementar una consulta que retorne los datos de los empleados, la cantidad de
--ordenes que preparó en 1996 y el valor unitario máximo de ese período, para todos los
--empleados que hayan preparado al menos 20 ordenes en el período indicado.

--35. Mostrar los datos de los empleados que no han preparado ordenes en el segundo semestre del
--1997, registraron alguna orden en el 1996 y solo han preparado ordenes a empresas de France.

--36. Mostrar los datos de los clientes que tengan ordenes con mas de 3 renglones y
--que no tengan mas de 2 ordenes con menos de 5 renglones en el año 1996.

--37. Utilizando EXISTS mostrar código de cliente y nombre de empresa para todos los
--clientes que ordenaron el producto 40

--38. Utilizando ANY l istar los nombres de productos para los que exista alguna orden con cantidad
--igual a 10

--39. Mostrar los nombres de los Shipper que enviaron todas las ordenes del cliente
--SEVES

--40. Mostrar los datos de los clientes que hicieron ordenes de mas de 10 productos diferentes y que
--no han realizado ordenes de mas de 20 productos en el año 1997

--41. Mostrar el nombre de las ciudades y el nombre del país para todas las ordenes que tienen
--descuentos en todas sus líneas o las que no tienen descuentos en ninguna de sus líneas

--42. Para cada producto que no esté discontinuado, mostrar sus datos, la fecha de la última orden
--en la que participó, el importe mas alto en que se vendió y el nombre a la categoría que
--pertenece.

--43. Marcar como discontinuado todos los productos que no se vendieron en todo el año 1997

--44. Bajar el precio en un 10% a todos los productos que no tienen stock y que se vendieron
--menos de 50 unidades en el año 1997.

--45. Utilizando ALL listar los nombres de los productos que tengan todas las ordenes con
--cantidad igual a 10

--46. Utilizando EXISTS listar los proveedores que provean productos de precio igual a 22