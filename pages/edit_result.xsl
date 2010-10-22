<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="edit.xsl" />

<xsl:template name="resource-title">
	<xsl:text>Result</xsl:text>
</xsl:template>

<xsl:template name="get-main-resource">
	<pre>
		<xsl:value-of select="snippet-result/text()" />
	</pre>
</xsl:template>

</xsl:stylesheet>
