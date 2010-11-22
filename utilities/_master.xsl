<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="xml"
	doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
	doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
	omit-xml-declaration="yes"
	encoding="UTF-8"
	indent="yes" />

<xsl:param name="url-edit" />
<xsl:param name="resource" />


<xsl:template match="/">
	<html>	

		<head>
			<title>XPath of the Ninja</title>
		</head>
		<body>
			<form action="" method="post">
				<xsl:apply-templates select="data" />
			</form>
		</body>
	</html>
</xsl:template>


<xsl:template match="data">
	<div id="snip-info">
		<xsl:apply-templates select="snippet-information/entry" />
	</div>

	<div id="resource">
		<xsl:call-template name="current-resource" />
		<xsl:apply-templates select="resources-list" />
	</div>		
</xsl:template>


<xsl:template match="snippet-information/entry">

	<xsl:if test="$url-edit = 'snip-info'">
		<fieldset>
			<legend>Snippet Information</legend>
			<label for="snip-title">Title</label>
			<input type="text" name="fields[title]" value="{title}" id="snip-title" />

			<label for="snip-description">Description</label>
			<textarea name="fields[description]" id="snip-description" rows="3" cols="40">
				<xsl:value-of select="description" />
			</textarea>

			<input type="hidden" name="id" value="{@id}" />
			<input type="submit" name="action[save-snippet]" value="Save" />
			<a href="{$root}/snippet/{$user}/{$snip-id}/">cancel</a>
		</fieldset>
	</xsl:if>

	<xsl:if test="$url-edit != 'snip-info'">
		<h2>
			<a href="{$root}/snippet/{$user}/{$snip-id}/">
				<xsl:value-of select="title" />
			</a>
		</h2>
		<div class="description">
			<xsl:value-of select="description" />
		</div>

		<p class="author">
			by <a href="#">anonymous</a>
		</p>

		<a href="{$root}/snippet/process/{$user}/{$snip-id}/" class="process">Process</a>
	</xsl:if>
</xsl:template>


<xsl:template name="current-resource">
	<h3>Main Resources</h3>
</xsl:template>

<xsl:template match="resources-list">
	<xsl:choose>
		<xsl:when test="count(resource) &gt; 0">

			<span class="files">Files:</span>
			<ul>
				<xsl:apply-templates select="resource">
					<xsl:sort select="@main" order="descending" />
				</xsl:apply-templates>
			</ul>

		</xsl:when>

		<xsl:otherwise>
			<span class="files">Snippet has no file.</span>
		</xsl:otherwise>

	</xsl:choose>

	<a href="{$root}/snippet/add-resource/{$user}/{$snip-id}/" class="new">new</a>
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

		<a href="{$root}/snippet/resource/{$user}/{$snip-id}/{@file}/" >
			<xsl:value-of select="@file" />
		</a>

		<xsl:if test="@main = 'true'">
			<input type="hidden" name="fields[main-{@type}-file]" value="{@file}" />
		</xsl:if>
	</li>
</xsl:template>
</xsl:stylesheet>
