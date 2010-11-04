<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="view.xsl" />

<xsl:template name="resource-title">
	<xsl:variable name="res" select="snippet-resource/resource" />

	<h3>
		<xsl:if test="$res/@main = 'true'">
			<xsl:attribute name="class">main-resource</xsl:attribute>
		</xsl:if>
		<xsl:value-of select="$res/@file" />
	</h3>
</xsl:template>

<xsl:template name="get-main-resource">
	<xsl:apply-templates select="snippet-resource/*" mode="main" />
</xsl:template>

<xsl:template name="get-edit-link">
	<xsl:value-of select="concat($root, '/edit/resource/', $snip-id, '/', $resource, '/')" />
</xsl:template>
</xsl:stylesheet>
