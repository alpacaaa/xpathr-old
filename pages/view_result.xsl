<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="view.xsl" />

<xsl:template match="snippet-information/entry">
	<p>
		This is the processed result of 
		<a>
			<xsl:attribute name="href">
				<xsl:call-template name="get-view-link" />
			</xsl:attribute>
			<xsl:value-of select="title/text()" />
		</a>.
	</p>
</xsl:template>

<xsl:template name="get-main-resource">
	<pre>
		<code>
			<xsl:value-of select="snippet-result/text()" />
		</code>
	</pre>
</xsl:template>
</xsl:stylesheet>
