Use Northwind

--Nombre de los proveedores y número de productos que nos vende cada uno

SELECT * FROM Suppliers

SELECT S.ContactName,COUNT(P.ProductID) AS [Cantidad de productos] FROM Suppliers AS S INNER JOIN Products AS P ON S.SupplierID = P.SupplierID
GROUP BY S.ContactName

--Nombre completo y telefono de los vendedores que trabajen en New York, Seattle, Vermont, Columbia, Los Angeles, Redmond o Atlanta.

SELECT FirstName,LastName,HomePhone,City FROM Employees WHERE City IN ('New York','Seattle','Vermont','Columbia','Los Angeles','Redmond','Atalanta')

--Número de productos de cada categoría y nombre de la categoría.

SELECT * FROM Categories

SELECT C.CategoryName,COUNT(P.ProductName) AS [Cantidad de Productos] FROM Categories AS C INNER JOIN Products AS P ON C.CategoryID = P.CategoryID 
GROUP BY C.CategoryName

--Nombre de la compañía de todos los clientes que hayan comprado queso de cabrales o tofu.

SELECT * FROM Products

SELECT DISTINCT C.CompanyName FROM Customers AS C 
	INNER JOIN Orders AS O ON C.CustomerID = O.CustomerID
	INNER JOIN [Order Details] AS OD ON O.OrderID = OD.OrderID
	INNER JOIN Products AS P ON OD.ProductID = P.ProductID
	WHERE P.ProductName IN ('Queso cabrales','Tofu')

--Empleados (ID, nombre, apellidos y teléfono) que han vendido algo a Bon app' o Meter Franken.

SELECT * FROM Customers

SELECT DISTINCT E.EmployeeID,E.FirstName,E.LastName,E.HomePhone FROM Employees AS E
		INNER JOIN Orders AS O ON E.EmployeeID = O.EmployeeID
		INNER JOIN Customers AS C ON O.CustomerID = C.CustomerID
		WHERE C.CompanyName IN ('Bon app''','Meter Franken')

--Empleados (ID, nombre, apellidos, mes y día de su cumpleaños) que no han vendido nunca nada a ningún cliente de Portugal. *

SELECT EmployeeID,FirstName,LastName,DATEPART(DAY,BirthDate) AS [Dia Cumple],DATEPART(MONTH,BirthDate) AS [Mes Cumple]
FROM Employees 
		WHERE EmployeeID NOT IN (
	
		SELECT E.EmployeeID FROM Employees AS E
		INNER JOIN Orders AS O ON E.EmployeeID = O.EmployeeID
		INNER JOIN Customers AS C ON O.CustomerID = C.CustomerID
		WHERE C.Country = 'Portugal')

--Total de ventas en US$ de productos de cada categoría (nombre de la categoría).

SELECT * FROM [Order Details]

SELECT C.CategoryName, SUM(OD.UnitPrice*OD.Quantity) AS [Total] FROM [Order Details] AS OD
	INNER JOIN Products AS P ON OD.ProductID = P.ProductID
	INNER JOIN Categories AS C ON P.ProductID = C.CategoryID
	GROUP BY C.CategoryName

--Total de ventas en US$ de cada empleado cada año (nombre, apellidos, dirección).

SELECT E.FirstName,E.LastName,E.Address,DATEPART(YEAR,E.HireDate) AS [Año],SUM(OD.UnitPrice*OD.Quantity) AS [Total] FROM [Order Details] AS OD
	INNER JOIN Products AS P ON OD.ProductID = P.ProductID
	INNER JOIN Orders AS O ON OD.OrderID = O.OrderID
	INNER JOIN Employees AS E ON O.EmployeeID = O.EmployeeID
	GROUP BY E.FirstName,E.LastName,E.Address,DATEPART(YEAR,E.HireDate) --cada año¿?

--Ventas de cada producto en el año 97. Nombre del producto y unidades.

SELECT * FROM Orders

SELECT P.ProductName,SUM(OD.Quantity) AS [Cantidad]--,DATEPART(YEAR,O.OrderDate) AS [Año]
	FROM Orders AS O 
	INNER JOIN [Order Details] AS OD ON O.OrderID = OD.OrderID
	INNER JOIN Products AS P ON OD.ProductID = P.ProductID 
	GROUP BY P.ProductID,P.ProductName,DATEPART(YEAR,O.OrderDate)
	HAVING DATEPART(YEAR,O.OrderDate)='1997'

--Cuál es el producto del que hemos vendido más unidades en cada país. *
GO
CREATE OR ALTER VIEW [Ventas por pais] AS 
SELECT P.ProductID,O.ShipCountry,SUM(OD.Quantity) AS [Total Ventas] FROM Products AS P
	INNER JOIN [Order Details] AS OD ON P.ProductID = OD.ProductID
	INNER JOIN Orders AS O ON OD.OrderID = O.OrderID
	GROUP BY P.ProductID,O.ShipCountry
GO

SELECT VP.ProductID, VP.ShipCountry FROM [Ventas por pais] AS VP
	INNER JOIN (
	SELECT ShipCountry,MAX([Total Ventas]) AS [Mas Vendido] FROM [Ventas por pais] 
	GROUP BY ShipCountry
	) AS MVDP ON VP.[Total Ventas] = MVDP.[Mas Vendido] AND VP.ShipCountry = MVDP.ShipCountry
	
	


--Empleados (nombre y apellidos) que trabajan a las órdenes de Andrew Fuller.


SELECT E.ReportsTo, E.FirstName,E.LastName FROM Employees AS E
	INNER JOIN Employees AS E1 ON E.ReportsTo = E1.EmployeeID
	WHERE E1.FirstName = 'Andrew'	
	GROUP BY E.FirstName,E.LastName, E.ReportsTo
	
	

	

	