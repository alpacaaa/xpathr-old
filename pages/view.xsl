<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../utilities/snippet-master.xsl" />

<xsl:param name="resource" />

<xsl:template match="snippet-information/entry" mode="info">
	<img src="{$workspace}/images/gravatar-140.png" alt="gravatar" />
	<h2><xsl:value-of select="title/text()" /></h2>
	<div class="description"><xsl:value-of select="description/text()" /></div>
</xsl:template>

<xsl:template match="resources-list">
	<xsl:apply-templates select="resource[@file != $resource]">
		<xsl:sort select="@main" order="descending" />
	</xsl:apply-templates>
</xsl:template>

<xsl:template match="resources-list/resource">
	<li>
		<a href="{$root}/view/resource/{$user}/{$snip-id}/{@file}/">
			<xsl:if test="@main = 'true'">
				<xsl:attribute name="class">main</xsl:attribute>
			</xsl:if>
			<xsl:value-of select="@file" />
		</a>
	</li>
</xsl:template>

<xsl:template name="actions">
	<li>
		<a>
			<xsl:attribute name="href">
				<xsl:call-template name="get-edit-link" />
			</xsl:attribute>
			<xsl:text>Edit</xsl:text>
		</a>
	</li>
	<li>
		<a href="{$root}/view/result/{$user}/{$snip-id}/" class="result">Result</a>
	</li>
</xsl:template>

<xsl:template name="resource-title">
	<h3>Main Files</h3>
</xsl:template>

<xsl:template name="get-main-resource">
	<xsl:attribute name="class">split</xsl:attribute>
	<xsl:apply-templates select="events/save-main-resources/*" mode="main" />
	<xsl:apply-templates select="snippet-main-resources/*" mode="main" />
</xsl:template>

<xsl:template match="resource" mode="main">
	<pre>
		<xsl:value-of select="text()" />
	</pre>
</xsl:template>

<xsl:template name="get-edit-link">
	<xsl:value-of select="concat($root, '/edit/', $snip-id, '/')" />
</xsl:template>
</xsl:stylesheet>
