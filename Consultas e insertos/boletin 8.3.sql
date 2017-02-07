--Consultas de dificultad media

GO
use AdventureWorks2014
GO


--5.Número de productos de cada categoría
select sum(ProductID),Class from Production.product group by Class
--6.Igual a la anterior, pero considerando las categorías generales (categorías de categorías).

--7.Número de unidades vendidas de cada producto cada año.
--8.Nombre completo, compañía y total facturado a cada cliente
--9.Número de producto, nombre y precio de todos aquellos en cuya descripción aparezcan las palabras "race”, "competition” o "performance”
--Consultas avanzadas
--10.Facturación total en cada país
--11.Facturación total en cada Estado
--12.Margen medio de beneficios y total facturado en cada país