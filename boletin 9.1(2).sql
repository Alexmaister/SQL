go
use Northwind
go
--Empleados (ID, nombre, apellidos, mes y d�a de su cumplea�os) que no han vendido nunca nada a ning�n cliente de Francia. *
select EmployeeID,LastName,FirstName,(MONTH(BirthDate))as mes,(day(BirthDate))as dia  from Employees
except
select distinct E.EmployeeID,LastName,FirstName,(MONTH(BirthDate))as mes,(day(BirthDate))as dia from Employees  as E
inner join Orders as O
on E.EmployeeID=O.EmployeeID
inner join Customers as C
on O.CustomerID=C.CustomerID
where C.Country ='Argentina'
for xml auto--Se muestra en formato xml
set nocount off-- on/off , se utiliza para ver o no el numero de filas afectadas

--Total de ventas en US$ de productos de cada categor�a (nombre de la categor�a).
select C.CategoryName,sum((OD.UnitPrice*OD.Quantity)-((OD.UnitPrice*OD.Quantity)*Discount))as [Total US$] from [Order Details] as OD
inner join Products as P
on OD.ProductID=P.ProductID
inner join Categories as C
on P.CategoryID=C.CategoryID
group by C.CategoryName

--Total de ventas en US$ de cada empleado cada a�o (nombre, apellidos, direcci�n).
select E.FirstName,E.LastName,E.Address,round(sum((OD.UnitPrice*OD.Quantity)-((OD.UnitPrice*OD.Quantity)*Discount)),2)as [Total US$] from [Order Details] as OD
inner join Orders as O
on OD.OrderID=O.OrderID
inner join Employees as E
on O.EmployeeID=E.EmployeeID
group by E.FirstName,E.LastName,E.Address
--Ventas de cada producto en el a�o 97. Nombre del producto y unidades.

--Cu�l es el producto del que hemos vendido m�s unidades en cada pa�s. *
--Empleados (nombre y apellidos) que trabajan a las �rdenes de Andrew Fuller.
--N�mero de subordinados que tiene cada empleado, incluyendo los que no tienen ninguno. Nombre, apellidos, ID.