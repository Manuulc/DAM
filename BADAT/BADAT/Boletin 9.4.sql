Use Northwind

----Boletin 9.2 (Tema 9) 9.4 en la plataforma

--1. N�mero de clientes de cada pa�s
SELECT * FROM Customers

SELECT DISTINCT Country, COUNT(*) AS Numero_Clientes FROM Customers
GROUP BY Country

--2. N�mero de clientes diferentes que compran cada producto. Incluye el nombre del producto
SELECT  P.ProductName, COUNT(DISTINCT C.CustomerID) AS Numero_Clientes FROM Customers AS C
INNER JOIN Orders AS O
ON  C.CustomerID = O.CustomerID
INNER JOIN [Order Details] AS OD
ON O.OrderID = OD.OrderID
INNER JOIN Products AS P
ON P.ProductID = OD.ProductID
GROUP BY P.ProductName, P.ProductID


--3. N�mero de pa�ses diferentes en los que se vende cada producto. Incluye el nombre del producto 
SELECT * FROM Orders

SELECT P.ProductName, COUNT(DISTINCT O.ShipCountry) AS Numero_Paises FROM Orders AS O
INNER JOIN [Order Details] AS OD
ON O.OrderID = OD.OrderID
INNER JOIN Products AS P
ON P.ProductID = OD.ProductID
GROUP BY P.ProductName, P.ProductID

/*4.Empleados (nombre y apellido) que han vendido alguna vez �Gudbrandsdalsost�, �Lakkalik��ri�, �Tourti�re� 
o �Boston Crab Meat�. */

SELECT DISTINCT E.FirstName, E.LastName FROM Employees AS E
INNER JOIN Orders AS O
ON  E.EmployeeID = O.EmployeeID
INNER JOIN [Order Details] AS OD
ON O.OrderID = OD.OrderID
INNER JOIN Products AS P
ON P.ProductID = OD.ProductID
WHERE P.ProductName IN ('Gudbrandsdalsost', 'Lakkalik��ri', 'Tourti�re', 'Boston Crab Meat')


--5. Empleados que no han vendido nunca �Northwoods Cranberry Sauce� o �Carnarvon Tigers�
SELECT DISTINCT E.FirstName, E.LastName FROM Employees AS E
EXCEPT
SELECT DISTINCT E.FirstName, E.LastName FROM Employees AS E
INNER JOIN Orders AS O
ON E.EmployeeID = O.EmployeeID
INNER JOIN [Order Details] AS OD
ON O.OrderID = OD.OrderID
INNER JOIN Products AS P
ON P.ProductID = OD.ProductID
WHERE P.ProductName IN ('Northwoods Cranberry Sauce', 'Carnarvon Tigers')

/*6. N�mero de unidades de cada categor�a de producto que ha vendido cada
empleado. Incluye el nombre y apellidos del empleado y el nombre de la categor�a. 
*/

SELECT DISTINCT E.FirstName, E.LastName, CA.CategoryName, COUNT(CA.CategoryName) AS Numero_Unidades FROM Employees AS E
INNER JOIN Orders AS O
ON O.EmployeeID = E.EmployeeID
INNER JOIN [Order Details] AS OD
ON O.OrderID = OD.OrderID
INNER JOIN Products AS P
ON P.ProductID = OD.ProductID
INNER JOIN Categories AS CA
ON P.CategoryID = CA.CategoryID
GROUP BY E.FirstName, E.LastName, CA.CategoryName


--7.Total de ventas (US$) de cada categor�a en el a�o 97. Incluye el nombre de la categor�a. 

SELECT DISTINCT C.CategoryName, YEAR (O.OrderDate) AS A�o_Venta, SUM(OD.Quantity*OD.UnitPrice) AS Total_Ventas FROM Categories AS C
INNER JOIN Products AS P
ON P.CategoryID = C.CategoryID
INNER JOIN [Order Details] AS OD
ON P.ProductID = OD.ProductID
INNER JOIN Orders AS O
ON O.OrderID = OD.OrderID
WHERE YEAR (O.OrderDate) = 1997
GROUP BY C.CategoryName, YEAR (O.OrderDate)


