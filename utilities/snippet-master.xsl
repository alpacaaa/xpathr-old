<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../utilities/master.xsl" />

<xsl:param name="resource" />

<xsl:template match="data">

<form action="" method="post" id="{$root-page}">
	<div id="header">

		<h1><a href="{$root}">Logo</a>
			<!-- <a href="#">draw it!</a> -->
		</h1>

		<div id="information">
			<div>
				<xsl:apply-templates select="snippet-information/entry" mode="info" />
			</div>
		</div>

		<div id="current-resource">
			<div>
				<xsl:call-template name="resource-title" />
			</div>
		</div>

		<div id="actions">
			<ul>	
				<xsl:call-template name="actions" />
			</ul>
		</div>

		<div id="resources">
			<span>resources</span>
			<ul>
				<xsl:apply-templates select="resources-list" />
			</ul>
		</div>


	</div>

	<xsl:apply-templates select="events/*[name() != 'save-snippet-information']/message" mode="main" />
	<div id="main">
		<xsl:call-template name="get-main-resource" />
	</div>
</form>


<div id="footer">
	<a href="{$root}/view/all/{$snip-id}/">Snippet permalink</a>
</div>
</xsl:template>

<xsl:template match="resources-list">
	<!-- [@file != $resource] -->
	<xsl:apply-templates select="resource">
		<xsl:sort select="@main" order="descending" />
	</xsl:apply-templates>
</xsl:template>


<xsl:template match="resources-list/resource">
	<li>
		<xsl:variable name="class">
			<xsl:if test="@main = 'true'">
				<xsl:text>main</xsl:text>
			</xsl:if>
			<xsl:if test="@file = $resource">
				<xsl:text> current</xsl:text>
			</xsl:if>
		</xsl:variable>

		<xsl:if test="$class != ''">
			<xsl:attribute name="class">
				<xsl:value-of select="$class" />
			</xsl:attribute>
		</xsl:if>

		<a>
			<xsl:attribute name="href">
				<xsl:call-template name="resource-link">
					<xsl:with-param name="node" select="." />
				</xsl:call-template>
			</xsl:attribute>

			<xsl:value-of select="@file" />
		</a>

		<xsl:if test="$root-page = 'edit' and @main = 'true'">
			<input type="hidden" name="fields[main-{@type}-file]" value="{@file}" />
		</xsl:if>
	</li>
</xsl:template>

<xsl:template name="actions"></xsl:template>
<xsl:template name="resource-title"></xsl:template>
<xsl:template name="get-main-resource"></xsl:template>

<xsl:template name="resource-link">
	<xsl:param name="node" />

	<xsl:value-of select="concat($root, '/', $root-page, '/resource/')" />
	<xsl:if test="$root-page = 'view'">
		<xsl:value-of select="concat($user, '/')" />
	</xsl:if>

	<xsl:value-of select="concat($snip-id, '/', $node/@file, '/')" />
</xsl:template>

<xsl:template match="message" mode="main">
	<div class="{../@result}"><xsl:value-of select="text()" /></div>
</xsl:template>

</xsl:stylesheet>
