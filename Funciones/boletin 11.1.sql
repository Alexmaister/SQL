--En la base de datos NorthWind. Para comprobar si una tabla existe puedes utilizar la funci�n OBJECT_ID
go
use Northwind
go

--Ejercicios
--Deseamos incluir un producto en la tabla Products llamado "Cruzcampo lata� pero no estamos seguros si se ha insertado o no.
declare @Producto int 
set @Producto = (select ProductID from Products where ProductName= 'Cruzcampo lata' )
if @Producto is null
	begin 
		insert into Products(ProductName)
		values('Cruzcampo lata')
	end
else
	begin 
		print 'Cervezaaa!!'
	end

	select * from Products where ProductName= 'Cruzcampo lata'


--if @@Rowcount >0
--print isnull (@id,'Es lo q hay')
--if exists(select...)
--if @id is null
--comprobar tablas
--funcion : object_id()
--begin end
--else 
--begin end
--El precio son 4,40, el proveedor es el 16, la categor�a 1 y la cantidad por unidad es "Pack 6 latas� "Discontinued� toma el valor 0 y el resto de columnas se dejar�n a NULL.

update Products set UnitPrice= 4.40, SupplierID=16, CategoryID=1,QuantityPerUnit='Pack 6 latas',Discontinued=0 where ProductName='Cruzcampo lata'

--Escribe un script que compruebe si existe un producto con ese nombre. En caso afirmativo, actualizar� el precio y en caso negativo insertarlo. 

declare @nombreProducto varchar 
set @nombreProducto= ('Cruzcampo lata')
if exists(select ProductName from Products where ProductName=@nombreProducto)
update Products set UnitPrice= 4.99
else
begin 
		insert into Products(ProductName)
		values('Cruzcampo lata')
	end
--Comprueba si existe una tabla llamada ProductSales. Esta tabla ha de tener de cada producto el ID, el Nombre, el Precio unitario, el n�mero total de unidades vendidas y el total de dinero facturado con ese producto. Si no existe, cr�ala
if(object_id('ProductSales')is  null )
begin
	create table ProductSales(
	
	ID int not null,
	Nombre varchar(20) not null,
	PrecioUnitario money,
	Unidades_Vendidas int ,
	Dinero_Facturado money,

	
	 constraint PK_ProductSales primary key(ID),
	)
	if(object_id('ProductSales')is  null)
	print 'Hubo un error inesperado'
	else
	print 'La tabla se ha creado exitosamente'
end
else print 'La tabla ya existe'

--Comprueba si existe una tabla llamada ShipShip. Esta tabla ha de tener de cada Transportista el ID, el Nombre de la compa��a, el n�mero total de env�os que ha efectuado y el n�mero de pa�ses diferentes a los que ha llevado cosas. Si no existe, cr�ala
--Comprueba si existe una tabla llamada EmployeeSales. Esta tabla ha de tener de cada empleado su ID, el Nombre completo, el n�mero de ventas totales que ha realizado, el n�mero de clientes diferentes a los que ha vendido y el total de dinero facturado. Si no existe, cr�ala
--Entre los a�os 96 y 97 hay productos que han aumentado sus ventas y otros que las han disminuido. Queremos cambiar el precio unitario seg�n la siguiente tabla:
--Incremento de ventas

create function ventasXA�o(@a�o int)
returns table as
return(
select P.ProductID,sum(OD.Quantity)as cantidad from Products as P
inner join [Order Details] as OD
on P.ProductID=OD.ProductID
inner join Orders as O
on OD.OrderID=O.OrderID
where year(O.OrderDate)=@a�o
group by P.ProductID

)
select * from ventasXA�o(1996)

alter function diferenciaVentasxA�o(@a�oComparador int,@a�oComparado int)
returns table as
return (
select A1.ProductID as Producto ,((cast(A2.cantidad as float)/(A1.cantidad-A2.cantidad))*100) as DiferenciaTantoXCiento from ventasXA�o(@a�oComparado) as A1
inner join ventasXA�o(@a�oComparador)as A2
on A1.ProductID=A2.ProductID
)

select * from diferenciaVentasxA�o(1996,1997)

/*cabecera: procedure CambioDPrecioSegunVentas (a�o1 int, a�o2 int)
descripcion: procedimiento que modificar� el precio de los productos , segun la diferencia de ventas ,como se indica en la tabla,
entre dos a�os dados o un a�o y el a�o actual
entradas: dos enteros, el segundo oopcional, se tomar� el a�o actual por defecto, el primer a�o sera el a�o comparado, y el segundo con el cual se comparar�
precondiciones:los a�os introducidos deben ser a�os correspondiente a las ventas de la base de datos
postcondiciones:se modificara el precio de los productos segun la tabla
--Incremento de precio

--Negativo

---10%

--Entre 0 y 10%

--No var�a

--Entre 10% y 50%

--+5%

--Mayor del 50%

--10% con un m�ximo de 2,25
*/
alter procedure CambioDPrecioSegunVentas
@a�o1 int,
 @a�o2 int=-1
 as
 begin 
 if @a�o2 = -1
	set @a�o2 = year(current_timestamp)
 update Products
 set UnitPrice=case 
 when (DiferenciaTantoXCiento)<0 then UnitPrice-(10*UnitPrice/100)
 when (DiferenciaTantoXCiento) between 10 and 50 then UnitPrice+(5*UnitPrice/100)
 when (DiferenciaTantoXCiento)>50 then 
 case 
 when  (10*UnitPrice/100)>2.25 
 then UnitPrice+2.25 
 else  UnitPrice+(10*UnitPrice/100)
 end
 end
 from diferenciaVentasxA�o(@a�o1,@a�o2)
 where ProductID=Producto
 end
 

 declare @a�o1 int
 set @a�o1=1996
 declare @a�o2 int
 set @a�o1=1997


 exec CambioDPrecioSegunVentas @a�o1,@a�o2

