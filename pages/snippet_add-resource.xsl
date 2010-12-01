<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../utilities/master.xsl" />

<xsl:template name="current-resource">
	<xsl:variable name="filename">
		<xsl:choose>
			<xsl:when test="events/add-resource/post-data">
				<xsl:value-of select="events/add-resource/post-data/@filename" />
			</xsl:when>
			<xsl:otherwise>filename.xml</xsl:otherwise>
		</xsl:choose>

	</xsl:variable>
	
	<fieldset>
		<legend>New Resource</legend>

		<label for="filename">filename</label>
		<input type="text" name="snippet[new-resource][filename]" value="{$filename}" id="filename" />

		<input type="checkbox" name="snippet[new-resource][main-resource]" id="snippet-main-resource">
			<xsl:if test="count(resources-list/resource[@main = 'true']) &lt; 2">
				<xsl:attribute name="checked">checked</xsl:attribute>
			</xsl:if>
		</input>
		<label for="snippet-main-resource">Main resource</label>

		<ul>
			<li><a href="{$root}/snippet/{$user}/{$snip-id}/">back</a></li>
			<li><input type="submit" name="action[save-snippet]" value="Save" /></li>
		</ul>
	</fieldset>
</xsl:template>

<xsl:template name="main">
	<textarea name="snippet[new-resource][content]" rows="30" cols="160" id="snippet-resource-content">
		<xsl:choose>
			<xsl:when test="/data/events/add-resource/post-data">
				<xsl:value-of select="/data/events/add-resource/post-data/text()" />
			</xsl:when>
			<xsl:otherwise>&lt;source&gt;Paste here :)&lt;/source&gt;</xsl:otherwise>
		</xsl:choose>
	</textarea>

</xsl:template>

<xsl:template name="head">
	<link id="bespin_base" href="{$workspace}/bespin" />
	<script src="{$workspace}/bespin/BespinEmbedded.js" type="text/javascript"></script>
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.4.4/jquery.min.js"></script>
	<script type="text/javascript" src="{$workspace}/assets/js/main.js"></script>
	<script type="text/javascript" src="{$root}/extensions/debugdevkit/assets/devkit.js"></script>
	<link rel="stylesheet" href="{$root}/extensions/debugdevkit/assets/devkit.css" />
</xsl:template>

<xsl:template match="data" mode="head">New Resource</xsl:template>
</xsl:stylesheet>
