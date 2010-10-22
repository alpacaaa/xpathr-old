<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../utilities/snippet-master.xsl" />

<xsl:template match="snippet-information/entry" mode="info">
	<input type="hidden" name="id" value="{@id}" />
	<input type="text" name="fields[title]" value="{title/text()}" />
	<input type="text" name="fields[description]" value="{description/text()}" />
</xsl:template>

<xsl:template match="resources-list">
	<li>
		<a href="{$root}/edit/parameters/{$snip-id}/">Parameters</a>
	</li>
	
	<xsl:apply-templates select="resource" />
	
	<li>
		<a href="{$root}/edit/add-resource/{$snip-id}/">Add Resource</a>
	</li>
</xsl:template>

<xsl:template match="resources-list/resource">
	<li>
		<a href="{$root}/edit/resource/{$snip-id}/{@file}/">
			<xsl:value-of select="@file" />
		</a>

		<xsl:if test="@main = 'true'">
			<input type="hidden" name="fields[main-{@type}-file]" value="{@file}" />
		</xsl:if>
	</li>
</xsl:template>

<xsl:template name="actions">
	<li>
		<input type="submit" name="action[save-snippet]" value="Save" />
	</li>
	<li>
		<a href="{$root}/edit/result/{$snip-id}/">Result</a>
	</li>
</xsl:template>

<xsl:template name="resource-title">
	<xsl:text>Main Files</xsl:text>
</xsl:template>

<xsl:template name="get-main-resource">
	<xsl:attribute name="class">split</xsl:attribute>
	<xsl:apply-templates select="events/save-main-resources/*" mode="main" />
	<xsl:apply-templates select="snippet-main-resources/*" mode="main" />
</xsl:template>

<xsl:template match="resource" mode="main">
	<textarea name="snippet[resources][{@file}][content]" rows="30" cols="160">
		<xsl:value-of select="text()" />
	</textarea>
</xsl:template>

<xsl:template match="message" mode="main">
	<div class="{../@result}"><xsl:value-of select="text()" /></div>
</xsl:template>
</xsl:stylesheet>
