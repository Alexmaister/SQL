--Unidad 9. Consultas elaboradas en SQL Server
-- NorthWind.
go
use Northwind
go
--PROBLEMA
--1. N�mero de clientes de cada pa�s.
select COUNT(CustomerID)as[N�mero de clientes],Country from Customers group by Country

--2. N�mero de clientes diferentes que compran cada producto.
select distinct COUNT(C.CustomerID)as[N�mero de clientes],P.ProductName from Customers as C
join Orders as O
on C.CustomerID=O.CustomerID
join [Order Details] as OD
on O.OrderID=OD.OrderID
join Products as P
on OD.ProductID=P.ProductID
group by P.ProductID,P.ProductName

--3. N�mero de pa�ses diferentes en los que se vende cada producto.


--4. Empleados que han vendido alguna vez �Gudbrandsdalsost�, �Lakkalik��ri�,
--�Tourti�re� o �Boston Crab Meat�.
--5. Empleados que no han vendido nunca �Chartreuse verte� ni �Ravioli Angelo�.
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
--6. N�mero de unidades de cada categor�a de producto que ha vendido cada
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
--7. Total de ventas (US$) de cada categor�a en el a�o 97.

--8. Productos que han comprado m�s de un cliente del mismo pa�s, indicando el
--nombre del producto, el pa�s y el n�mero de clientes distintos de ese pa�s que
--lo han comprado.

select distinct P.ProductName,COUNT (C.CustomerID)as [N�mero de clientes],C.Country from Products as P
inner join [Order Details] as OD
on P.ProductID=OD.ProductID
inner join Orders as O
on OD.OrderID=O.OrderID
inner join Customers as C
on O.CustomerID=C.CustomerID
group by P.ProductName,C.Country
having (COUNT(C.CustomerID)>1)

--9. Total de ventas (US$) en cada pa�s cada a�o.
select sum((OD.UnitPrice*OD.Quantity)-(OD.UnitPrice*OD.Quantity*OD.Discount))as [Total($)],year(O.OrderDate)as [Año de Venta],C.Country from [Order Details] as OD
inner join Orders as O
on  OD.OrderID=O.OrderID
inner join Customers as C
on O.CustomerID=C.CustomerID
group by year(O.OrderDate),C.Country
order by year(O.OrderDate)
select * from Orders
--10. Producto superventas de cada a�o, indicando a�o, nombre del producto,
--categor�a y cifra total de ventas.
select SC.ProductName,Unidades,C.Año from(
select  MAX(UnidadesVendidas)as Unidades,Año from (select P.ProductName ,year(O.OrderDate) as Año,sum(OD.Quantity) as UnidadesVendidas from Products as P
inner join [Order Details] as OD
on P.ProductID=OD.ProductID
inner join Orders as O
on OD.OrderID=O.OrderID
group by year(O.OrderDate),P.CategoryID,P.ProductName) as SubC
group by Año)as C
inner join (select P.ProductName ,year(O.OrderDate) as Año,sum(OD.Quantity) as UnidadesVendidas from Products as P
inner join [Order Details] as OD
on P.ProductID=OD.ProductID
inner join Orders as O
on OD.OrderID=O.OrderID
group by year(O.OrderDate),P.CategoryID,P.ProductName) as SC
on C.Unidades=SC.[UnidadesVendidas]




select * from [Order Details]
--11. Cifra de ventas de cada producto en el a�o 97 y su aumento o disminuci�n
--respecto al a�o anterior en US $ y en %.
--12. Mejor cliente (el que m�s nos compra) de cada pa�s.
--13. N�mero de productos diferentes que nos compra cada cliente.
--14. Clientes que nos compran m�s de cinco productos diferentes.
--15. Vendedores que han vendido una mayor cantidad que la media en US $ en el
--a�o 97.
--16. Empleados que hayan aumentado su cifra de ventas m�s de un 10% entre dos
--a�os consecutivos, indicando el a�o en que se produjo el aumento.