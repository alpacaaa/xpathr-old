<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../utilities/snippet-master.xsl" />

<xsl:template match="snippet-data/info/entry" mode="info">
	<input type="text" name="snippet[title]" value="{title/text()}" />
	<input type="text" name="snippet[description]" value="{description/text()}" />
</xsl:template>

<xsl:template match="snippet-data/all">
	<li>
		<a href="{$root}/edit/all/{$snip-id}/parameters/">Parameters</a>
	</li>
	
	<xsl:apply-templates select="resource" />
	
	<li>
		<a href="{$root}/edit/all/{$snip-id}/add-resource/">Add Resource</a>
	</li>
</xsl:template>

<xsl:template match="snippet-data/all/resource">
	<li>
		<a href="{$root}/edit/all/{$snip-id}/{@file}/">
			<xsl:value-of select="@file" />
		</a>
	</li>
</xsl:template>

<xsl:template name="actions">
	<li>
		<input type="submit" name="action[save-snippet]" value="Save" />
	</li>
	<li>
		<a href="{$root}/edit/all/{$snip-id}/result/">Result</a>
	</li>
</xsl:template>

<xsl:template match="snippet-data/current" mode="title">
	<xsl:if test="not(error)">
		<xsl:choose>
			<xsl:when test="count(resource) &gt; 1">Main Files</xsl:when>
			<xsl:when test="result">Result</xsl:when>

			<xsl:otherwise>
				<xsl:variable name="file" select="resource/@file" />
				<input type="text" name="snippet[resources][{$file}][name]" value="{$file}" />

				<xsl:if test="$resource != 'add-resource'">
					<button type="submit" name="action[save-snippet]" value="main-resource">
						<xsl:text>Set as main resource</xsl:text>
					</button>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:if>
</xsl:template>

<xsl:template match="snippet-data/error">
	<xsl:value-of select="text()" />
</xsl:template>

<xsl:template match="snippet-data/current" mode="main">
	<xsl:if test="count(resource) &gt; 1">
		<xsl:attribute name="class">split</xsl:attribute>
	</xsl:if>
	<xsl:apply-templates select="resource" mode="main" />
</xsl:template>

<xsl:template match="snippet-data/current/resource" mode="main">
	<textarea name="snippet[resources][{@file}]" rows="30" cols="160">
		<xsl:value-of select="text()" />
	</textarea>
</xsl:template>

</xsl:stylesheet>
