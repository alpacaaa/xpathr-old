<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../utilities/master.xsl" />

<xsl:import href="../utilities/snippet-view.xsl" />

<xsl:variable name="snip" select="/data/store/key[@handle = 'snip']" />
<xsl:variable name="resources" select="$snip/key[@handle = 'resources']" />
<xsl:variable name="snip-id">
	<xsl:choose>
		<xsl:when test="$uniq-id">
			<xsl:value-of select="$uniq-id" />
		</xsl:when>
		<xsl:otherwise>temp</xsl:otherwise>
	</xsl:choose>
</xsl:variable>
</xsl:stylesheet>
