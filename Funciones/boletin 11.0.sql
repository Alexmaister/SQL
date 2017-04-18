--Sobre la base de datos LeoMetro

go
use LeoMetro
go

--Crea una función inline que nos devuelva el número de estaciones que ha recorrido cada tren en un determinado periodo de tiempo.
-- El principio y el fin de ese periodo se pasarán como parámetros
create function NumeroEstacionesRecorridas (@fecha_i date, @fecha_f date)
returns table as
return(
	select T.ID,count(E.ID),@fecha_i as fecha_inicio,2 from LM_Trenes as T
	inner join LM_Recorridos as R
	on T.ID=R.Tren
	inner join LM_Estaciones as E
	on R.Momento=E.ID
	inner join LM_Viajes as V
	on E.ID=V.IDEstacionEntrada
	where V.MomentoSalida>=@fecha_i
)

--Crea una función inline que nos devuelva el número de veces que cada usuario ha entrado en el metro en un periodo de tiempo.
-- El principio y el fin de ese periodo se pasarán como parámetros


--Crea una función inline a la que pasemos la matrícula de un tren y una fecha de inicio y fin y nos devuelva una tabla con el número de vecesç
-- que ese tren ha estado en cada estación, además del ID, nombre y dirección de la estación


--Crea una función inline que nos diga el número de personas que han pasado por una estacion en un periodo de tiempo.
-- Se considera que alguien ha pasado por una estación si ha entrado o salido del metro por ella.
-- El principio y el fin de ese periodo se pasarán como parámetros



--Crea una función inline que nos devuelva los kilómetros que ha recorrido cada tren en un periodo de tiempo.
-- El principio y el fin de ese periodo se pasarán como parámetros



--Crea una función inline que nos devuelva el número de trenes que ha circulado por cada línea en un periodo de tiempo.
-- El principio y el fin de ese periodo se pasarán como parámetros. Se devolverá el ID, denominación y color de la línea



--Crea una función inline que nos devuelva el tiempo total que cada usuario ha pasado en el metro en un periodo de tiempo.
-- El principio y el fin de ese periodo se pasarán como parámetros. Se devolverá ID, nombre y apellidos del pasajero.
-- El tiempo se expresará en horas y minutos.