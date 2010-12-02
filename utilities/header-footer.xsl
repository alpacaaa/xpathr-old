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
					<a href="{$root}/">Home</a>
				</li>
				<li>
					<a href="{$root}/my-snippets/"><span>my</span> Snippets</a>
				</li>
				<li>
					<a href="{$root}/snippets/">Snippets</a>
				</li>
				<!-- <li>
					<a href="users">Users</a>
				</li> -->
				<li class="help">
					<a href="{$root}/help/">Help</a>
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
			<li class="snippets">
				<h5><a href="{$root}/dev/snippets/">Snippets</a></h5>
				<ul>
					<xsl:apply-templates select="/data/footer-snippet-list/entry" />
				</ul>
			</li>
			<!-- <li>
				<h5>My snippets</h5>
				<ul>
					<xsl:apply-templates select="/data/footer-snippet-list/entry">
						<xsl:sort select="@id" />
					</xsl:apply-templates>
				</ul>
			</li> -->
			<li class="help">
				<h5><a href="{$root}/help/">Help</a></h5>
				<ul>
					<xsl:apply-templates select="/data/footer-help-notes/entry">
						<xsl:sort select="order"/>
					</xsl:apply-templates>
				</ul>
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


<xsl:template match="footer-snippet-list/entry">
	<li>
		<a href="{$root}/snippet/all/{uniq-id}/">
			<xsl:value-of select="title" />
		</a>
	</li>
</xsl:template>

<xsl:template match="footer-help-notes/entry">
	<li>
		<a href="{$root}/help/#note-{@id}">#<xsl:value-of select="order" /></a> - 
		<xsl:value-of select="question" />
	</li>
</xsl:template>
</xsl:stylesheet>
