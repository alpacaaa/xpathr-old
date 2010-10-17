<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../utilities/master.xsl" />

<xsl:template match="data">

<form action="" method="post">
	<div id="header">

		<div id="information">
			<xsl:apply-templates select="snippet-data/info/entry" mode="info" />
		</div>

		<div id="current-resource">
			<xsl:apply-templates select="snippet-data/current" mode="title" />
		</div>

		<ul id="resources">
			<xsl:apply-templates select="snippet-data/all" />
		</ul>

		<ul id="actions">
			<xsl:call-template name="actions" />
		</ul>
	</div>

	<div id="main">
		<xsl:apply-templates select="snippet-data/current" mode="main" />
		<xsl:apply-templates select="snippet-data/error" />
		<xsl:apply-templates select="events/save-snippet/error" />
	</div>
</form>
</xsl:template>

<xsl:template name="actions"></xsl:template>

<xsl:template match="snippet-data/current/result" mode="main">
	<pre id="result">
		<xsl:value-of select="text()" />
	</pre>
</xsl:template>
</xsl:stylesheet>
