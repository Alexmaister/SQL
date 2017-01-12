--Sobre la base de Datos AdventureWorks
GO
 USE AdventureWorks2014
 GO

--Nombre, numero de producto, precio y color de los productos de color rojo o amarillo cuyo precio esté comprendido entre 50 y 500
SELECT Name,ProductNumber,ListPrice,Color FROM Production.Product
WHERE (Color IN ('RED','YELLOW')AND ListPrice BETWEEN 50 AND 500)
--Nombre, número de producto, precio de coste,  precio de venta, margen de beneficios total y margen de beneficios en % del precio de venta de los productos de categorías inferiores a 16
SELECT * FROM Production.Product
SELECT Name,ProductNumber,StandardCost,ListPrice,ListPrice-StandardCost as [Margen de beneficio TOTAL],(ListPrice/StandardCost*100)-100 AS [MARGEN DE BENEFICIO %]
FROM Production.Product WHERE ListPrice>0 ORDER BY [Margen de beneficio TOTAL] DESC
--Empleados cuyo nombre o apellidos contenga la letra "r". Los empleados son los que tienen el valor "EM" en la columna PersonType de la tabla Person
SELECT * FROM Person.Person WHERE PersonType = 'EM' AND (FirstName LIKE '%r%' OR LastName LIKE '%r%')
--LoginID, nationalIDNumber, edad y puesto de trabajo (jobTitle) de los empleados (tabla Employees) de sexo femenino que tengan más de cinco años de antigüedad
SELECT LoginID,NationalIDNumber,DATEDIFF(YEAR,BirthDate,CURRENT_TIMESTAMP) AS Age,DATEDIFF(YEAR,HireDate,CURRENT_TIMESTAMP)AS aNTIGUEDAD,JobTitle FROM HumanResources.Employee 
WHERE Gender='F' AND DATEDIFF(YEAR,HireDate,CURRENT_TIMESTAMP)>=5
--Ciudades correspondientes a los estados 11, 14, 35 o 70, sin repetir. Usar la tabla Person.Address
SELECT DISTINCT City FROM Person.Address
WHERE StateProvinceID IN ('11','14','35','70')