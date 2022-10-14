/* 32. Obtener los datos de los clientes de ‘USA’ que en el 1997 hayan tenido en algún mes una
orden de cantidad productos superior a 100 y que también hayan tenido algún mes con una inferior a
20. */

SELECT *
FROM Customers
WHERE Country='USA' and
      CustomerID IN (SELECT customerid
                     FROM orders,OrderDetails
					 WHERE orders.orderid=orderdetails.orderid and
					       year(OrderDate)=1997 and OrderDetails.Quantity > 100) and
	  CustomerID IN (SELECT customerid
                     FROM orders,OrderDetails
					 WHERE orders.orderid=orderdetails.orderid and
					       year(OrderDate)=1997 and OrderDetails.Quantity < 20) 		   	               


/* 33. Mostrar los datos de los clientes que tengan mas de 2 ordenes y que la cantidad total de
productos del año 1997 supere los 50 */

SELECT *
FROM customers
WHERE customerid IN (SELECT customerid
                     FROM orders,orderdetails
					 WHERE orders.orderid=OrderDetails.orderid and
					       year(orderdate)=1997
                     GROUP BY customerid
					 HAVING count(orders.orderid) > 2 and
					        SUM(quantity) > 50)

/* 34. Implementar una consulta que retorne los datos de los empleados, la cantidad de
ordenes que preparó en 1996 y el valor unitario máximo de ese período, para todos los
empleados que hayan preparado al menos 20 ordenes en el período indicado. */

SELECT employees.employeeid,
       employees.LastName,
       count(orders.orderid) as cant,
       MAX(unitprice) as maximo
FROM orders,orderdetails,employees
WHERE orders.orderid=orderdetails.orderid and
      employees.employeeid=orders.employeeid and
      YEAR(orderdate)=1996
GROUP BY employees.employeeid,employees.LastName
HAVING count(orders.orderid) >=20


/* 35. Mostrar los datos de los empleados que no han preparado ordenes en el segundo semestre del
1997, registraron alguna orden en el 1996 y solo han preparado ordenes a empresas de France. */

SELECT employeeid,LastName
FROM employees
WHERE employeeid IN (SELECT employeeid
                     FROM orders
                     WHERE ShipCountry='France') AND
      employeeid NOT IN (SELECT employeeid
                         FROM orders
                         WHERE ShipCountry <> 'France') AND
      employeeid NOT IN (SELECT employeeid
                         FROM orders
                         WHERE orderdate >= '01/07/1997' and
                               orderdate <= '31/12/1997') AND
      employeeid IN (SELECT employeeid
                     FROM orders
                     WHERE orderdate >= '01/01/1996' and
                           orderdate <= '31/12/1996')


--37. Utilizando EXISTS mostrar código de cliente y nombre de empresa para todos los
--clientes que ordenaron el producto 40

Select c.CustomerID,c.CompanyName
From Customers c
where EXISTS ( SELECT *
			   FROM Products p
			   inner join OrderDetails od ON od.ProductID = p.ProductID
			   Inner join Orders o ON o.OrderID = od.OrderID 
			   Where o.CustomerID = c.CustomerID AND p.ProductID = 40
			)

--38. Utilizando ANY listar los nombres de productos para los que exista alguna orden con cantidad
--igual a 10

Select p.ProductName
From Products p
Where p.ProductID = ANY (Select od.ProductID
						From OrderDetails od
						Where Od.Quantity = 10
						)

--39. Mostrar los nombres de los Shipper que enviaron todas las ordenes del cliente
--SEVES

Select s.CompanyName
From Shippers s
Where s.ShipperID = ALL (
						Select o.ShipVia
						From Orders o
						Where o.CustomerID = 'SEVES' 
)


--40. Mostrar los datos de los clientes que hicieron ordenes de mas de 10 productos diferentes y que
--no han realizado ordenes de mas de 20 productos en el año 1997

Select c.*
From Customers c
Where c.CustomerID in (Select o.CustomerID
					   From Orders o
					   Inner join OrderDetails od ON od.OrderID = o.OrderID
					   Inner join Products p ON p.ProductID = od.ProductID
					   Where c.CustomerID = o.CustomerID  
					   group by o.CustomerID
					   HAVING COUNT(p.ProductID) > 10 
					  ) AND c.CustomerID NOT IN
					  (Select o.CustomerID
					   From Orders o
					   Inner join OrderDetails od ON od.OrderID = o.OrderID
					   Inner join Products p ON p.ProductID = od.ProductID
					   Where c.CustomerID = o.CustomerID  AND YEAR(O.OrderDate) = 1997
					   group by o.CustomerID
					   HAVING COUNT(p.ProductID) > 20 
					  )

--45. Utilizando ALL listar los nombres de los productos que tengan todas las ordenes con
--cantidad igual a 10

Select p.*
From Products p
where p.ProductID = ALL ( Select od.ProductID
						  from OrderDetails od
						  INNER JOIN Orders o ON o.OrderID = od.OrderID
						  where od.Quantity = 10
)

--46. Utilizando EXISTS listar los proveedores que provean productos de precio igual a 22

Select s.*
From Suppliers s
Where EXISTS (select *
			  from Products p
			  where s.SupplierID = p.SupplierID
			  AND p.UnitPrice = 22
			  )