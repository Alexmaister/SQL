--Sobre la base de datos LeoMetro

go
use LeoMetro
go

--Crea una funci�n inline que nos devuelva el n�mero de estaciones que ha recorrido cada tren en un determinado periodo de tiempo.
-- El principio y el fin de ese periodo se pasar�n como par�metros
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

--Crea una funci�n inline que nos devuelva el n�mero de veces que cada usuario ha entrado en el metro en un periodo de tiempo.
-- El principio y el fin de ese periodo se pasar�n como par�metros


--Crea una funci�n inline a la que pasemos la matr�cula de un tren y una fecha de inicio y fin y nos devuelva una tabla con el n�mero de veces�
-- que ese tren ha estado en cada estaci�n, adem�s del ID, nombre y direcci�n de la estaci�n


--Crea una funci�n inline que nos diga el n�mero de personas que han pasado por una estacion en un periodo de tiempo.
-- Se considera que alguien ha pasado por una estaci�n si ha entrado o salido del metro por ella.
-- El principio y el fin de ese periodo se pasar�n como par�metros



--Crea una funci�n inline que nos devuelva los kil�metros que ha recorrido cada tren en un periodo de tiempo.
-- El principio y el fin de ese periodo se pasar�n como par�metros



--Crea una funci�n inline que nos devuelva el n�mero de trenes que ha circulado por cada l�nea en un periodo de tiempo.
-- El principio y el fin de ese periodo se pasar�n como par�metros. Se devolver� el ID, denominaci�n y color de la l�nea



--Crea una funci�n inline que nos devuelva el tiempo total que cada usuario ha pasado en el metro en un periodo de tiempo.
-- El principio y el fin de ese periodo se pasar�n como par�metros. Se devolver� ID, nombre y apellidos del pasajero.
-- El tiempo se expresar� en horas y minutos.