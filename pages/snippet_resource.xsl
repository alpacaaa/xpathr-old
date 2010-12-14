<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../utilities/master.xsl" />

<xsl:variable name="post-data" select="/data/events/save-resource/post-data" />

<xsl:template name="current-resource">
	<xsl:apply-templates select="snippet-resource/resource" />
</xsl:template>

<xsl:template match="snippet-resource/resource">
	<xsl:if test="$owner = 'true' and $url-edit != 'snip-info'">

		<xsl:variable name="file">
			<xsl:if test="$post-data">

				<xsl:variable name="same" select="/data/resources-list/resource[@file = $post-data/@filename]" />

				<xsl:if test="$same = true()">
					<xsl:value-of select="@file" />
				</xsl:if>
				<xsl:if test="$same = false()">
					<xsl:value-of select="$post-data/@filename" />
				</xsl:if>
			</xsl:if>
			<xsl:if test="not($post-data) or $post-data/@filename = ''">
				<xsl:value-of select="@file" />
			</xsl:if>
		</xsl:variable>


		<fieldset>
			<legend>Snippet Resource</legend>
			<label for="resource-filename">Filename</label>
			<input type="text" name="snippet[resources][{@file}][filename]" value="{$file}" id="resource-filename" />

			<input type="checkbox" name="snippet[resources][{@file}][main-resource]" id="snippet-main-resource">
				<xsl:if test="@main = 'true'">
					<xsl:attribute name="checked">checked</xsl:attribute>
				</xsl:if>
			</input>
			<label for="snippet-main-resource">Main resource</label>

			<ul>
				<li><input type="submit" name="action[save-snippet]" value="Save" /></li>
				<li><input type="submit" name="action[delete-resource]" value="Delete" id="resource-delete" /></li>
			</ul>
		</fieldset>
	</xsl:if>

	<xsl:if test="$url-edit = 'snip-info' or $owner != 'true'">
		<h3>
			<a href="{$root}/snippets/{$user}/{$snip-id}/{$resource}/">
				<xsl:value-of select="@file" />
			</a>
		</h3>

		<xsl:if test="@main = 'true'">
			<span>(main)</span>
		</xsl:if>

		<xsl:if test="$owner = 'atrue'">
			<a href="{$root}/snippets/{$user}/{$snip-id}/{$resource}/?edit=snip-resource">
				edit
			</a>
		</xsl:if>
	</xsl:if>
</xsl:template>

<xsl:template name="main">

	<xsl:if test="$owner = 'true' and $url-edit != 'snip-info'">
		<xsl:if test="$post-data">
			<xsl:apply-templates select="$post-data" mode="textarea" />
		</xsl:if>

		<xsl:if test="not($post-data)">
			<xsl:apply-templates select="snippet-resource/resource" mode="textarea" />
		</xsl:if>
	</xsl:if>

	<xsl:if test="$owner != 'true' or $url-edit = 'snip-info'">
		<xsl:apply-templates select="snippet-resource/resource" mode="main" />
	</xsl:if>
</xsl:template>

<xsl:template match="snippet-resource/resource | save-resource/post-data" mode="textarea">

	<label for="snippet-resource-content">Resource content</label>
	<textarea name="snippet[resources][{@file}][content]" rows="30" cols="180" id="snippet-resource-content">
		<xsl:value-of select="text()" />
	</textarea>
</xsl:template>

<xsl:template name="head">
	<script src="{$workspace}/codemirror/js/codemirror.js" type="text/javascript"></script>
	<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.4/jquery.min.js"></script>
	<script type="text/javascript" src="{$workspace}/assets/js/main.js"></script>
	<link rel="stylesheet" href="{$workspace}/assets/stylesheets/ninja.highlight.css" />
</xsl:template>

<xsl:template match="data" mode="head">
	<xsl:value-of select="snippet-resource/resource/@file" /> from 
	`<xsl:value-of select="snippet-information/entry/title" />`
</xsl:template>

</xsl:stylesheet>
