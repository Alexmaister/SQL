--Sobre la base de datos LeoMetro

go
use LeoMetro
go

--Crea una función inline que nos devuelva el número de estaciones que ha recorrido cada tren en un determinado periodo de tiempo.
-- El principio y el fin de ese periodo se pasarán como parámetros
create function NumeroEstacionesRecorridas (@fecha_i date, @fecha_f date)
returns table as
return(
	select T.ID,count(R.estacion) as [Numero de estaciones],@fecha_i as fecha_inicio, @fecha_f as fecha_fin from LM_Trenes as T
	inner join LM_Recorridos as R
	on T.ID=R.Tren
	where R.Momento between @fecha_i and @fecha_f
	group by T.ID
	
)
select * from NumeroEstacionesRecorridas('1/1/2009','1/1/2018')

--Crea una función inline que nos devuelva el número de veces que cada usuario ha entrado en el metro en un periodo de tiempo.
-- El principio y el fin de ese periodo se pasarán como parámetros
create function EntradasMetroXUsuario (@fecha_i date, @fecha_f date)
returns table as 
return(
select P.ID,count (V.IDEstacionEntrada)as [Numero de Estaciones] from LM_Pasajeros as P
inner join LM_Viajes as V
on P.ID=V.IDPasajero
where MomentoEntrada between @fecha_i and @fecha_f
group by P.ID

)

select * from  EntradasMetroXUsuario('1/1/2001','1/1/2015')

--Crea una función inline a la que pasemos la matrícula de un tren y una fecha de inicio y fin y nos devuelva una tabla con el número de vecesç
-- que ese tren ha estado en cada estación, además del ID, nombre y dirección de la estación
alter function NumeroEstacionesXTren(@matricula varchar(30), @fecha_i date ,@fecha_f date)
returns table as
return(
select count (R.estacion)as [Nº de veces],E.ID,E.Denominacion,E.Direccion from LM_Estaciones as E
inner join LM_Recorridos as R
on E.ID= R.estacion
inner join LM_Trenes as T
on R.Tren=T.ID
where( Momento between @fecha_i and @fecha_f) and (T.Matricula=@matricula)
group by E.ID,E.Denominacion,E.Direccion
)
select * from LM_Trenes
select * from NumeroEstacionesXTren('0100FLZ','1/1/2001','1/1/2018')
--Crea una función inline que nos diga el número de personas que han pasado por una estacion en un periodo de tiempo.
-- Se considera que alguien ha pasado por una estación si ha entrado o salido del metro por ella.
-- El principio y el fin de ese periodo se pasarán como parámetros
create function PersonaXEstacion (@fecha_i date , @fecha_f date)
returns table as
return(
select E.ID as Tren,count(V.IDPasajero)as [Numero Pasajeros] from LM_Estaciones as E
inner join LM_Viajes as V
on E.ID=V.IDEstacionEntrada or E.ID=V.IDEstacionSalida
where ((V.MomentoEntrada between @fecha_i and @fecha_f) or (V.MomentoSalida between @fecha_i and @fecha_f))
group by E.ID)

select * from PersonaXEStacion('1/1/2001','1/1/2018')
--Crea una función inline que nos devuelva los kilómetros que ha recorrido cada tren en un periodo de tiempo.
-- El principio y el fin de ese periodo se pasarán como parámetros



--Crea una función inline que nos devuelva el número de trenes que ha circulado por cada línea en un periodo de tiempo.
-- El principio y el fin de ese periodo se pasarán como parámetros. Se devolverá el ID, denominación y color de la línea



--Crea una función inline que nos devuelva el tiempo total que cada usuario ha pasado en el metro en un periodo de tiempo.
-- El principio y el fin de ese periodo se pasarán como parámetros. Se devolverá ID, nombre y apellidos del pasajero.
-- El tiempo se expresará en horas y minutos.