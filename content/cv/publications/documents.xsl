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

		An XSLT stylesheet for representing a list of XML files denoting CiteSeerX documents as (X)HTML for display by web browsers.
	-->

	<xsl:output method="xhtml" version="1.0" encoding="utf-8" indent="yes"/>

	<!-- Include XSLT stylesheet for CiteSeerX documents -->
	<xsl:include href="http://errantlinguist.com/content/cv/publications/document.xsl"/>

	<xsl:template match="csx:documents">
		<html>
			<body>
				<table>
					<xsl:apply-templates select="csx:document"/>
				</table>			
			</body>
		</html>
	</xsl:template>

</xsl:stylesheet>
