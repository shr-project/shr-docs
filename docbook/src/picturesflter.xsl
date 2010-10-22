<?xml version='1.0'?>
<!--find all imagedata definitions and transform them in a fileset readable format-->
<xsl:stylesheet  
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"  version="1.0"
    xmlns:fo="http://www.w3.org/1999/XSL/Format">

    <xsl:output omit-xml-declaration="yes" method="text" indent="yes"/>
    <xsl:strip-space elements = "*" />
 
    <xsl:template match="text()">
    </xsl:template>
    
<!--DO NOT ADD any whitespaces in the template definition--> 
    <xsl:template match="imagedata" xml:space="preserve"><!--
--><xsl:value-of select="@fileref"/><xsl:apply-templates/>
</xsl:template>

</xsl:stylesheet> 
