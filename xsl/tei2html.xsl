<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xpath-default-namespace="http://www.tei-c.org/ns/1.0">


<xsl:output 
		method="xhtml"
		encoding="UTF-8"/> 

<xsl:template match="/">
<html>
<body>
	<xsl:apply-templates/>
</body>
</html>
</xsl:template>


<xsl:template match="teiHeader">
</xsl:template>


<xsl:template match="text()">
	<xsl:value-of select="normalize-space(.)"/>
</xsl:template>


<xsl:template match="text">
	<xsl:apply-templates/>
</xsl:template>

<xsl:template match="p">
	<p>
		<xsl:apply-templates select="normalize-space(.)"/>
	</p>
</xsl:template>

<xsl:template match="head">
	<h2>
		<xsl:apply-templates/>
	</h2>
</xsl:template>

</xsl:stylesheet>

