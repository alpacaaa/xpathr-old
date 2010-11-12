<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="view.xsl" />

<xsl:param name="files-list-message" select="'Other files'" />

<xsl:template match="snippet-information/entry">
	<xsl:variable name="main" select="/data/resources-list/resource[@file = $resource and @main = 'true']" />
	
	<p>
		This is 
		<a href="{$current-url}">
			<xsl:if test="$main = true()">
				<xsl:attribute name="class">main</xsl:attribute>
			</xsl:if>
			<xsl:value-of select="$resource" />
		</a> 
		from 
		<a>
			<xsl:attribute name="href">
				<xsl:call-template name="get-view-link" />
			</xsl:attribute>
			<xsl:value-of select="title/text()" />
		</a>.
	</p>
</xsl:template>

<xsl:template name="get-main-resource">
	<xsl:apply-templates select="snippet-resource/*" mode="main" />
</xsl:template>

<xsl:template name="get-edit-link">
	<xsl:value-of select="concat($root, '/edit/resource/', $snip-id, '/', $resource, '/')" />
</xsl:template>
</xsl:stylesheet>
