<?xml version='1.0'?>

<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
    xmlns:fo="http://www.w3.org/1999/XSL/Format">

    <xsl:import href="http://docbook.sourceforge.net/release/xsl/current/html/profile-docbook.xsl"/>

    <xsl:param name="admon.graphics" select="1"/>
    <xsl:param name="admon.graphics.extension">.png</xsl:param>
    <xsl:param name="admon.graphic.width">100</xsl:param>

    <xsl:param name="section.autolabel" select="1"/>
    <xsl:param name="section.label.includes.component.label" select="1"/>
    <xsl:param name="generate.toc">
        appendix  toc,title
        article/appendix  nop
        article   toc,title,figure,table
        book      toc,title,figure,table,example,equation
        chapter   toc,title
        part      toc,title
        preface   toc,title
        qandadiv  toc
        qandaset  toc
        reference toc,title
        sect1     toc
        sect2     toc
        sect3     toc
        sect4     toc
        sect5     toc
        section   toc
        set       toc,title
    </xsl:param>

    <xsl:param name="html.stylesheet" select="'default.css'"/>

  <!-- Remove "Chapter" from the Chapter titles... -->
  <!-- Move section in xref number and title into brackets behind text-->  
  <xsl:param name="local.l10n.xml" select="document('')"/>
  <l:i18n xmlns:l="http://docbook.sourceforge.net/xmlns/l10n/1.0">
      <l:l10n language="en">
          <l:context name="title-numbered">
             <l:template name="chapter" text="%n.&#160;%t"/>
             <l:template name="section" text="%n&#160;%t"/>
          </l:context>
          <l:context name="xref-number-and-title"> 
             <l:template name="section" text="&#8220;%t&#8221; (Section %n)"/>
             <l:template name="bridgehead" text="&#8220;%t&#8221; (Section %n)"/>
          </l:context>
      </l:l10n>
  </l:i18n>

<xsl:template name="graphical.admonition">
  <xsl:variable name="admon.type">
    <xsl:choose>
      <xsl:when test="local-name(.)='note'">Note</xsl:when>
      <xsl:when test="local-name(.)='warning'">Warning</xsl:when>
      <xsl:when test="local-name(.)='caution'">Caution</xsl:when>
      <xsl:when test="local-name(.)='tip'">Tip</xsl:when>
      <xsl:when test="local-name(.)='important'">Important</xsl:when>
      <xsl:otherwise>Note</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="alt">
    <xsl:call-template name="gentext">
      <xsl:with-param name="key" select="$admon.type"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="border.color">
    <xsl:choose>
      <xsl:when test="local-name(.)='note'">blue</xsl:when>
      <xsl:when test="local-name(.)='warning'">orange</xsl:when>
      <xsl:when test="local-name(.)='caution'">yellow</xsl:when>
      <xsl:when test="local-name(.)='tip'">green</xsl:when>
      <xsl:when test="local-name(.)='important'">red</xsl:when>
      <xsl:otherwise>note</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <div>
    <xsl:apply-templates select="." mode="class.attribute"/>
    <xsl:if test="$admon.style != ''">
      <xsl:attribute name="style">
        <xsl:value-of select="$admon.style"/>
      </xsl:attribute>
    </xsl:if>

    <table border="3" 
           bordercolor="{$border.color}"
           rules="none"
           frame="hsides">
      <xsl:attribute name="summary">
        <xsl:value-of select="$admon.type"/>
        <xsl:if test="title|info/title">
          <xsl:text>: </xsl:text>
          <xsl:value-of select="(title|info/title)[1]"/>
        </xsl:if>
      </xsl:attribute>
      <tr>
        <td rowspan="2" align="center" valign="top">
          <xsl:attribute name="width">
            <xsl:apply-templates select="." mode="admon.graphic.width"/>
          </xsl:attribute>
          <img alt="[{$alt}]" width="100%">
            <xsl:attribute name="src">
              <xsl:call-template name="admon.graphic"/>
            </xsl:attribute>
          </img>
        </td>
        <th align="{$direction.align.start}">
          <xsl:call-template name="anchor"/>
          <xsl:if test="$admon.textlabel != 0 or title or info/title">
            <xsl:apply-templates select="." mode="object.title.markup"/>
          </xsl:if>
        </th>
      </tr>
      <tr>
        <td align="{$direction.align.start}" valign="top">
          <xsl:apply-templates/>
        </td>
      </tr>
    </table>
  </div>
</xsl:template>

<xsl:template match="tip" mode="admon.graphic.width">
  <xsl:text>50pt</xsl:text>
</xsl:template>

<xsl:template match="*" mode="admon.graphic.width">
  <xsl:text>100pt</xsl:text>
</xsl:template>

</xsl:stylesheet>
