<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="/">
		<html>
			<head>
				<title>Granja</title>
			</head>
			<body>
				<h2>Las tablas tendrán una columna para los nombres de los animales y otras dos columnas, una con los productos y otra para los alimentos</h2>

				<table border="5" cellspacing="0" cellpadding="5" bordercolor="#000CFF">

					<tr align="center" bgcolor="#FA8072">
						<th>Tipo</th>
						<th>Animal</th>
						<th>Alimentacion</th>
						<th>Producto</th>
					</tr>
					
					<xsl:for-each select="/bichos/animal/tipo[not(preceding::tipo/. = .)]">
					
					<xsl:variable name="queTipo" select="."/>
						
						<tr align="center">
							<td bgcolor="#FFA07A">

								<xsl:value-of select="."/>

							</td>
							
							<td bgcolor="#898980">
								
								<table>
								<xsl:for-each select="./../../animal[tipo=$queTipo]">
								
								<tr>
								
								<td><xsl:value-of select="./@nombre"/></td>
								
								</tr>
								
								</xsl:for-each>
								</table>
							</td>

							<td bgcolor="#87E78C">
								
								<table>
								<xsl:for-each select="./../../animal[tipo=$queTipo]">
								
								<tr>
								
								<td><xsl:value-of select="./alimentacion"/></td>
		
								</tr>
								
								</xsl:for-each>
								</table>
								

							</td>
							<td bgcolor="#E8EC9F">
								
								<table>
								<xsl:for-each select="./../../animal[tipo=$queTipo]">
								
								<tr>
								
								<td>
								<ul>
									<xsl:for-each select="./produccion/producto">
										<li>
											<xsl:value-of select="."/>

										</li>
									</xsl:for-each>
								</ul>
								
								
								</td>
								</tr>
								
								</xsl:for-each>
								</table>
								
							</td>

						</tr>
					</xsl:for-each>
				</table>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>