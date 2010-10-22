<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="edit.xsl" />

<xsl:template name="resource-title">
	<xsl:text>Parameters</xsl:text>
</xsl:template>

<xsl:template name="get-main-resource">
	<textarea name="snippet[parameters]" rows="30" cols="160">
		<xsl:choose>
			<xsl:when test="events/save-parameters[@result = 'error']">
				<xsl:value-of select="events/save-parameters/post-data" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates select="snippet-parameters/parameters/param" mode="main" />
			</xsl:otherwise>
		</xsl:choose>
	</textarea>
</xsl:template>


<xsl:template match="snippet-parameters/parameters/param" mode="main" >
	<xsl:value-of select="concat('$', @key, ' = ', text())" />
<xsl:text><!-- oh shi -->
</xsl:text>
</xsl:template>

</xsl:stylesheet>
