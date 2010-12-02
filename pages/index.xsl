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
			<xsl:call-template name="header">
				<xsl:with-param name="show-logo" select="false()" />
			</xsl:call-template>

			<div id="logo">
				<h1>
					<!-- <a href="{$root}/">Xpath of the Ninja</a> -->
					Xpath of the Ninja
				</h1>
				<p class="tagline">
					paste service for 
					<acronym title="eXtensible Stylesheet Language Transformations">XSLT</acronym> 
					code
				</p>
				<img src="{$workspace}/assets/images/ninja.png" alt="`Stupid Ninja` by AznJoker2" />
			</div>

			<div id="use-case">
				<ul>
					<li>
						<dl>
							<dt>
								<span class="for">for</span>
								<span class="aka">aka</span>
								<span class="term">genin</span>
								<span class="exp">noobs</span>
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
								<span class="for">for</span>
								<span class="aka">aka</span>
								<span class="term">chunin</span>
								<span class="exp">mortal developers</span>
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
								<span class="for">for</span>
								<span class="aka">aka</span>
								<span class="term">junin</span>
								<span class="exp">masters</span>
							</dt>
							<dd>
								After years of hard trainig, you're able to master
								very complex techniques. Paste smart snippets and share 
								the knowledge.
							</dd>
						</dl>
					</li>
				</ul>
			</div>

			<div id="paste-now">
				<form action="" method="post">				
					And now some pasting!
					<input type="submit" name="action[new-snippet]" value="Create" />
					a new snippet.
				</form>
			</div>

			<xsl:call-template name="footer" />
		</body>
	</html>
</xsl:template>

</xsl:stylesheet>
