USE Northwind

--1. Nombre de la compa��a y direcci�n completa (direcci�n, cuidad, pa�s) de todos los clientes que no sean de los Estados Unidos.

SELECT CompanyName,City,Region,PostalCode,Country,Address FROM Customers 
WHERE  Country NOT LIKE 'USA'

--2. La consulta anterior ordenada por pa�s y ciudad.

SELECT CompanyName,City,Region,PostalCode,Country FROM Customers 
WHERE  Country NOT LIKE 'USA'
ORDER BY City,Country

--3. Nombre, Apellidos, Ciudad y Edad de todos los empleados, ordenados por antig�edad en la empresa. 

SELECT FirstName,LastName,City,HireDate AS Antiguedad FROM Employees 
ORDER BY HireDate 

--4. Nombre y precio de cada producto, ordenado de mayor a menor precio

SELECT ProductName,UnitPrice AS Precio FROM Products
ORDER BY UnitPrice

--5. Nombre de la compa��a y direcci�n completa de cada proveedor de alg�n pa�s de Am�rica del Norte. 

SELECT CompanyName,Address FROM Suppliers
WHERE Region LIKE 'North America'

--6. Nombre del producto, n�mero de unidades en stock y valor total del stock, de los productos que no sean de la categor�a 4.

SELECT ProductName,UnitsInStock,CategoryID FROM Products
WHERE CategoryID NOT LIKE '4'

--7. Clientes (Nombre de la Compa��a, direcci�n completa, persona de contacto) que no residan en un pa�s de Am�rica del Norte y que la persona de contacto no sea el propietario de la compa��a

SELECT CustomerID,CompanyName,Address,ContactName FROM Customers
WHERE ContactName != CustomerID

--8. ID del cliente y n�mero de pedidos realizados por cada cliente, ordenado de mayor a menor n�mero de pedidos.



--9. N�mero de pedidos enviados a cada ciudad, incluyendo el nombre de la ciudad.



--10. N�mero de productos de cada categor�a. 


