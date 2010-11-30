<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">



<xsl:import href="../utilities/master.xsl" />
<xsl:import href="../utilities/time-ago.xsl" />
<xsl:import href="../utilities/pagination.xsl" />

<xsl:template match="data">

	<div id="content">
		<h2>Latest snippets</h2>
		<table>
			<thead>
				<tr>
					<th>Title</th>
					<th>Description</th>
					<th>Last Update</th>
				</tr>
			</thead>
			<tbody>
				<xsl:apply-templates select="snippet-list-by-user/entry" />
			</tbody>
		</table>

		<xsl:call-template name="pagination">
			<xsl:with-param name="pagination" select="snippet-list-by-user/pagination" />
			<xsl:with-param name="pagination-url" select="concat($root, '/snippets/', $user, '?page=$')" />
		</xsl:call-template>
	</div>
</xsl:template>


<xsl:template match="snippet-list-by-user/entry">
	<tr>
		<td>
			<a href="{$root}/snippet/all/{uniq-id}/">
				<xsl:value-of select="title" />
			</a>
		</td>
		<td class="description"><xsl:value-of select="description" /></td>
		<td class="date">
			<xsl:call-template name="time-ago">
				<xsl:with-param name="date-and-time" select="concat(last-update, 'T', last-update/@time, ':00')" />
			</xsl:call-template>
		</td>
	</tr>
</xsl:template>
</xsl:stylesheet>
