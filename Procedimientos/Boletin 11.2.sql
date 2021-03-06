--Bolet�n 11.2
--Sobre la base de datos AirLeo.

--Ejercicio 1
--Escribe un procedimiento que cancele un pasaje y las tarjetas de embarque asociadas.

--Recibir� como par�metros el ID del pasaje.

alter procedure CancelarPasaje @id int
as 
begin

delete AL_Tarjetas where Numero_Pasaje= @id
delete AL_Vuelos_Pasajes where Numero_Pasaje =@id



delete AL_Pasajes where Numero=@id 


end

select * from AL_Pasajeros join AL_Pasajes on ID=ID_Pasajero join AL_Tarjetas on Numero_Pasaje=Numero
exec CancelarPasaje 8
--Ejercicio 2
--Escribe un procedimiento almacenado que reciba como par�metro el ID de un pasajero y devuelva en un par�metro de salida el n�mero de vuelos diferentes que ha tomado ese pasajero.
create procedure NumeroDeVuelosPasajero @id varchar(5), @numeroVuelos int output
as
begin
set @numeroVuelos= (select count(*) from AL_Pasajes join AL_Pasajeros on ID_Pasajero=ID where ID=@id)
end
declare @numero int 
exec NumeroDeVuelosPasajero 'A003', @numeroVuelos=@numero output
print @numero

--Ejercicio 3
--Escribe un procedimiento almacenado que reciba como par�metro el ID de un pasajero y dos fechas y nos devuelva en otro par�metro (de salida) el n�mero de horas que ese pasajero ha volado durante ese intervalo de fechas.
alter procedure HorasDeVuelo @id varchar(5), @fecha_i date, @fecha_f date, @horasdeVuelo int output
as
begin
select (sum(DATEDIFF(MINUTE,Salida,Llegada))/60)from AL_Vuelos  join AL_Tarjetas on Codigo=Codigo_Vuelo join AL_Pasajes on Numero_Pasaje=Numero join AL_Pasajeros on ID_Pasajero=ID 
where ((ID=@id )and(Salida between @fecha_i and @fecha_f))
end

declare @horas int
exec HorasDeVuelo 'A003', '1/1/2000','1/1/2019' , @horasdeVuelo =@horas output
print @horas
--Ejercicio 4
--Escribe un procedimiento que reciba como par�metro todos los datos de un pasajero y un n�mero de vuelo y realice el siguiente proceso:

--En primer lugar, comprobar� si existe el pasajero. Si no es as�, lo dar� de alta.

--A continuaci�n comprobar� si el vuelo tiene plazas disponibles (hay que consultar la capacidad del avi�n) y en caso afirmativo crear� un nuevo pasaje para ese vuelo.

--Ejercicio 5
--Escribe un procedimiento almacenado que cancele un vuelo y reubique a sus pasajeros en otro. Se ocupar�n los asientos libres en el vuelo sustituto. Se comprobar� que ambos vuelos realicen el mismo recorrido. Se borrar�n todos los pasajes y las tarjetas de embarque y se generar�n nuevos pasajes. No se generar�n nuevas tarjetas de embarque. El vuelo a cancelar y el sustituto se pasar�n como par�metros. Si no se pasa el vuelo sustituto, se buscar� el primer vuelo inmediatamente posterior al cancelado que realice el mismo recorrido.

--Ejercicio 6
--Escribe un procedimiento al que se pase como par�metros un c�digo de un avi�n y un momento (dato fecha-hora) y nos escriba un mensaje que indique d�nde se encontraba ese avi�n en ese momento. El mensaje puede ser "En vuelo entre los aeropuertos de NombreAeropuertoSalida y NombreaeropuertoLlegada� si el avi�n estaba volando en ese momento, o "En tierra en el aeropuerto NombreAeropuerto� si no est� volando. Para saber en qu� aeropuerto se encuentra el avi�n debemos consultar el �ltimo vuelo que realiz� antes del momento indicado.
--Si se omite el segundo par�metro, se tomar� el momento actual.