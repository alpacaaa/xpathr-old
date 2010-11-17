<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/">

	<form action="?debug" method="post">
		<input type="submit" name="action[new-snippet]" value="new snippet" />
	</form>
	
	<ul>
		<xsl:apply-templates select="data/user-snippets/snippet" />
	</ul>
</xsl:template>

<xsl:template match="snippet">
	<li>
		<a href="{$root}/edit/{@uniq-id}/">
			<xsl:value-of select="@uniq-id" />
		</a>
	</li>
</xsl:template>
</xsl:stylesheet>
