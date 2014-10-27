<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="text" media-type="text/plain" omit-xml-declaration="yes" indent="no" />
	<xsl:template match="/feature/plugin">
		<xsl:value-of select="@id" />
		<xsl:text>;version=</xsl:text>
		<xsl:value-of select="@version" />
	</xsl:template>
</xsl:stylesheet>
