use Northwind
/* 22 */
SELECT products.ProductName
FROM products,OrderDetails
WHERE products.ProductID=OrderDetails.ProductID
GROUP BY products.ProductName
HAVING COUNT(DISTINCT(orderid)) > 50

/* 23 */
SELECT products.ProductName,MAX(OrderDetails.Discount)
FROM products,OrderDetails
WHERE products.ProductID=OrderDetails.ProductID
GROUP BY products.ProductName
HAVING MAX(OrderDetails.Discount) > 0.20

/* 24 */

SELECT CompanyName,contactName
FROM orders,customers
WHERE orders.CustomerID=customers.CustomerID AND
      YEAR(orderdate)=1998
GROUP BY CompanyName,contactName
HAVING count(orderid) > 8
 
/* 25 */
SELECT CompanyName,contactName,country
FROM orders,customers,orderdetails
WHERE orders.CustomerID=customers.CustomerID AND
      orders.orderid=OrderDetails.OrderID AND
	  orderdate >= '01/07/1997' AND
	  orderdate <= '31/12/1997'
GROUP BY CompanyName,contactName,country
HAVING AVG(quantity) > 30

/* 26 */
SELECT e.FirstName
FROM Employees e,Orders o
WHERE e.EmployeeID=o.EmployeeID and
      o.OrderDate=(SELECT MAX(orderdate)
	                    FROM orders)



/* 27 */
INSERT INTO Categories(CategoryName,description) VALUES('Mapaches','Mamifero roedor')
INSERT INTO PROducts(productname,SupplierID,CategoryID) values('Piel de Mapache',1,9)

SELECT *
FROM Categories
WHERE CategoryID IN 
       (SELECT CategoryID
        FROM products
		WHERE productid NOT IN
		 (SELECT Productid
		  FROM OrderDetails))

/*
29. Mostrar los nombres de todos los empleados, su cantidad de ordenes realizadas en los
10 primeros días de julio de 1997 y la fecha de la última orden realizada en los primeros 10 días de julio
de 1997. En caso que el empleado no preparara ninguna orden en dicha fecha, igual deben mostrarse sus
datos 
*/


select e.FirstName, e.LastName, 
/*su cantidad de ordenes realizadas en los 10 primeros días de julio de 1997*/
	(select count(o.OrderID) from Orders o, Employees e where o.OrderDate >= '01/07/1997' and o.OrderDate<= '10/07/1997' 
				and e.EmployeeID = o.EmployeeID) as 'Cantidad de ordenes', 
	/*la fecha de la última orden realizada en los primeros 10 días de juliode 1997	*/
	(select max (o.OrderDate) from Orders o join Employees e on e.EmployeeID = o.EmployeeID 
		where o.OrderDate >= '01/07/1997' and o.OrderDate<= '10/07/1997' ) as 'fecha ultima orden'
From Employees e


/*
30. Mostrar los datos de los clientes que tengan órdenes con más de 2 productos 
y que no tengan más de 3 órdenes con menos de 7 productos
*/

Select * 
From Customers c

-- clientes que tengan órdenes con más de 2 productos 

Select c.CustomerID
from Customers c inner join Orders o on o.CustomerID = c.CustomerID
inner join OrderDetails od on od.OrderID = o.OrderID
group by c.CustomerID
having count(distinct od.ProductID) >2


-- clientes que no tengan mas de 3 ordenes con menos de 7 productos

select CustomerID
from (select customerId, count(orderId) as CantOrd from Orders
		where customerId in (select c.CustomerID
							from Customers c, OrderDetails od, Orders o
							where c.CustomerID = o.CustomerID and o.OrderID = od.OrderID
							group by c.CustomerID
							having count(od.ProductID) <7)
							) miTablaAuxiliar
where CantOrd <= 3



-- consulta completa: 

Select * 
From Customers c
where c.CustomerID in (
	Select c.CustomerID
	from Customers c inner join Orders o on o.CustomerID = c.CustomerID
	inner join OrderDetails od on od.OrderID = o.OrderID
	group by c.CustomerID
	having count(distinct od.ProductID) >2 
		and c.CustomerID in (
						select CustomerID
						from (select customerId, count(orderId) as CantOrd from Orders
								where customerId in (select c.CustomerID
													from Customers c, OrderDetails od, Orders o
													where c.CustomerID = o.CustomerID and o.OrderID = od.OrderID
													group by c.CustomerID
													having count(od.ProductID) <7)
													) miTablaAuxiliar
						where CantOrd <= 3
						)
)





