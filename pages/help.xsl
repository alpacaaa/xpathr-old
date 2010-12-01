<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../utilities/master.xsl" />

<xsl:template match="data">
	<div id="content">
		<h2>Help</h2>
		<h5>Just some random notes about this project.</h5>

		<dl>
			<xsl:apply-templates select="all-help-notes/entry" />
		</dl>
	</div>
</xsl:template>

<xsl:template match="all-help-notes/entry">
	<dt id="note-{@id}">
		<a href="{$root}/help/#note-{@id}">#<xsl:value-of select="order" /></a> - 
		<xsl:value-of select="question" />
	</dt>
	<dd>
		<xsl:value-of select="answer" disable-output-escaping="yes" />
	</dd>
</xsl:template>

<xsl:template match="data" mode="head">Help</xsl:template>

</xsl:stylesheet>
