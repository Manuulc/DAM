Use Antisistemas

--EJERCICIO 1 ( Faltan las personas detenidas )
SELECT G.Nombre,COUNT(AP.ID) AS [Numero de actos] FROM ActosProtesta AS AP
	INNER JOIN Incidentes AS I ON AP.ID = I.IDActo
	INNER JOIN GruposProtestas AS GP ON AP.ID = GP.IDActo
	INNER JOIN Grupos AS G ON GP.IDGrupo = G.ID
	INNER JOIN Detenciones AS D ON I.IDActo = D.IDActo
	GROUP BY G.Nombre

--EJERCICIO 2
SELECT AP.ID AS [ID del Acto] ,C.Nombre AS [Materiales] FROM ActosProtesta AS AP
	INNER JOIN Incidentes AS I ON AP.ID = I.IDActo
	INNER JOIN MaterialesIncidentes AS MI ON I.IDActo = MI.IDActo
	INNER JOIN Materiales AS M ON MI.IDMaterial = M.Categoria
	INNER JOIN Categorias AS C ON M.Categoria = C.ID
	WHERE C.Nombre NOT IN ('Arrojadizas','Armas blancas')
	GROUP BY AP.ID,C.Nombre

--EJERCICIO 3 (ESTILO SUPERVENTAS),( Faltan menores de edad )
GO
CREATE VIEW [Detenciones por Ciudad] AS 
SELECT AP.ID, AP.Ciudad,COUNT(D.IDActivista) AS [Detenidos] FROM ActosProtesta AS AP
	INNER JOIN Incidentes AS I ON AP.ID = I.IDActo
	INNER JOIN Detenciones AS D ON I.IDActo = D.IDActo
	GROUP BY AP.Ciudad, AP.ID
GO

SELECT DPC.Ciudad,DPC.Detenidos FROM [Detenciones por Ciudad] AS DPC
	INNER JOIN (
		SELECT Ciudad,MAX([Detenidos]) AS [Maximo de detenidos] FROM [Detenciones por Ciudad]
		GROUP BY Ciudad
		) AS MDPC ON DPC.Detenidos = MDPC.[Maximo de detenidos]
		GROUP BY DPC.Ciudad,DPC.Detenidos

/*EJERCICIO 4 (ESTILO SUPERVENTAS) (No creo que este bien, mi intencion era unir 2 tablas, una en la 
que obtengamos las horas y detenciones por cada ciudad y despues unirlas con otra tabla que contenga la hora mas peligrosa igualando
en la condicion del ON la hora de la detencion con el maximo de la hora.*/
GO
CREATE VIEW [Hora por ciudad] AS 
SELECT D.Hora,Ciudad, COUNT(D.ID) AS [Detenidos] FROM Detenciones AS D
	INNER JOIN Incidentes AS I ON D.IDActo = I.IDActo
	INNER JOIN ActosProtesta AS AP ON I.IDActo = AP.ID	
	GROUP BY D.Hora,AP.Ciudad
	
GO

SELECT HC.Hora,HC.Ciudad FROM [Hora por ciudad] AS HC
	INNER JOIN (
	SELECT Ciudad,MAX(Hora) AS [Hora mas peligrosa] FROM [Hora por ciudad]
	GROUP BY Ciudad
	) AS HCMP ON HC.Hora = HCMP.[Hora mas peligrosa] AND HC.Ciudad = HCMP.Ciudad
	GROUP BY HC.Ciudad,HC.Hora

--EJERCICIO 5


