<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="/">
		<html>
			<head>
				<title>Ejemplo XSLT ciudades</title>
			</head>
			<body>
				<h2>Destacades</h2>
				
					
					<xsl:for-each select="//ciudad">
							
						<xsl:for-each select="//destacados">
							
							<xsl:value-of select="./persona"/>
							<br/>
						
						</xsl:for-each>
						
					</xsl:for-each>
				
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
