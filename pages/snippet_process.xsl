<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../utilities/master.xsl" />

<xsl:template name="current-resource">
	<h3>Processed Result</h3>
</xsl:template>

<xsl:template name="main">
	<xsl:if test="snippet-result[@result = 'success']">
		<xsl:copy-of select="snippet-result/*" />
	</xsl:if>

	<xsl:if test="snippet-result[@result != 'success']">
		<div class="message error">
			Snippet can't be processed due to the following errors.
			<xsl:apply-templates select="snippet-result/*" />
		</div>
	</xsl:if>
</xsl:template>

<xsl:template match="processing-errors/general">
	<ul>
		<xsl:apply-templates mode="error"/>
	</ul>
</xsl:template>

<xsl:template match="processing-errors/stack | processing-errors/xml">
	<p>
		<a href="{$root}/snippets/{$user}/{$snip-id}/{@filename}/#line-{@line}">
			<xsl:value-of select="@filename" />
		</a>
	</p>
	<ul>
		<xsl:apply-templates mode="error"/>
	</ul>
</xsl:template>

<xsl:template match="message" mode="error">
	<li><xsl:value-of select="text()" /></li>
</xsl:template>


<xsl:template name="head">
	<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.4/jquery.min.js"></script>
	<script type="text/javascript" src="{$workspace}/assets/js/main.js"></script>
	<link rel="stylesheet" href="{$workspace}/assets/stylesheets/ninja.highlight.css" />
</xsl:template>

<xsl:template match="data" mode="head">
	Result of `<xsl:value-of select="snippet-information/entry/title" />`
</xsl:template>
</xsl:stylesheet>
