<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../utilities/master.xsl" />

<xsl:template name="head">
	<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.4/jquery.min.js"></script>
	<script type="text/javascript" src="{$workspace}/assets/js/main.js"></script>
	<link rel="stylesheet" href="{$workspace}/assets/stylesheets/ninja.highlight.css" />
</xsl:template>



<xsl:template name="main">
	<xsl:attribute name="class">split</xsl:attribute>
	<xsl:apply-templates select="snippet-main-resources/resource" />
</xsl:template>

<xsl:template match="snippet-main-resources/resource">
	<div>
		<a href="{$root}/snippets/{$user}/{$snip-id}/{@file}/">
			<xsl:value-of select="@file" />
		</a>
		<xsl:apply-templates select="." mode="main" />
	</div>
</xsl:template>

</xsl:stylesheet>
