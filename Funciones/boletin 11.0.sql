--Sobre la base de datos LeoMetro

go
use LeoMetro
go

--Crea una funci�n inline que nos devuelva el n�mero de estaciones que ha recorrido cada tren en un determinado periodo de tiempo.
-- El principio y el fin de ese periodo se pasar�n como par�metros
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

--Crea una funci�n inline que nos devuelva el n�mero de veces que cada usuario ha entrado en el metro en un periodo de tiempo.
-- El principio y el fin de ese periodo se pasar�n como par�metros
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

--Crea una funci�n inline a la que pasemos la matr�cula de un tren y una fecha de inicio y fin y nos devuelva una tabla con el n�mero de veces�
-- que ese tren ha estado en cada estaci�n, adem�s del ID, nombre y direcci�n de la estaci�n
alter function NumeroEstacionesXTren(@matricula varchar(30), @fecha_i date ,@fecha_f date)
returns table as
return(
select count (R.estacion)as [N� de veces],E.ID,E.Denominacion,E.Direccion from LM_Estaciones as E
inner join LM_Recorridos as R
on E.ID= R.estacion
inner join LM_Trenes as T
on R.Tren=T.ID
where( Momento between @fecha_i and @fecha_f) and (T.Matricula=@matricula)
group by E.ID,E.Denominacion,E.Direccion
)
select * from LM_Trenes
select * from NumeroEstacionesXTren('0100FLZ','1/1/2001','1/1/2018')
--Crea una funci�n inline que nos diga el n�mero de personas que han pasado por una estacion en un periodo de tiempo.
-- Se considera que alguien ha pasado por una estaci�n si ha entrado o salido del metro por ella.
-- El principio y el fin de ese periodo se pasar�n como par�metros
create function PersonaXEstacion (@fecha_i date , @fecha_f date)
returns table as
return(
select E.ID as Tren,count(V.IDPasajero)as [Numero Pasajeros] from LM_Estaciones as E
inner join LM_Viajes as V
on E.ID=V.IDEstacionEntrada or E.ID=V.IDEstacionSalida
where ((V.MomentoEntrada between @fecha_i and @fecha_f) or (V.MomentoSalida between @fecha_i and @fecha_f))
group by E.ID)

select * from PersonaXEStacion('1/1/2001','1/1/2018')
--Crea una funci�n inline que nos devuelva los kil�metros que ha recorrido cada tren en un periodo de tiempo.
-- El principio y el fin de ese periodo se pasar�n como par�metros



--Crea una funci�n inline que nos devuelva el n�mero de trenes que ha circulado por cada l�nea en un periodo de tiempo.
-- El principio y el fin de ese periodo se pasar�n como par�metros. Se devolver� el ID, denominaci�n y color de la l�nea



--Crea una funci�n inline que nos devuelva el tiempo total que cada usuario ha pasado en el metro en un periodo de tiempo.
-- El principio y el fin de ese periodo se pasar�n como par�metros. Se devolver� ID, nombre y apellidos del pasajero.
-- El tiempo se expresar� en horas y minutos.