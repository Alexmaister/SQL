go
use Northwind
GO

alter function "Venta Producto Por Estacion" (@NombreProducto varchar(50))
returns table as
return(
select @NombreProducto NombreProducto , sum(OD.Quantity) as Cantidad, case 
  when (month(OrderDate)=12 and day(OrderDate)>21) or (month(OrderDate)between 1 and 2)or(MONTH(OrderDate)=3 and day(OrderDate)<22)then 'Invierno'
  when (DAY(OrderDate)>21 and month(OrderDate)=3 )or(MONTH(OrderDate)between 3 and 5)or( day(OrderDate)<22 and month(OrderDate)=6) then 'Primavera'
  when (DAY(OrderDate)>21 and month(OrderDate)=6 )or(MONTH(OrderDate)between 7 and 8) or( day(OrderDate)<22 and month(OrderDate)=9) then 'Verano'
  when (DAY(OrderDate)>21 and month(OrderDate)=9 )or (MONTH(OrderDate)between 10 and 11)or( day(OrderDate)<22 and month(OrderDate)=12) then 'Otoño'
  END as Estacion
from Orders as O
inner join [Order Details] as OD
  on O.OrderID=OD.OrderID
inner join Products as P
  on OD.ProductID=P.ProductID
where ProductName=@NombreProducto
group by case 
  when (month(OrderDate)=12 and day(OrderDate)>21) or (month(OrderDate)between 1 and 2)or(MONTH(OrderDate)=3 and day(OrderDate)<22)then 'Invierno'
  when (DAY(OrderDate)>21 and month(OrderDate)=3 )or(MONTH(OrderDate)between 3 and 5)or( day(OrderDate)<22 and month(OrderDate)=6) then 'Primavera'
  when (DAY(OrderDate)>21 and month(OrderDate)=6 )or(MONTH(OrderDate)between 7 and 8) or( day(OrderDate)<22 and month(OrderDate)=9) then 'Verano'
  when (DAY(OrderDate)>21 and month(OrderDate)=9 )or (MONTH(OrderDate)between 10 and 11)or( day(OrderDate)<22 and month(OrderDate)=12) then 'Otoño'
  END
)
select * from Products
select * from "Venta Producto Por Estacion" ('Queso Cabrales')