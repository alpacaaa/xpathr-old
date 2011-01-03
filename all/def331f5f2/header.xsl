<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template name="header">

	<xsl:param name="show-logo" select="true()" />
	
	<div id="header">
		<form action="" method="post">

			<xsl:if test="$show-logo = true()">
				<h1>
					<a href="{$root}/">
						Xpath <span>of the</span> Ninja
					</a>
				</h1>
				<p class="tagline">
					paste service for 
					<acronym title="eXtensible Stylesheet Language Transformations">XSLT</acronym> 
					code
				</p>
			</xsl:if>

			<ul id="nav">
				<li>
					<a href="{$root}">Home</a>
				</li>
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
</xsl:template>

<xsl:template name="footer">
	<div id="footer">
		<ul>
			<li>
				<h5>Snippets</h5>
				<ul>
					<xsl:apply-templates select="snippet-list/entry" />
				</ul>
			</li>
			<li>
				<h5>Your snippets</h5>
				<ul>
					<xsl:apply-templates select="snippet-list/entry">
						<xsl:sort select="@id" />
					</xsl:apply-templates>
				</ul>
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
					A project by <a href="http://github.com/alpacaaa/">Marco Sampellegrini</a>.<br />
					Built in <a href="http://symphony-cms.com/">Symphony CMS</a>.
				</p>
			</li>
		</ul>
	</div>


</xsl:template>


<xsl:template match="snippet-list/entry">
	<li>
		<a href="{$root}/snippet/all/{uniq-id}/">
			<xsl:value-of select="title" />
		</a>
	</li>
</xsl:template>
</xsl:stylesheet>