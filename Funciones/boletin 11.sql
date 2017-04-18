--En la base de datos NorthWind. Para comprobar si una tabla existe puedes utilizar la función OBJECT_ID
go
use Northwind
go

--Ejercicios
--Deseamos incluir un producto en la tabla Products llamado "Cruzcampo lata” pero no estamos seguros si se ha insertado o no.
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
--El precio son 4,40, el proveedor es el 16, la categoría 1 y la cantidad por unidad es "Pack 6 latas” "Discontinued” toma el valor 0 y el resto de columnas se dejarán a NULL.

update Products set UnitPrice= 4.40, SupplierID=16, CategoryID=1,QuantityPerUnit='Pack 6 latas',Discontinued=0 where ProductName='Cruzcampo lata'

--Escribe un script que compruebe si existe un producto con ese nombre. En caso afirmativo, actualizará el precio y en caso negativo insertarlo. 

declare @nombreProducto varchar 
set @nombreProducto= ('Cruzcampo lata')
if exists(select ProductName from Products where ProductName=@nombreProducto)
update Products set UnitPrice= 4.99
else
begin 
		insert into Products(ProductName)
		values('Cruzcampo lata')
	end
--Comprueba si existe una tabla llamada ProductSales. Esta tabla ha de tener de cada producto el ID, el Nombre, el Precio unitario, el número total de unidades vendidas y el total de dinero facturado con ese producto. Si no existe, créala
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

--Comprueba si existe una tabla llamada ShipShip. Esta tabla ha de tener de cada Transportista el ID, el Nombre de la compañía, el número total de envíos que ha efectuado y el número de países diferentes a los que ha llevado cosas. Si no existe, créala
--Comprueba si existe una tabla llamada EmployeeSales. Esta tabla ha de tener de cada empleado su ID, el Nombre completo, el número de ventas totales que ha realizado, el número de clientes diferentes a los que ha vendido y el total de dinero facturado. Si no existe, créala
--Entre los años 96 y 97 hay productos que han aumentado sus ventas y otros que las han disminuido. Queremos cambiar el precio unitario según la siguiente tabla:
--Incremento de ventas

create function ventasXAño(@año int)
returns table as
return(
select P.ProductID,sum(OD.Quantity)as cantidad from Products as P
inner join [Order Details] as OD
on P.ProductID=OD.ProductID
inner join Orders as O
on OD.OrderID=O.OrderID
where year(O.OrderDate)=@año
group by P.ProductID

)
select * from ventasXAño(1996)

alter function diferenciaVentasxAño(@añoComparador int,@añoComparado int)
returns table as
return (
select A1.ProductID as Producto ,((cast(A2.cantidad as float)/(A1.cantidad-A2.cantidad))*100) as DiferenciaTantoXCiento from ventasXAño(@añoComparado) as A1
inner join ventasXAño(@añoComparador)as A2
on A1.ProductID=A2.ProductID
)

select * from diferenciaVentasxAño(1996,1997)

/*cabecera: procedure CambioDPrecioSegunVentas (año1 int, año2 int)
descripcion: procedimiento que modificará el precio de los productos , segun la diferencia de ventas ,como se indica en la tabla,
entre dos años dados o un año y el año actual
entradas: dos enteros, el segundo oopcional, se tomará el año actual por defecto, el primer año sera el año comparado, y el segundo con el cual se comparará
precondiciones:los años introducidos deben ser años correspondiente a las ventas de la base de datos
postcondiciones:se modificara el precio de los productos segun la tabla
--Incremento de precio

--Negativo

---10%

--Entre 0 y 10%

--No varía

--Entre 10% y 50%

--+5%

--Mayor del 50%

--10% con un máximo de 2,25
*/
alter procedure CambioDPrecioSegunVentas
@año1 int,
 @año2 int=-1
 as
 begin 
 if @año2 = -1
	set @año2 = year(current_timestamp)
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
 from diferenciaVentasxAño(@año1,@año2)
 where ProductID=Producto
 end
 

 declare @año1 int
 set @año1=1996
 declare @año2 int
 set @año1=1997


 exec CambioDPrecioSegunVentas @año1,@año2

