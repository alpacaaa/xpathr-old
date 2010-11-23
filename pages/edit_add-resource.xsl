<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="edit.xsl" />

<xsl:template name="resource-title">
	<xsl:variable name="filename">
		<xsl:choose>
			<xsl:when test="events/add-resource/post-data">
				<xsl:value-of select="events/add-resource/post-data/@filename" />
			</xsl:when>
			<xsl:otherwise>filename.xml</xsl:otherwise>
		</xsl:choose>

	</xsl:variable>
	
	<label for="filename">filename</label>
	<input type="text" name="snippet[new-resource][filename]" value="{$filename}" id="filename" />

	<input type="checkbox" name="snippet[main-resource]" id="snippet[main-resource]">
		<xsl:if test="count(resources-list/resource[@main = 'true']) &lt; 2">
			<xsl:attribute name="checked">checked</xsl:attribute>
		</xsl:if>
	</input>
	<label for="snippet[main-resource]">Main resource</label>
</xsl:template>

<xsl:template name="get-main-resource">
	<textarea name="snippet[new-resource][content]" rows="30" cols="160">
		<xsl:choose>
			<xsl:when test="/data/events/add-resource/post-data">
				<xsl:value-of select="/data/events/add-resource/post-data/text()" />
			</xsl:when>
			<xsl:otherwise><source>Paste here :)</source></xsl:otherwise>
		</xsl:choose>
	</textarea>
</xsl:template>
</xsl:stylesheet>