<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../utilities/get-snippets.xsl" />

<xsl:template match="data">
	<xsl:apply-templates select="snippet-list-by-user" />
</xsl:template>

<xsl:template match="snippet-list-by-user">
	<xsl:call-template name="get-snippets">
		<xsl:with-param name="pagination-url" 
			select="concat($root, '/snippets/', $user, '?page=$')" />
	</xsl:call-template>
</xsl:template>


<xsl:template name="title" mode="content">
	<h2>All Snippets</h2>
	<a href="{$root}/my-snippets/">view my snippets</a>
</xsl:template>

<xsl:template match="data" mode="head">Snippets</xsl:template>
</xsl:stylesheet>
