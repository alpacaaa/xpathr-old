<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">



<xsl:import href="../utilities/snippet-master.xsl" />
<xsl:import href="../utilities/truncate.xsl" />


<xsl:param name="resource" />
<xsl:param name="url-description" select="'less'" />
<xsl:param name="files-list-message" select="'Files'" />


<xsl:template match="data">

<form action="" method="post" id="{$root-page}">
	<div id="header">

		<h1><a href="{$root}">Logo</a></h1>

		<div id="information">
			
			<xsl:apply-templates select="snippet-information/entry" />
			<xsl:apply-templates select="resources-list" />
		</div>

		<div id="actions">
			<p>
				You can <a href="{$root}/view/result/{$user}/{$snip-id}/">process</a> or 
				<xsl:choose>
					<xsl:when test="user-snippets/snippet[@uniq-id = $snip-id]">
						<a href="{$root}/edit/{$snip-id}">edit</a>
					</xsl:when>
					<xsl:otherwise>
						<button type="submit" name="action[fork-snippet]"><span>fork</span></button>
					</xsl:otherwise>
				</xsl:choose>
				 this snippet.
			</p>
		</div>

	</div>

	<div id="main">
		<xsl:call-template name="get-main-resource" />
	</div>
</form>
</xsl:template>

<xsl:template match="snippet-information/entry">
	<p>
		This is 
		<a>
			<xsl:attribute name="href">
				<xsl:call-template name="get-view-link" />
			</xsl:attribute>
			<xsl:value-of select="title/text()" />
		</a>
		<xsl:if test="description/text() != ''">
			<xsl:if test="$url-description = 'less'">
				<xsl:text>, </xsl:text>
			</xsl:if>
			<xsl:if test="$url-description != 'less'">
				<br />
			</xsl:if>

			<q>
				<xsl:variable name="base">
					<xsl:choose>
						<xsl:when test="contains($current-url, '?description')">
							<xsl:value-of select="substring-before($current-url, '?description')" />
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="$current-url" />
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>

				<xsl:choose>
					<xsl:when test="$url-description = 'less'">
						<xsl:variable name="truncate">
							<xsl:call-template name="truncate">
								<xsl:with-param name="node" select="description" />
								<xsl:with-param name="limit" select="40" />
								<xsl:with-param name="suffix" select="''" />
							</xsl:call-template>
						</xsl:variable>

						<xsl:choose>
							<xsl:when test="string-length($truncate) = string-length(./description/text())">
								<xsl:value-of select="description/text()" />
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="$truncate" />&#x2026;
								 (<a href="{$base}?description=more">more</a>)
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>

					<xsl:otherwise>
						<xsl:value-of select="description/text()" />
						(<a href="{$base}?description=less">less</a>)
					</xsl:otherwise>
				</xsl:choose>
			</q>
		</xsl:if>
	</p>
</xsl:template>

<xsl:template match="resources-list">
	<xsl:value-of select="$files-list-message" />: 
	<ul>
		<xsl:apply-templates select="resource[@file != $resource]">
			<xsl:sort select="@main" order="descending" />
		</xsl:apply-templates>
	</ul>
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

<xsl:template name="get-view-link">
	<xsl:value-of select="concat($root, '/view/', $user, '/', $snip-id, '/')" />
</xsl:template>
</xsl:stylesheet>
