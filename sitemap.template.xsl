<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
	xmlns:html="http://www.w3.org/TR/REC-html40"
	xmlns:image="http://www.google.com/schemas/sitemap-image/1.1"
	xmlns:sitemap="http://www.sitemaps.org/schemas/sitemap/0.9"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.w3.org/1999/xhtml">
	<xsl:output
		doctype-system="about:legacy-compat"
		encoding="UTF-8"
		indent="yes"
		method="xml" />
	<xsl:template match="sitemap:urlset">
		<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
			<head>
				<meta charset='utf-8' />
				<meta http-equiv="X-UA-Compatible" content="chrome=1" />
				<meta name="description" content="The life a roving computational linguist" />
				<meta name="keywords" content="linguistics, computational linguistics, natural language processing, linguist, language, professional, expatriate, expat" />
				<meta name="author" content="the errant linguist" />

				<link rel="stylesheet" type="text/css" media="screen" href="stylesheets/stylesheet.css">
				<link rel="shortcut icon" type="image/x-icon" href="http://errantlinguist.github.io/favicon.ico" />

				<title>errantlinguist &mdash; Site map</title>
			</head>

			<body>

				<!-- HEADER -->
				<div id="header_wrap" class="outer">
					<header class="inner">
						<a id="forkme_banner" href="https://github.com/errantlinguist">View on GitHub</a>

						<h1 id="project_title">errantlinguist</h1>
						<h2 id="project_tagline">The life a roving computational linguist</h2>
					</header>
				</div>

				<!-- MAIN CONTENT -->
				<div id="main_content_wrap" class="outer">
			<div class="intro">
			  <p>Generated By <a href="http://www.alecos.it/">www.alecos.it</a>. Windows, Linux, Unix, MacOS(X) and Amiga programs, scripts, translations, articles and more...</p>
			  <p>This sitemap contains <xsl:value-of select="count(sitemap:urlset/sitemap:url)"/> URLs.</p>
			</div>
			<table class="sitemap" cellpadding="3">
			  <thead>
			    <tr>
			      <th width="80%">URL</th>
			      <th width="10%">Priority</th>
			      <th width="10%">Change Frequency</th>
			    </tr>
			  </thead>
			  <tbody>
			    <xsl:variable name="lower" select="'abcdefghijklmnopqrstuvwxyz'"/>
			    <xsl:variable name="upper" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'"/>
			    <xsl:for-each select="sitemap:urlset/sitemap:url">
			      <tr>
				<td>
				  <xsl:variable name="itemURL">
				    <xsl:value-of select="sitemap:loc"/>
				  </xsl:variable>
				  <a href="{$itemURL}">
				    <xsl:value-of select="sitemap:loc"/>
				  </a>
				</td>
				<td>
				  <xsl:value-of select="concat(sitemap:priority*100,'%')"/>
				</td>
				<td>
				  <xsl:value-of select="concat(translate(substring(sitemap:changefreq, 1, 1),concat($lower, $upper),concat($upper, $lower)),substring(sitemap:changefreq, 2))"/>
				</td>
			      </tr>
			    </xsl:for-each>
			  </tbody>
			</table>
			</div>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