/*8. Productos que han comprado m�s de un cliente del mismo pa�s, indicando el nombre del producto, 
el pa�s y el n�mero de clientes distintos de ese pa�s que lo han comprado.*/

SELECT DISTINCT P.ProductName, C.Country, COUNT(C.Country) AS Numero_Clientes FROM Products AS P
INNER JOIN [Order Details] AS OD
ON P.ProductID = OD.ProductID
INNER JOIN Orders AS O
ON O.OrderID = OD.OrderID
INNER JOIN Customers AS C
ON O.CustomerID = C.CustomerID
GROUP BY  P.ProductName, C.Country
HAVING COUNT(DISTINCT C.CompanyName)>1

--9. Total de ventas (US$) en cada pa�s cada a�o.
SELECT DISTINCT O.ShipCountry, YEAR(O.OrderDate) AS A�o_Ventas, SUM (OD.Quantity*OD.UnitPrice) AS Total_Ventas FROM [Order Details] AS OD
INNER JOIN Orders AS O
ON OD.OrderID = O.OrderID
GROUP BY O.ShipCountry, YEAR(O.OrderDate)
ORDER BY O.ShipCountry
--SUM (OD.Quantity*OD.UnitPrice) para sacar el precio en US$


--10.Producto superventas de cada a�o, indicando a�o, nombre del producto, categor�a y cifra total de ventas.*
--producto superventas: el que mas se ha vendido por a�o

--Primero hacemos los productos vendidos por a�o

CREATE OR ALTER VIEW Ventas_A�o AS
SELECT P.ProductID, P.ProductName,C.CategoryName,  YEAR(O.OrderDate) AS A�o_Venta, SUM(OD.Quantity) AS Venta_Producto FROM Orders AS O
	INNER JOIN [Order Details] AS OD ON O.OrderID = OD.OrderID
	INNER JOIN Products AS P ON OD.ProductID = P.ProductID
	INNER JOIN Categories AS C ON P.CategoryID = C.CategoryID
	GROUP BY P.ProductID, P.ProductName, P.ProductID, YEAR(O.OrderDate), C.CategoryName

--Hacemos los m�s vendidos por a�o
GO
CREATE OR ALTER VIEW MasVendidos_A�o AS
SELECT  A�o_Venta, MAX(Venta_Producto) AS Mayor_Venta 
	FROM Ventas_A�o
	GROUP BY  A�o_Venta

GO
SELECT DISTINCT V.ProductName, MV.A�o_Venta, V.CategoryName, MV.Mayor_Venta  FROM Ventas_A�o AS V
	INNER JOIN MasVendidos_A�o AS MV ON V.A�o_Venta = MV.A�o_Venta AND V.Venta_Producto = MV.Mayor_Venta



SELECT * FROM MasVendidos_A�o
SELECT * FROM Ventas_A�o

--11. Cifra de ventas de cada producto en el a�o 97 y su aumento o disminuci�n respecto al a�o anterior en US $ y en %.*

--Primera parte: Cifra de ventas de cada producto en el a�o 97
SELECT P.ProductName, YEAR(O.OrderDate) AS A�o_Ventas, SUM(OD.Quantity*OD.UnitPrice) AS Total_Ventas FROM Orders AS O
INNER JOIN [Order Details] AS OD
ON O.OrderID = OD.OrderID
INNER JOIN Products AS P
ON P.ProductID = OD.ProductID
WHERE YEAR(O.OrderDate)=1997
GROUP BY P.ProductName, YEAR(O.OrderDate)

--su aumento o disminuci�n respecto al a�o anterior en US $ y en %.
SELECT P.ProductName, YEAR(O.OrderDate) AS A�o_Ventas, SUM(OD.Quantity*OD.UnitPrice) AS Total_Ventas FROM Orders AS O
INNER JOIN [Order Details] AS OD
ON O.OrderID = OD.OrderID
INNER JOIN Products AS P
ON P.ProductID = OD.ProductID
WHERE YEAR(O.OrderDate)=1997-1
GROUP BY P.ProductName, YEAR(O.OrderDate)

--unimos las dos
SELECT Ventas_1997.ProductName, Ventas_1996.Total_Ventas, Ventas_1997.Total_Ventas, 
(Ventas_1997.Total_Ventas-Ventas_1996.Total_Ventas) AS Incremento_Ventas, 
((Ventas_1997.Total_Ventas-Ventas_1996.Total_Ventas)/Ventas_1996.Total_Ventas*100) AS Porcentaje_Ventas 

