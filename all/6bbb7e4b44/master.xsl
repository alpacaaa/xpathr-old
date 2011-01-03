<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  
  <xsl:import href="date-time.xsl" />

<xsl:output method="xml" indent="yes" />

  <xsl:template match="/">

    <xsl:call-template name="format-date">
  <xsl:with-param name="date"><xsl:value-of select="'2010-11-30'"/></xsl:with-param>
  <xsl:with-param name="format" select="'W, M D'" />
</xsl:call-template>

  </xsl:template>
</xsl:stylesheet>