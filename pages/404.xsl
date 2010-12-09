<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../utilities/master.xsl" />

<xsl:template match="data">
	<div id="content">
		<h2>404 - Not found</h2>
		<h5>Sorry</h5>

		<p>
			What you are looking for could not be found.
		</p>
	</div>
</xsl:template>


<xsl:template match="data" mode="head">Not Found</xsl:template>


</xsl:stylesheet>