FROM(
SELECT P.ProductName, YEAR(O.OrderDate) AS A�o_Ventas, SUM(OD.Quantity*OD.UnitPrice) AS Total_Ventas FROM Orders AS O
INNER JOIN [Order Details] AS OD
ON O.OrderID = OD.OrderID
INNER JOIN Products AS P
ON P.ProductID = OD.ProductID
WHERE YEAR(O.OrderDate)=1997
GROUP BY P.ProductName, YEAR(O.OrderDate)) AS Ventas_1997
INNER JOIN 
(SELECT P.ProductName, YEAR(O.OrderDate) AS A�o_Ventas, SUM(OD.Quantity*OD.UnitPrice) AS Total_Ventas FROM Orders AS O
INNER JOIN [Order Details] AS OD
ON O.OrderID = OD.OrderID
INNER JOIN Products AS P
ON P.ProductID = OD.ProductID
WHERE YEAR(O.OrderDate)=1997-1
GROUP BY P.ProductName, YEAR(O.OrderDate)) AS Ventas_1996
ON Ventas_1997.ProductName=Ventas_1996.ProductName

--Usando Products s�lo una vez en la consulta principal y lo quitamos de las subconsultas
SELECT P.ProductName, Ventas_1996.Total_Ventas, Ventas_1997.Total_Ventas, 
(Ventas_1997.Total_Ventas-Ventas_1996.Total_Ventas) AS Incremento_Ventas, 
((Ventas_1997.Total_Ventas-Ventas_1996.Total_Ventas)/Ventas_1996.Total_Ventas*100) AS Porcentaje_Ventas 
	FROM(
	SELECT OD.ProductID, YEAR(O.OrderDate) AS A�o_Ventas, SUM(OD.Quantity*OD.UnitPrice) AS Total_Ventas FROM Orders AS O
		INNER JOIN [Order Details] AS OD
		ON O.OrderID = OD.OrderID
		WHERE YEAR(O.OrderDate)=1997
		GROUP BY OD.ProductID, YEAR(O.OrderDate)) AS Ventas_1997
	INNER JOIN 
	(SELECT OD.ProductID, YEAR(O.OrderDate) AS A�o_Ventas, SUM(OD.Quantity*OD.UnitPrice) AS Total_Ventas FROM Orders AS O
		INNER JOIN [Order Details] AS OD
		ON O.OrderID = OD.OrderID
		WHERE YEAR(O.OrderDate)=1997-1
		GROUP BY OD.ProductID, YEAR(O.OrderDate)) AS Ventas_1996
	ON Ventas_1997.ProductID=Ventas_1996.ProductID
	INNER JOIN Products AS P
	ON P.ProductID = Ventas_1996.ProductID


--12. Mejor cliente (el que m�s nos compra) de cada pa�s.*
-- interpreto que el mejor cliente es el que ha realizado mas pedidos
SELECT C.Country, COUNT(O.OrderID) AS Mejor_Cliente FROM Customers AS C
INNER JOIN Orders AS O
ON C.CustomerID = O.CustomerID
GROUP BY C.Country


--13. N�mero de productos diferentes que nos compra cada cliente. Incluye el nombre y apellidos del cliente y su direcci�n completa.

SELECT C.ContactName, C.Address, C.City, COUNT(P.ProductID) AS Numero_Productos FROM Customers AS C
INNER JOIN Orders AS O
ON C.CustomerID = O.CustomerID
INNER JOIN [Order Details] AS OD
ON OD.OrderID = O.OrderID
INNER JOIN Products AS P
ON OD.ProductID = P.ProductID
GROUP BY C.ContactName, C.Address, C.City

--14.Clientes que nos compran m�s de cinco productos diferentes.

SELECT C.ContactName, C.Address, C.City, COUNT(P.ProductID) AS Numero_Productos FROM Customers AS C
INNER JOIN Orders AS O
ON C.CustomerID = O.CustomerID
INNER JOIN [Order Details] AS OD
ON OD.OrderID = O.OrderID
INNER JOIN Products AS P
ON OD.ProductID = P.ProductID
GROUP BY C.ContactName, C.Address, C.City
HAVING COUNT(DISTINCT P.ProductID)>5

