--Base de datos: AdventureWorks2012
go
use AdventureWorks2012
go


--Consultas sencillas


--1.Nombre del producto, código y precio, ordenado de mayor a menor precio
select Name,ProductID,ListPrice from Production.Product order by ListPrice desc
--2.Número de direcciones de cada Estado/Provincia
select count(AddressID),StateProvinceID from Person.Address group by StateProvinceID
--3.Nombre del producto, código, número, tamaño y peso de los productos que estaban a la venta durante todo el mes de septiembre de 2002. No queremos que aparezcan aquellos cuyo peso sea superior a 2000.
select Name,ProductID,ProductNumber,Size,Weight from Production.Product where Month(SellStartDate)=6 and year(SellStartDate)=2002
select * from Production.Product
--4.Margen de beneficio de cada producto (Precio de venta menos el coste), y porcentaje que supone respecto del precio de venta.
select (ListPrice-StandardCost)as Beneficio,(((ListPrice-StandardCost)/ListPrice)*100)as [porcentaje%precioDeVenta] from Production.Product where ListPrice>0 and StandardCost>0



--Consultas de dificultad media


--5.Número de productos de cada categoría
select *  from Production.Product
select count(ProductID),ProductSubcategoryID from Production.Product group by ProductSubcategoryID
--6.Igual a la anterior, pero considerando las categorías generales (categorías de categorías).
select  count(ProductID),Class from Production.Product group by Class
--7.Número de unidades vendidas de cada producto cada año.
select * from Sales.SalesOrderDetail
select count(ProductID), year(ModifiedDate) from Sales.SalesOrderDetail group by YEAR(ModifiedDate)
--8.Nombre completo, compañía y total facturado a cada cliente

--9.Número de producto, nombre y precio de todos aquellos en cuya descripción aparezcan las palabras "race”, "competition” o "performance”


              
--Consultas avanzadas


--10.Facturación total en cada país
--11.Facturación total en cada Estado
--12.Margen medio de beneficios y total facturado en cada país
--Última modificación: martes, 26 de enero de 2016, 14:20