<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../utilities/snippet-master.xsl" />

<xsl:param name="resource" />

<xsl:template match="snippet-information/entry" mode="info">
	<!-- <img src="{$workspace}/images/gravatar-140.png" alt="gravatar" /> -->
	<h2><xsl:value-of select="title/text()" /></h2>
	<div class="description"><xsl:value-of select="description/text()" /></div>
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
		<a href="{$root}/view/result/{$user}/{$snip-id}/" class="process">Process</a>
	</li>
</xsl:template>

<xsl:template name="resource-title">
	<h3>Main Files</h3>
</xsl:template>

<xsl:template name="get-main-resource">
	<xsl:attribute name="class">split</xsl:attribute>
	<xsl:apply-templates select="events/save-main-resources/*" mode="main" />
	<xsl:apply-templates select="snippet-main-resources" mode="main" />
</xsl:template>

<xsl:template match="resource" mode="main">
	<pre>
		<code>
			<xsl:value-of select="text()" />
		</code>
	</pre>
</xsl:template>

<xsl:template match="snippet-main-resources" mode="main">
	<xsl:for-each select="resource">
		<div id="{@file}">
			<a href="{$root}/view/resource/{$user}/{$snip-id}/{@file}/">
				<xsl:value-of select="@file" />
			</a>
			<xsl:apply-templates select="." mode="main" />
		</div>
	</xsl:for-each>
</xsl:template>

<xsl:template name="get-edit-link">
	<xsl:value-of select="concat($root, '/edit/', $snip-id, '/')" />
</xsl:template>
</xsl:stylesheet>