-- 15. Vendedores (nombre y apellidos) que han vendido una mayor cantidad que la media en US $ en el a�o 97.*

--primero los empleados que vendieron total de productos
GO--generar vista
CREATE OR ALTER VIEW VentasEmpleado97 AS
		SELECT E.EmployeeID, E.FirstName, E.LastName, SUM(OD.Quantity*OD.UnitPrice) AS Cantidad_Vendida 
			FROM Employees AS E
				LEFT JOIN Orders AS O ON E.EmployeeID = O.EmployeeID
				LEFT JOIN [Order Details] AS OD ON OD.OrderID = O.OrderID
			WHERE YEAR(O.OrderDate)=1997
			GROUP BY E.EmployeeID, E.FirstName, E.LastName 

			
GO--esta es la global con la vista creada
SELECT * FROM VentasEmpleado97
WHERE Cantidad_Vendida>(
SELECT AVG(Cantidad_Vendida) AS Media FROM VentasEmpleado97)

GO--esta calcula la media sin usar la vista
SELECT AVG(Cantidad_Vendida) AS Media FROM (
		SELECT  E.FirstName, E.LastName, SUM(OD.Quantity*OD.UnitPrice) AS Cantidad_Vendida 
			FROM Employees AS E
				LEFT JOIN Orders AS O ON E.EmployeeID = O.EmployeeID
				LEFT JOIN [Order Details] AS OD ON OD.OrderID = O.OrderID
			WHERE YEAR(O.OrderDate)=1997
			GROUP BY E.FirstName, E.LastName 
			) AS VentasEmpleado97
GO

--calcula la media usando la vista
SELECT AVG(Cantidad_Vendida) AS Media FROM VentasEmpleado97


GO
--calcula el global sin usar la vista
	SELECT  E.FirstName, E.LastName, SUM(OD.Quantity*OD.UnitPrice) AS Cantidad_Vendida 
			FROM Employees AS E
				LEFT JOIN Orders AS O ON E.EmployeeID = O.EmployeeID
				LEFT JOIN [Order Details] AS OD ON OD.OrderID = O.OrderID
			WHERE YEAR(O.OrderDate)=1997
			GROUP BY E.FirstName, E.LastName 
			
HAVING SUM(OD.Quantity*OD.UnitPrice)>
	(SELECT AVG(Cantidad_Vendida) AS Media 
	FROM 
		(SELECT  E.FirstName, E.LastName, SUM(OD.Quantity*OD.UnitPrice) AS Cantidad_Vendida 
			FROM Employees AS E
				LEFT JOIN Orders AS O ON E.EmployeeID = O.EmployeeID
				LEFT JOIN [Order Details] AS OD ON OD.OrderID = O.OrderID
			WHERE YEAR(O.OrderDate)=1997
			GROUP BY E.FirstName, E.LastName) AS Empleados_Ventas)
	


--16. Empleados que hayan aumentado su cifra de ventas m�s de un 10% entre dos a�os consecutivos, indicando el a�o en que se produjo el aumento.*

GO--generar vista 96
CREATE OR ALTER VIEW VentasEmpleado96 AS
		SELECT E.EmployeeID, E.FirstName, E.LastName, SUM(OD.Quantity*OD.UnitPrice) AS Cantidad_Vendida 
			FROM Employees AS E
				LEFT JOIN Orders AS O ON E.EmployeeID = O.EmployeeID
				LEFT JOIN [Order Details] AS OD ON OD.OrderID = O.OrderID
			WHERE YEAR(O.OrderDate)=1996
			GROUP BY E.EmployeeID, E.FirstName, E.LastName 


SELECT VE97.EmployeeID, VE97.FirstName, VE97.LastName,  VE96.Cantidad_Vendida, VE97.Cantidad_Vendida
	FROM VentasEmpleado97 AS VE97
		INNER JOIN VentasEmpleado96 AS VE96 ON VE97.EmployeeID = VE96.EmployeeID
	WHERE VE97.Cantidad_Vendida>1.1*VE96.Cantidad_Vendida
