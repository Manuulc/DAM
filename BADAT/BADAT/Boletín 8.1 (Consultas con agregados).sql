Use Northwind

--1. Nombre del país y número de clientes de cada país, ordenados alfabéticamente por el nombre del país

SELECT * FROM Customers

SELECT CustomerID,City FROM Customers ORDER BY City

--2. ID de producto y número de unidades vendidas de cada producto.

SELECT * FROM [Order Details]

SELECT ProductID, SUM(Quantity) AS Cantidad FROM [Order Details] GROUP BY ProductID

--3. ID del cliente y número de pedidos que nos ha hecho.

SELECT * FROM Orders

SELECT CustomerID, COUNT(OrderID) AS [Numero de Pedidos] FROM Orders GROUP BY CustomerID

--4. ID del cliente, año y número de pedidos que nos ha hecho cada año.

SELECT CustomerID, DATEPART(YEAR,OrderDate) AS Año, COUNT(OrderID) AS [ID del pedido] FROM Orders GROUP BY CustomerID,DATEPART(YEAR,OrderDate)

--5. ID del producto, precio unitario y total facturado de ese producto, ordenado por cantidad facturada de mayor a menor. 
--Si hay varios precios unitarios para el mismo producto tomaremos el mayor.

SELECT * FROM [Order Details]

SELECT ProductID,MAX(UnitPrice) AS Maximo,SUM(UnitPrice*Quantity) AS [Total Facturado] FROM [Order Details] GROUP BY ProductID  
ORDER BY [Total Facturado] DESC

--6. ID del proveedor e importe total del stock acumulado de productos correspondientes a ese proveedor.

SELECT * FROM Products

SELECT SupplierID, SUM(UnitPrice*UnitsInStock) AS [Importe del Stock] FROM Products GROUP BY SupplierID

--7. Número de pedidos registrados mes a mes de cada año.

SELECT * FROM Orders

SELECT DATEPART(YEAR,OrderDate) AS [Año] ,DATEPART(MONTH,OrderDate) AS [Mes], COUNT(OrderID) [Pedidos] FROM Orders GROUP BY DATEPART(YEAR,OrderDate),DATEPART(MONTH,OrderDate)

--8. Año y tiempo medio transcurrido entre la fecha de cada pedido (OrderDate) y la fecha en la que lo hemos enviado (ShipDate), en días para cada año.

SELECT * FROM Orders

SELECT DATEPART(YEAR,OrderDate) AS [Año] ,AVG(DATEDIFF(DAY,OrderDate,ShippedDate)) AS [Media] FROM Orders GROUP BY DATEPART(YEAR,OrderDate) ORDER BY [Año]

--9. ID del distribuidor y número de pedidos enviados a través de ese distribuidor.

SELECT * FROM Orders

SELECT ShipVia, COUNT(*) AS [Numero de pedidos] FROM Orders GROUP BY ShipVia

--10. ID de cada proveedor y número de productos distintos que nos suministra.

SELECT * FROM Products

SELECT SupplierID, COUNT(ProductID) AS [Numero de productos suministrados] FROM Products GROUP BY SupplierID,ProductID

