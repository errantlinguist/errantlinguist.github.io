<?xml version="1.0" encoding="utf-8"?>
<!--
	Licensed to the Apache Software Foundation (ASF) under one
	or more contributor license agreements.  See the NOTICE file
	distributed with this work for additional information
	regarding copyright ownership.  The ASF licenses this file
	to you under the Apache License, Version 2.0 (the
	"License"); you may not use this file except in compliance
	with the License.  You may obtain a copy of the License at

		http://www.apache.org/licenses/LICENSE-2.0

	Unless required by applicable law or agreed to in writing,
	software distributed under the License is distributed on an
	"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
	KIND, either express or implied.  See the License for the
	specific language governing permissions and limitations
	under the License.
-->
<!-- XSLT DTD not used because it is non-normative and cannot handle the necessary multiple namespaces
<!DOCTYPE xsl:stylesheet SYSTEM "http://www.w3.org/1999/11/xslt10.dtd"> -->
<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.w3.org/1999/xhtml"
	xmlns:csx="http://citeseerx.ist.psu.edu"
	xpath-default-namespace="http://citeseerx.ist.psu.edu">
	<!-- 
		AUTHOR: Todd Shore
		VERSION: 2013-06-24
		COPYRIGHT: Copyright 2013 Todd Shore. Licensed for distribution under the Apache License 2.0.
		WEBSITE: http://errantlinguist.com

		An XSLT stylesheet for representing XML files denoting CiteSeerX documents as (X)HTML for display by web browsers.
	-->

	<xsl:output method="xhtml" version="1.0" encoding="utf-8" indent="yes"/>

	<xsl:template match="csx:document">
		<html>
			<body>
				<xsl:apply-templates select="authors"/>.
				<xsl:apply-templates select="year"/>.
				<xsl:apply-templates select="title"/>.
				<xsl:call-template name="apply-if-not-whitespace">
					<xsl:with-param name="value" select="venue"/>
				</xsl:call-template>
				<xsl:call-template name="apply-if-not-whitespace">
					<xsl:with-param name="value" select="volume"/>
					<xsl:with-param name="suffix" select="'.'"/>
				</xsl:call-template>
				<xsl:call-template name="apply-if-not-whitespace">
					<xsl:with-param name="value" select="number"/>
				</xsl:call-template>				
				<xsl:call-template name="apply-if-not-whitespace">
					<xsl:with-param name="value" select="publisher"/>
				</xsl:call-template>
				<xsl:call-template name="apply-if-not-whitespace">
					<xsl:with-param name="value" select="pubAddress"/>
				</xsl:call-template>
				<xsl:call-template name="apply-if-not-whitespace">
					<xsl:with-param name="value" select="pages"/>
				</xsl:call-template>
			</body>
		</html>
	</xsl:template>
	
	<!-- Checks if a node's text value is empty or whitespace before outputting a prefix before it, then applying template(s) to the node selection itself, and then outputting the value of a given suffix afterwards -->
	<xsl:template name="apply-if-not-whitespace">
		<xsl:param name="value"/>
		<xsl:param name="prefix" select="''"/>
		<xsl:param name="suffix" select="'. '"/>
		<xsl:if test="normalize-space($value)">
			<xsl:value-of select="$prefix"/><xsl:apply-templates select="$value"/><xsl:value-of select="$suffix"/>
		</xsl:if>
	</xsl:template>

	<!-- This template also prevents the automatic addition of whitespace around each matched "author" template -->
	<xsl:template match="authors">
		<xsl:apply-templates select="author">
			<xsl:sort select="order" data-type="number" order="ascending"/>
			<xsl:sort select="name"/>
		</xsl:apply-templates>
	</xsl:template>
	
	<!-- <xsl:template match="volume">
		<xsl:value-of select="."/>
	</xsl:template>
	
	<xsl:template match="number">
		<xsl:value-of select="."/>
	</xsl:template> -->

	<xsl:template match="author">
		<xsl:choose>
			<!-- For the last author element in a set of elements with a size greater than 1, add " and " -->
			<xsl:when test="position()&gt;1 and position()=count(../author)"> and </xsl:when>
			<!-- For all author elements which follow the first author element, add a comma and a space (", ") -->
			<xsl:when test="position()&gt;1">, </xsl:when>			
		</xsl:choose>
		<xsl:value-of select="name"/>
	</xsl:template>
	
	<!-- For title elements, display them in double quotes -->
	<xsl:template match="title">&#x201C;<xsl:value-of select="."/>&#x201D;</xsl:template>

	<!-- For venue elements, emphasize them -->
	<xsl:template match="venue">
		<em>
			<xsl:value-of select="."/>
		</em>
	</xsl:template>

	<xsl:template match="pubAddress"><xsl:value-of select="."/></xsl:template>
</xsl:stylesheet>
