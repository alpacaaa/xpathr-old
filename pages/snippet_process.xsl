<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../utilities/master.xsl" />

<xsl:template name="current-resource">
	<h3>Processed Result</h3>
</xsl:template>

<xsl:template name="main">
	<xsl:if test="snippet-result[@result = 'success']">
		<xsl:copy-of select="snippet-result/*" />
	</xsl:if>

	<xsl:if test="snippet-result[@result != 'success']">
		<div class="message error">
			Snippet can't be processed due to the following errors.
			<xsl:apply-templates select="snippet-result/*" />
		</div>
	</xsl:if>
</xsl:template>

<xsl:template match="processing-errors/general">
	<ul>
		<xsl:apply-templates />
	</ul>
</xsl:template>

<xsl:template match="processing-errors/stack | processing-errors/xml">
	<p>
		<a href="{$root}/snippet/resource/{$user}/{$snip-id}/{@filename}/#line-{@line}">
			<xsl:value-of select="@filename" />
		</a>
	</p>
	<ul>
		<xsl:apply-templates />
	</ul>
</xsl:template>

<xsl:template match="message">
	<li><xsl:value-of select="text()" /></li>
</xsl:template>
</xsl:stylesheet>
