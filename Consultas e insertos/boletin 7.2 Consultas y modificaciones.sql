--Sobre la base de datos "pubs” (En la plataforma aparece como "Ejemplos 2000").
GO
USE pubs
GO
--Título, precio y notas de los libros (titles) que tratan de cocina, ordenados de mayor a menor precio.
SELECT * FROM titles
SELECT title,price,notes FROM titles WHERE type='mod_cook' ORDER BY price DESC
--ID, descripción y nivel máximo y mínimo de los puestos de trabajo (jobs) que pueden tener un nivel 110.
SELECT * FROM jobs
SELECT job_id,job_desc AS DESCRIPCION,min_lvl,max_lvl FROM jobs WHERE max_lvl>=110
--Título, ID y tema de los libros que contengan la palabra "and” en las notas
SELECT title,title_id,type  FROM titles WHERE notes LIKE '%and%'
--Nombre y ciudad de las editoriales (publishers) de los Estados Unidos que no estén en California ni en Texas
SELECT* FROM publishers
SELECT pub_name,city FROM publishers WHERE state NOT IN ('CA','TX') AND country LIKE 'USA'
--Título, precio, ID de los libros que traten sobre psicología o negocios y cuesten entre diez y 20 dólares.
SELECT * FROM titles
SELECT title,title_id,price FROM titles WHERE (type = 'business' or type= 'psychology') and (price between 10 and 20)
--Nombre completo (nombre y apellido) y dirección completa de todos los autores que no viven en California ni en Oregón.
SELECT * FROM authors 
SELECT au_fname,au_lname,address,city,state,zip FROM authors WHERE state NOT IN ('OR','CA')
--Nombre completo y dirección completa de todos los autores cuyo apellido empieza por D, G o S.
SELECT * FROM authors
SELECT au_fname,au_lname FROM authors WHERE au_lname NOT LIKE '[DGS]%'
--ID, nivel y nombre completo de todos los empleados con un nivel inferior a 100, ordenado alfabéticamente
SELECT * FROM employee
SELECT emp_id,job_lvl,fname FROM employee WHERE job_lvl<100 ORDER BY fname ASC

--Modificaciones de datos
--Inserta un nuevo autor.
SELECT * FROM authors
INSERT INTO authors (au_id ,au_lname,au_fname,contract )
VALUES ('123-21-7568','Carson','Megan',1)
--Inserta dos libros, escritos por el autor que has insertado antes y publicados por la editorial "Ramona publishers”.

--Modifica la tabla jobs para que el nivel mínimo sea 90.

--Crea una nueva editorial (publihers) con ID 9908, nombre Mostachon Books y sede en Utrera.

--Cambia el nombre de la editorial con sede en Alemania para que se llame "Machen Wücher" y traslasde su sede a Stuttgart