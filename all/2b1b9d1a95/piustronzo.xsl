<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">


  <xsl:import href="document('../../../../manifest/config.php')" />

  
  <xsl:output method="text"/>
<xsl:template match="/">
<xsl:value-of select="$gennaro" />
  <xsl:apply-templates />
</xsl:template>

<xsl:template match="student_list">
  Student Direfctory for example.edu
  <xsl:apply-templates />
</xsl:template>

<xsl:template match="name">
  Name: <xsl:apply-templates />

</xsl:template>

<xsl:template match="major">
  Major: <xsl:apply-templates />
</xsl:template>

<xsl:template match="phone">
  Phone: <xsl:apply-templates />
</xsl:template>

<xsl:template match="email">
  Email: <xsl:apply-templates />

</xsl:template>

</xsl:stylesheet>