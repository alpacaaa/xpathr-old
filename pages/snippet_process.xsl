<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../utilities/_master.xsl" />

<xsl:template name="current-resource">
	<h3>Processed Result</h3>
</xsl:template>

<xsl:template name="main">
	<xsl:if test="snippet-result[@result = 'success']">
		<pre>
			<code>
				<xsl:value-of select="snippet-result" />
			</code>
		</pre>
	</xsl:if>

	<xsl:if test="snippet-result[@result != 'success']">
		<div class="message error">
			Snippet can't be processed due to the following errors.
			<xsl:apply-templates select="snippet-result/processing-errors" />
		</div>
	</xsl:if>
</xsl:template>

<xsl:template match="processing-errors/general">
	<p>
		<xsl:apply-templates />
	</p>
</xsl:template>

<xsl:template match="processing-errors/stack | processing-errors/xml">
	<a href="{$root}/snippet/resource/{$user}/{$snip-id}/{@filename}/#{@line}">
		<xsl:value-of select="@filename" />
	</a>
	<p>
		<xsl:apply-templates />
	</p>
</xsl:template>

<xsl:template match="message">
	<xsl:value-of select="text()" /><br />
</xsl:template>
</xsl:stylesheet>
