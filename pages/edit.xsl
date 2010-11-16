<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../utilities/snippet-master.xsl" />

<xsl:template match="snippet-information/entry" mode="info">
	<!-- <img src="{$workspace}/images/gravatar-140.png" alt="gravatar" /> -->

	<input type="hidden" name="id" value="{@id}" />

	<label>title
		<input type="text" name="fields[title]" value="{title/text()}" />
	</label>

	<label>description
		<!-- <input type="text" name="fields[description]" value="{description/text()}" /> -->
		<textarea name="fields[description]" rows="2" cols="30">
			<xsl:value-of select="description/text()" />
		</textarea>
	</label>
</xsl:template>

<xsl:template match="resources-list">
	<xsl:apply-templates select="resource">
		<xsl:sort select="@main" order="descending" />
	</xsl:apply-templates>

	<li>
		<a href="{$root}/edit/add-resource/{$snip-id}/">Add Resource</a>
	</li>
</xsl:template>

<xsl:template name="actions">
	<li>
		<input type="submit" name="action[save-snippet]" value="Save" />
	</li>
	<li>
		<a href="{$root}/edit/result/{$snip-id}/" class="process">Process</a>
	</li>
</xsl:template>

<xsl:template name="resource-title">
	<h3>Main Files</h3>
	<ul>
		<xsl:apply-templates select="resources-list/resource[@main = 'true']" mode="list"/>
	</ul>
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

<xsl:template match="resource" mode="list">
	<li>
		<a href="{$root}/edit/resource/{$snip-id}/{@file}/">
			<xsl:value-of select="@file" />
		</a>
	</li>
</xsl:template>
</xsl:stylesheet>
