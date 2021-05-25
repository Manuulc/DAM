/*
EXAMEN BADAT MAYO 2021
OPCION B
*/
Use HBleO

SELECT * FROM HCapitulos
SELECT * FROM HContenidos
SELECT * FROM HGeneros
SELECT * FROM HPeliculas
SELECT * FROM HPeliculasGeneros
SELECT * FROM HPerfiles
SELECT * FROM HRecibos
SELECT * FROM HSeries
SELECT * FROM HSuscripciones
SELECT * FROM HTemporadas
SELECT * FROM HTiposSuscripcion
SELECT * FROM HTitulares
SELECT * FROM HVisionados

/* EJERCICIO 1

Nombre: verSerieFavorita
Descripcion: Funcion inline a la que se le pasa el ID de un suscriptor y nos digan cual es su serie favorita ( a la que ha dedicado mas tiempo )
Entrada: @IDSusc int
Salida: Devuelve una tabla en la que aparece el id, nombre de suscriptor y su serie favorita.

*/

GO
CREATE FUNCTION verSerieFavorita(@IDSusc Int)
RETURNS TABLE AS 
		RETURN ()
		                                                                                                                               
GO

/* EJERCICIO 2

Nombre: verImporteEnContenidoExtra
Descripcion: Funcion escalar a la que se le pasa el ID de un suscriptor y un periodo de tiempo (inicio y fin) y nos devuelve el importe gastado
en contenidos extras entre esa fecha
Entradas: @IDSusc int
Salidas: Devuelve un int con el importe gastado

*/

GO
CREATE FUNCTION verImporteEnContenidoExtra(@IDSusc Int)
	RETURNS INT AS
		BEGIN
			RETURN()
		END
GO

/* EJERCICIO 3

Nombre: verMinutosPorTemporada
Descripcion: Funcion inline a la que se le pasa el ID de una serie y nos devuelva una tabla con numero de visionados y los minutos totales
vistos de cada temporada, asi como el incremento o decremento entre cada temporada y la anterior.
Entradas: @IDSerio int
Salidas: Devuelve una tabla con el numero de visionados, minutos vistos por temporada y decremento o incremento entre cada una.

*/

GO
CREATE FUNCTION verMinutosPorTemporada (@IDSerie Int)
RETURNS TABLE AS
	RETURN ()
GO

/* EJERCICIO 4

Nombre: crearRecibo
Descripcion: Procedimiento almacenado que al pasar un id de usuario mes y año devuelva un recibo con cuota y contenidos de pago de ese mes.
Entradas: @IDUsuario int
		  @FechaInicio date
		  @FechaFin date
Salidas: 

*/


GO
CREATE PROCEDURE crearRecibo
@IDUsuario AS Int,
@FechaInicio AS date,
@FechaFin AS date
AS
()

