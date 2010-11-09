<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="view.xsl" />

<xsl:template name="resource-title">
	<h3>Result</h3>
</xsl:template>

<xsl:template name="get-main-resource">
	<pre>
		<xsl:value-of select="snippet-result/text()" />
	</pre>
</xsl:template>
</xsl:stylesheet>
