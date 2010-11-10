<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="edit.xsl" />

<xsl:template name="resource-title">
	<xsl:variable name="res" select="snippet-resource/resource" />

	<label for="filename">filename</label>
	<input type="text" name="snippet[resources][{$res/@file}][filename]" value="{$res/@file}" id="filename" />

	<input type="checkbox" name="snippet[main-resource]" id="snippet[main-resource]">
		<xsl:if test="$res/@main = 'true'">
			<xsl:attribute name="checked">checked</xsl:attribute>
		</xsl:if>
	</input>
	<label for="snippet[main-resource]">Main resource</label>

	<input type="submit" name="action[delete-resource]" value="Delete" />
</xsl:template>

<xsl:template name="get-main-resource">
	<xsl:apply-templates select="snippet-resource/*" mode="main" />
</xsl:template>
</xsl:stylesheet>
