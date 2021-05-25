USE pubs
SELECT * FROM ActualizaTitles
SELECT * FROM titles

 -- DECLARACION DE LAS VARIABLES
DECLARE @VCB int, @Final int
DECLARE @Letra varChar(1)

 -- INICIALIZACION DE LAS VARIABLES
SELECT @VCB = MIN(NumActualiza) FROM ActualizaTitles
SELECT @Final = MAX(NumActualiza) FROM ActualizaTitles


 -- BUCLE PARA RECORRER LAS FILAS DE LA TABLA ActualizaTitles
WHILE @VCB <= @Final
	BEGIN --INICIO WHILE
		SELECT @Letra = TipoActualiza FROM ActualizaTitles WHERE NumActualiza = @VCB
			
--Si la columna TipoActualiza contiene una "I" hay que insertar una nueva fila en titles con todos los datos leídos de esa fila de ActualizaTitles.

			IF @Letra = 'I'
				INSERT INTO titles (title_id,title,[type],pub_id,price,advance,royalty,ytd_sales,notes,pubdate)
					SELECT title_id,title,[type],pub_id,price,advance,royalty,ytd_sales,notes,pubdate FROM ActualizaTitles
						WHERE NumActualiza = @VCB

--Si TipoActualiza contiene una "D" hay que eliminar la fila cuyo código (title_id) se incluye.				
				
			IF @Letra = 'D' 
				DELETE FROM titles WHERE title_id = (SELECT title_id FROM ActualizaTitles WHERE NumActualiza = @VCB)

--Si TipoActualiza es "U" hay que actualizar la fila identificada por title_id con las columnas que no sean Null. Las que sean Null se dejan igual.
				
				IF @Letra = 'U' 
					UPDATE titles
						SET pub_id = (SELECT pub_id FROM ActualizaTitles WHERE TipoActualiza = @Letra),
							price = (SELECT price FROM ActualizaTitles WHERE TipoActualiza = @Letra),
							advance = (SELECT advance FROM ActualizaTitles WHERE TipoActualiza = @Letra),
							royalty = (SELECT royalty FROM ActualizaTitles WHERE TipoActualiza = @Letra),
							pubdate = (SELECT pubdate FROM ActualizaTitles WHERE TipoActualiza = @Letra)

			SET @VCB += 1
	END --FIN WHILE
	