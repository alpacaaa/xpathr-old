<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">



<xsl:import href="../utilities/master.xsl" />

<xsl:import href="../utilities/time-ago.xsl" />
<xsl:import href="../utilities/pagination.xsl" />

<xsl:variable name="show-fork-column" select="//entry[forked-from != '']" />
<xsl:template name="get-snippets">
	<xsl:param name="pagination-url" />

	<div id="content">
		<xsl:call-template name="title" mode="content" />

		<xsl:choose>
			<xsl:when test="error">
				<div class="message">No snippet found.</div>
			</xsl:when>
			<xsl:otherwise>
				<table>

					<thead>
						<tr>
							<th>Title</th>
							<th>Description</th>
							<th>Last Update</th>
							<xsl:if test="$show-fork-column">
								<th>Forked from</th>
							</xsl:if>
						</tr>
					</thead>
					<tbody>
						<xsl:for-each select="entry">
							<xsl:call-template name="snippet-row" />
						</xsl:for-each>
					</tbody>
				</table>

				<xsl:call-template name="pagination">
					<xsl:with-param name="pagination" select="pagination" />
					<xsl:with-param name="pagination-url"
						select="$pagination-url" />
				</xsl:call-template>
			
			</xsl:otherwise>
		</xsl:choose>
	</div>
</xsl:template>


<xsl:template name="snippet-row">
	<tr>
		<td>
			<a href="{$root}/snippets/all/{uniq-id}/">
				<xsl:value-of select="title" />
			</a>
		</td>
		<td class="description"><xsl:value-of select="description" /></td>
		<td class="date">
			<xsl:call-template name="time-ago">
				<xsl:with-param name="date-and-time"
					select="concat(last-update, 'T', last-update/@time, ':00')" />
			</xsl:call-template>
		</td>

		<xsl:if test="$show-fork-column">
			<td class="fork">
				<xsl:if test="forked-from">
						<a href="{$root}/snippets/{forked-from}/">
							<xsl:value-of select="forked-from" />
						</a>
				</xsl:if>
			</td>
		</xsl:if>
	</tr>
</xsl:template>
</xsl:stylesheet>
