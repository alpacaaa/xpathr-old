<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../utilities/header-footer.xsl" />

<xsl:output method="xml"
	doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
	doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
	omit-xml-declaration="yes"
	encoding="UTF-8"
	indent="yes" />


<xsl:template match="/">
	<xsl:apply-templates select="data" />
</xsl:template>

<xsl:template match="data">
	<html>

		<head>
			<link rel="stylesheet" href="{$workspace}/assets/stylesheets/screen.css" type="text/css" />
			<link href="http://fonts.googleapis.com/css?family=Lobster:regular|Droid+Sans&amp;subset=latin" rel="stylesheet" type="text/css" />
			<title>Home – XPath of the Ninja</title>
		</head>
		<body id="index">
			<xsl:apply-templates select="." mode="header">
				<xsl:with-param name="show-logo" select="false()" />
			</xsl:apply-templates>

			<div id="logo">
				<h1>Xpath of the Ninja</h1>
				<p class="tagline">
					paste service for 
					<acronym title="eXtensible Stylesheet Language Transformations">XSLT</acronym> 
					code
				</p>
				<img src="{$workspace}/assets/images/ninja.png" alt="A funny ninja image. Based on `Stupid Ninja` by ~AznJoker2" />
			</div>

			<div id="use-case">
				<ul>
					<li>
						<dl>
							<dt>
								<span>for <span>genin</span></span>
								<span>aka <span>noobs</span></span>
							</dt>
							<dd>
								Can't get your head around a compile error?
								Paste your code and wait for someone to <!-- fork&amp;fix<sup>tm</sup>.-->
								fork and fix.
							</dd>
						</dl>
					</li>
					<li>
						<dl>
							<dt>
								<span>for <span>chunin</span></span>
								<span>aka <span>mortal developers</span></span>
							</dt>
							<dd>
								Paste your most interesting stuff so you 
								don't need to search your whole codebase everytime.
							</dd>
						</dl>
					</li>
					<li>
						<dl>
							<dt>
								<span>for <span>junin</span></span>
								<span>aka <span>masters</span></span>
							</dt>
							<dd>
								After years of hard training, you're able to master
								very complex techniques. Paste smart snippets and share 
								the knowledge.
							</dd>
						</dl>
					</li>
				</ul>
			</div>

			<div id="paste-now">
				<form action="" method="post">				
					<p>
						And now some pasting!
						<input type="submit" name="action[new-snippet]" value="Create" />
						a new snippet.
					</p>
				</form>
			</div>

			<xsl:apply-templates select="." mode="footer" />
		</body>
	</html>
</xsl:template>

</xsl:stylesheet>
