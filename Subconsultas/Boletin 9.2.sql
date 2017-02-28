--Unidad 9. Consultas elaboradas en SQL Server
-- NorthWind.
go
use Northwind
go
--PROBLEMA
--1. Nï¿½mero de clientes de cada paï¿½s.
select COUNT(CustomerID)as[Nï¿½mero de clientes],Country from Customers group by Country

--2. Nï¿½mero de clientes diferentes que compran cada producto.
select distinct COUNT(C.CustomerID)as[Nï¿½mero de clientes],P.ProductName from Customers as C
join Orders as O
on C.CustomerID=O.CustomerID
join [Order Details] as OD
on O.OrderID=OD.OrderID
join Products as P
on OD.ProductID=P.ProductID
group by P.ProductID,P.ProductName

--3. Nï¿½mero de paï¿½ses diferentes en los que se vende cada producto.


<<<<<<< Updated upstream
--4. Empleados que han vendido alguna vez ï¿½Gudbrandsdalsostï¿½, ï¿½Lakkalikï¿½ï¿½riï¿½,
--ï¿½Tourtiï¿½reï¿½ o ï¿½Boston Crab Meatï¿½.
--5. Empleados que no han vendido nunca ï¿½Chartreuse verteï¿½ ni ï¿½Ravioli Angeloï¿½.
=======
--4. Empleados que han vendido alguna vez “Gudbrandsdalsost”, “Lakkalikööri”,
--“Tourtière” o “Boston Crab Meat”.
select * from [Orders]
select * from Employees as E
inner join Orders as O
on E.EmployeeID=O.EmployeeID
inner join [Order Details] as OD
on O.OrderID=OD.OrderID
inner join Products as P
on OD.ProductID=P.ProductID
where P.ProductName in ('Gudbrandsdalsost','Lakkalikööri','Tourtière','Boston Crab Meat')
--5. Empleados que no han vendido nunca “Chartreuse verte” ni “Ravioli Angelo”.
>>>>>>> Stashed changes
select FirstName,LastName from Employees
except(
select  E.FirstName,E.LastName from Employees as E
join Orders as O
on E.EmployeeID=O.EmployeeID
join [Order Details] as OD
on O.OrderID=OD.OrderID
join Products as P
on OD.ProductID=P.ProductID
where P.ProductName='Chartreuse verte' and P.ProductName='Ravioli Angelo'
)
--6. Nï¿½mero de unidades de cada categorï¿½a de producto que ha vendido cada
--empleado.
	
select COUNT(P.ProductID)as [Numero de productos],P.CategoryID,E.EmployeeID from Products as P
join [Order Details] as OD
on P.ProductID=OD.ProductID
join Orders as O 
on OD.OrderID=O.OrderID
join Employees as E
on O.EmployeeID=E.EmployeeID
group by P.CategoryID, E.EmployeeID
order by P.CategoryID, E.EmployeeID
--7. Total de ventas (US$) de cada categorï¿½a en el aï¿½o 97.

--8. Productos que han comprado mï¿½s de un cliente del mismo paï¿½s, indicando el
--nombre del producto, el paï¿½s y el nï¿½mero de clientes distintos de ese paï¿½s que
--lo han comprado.

select distinct P.ProductName,COUNT (C.CustomerID)as [Nï¿½mero de clientes],C.Country from Products as P
inner join [Order Details] as OD
on P.ProductID=OD.ProductID
inner join Orders as O
on OD.OrderID=O.OrderID
inner join Customers as C
on O.CustomerID=C.CustomerID
group by P.ProductName,C.Country
having (COUNT(C.CustomerID)>1)

<<<<<<< Updated upstream
--9. Total de ventas (US$) en cada paï¿½s cada aï¿½o.
select sum((OD.UnitPrice*OD.Quantity)-(OD.UnitPrice*OD.Quantity*OD.Discount))as [Total($)],year(O.OrderDate)as [AÃ±o de Venta],C.Country from [Order Details] as OD
inner join Orders as O
on  OD.OrderID=O.OrderID
inner join Customers as C
on O.CustomerID=C.CustomerID
group by year(O.OrderDate),C.Country
order by year(O.OrderDate)
select * from Orders
--10. Producto superventas de cada aï¿½o, indicando aï¿½o, nombre del producto,
--categorï¿½a y cifra total de ventas.
select SC.ProductName,Unidades,C.AÃ±o from(
select  MAX(UnidadesVendidas)as Unidades,AÃ±o from (select P.ProductName ,year(O.OrderDate) as AÃ±o,sum(OD.Quantity) as UnidadesVendidas from Products as P
inner join [Order Details] as OD
on P.ProductID=OD.ProductID
inner join Orders as O
on OD.OrderID=O.OrderID
group by year(O.OrderDate),P.CategoryID,P.ProductName) as SubC
group by AÃ±o)as C
inner join (select P.ProductName ,year(O.OrderDate) as AÃ±o,sum(OD.Quantity) as UnidadesVendidas from Products as P
inner join [Order Details] as OD
on P.ProductID=OD.ProductID
inner join Orders as O
on OD.OrderID=O.OrderID
group by year(O.OrderDate),P.CategoryID,P.ProductName) as SC
on C.Unidades=SC.[UnidadesVendidas]




select * from [Order Details]
--11. Cifra de ventas de cada producto en el aï¿½o 97 y su aumento o disminuciï¿½n
--respecto al aï¿½o anterior en US $ y en %.
--12. Mejor cliente (el que mï¿½s nos compra) de cada paï¿½s.
--13. Nï¿½mero de productos diferentes que nos compra cada cliente.
--14. Clientes que nos compran mï¿½s de cinco productos diferentes.
=======
--9. Total de ventas (US$) en cada país cada año.
select sum((UnitPrice*Quantity)-(UnitPrice*Quantity*Discount)),year(O.ShippedDate),C.Country from [Order Details] as OD
inner join Orders as O
on OD.OrderID=O.OrderID
inner join Customers as C
on O.CustomerID=C.CustomerID
group by C.Country, O.ShippedDate

--10. Producto superventas de cada año, indicando año, nombre del producto,
--categoría y cifra total de ventas.
select * from Products 
--11. Cifra de ventas de cada producto en el año 97 y su aumento o disminución
--respecto al año anterior en US $ y en %.
--12. Mejor cliente (el que más nos compra) de cada país.
--13. Número de productos diferentes que nos compra cada cliente.
--14. Clientes que nos compran más de cinco productos diferentes.
>>>>>>> Stashed changes
--15. Vendedores que han vendido una mayor cantidad que la media en US $ en el
--aï¿½o 97.
--16. Empleados que hayan aumentado su cifra de ventas mï¿½s de un 10% entre dos
--aï¿½os consecutivos, indicando el aï¿½o en que se produjo el aumento.