<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="xml"
	doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
	doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
	omit-xml-declaration="yes"
	encoding="UTF-8"
	indent="yes" />

<xsl:template match="/">
	<html>	
		<head>

		<!--
			<link rel="stylesheet" type="text/css" href="http://yui.yahooapis.com/2.8.1/build/reset/reset-min.css" media="screen" />
			<link rel="stylesheet" type="text/css" href="{$workspace}/css/style.css" media="screen" /> -->
			

			<link href="{$workspace}/assets/stylesheets/screen.css" media="screen, projection" rel="stylesheet" type="text/css" />
			<link href="{$workspace}/assets/stylesheets/print.css" media="print" rel="stylesheet" type="text/css" />
			<link href="{$workspace}/assets/stylesheets/ie.css" media="screen, projection" rel="stylesheet" type="text/css" />

			<title>XPath of the Ninja</title>
		</head>
		<body>
			<xsl:apply-templates select="data" />
		</body>
	</html>
</xsl:template>
</xsl:stylesheet>