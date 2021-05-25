Use Northwind

SELECT * FROM Employees

SELECT COUNT(Region) FROM Employees

SELECT * FROM Products
SELECT CategoryID FROM Products GROUP BY CategoryID
SELECT CategoryID FROM Products

SELECT CategoryID, UnitPrice FROM Products ORDER BY CategoryID 

SELECT CategoryID, SUM(UnitPrice) AS Total FROM Products GROUP BY CategoryID

SELECT CategoryID, COUNT(ProductName) AS [Total de productos] FROM Products GROUP BY CategoryID

SELECT CategoryID, MIN (UnitPrice) AS  [Producto mas economico] FROM Products GROUP BY CategoryID

SELECT CategoryID, MAX (UnitPrice) AS [Producto de mayor precio] FROM Products GROUP BY CategoryID

SELECT * FROM [Order Details] 

SELECT OrderID, SUM (UnitPrice*Quantity) AS [Total a pagar] FROM [Order Details] GROUP BY OrderID

SELECT CategoryID, COUNT(ProductName) AS Cantidad FROM Products GROUP BY CategoryID 
HAVING COUNT(ProductName)>10

SELECT OrderID, SUM (UnitPrice*Quantity) AS [Total a pagar] FROM [Order Details] GROUP BY OrderID 
HAVING SUM (UnitPrice*Quantity) > 30
ORDER BY [Total a pagar]