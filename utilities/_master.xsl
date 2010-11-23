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
			<link rel="stylesheet" href="{$workspace}/assets/stylesheets/screen.css" type="text/css" />
			<link href="http://fonts.googleapis.com/css?family=Lobster:regular&amp;subset=latin" rel="stylesheet" type="text/css" />
			<title>XPath of the Ninja</title>
		</head>
		<body>
			<div id="header">
				<form action="" method="post">
					<h1>
						<a href="{$root}/">
							Xpath <span>of the</span> Ninja
						</a>
					</h1>
					<p class="tagline">
						paste service for 
						<acronym title="eXtensible Stylesheet Language Transformations">XSLT</acronym> 
						code
					</p>

					<p class="create">
						<input type="submit" name="action[new-snippet]" value="Create new" />
					</p>
					
				</form>
			</div>

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

	<xsl:apply-templates select="events/*/message" />

	<div id="main">
		<xsl:call-template name="main" />
	</div>
</xsl:template>


<xsl:template match="snippet-information/entry">

	<input type="hidden" name="id" value="{@id}" />

	<xsl:if test="$owner = 'true' and $url-edit = 'snip-info'">
		<fieldset>
			<legend>Snippet Information</legend>
			<label for="snip-title">Title</label>
			<input type="text" name="fields[title]" value="{title}" id="snip-title" />

			<label for="snip-description">Description</label>
			<textarea name="fields[description]" id="snip-description" rows="3" cols="40">
				<xsl:value-of select="description" />
			</textarea>

			<ul>
				<li><a href="{substring-before($current-url, '?edit=')}">back</a></li>
				<li><input type="submit" name="action[save-snippet]" value="Save" /></li>
			</ul>
		</fieldset>
	</xsl:if>

	<xsl:if test="$url-edit != 'snip-info'">
		<h2>
			<!-- <a href="{$root}/snippet/{$user}/{$snip-id}/"> -->
				<xsl:value-of select="title" />
			<!-- </a> -->
		</h2>

		<xsl:if test="$owner = 'true'">
			<a href="{substring-before($current-url, '?edit=')}?edit=snip-info">
				edit
			</a>
		</xsl:if>

		<xsl:if test="$owner != 'true'">
			<a href="{substring-before($current-url, '?edit=')}?edit=snip-info">
				fork
			</a>
		</xsl:if>

		<div class="description">
			<xsl:value-of select="description" />
		</div>

		<span class="author">
			by <a href="#">anonymous</a>
		</span>

		<a href="{$root}/snippet/process/{$user}/{$snip-id}/" class="process">
			Process
		</a>
	</xsl:if>
</xsl:template>


<xsl:template name="current-resource">
	<h3>Main Resources</h3>
</xsl:template>

<xsl:template match="resources-list">
	<xsl:variable name="link">
		<xsl:if test="$owner = 'true'">
			<a href="{$root}/snippet/add-resource/{$user}/{$snip-id}/" class="new">
				new file
			</a>
		</xsl:if>
	</xsl:variable>

	<xsl:choose>
		<xsl:when test="count(resource) &gt; 0">

			<p>Files</p>
			<ul>
				<xsl:apply-templates select="resource">
					<xsl:sort select="@main" order="descending" />
				</xsl:apply-templates>

				<li>
					<xsl:copy-of select="$link" />
				</li>
			</ul>

		</xsl:when>

		<xsl:otherwise>
			<p>Snippet has no file.</p>
			<xsl:copy-of select="$link" />
		</xsl:otherwise>

	</xsl:choose>
	
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

<xsl:template match="message">
	<xsl:call-template name="show-message" />
</xsl:template>

<xsl:template match="save-snippet-information/message">
	<xsl:if test="$url-edit = 'snip-info'">
		<xsl:call-template name="show-message" />
	</xsl:if>
</xsl:template>

<xsl:template name="show-message">
	<div class="message {../@result}">
		<xsl:value-of select="text()" />
	</div>
</xsl:template>


<xsl:template name="main">
	<xsl:attribute name="class">split</xsl:attribute>
	<xsl:apply-templates select="snippet-main-resources/resource" />
</xsl:template>

<xsl:template match="snippet-main-resources/resource">
	<div>
		<a href="{$root}/snippet/resource/{$user}/{$snip-id}/{@file}/">
			<xsl:value-of select="@file" />
		</a>
		<xsl:apply-templates select="." mode="main" />
	</div>
</xsl:template>

<xsl:template match="resource" mode="main">
	<pre>
		<code>
			<xsl:value-of select="text()" />
		</code>
	</pre>
</xsl:template>
</xsl:stylesheet>