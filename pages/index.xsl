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
			<link rel="stylesheet" href="{$workspace}/assets/stylesheets/screen.css" type="text/css" />
			<link href="http://fonts.googleapis.com/css?family=Lobster:regular|Droid+Sans&amp;subset=latin" rel="stylesheet" type="text/css" />
			<title>XPath of the Ninja</title>
		</head>
		<body id="index">
			<div id="header">
				<form action="" method="post">
					<ul id="nav">
						<li>
							<a href="snippets">Snippets</a>
						</li>
						<li>
							<a href="users">Users</a>
						</li>
						<li class="help">
							<a href="help">Help</a>
						</li>
					</ul>

					<p class="create">
						<input type="submit" name="action[new-snippet]" value="Create new" />
					</p>
				</form>
			</div>

			<div id="logo">
				<h1>
					<!-- <a href="{$root}/">XPath of the Ninja</a> -->
					XPath of the Ninja
				</h1>
				<p class="tagline">
					paste service for 
					<acronym title="eXtensible Stylesheet Language Transformations">XSLT</acronym> 
					code
				</p>
				<img src="{$workspace}/assets/images/ninja.png" alt="'Stupid Ninja' by AznJoker2" />
			</div>

			<div id="use-case">
				<ul>
					<li>
						<dl>
							<dt>for <strong>genin</strong> (aka noobs)</dt>
							<dd>
								Can't get your head around a compile error?
								Paste your code and wait for someone to <!-- fork&amp;fix<sup>tm</sup>.-->
								fork and fix.
							</dd>
						</dl>
					</li>
					<li>
						<dl>
							<dt>for <strong>chunin</strong> (aka intermediate)</dt>
							<dd>
								Paste your most interesting stuff so you 
								don't need to search your whole codebase.
							</dd>
						</dl>
					</li>
					<li>
						<dl>
							<dt>for <strong>junin</strong> (aka masters)</dt>
							<dd>
								After years of hard trainig, you're able to master
								very complex techniques. Share the knowledge.
							</dd>
						</dl>
					</li>
				</ul>
			</div>

			<div id="paste-now">
				<p>				
					And now some pasting!
					<a href="sdf">Create</a> 
					a new snippet.
				</p>
			</div>

			<div id="footer">
				<ul>
					<li>
						<h5>Snippets</h5>
						<p>
							Semantic markup can benefit <a href="sadfasd">advanced</a> content management systems. 
								Bob Boiko (The Content Management Bible, p457.).
						</p>
					</li>
					<li>
						<h5>Users</h5>
						<p>
							Semantic <a href="sadfasd">markup</a> can benefit advanced content management systems. 
								Bob Boiko (The Content Management Bible, p457.).
						</p>
					</li>
					<li>
						<h5>Help</h5>
						<p>
							Semantic markup can benefit advanced content management systems. 
								Bob Boiko (The Content <a href="sadfasd">Management</a> Bible, p457.).
						</p>
					</li>
					<li>
						<h5>About</h5>
						<p>
							Semantic <a href="sadfasd">markup can benefit</a> advanced content management systems. 
								Bob Boiko (The Content Management Bible, p457.).
						</p>
					</li>
				</ul>
			</div>
		</body>
	</html>
</xsl:template>
</xsl:stylesheet>
