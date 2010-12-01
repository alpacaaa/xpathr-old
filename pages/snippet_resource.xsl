<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../utilities/master.xsl" />

<xsl:template name="current-resource">
	<xsl:apply-templates select="snippet-resource/resource" />
</xsl:template>

<xsl:template match="snippet-resource/resource">
	<xsl:if test="$owner = 'true' and $url-edit != 'snip-info'">
		<fieldset>
			<legend>Snippet Resource</legend>
			<label for="resource-filename">Filename</label>
			<input type="text" name="snippet[resources][{@file}][filename]" value="{@file}" id="resource-filename" />

			<input type="checkbox" name="snippet[resources][{@file}][main-resource]" id="snippet-main-resource">
				<xsl:if test="@main = 'true'">
					<xsl:attribute name="checked">checked</xsl:attribute>
				</xsl:if>
			</input>
			<label for="snippet-main-resource">Main resource</label>

			<ul>
				<!-- <li><a href="{$root}/snippet/resource/{$user}/{$snip-id}/{$resource}/">back</a></li> -->
				<li><input type="submit" name="action[delete-resource]" value="Delete" /></li>
				<li><input type="submit" name="action[save-snippet]" value="Save" /></li>
			</ul>
		</fieldset>
	</xsl:if>

	<xsl:if test="$url-edit = 'snip-info' or $owner != 'true'">
		<h3>
			<a href="{$root}/snippet/resource/{$user}/{$snip-id}/{$resource}/">
				<xsl:value-of select="@file" />
			</a>
		</h3>

		<xsl:if test="@main = 'true'">
			<span>(main)</span>
		</xsl:if>

		<xsl:if test="$owner = 'atrue'">
			<a href="{$root}/snippet/resource/{$user}/{$snip-id}/{$resource}/?edit=snip-resource">
				edit
			</a>
		</xsl:if>
	</xsl:if>
</xsl:template>

<xsl:template name="main">
	<!-- <xsl:if test="$url-edit = 'snip-resource'">
		<xsl:apply-templates select="snippet-resource/resource" mode="textarea" />
	</xsl:if>

	<xsl:if test="$url-edit != 'snip-resource'">
		<xsl:apply-templates select="snippet-resource/resource" mode="main" />
	</xsl:if> -->

	<xsl:if test="$owner = 'true' and $url-edit != 'snip-info'">
		<xsl:apply-templates select="snippet-resource/resource" mode="textarea" />
	</xsl:if>

	<xsl:if test="$owner != 'true' or $url-edit = 'snip-info'">
		<xsl:apply-templates select="snippet-resource/resource" mode="main" />
	</xsl:if>
</xsl:template>

<xsl:template match="snippet-resource/resource" mode="textarea">

	<label for="snippet-resource-content">Resource content</label>
	<textarea name="snippet[resources][{@file}][content]" rows="30" cols="180" id="snippet-resource-content">
		<xsl:value-of select="text()" />
	</textarea>
</xsl:template>

<xsl:template match="snippet-resource/resource" mode="main">

	<label for="snippet-resource-content">Resource content</label>
	<xsl:copy-of select="./*" />
</xsl:template>

<xsl:template name="head">
	<link id="bespin_base" href="{$workspace}/bespin" />
	<script src="{$workspace}/bespin/BespinEmbedded.js" type="text/javascript"></script>
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.4.4/jquery.min.js"></script>
	<script type="text/javascript" src="{$workspace}/assets/js/main.js"></script>
	<script type="text/javascript" src="{$root}/extensions/debugdevkit/assets/devkit.js"></script>
	<link rel="stylesheet" href="{$root}/extensions/debugdevkit/assets/devkit.css" />
</xsl:template>

<xsl:template match="data" mode="head">
	<xsl:value-of select="snippet-resource/resource/@file" /> from 
	`<xsl:value-of select="snippet-information/entry/title" />`
</xsl:template>
</xsl:stylesheet>
