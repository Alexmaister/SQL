--Escribe las siguientes consultas sobre la base de datos NorthWind.

go 
use Northwind
go
--Nombre de los proveedores y número de productos que nos vende cada uno
select count (ProductID)as numeroProductos, S.CompanyName from Products as P
join Suppliers as S
on  P.SupplierID=S.SupplierID
group by S.CompanyName
--Nombre completo y telefono de los vendedores que trabajen en New York, Seattle, Vermont, Columbia, Los Angeles, Redmond o Atlanta.
select * from Employees where City in ('Redmon','New York','Seattle','Vermont','Columbia','Los Angeles','Atlanta')
--Número de productos de cada categoría y nombre de la categoría.
select count(P.ProductID)as ProductsNumber, C.CategoryName from Categories as C
inner join Products  as P
on C.CategoryID=P.CategoryID
group by C.CategoryName
--Nombre de la compañía de todos los clientes que hayan comprado queso de cabrales o tofu.
select distinct CompanyName from Customers as C 
join Orders as O
on C.CustomerID=O.CustomerID
join [Order Details] as OD
on O.OrderID=OD.OrderID
join Products as P
on OD.ProductID=P.ProductID
where P.ProductName in ('Tofu','Queso Cabrales')
select* from Products
--Empleados (ID, nombre, apellidos y teléfono) que han vendido algo a Bon app' o Meter Franken.
select distinct E.EmployeeID,E.LastName,E.FirstName,E.HomePhone from Employees as E
join Orders as O
on E.EmployeeID=O.EmployeeID
join Customers as C
on O.CustomerID=C.CustomerID
where C.CustomerID in ('BONAP')
--Empleados (ID, nombre, apellidos, mes y día de su cumpleaños) que no han vendido nunca nada a ningún cliente de Francia. *
select distinct E.EmployeeID,E.LastName,E.FirstName,E.HomePhone from Employees as E
join Orders as O
on E.EmployeeID=O.EmployeeID
join Customers as C
on O.CustomerID=C.CustomerID
where C.Country not in ('France')
--Total de ventas en US$ de productos de cada categoría (nombre de la categoría).
--Total de ventas en US$ de cada empleado cada año (nombre, apellidos, dirección).
--Ventas de cada producto en el año 97. Nombre del producto y unidades.
--Cuál es el producto del que hemos vendido más unidades en cada país. *
--Empleados (nombre y apellidos) que trabajan a las órdenes de Andrew Fuller.
--Número de subordinados que tiene cada empleado, incluyendo los que no tienen ninguno. Nombre, apellidos, ID.