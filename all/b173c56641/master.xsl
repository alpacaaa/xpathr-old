<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output method="html"/>
<xsl:variable name="stica" select="document('anziaaano.xml')" />
	<xsl:template match="/">
<xsl:value-of select="$stica" />
		<xsl:apply-templates />
	</xsl:template>
</xsl:stylesheet>