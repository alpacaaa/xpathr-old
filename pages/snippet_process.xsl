<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../utilities/_master.xsl" />

<xsl:template name="current-resource">
	<h3>Processed Result</h3>
</xsl:template>

<xsl:template name="main">
	<pre>
		<code>
			<xsl:value-of select="snippet-result" />
		</code>
	</pre>
</xsl:template>
</xsl:stylesheet>
