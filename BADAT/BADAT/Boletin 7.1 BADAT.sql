USE Northwind

--1. Nombre de la compañía y dirección completa (dirección, cuidad, país) de todos los clientes que no sean de los Estados Unidos.

SELECT CompanyName,City,Region,PostalCode,Country,Address FROM Customers 
WHERE  Country NOT LIKE 'USA'

--2. La consulta anterior ordenada por país y ciudad.

SELECT CompanyName,City,Region,PostalCode,Country FROM Customers 
WHERE  Country NOT LIKE 'USA'
ORDER BY City,Country

--3. Nombre, Apellidos, Ciudad y Edad de todos los empleados, ordenados por antigüedad en la empresa. 

SELECT FirstName,LastName,City,HireDate AS Antiguedad FROM Employees 
ORDER BY HireDate 

--4. Nombre y precio de cada producto, ordenado de mayor a menor precio

SELECT ProductName,UnitPrice AS Precio FROM Products
ORDER BY UnitPrice

--5. Nombre de la compañía y dirección completa de cada proveedor de algún país de América del Norte. 

SELECT CompanyName,Address FROM Suppliers
WHERE Region LIKE 'North America'

--6. Nombre del producto, número de unidades en stock y valor total del stock, de los productos que no sean de la categoría 4.

SELECT ProductName,UnitsInStock,CategoryID FROM Products
WHERE CategoryID NOT LIKE '4'

--7. Clientes (Nombre de la Compañía, dirección completa, persona de contacto) que no residan en un país de América del Norte y que la persona de contacto no sea el propietario de la compañía

SELECT CustomerID,CompanyName,Address,ContactName FROM Customers
WHERE ContactName != CustomerID

--8. ID del cliente y número de pedidos realizados por cada cliente, ordenado de mayor a menor número de pedidos.



--9. Número de pedidos enviados a cada ciudad, incluyendo el nombre de la ciudad.



--10. Número de productos de cada categoría. 


