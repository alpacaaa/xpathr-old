<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../utilities/master.xsl" />

<xsl:template match="data">

<form action="" method="post">
	<div id="header">

		<h1>Logo</h1>

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

	<div id="main">
		<xsl:call-template name="get-main-resource" />
	</div>
</form>
</xsl:template>

<xsl:template name="actions"></xsl:template>
<xsl:template name="resource-title"></xsl:template>
<xsl:template name="get-main-resource"></xsl:template>

</xsl:stylesheet>
