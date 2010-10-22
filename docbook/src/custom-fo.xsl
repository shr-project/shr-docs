<?xml version='1.0'?>
<!DOCTYPE xsl:stylesheet [
<!ENTITY headfootbgcolor "#C0C0C0">
<!ENTITY bodyindent "30mm">
<!ENTITY shrgreen "#A9C938">
<!ENTITY lowercase "'abcdefghijklmnopqrstuvwxyz'">
<!ENTITY uppercase "'ABCDEFGHIJKLMNOPQRSTUVWXYZ'">
<!ENTITY primary   'normalize-space(concat(primary/@sortas, primary[not(@sortas)]))'>
<!ENTITY secondary 'normalize-space(concat(secondary/@sortas, secondary[not(@sortas)]))'>
<!ENTITY tertiary  'normalize-space(concat(tertiary/@sortas, tertiary[not(@sortas)]))'>
<!ENTITY scope 'count(ancestor::node()|$scope) = count(ancestor::node())'>
<!ENTITY sep '" "'>
]>

<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
    xmlns:xlink='http://www.w3.org/1999/xlink'
    xmlns:fo="http://www.w3.org/1999/XSL/Format">

  <xsl:import href="http://docbook.sourceforge.net/release/xsl/current/fo/profile-docbook.xsl"/>
  <xsl:import href="titlepage.shr-manual.xsl"/>

  <xsl:param name="draft.mode" select="no" />
  <xsl:param name="paper.type" select="'A4'"/>
  <xsl:param name="section.autolabel" select="1"/>
  <xsl:param name="section.label.includes.component.label" select="1"/>
  <xsl:param name="section.autolabel.max.depth" select="3"/>
  <xsl:param name="toc.section.depth" select="3"/>
  <xsl:param name="autotoc.label.separator"> </xsl:param>
  <xsl:param name="insert.xref.page.number" select="'no'" />

  <!-- <xsl:param name="double.sided" select="1"/> -->
  <xsl:param name="use.extension" select="1"/>
  <xsl:param name="fop1.extensions" select="1"/>
  <xsl:param name="graphicsize.extension" select="1" />
  <xsl:param name="ignore.image.scaling" select="0" />
  
  <xsl:param name="page.margin.top">24mm</xsl:param>
  <xsl:param name="page.margin.bottom">24mm</xsl:param>
  <xsl:param name="page.margin.inner">22mm</xsl:param>
  <xsl:param name="page.margin.outer">22mm</xsl:param>

  <xsl:param name="formal.title.placement" select="'table after figure after'" />

  <xsl:param name="header.rule" select="1"/>
  <xsl:param name="footer.rule" select="1"/>

  <xsl:param name="admon.graphics" select="1"/>
  <xsl:param name="admon.textlabel" select="0"/>
  <xsl:param name="admon.graphics.extension">.png</xsl:param>
  <!--<xsl:param name="admon.graphics.path">images/</xsl:param>-->

  <xsl:attribute-set name="informaltable.properties" use-attribute-sets="informal.object.properties">
    <!--xsl:attribute name="keep-together.within-column">always</xsl:attribute-->
    <xsl:attribute name="keep-together">auto</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="formal.title.properties"
                     use-attribute-sets="normal.para.spacing">
    <xsl:attribute name="font-style">italic</xsl:attribute>
    <xsl:attribute name="font-size">8pt</xsl:attribute>
  </xsl:attribute-set>

  <!-- xsl:param name="appendix.autolabel" select="A"/ -->

  <xsl:param name="body.start.indent" select="'&bodyindent;'"/>
  <xsl:param name="toc.indent.width" select="'0'"/>

  <xsl:param name="body.font.size" select="10"/>
  <xsl:param name="body.font.family" select="'sans-serif'" />
  <xsl:param name="title.font.family" select="'sans-serif'" />
  <xsl:param name="dingbat.font.family" select="'sans-serif'" />

  <xsl:param name="glossterm.width" select="'3cm'" />
  <xsl:param name="glossterm.separation" select="'1cm'" />


  <xsl:attribute-set name="header.table.properties">
    <xsl:attribute name="background-color">&headfootbgcolor;</xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="footer.table.properties">
    <xsl:attribute name="background-color">&headfootbgcolor;</xsl:attribute>
  </xsl:attribute-set>

  <xsl:template name="head.sep.rule">
    <xsl:param name="pageclass"/>
    <xsl:param name="sequence"/>
    <xsl:param name="gentext-key"/>

    <xsl:if test="$header.rule != 0">
      <xsl:attribute name="border-top-width">2.0pt</xsl:attribute>
      <xsl:attribute name="border-top-style">solid</xsl:attribute>
      <xsl:attribute name="border-top-color">&headfootbgcolor;</xsl:attribute>
      <xsl:attribute name="border-bottom-width">4.0pt</xsl:attribute>
      <xsl:attribute name="border-bottom-style">solid</xsl:attribute>
      <xsl:attribute name="border-bottom-color">&shrgreen;</xsl:attribute>
      <xsl:attribute name="font-weight">bold</xsl:attribute>
      <xsl:attribute name="font-size">10</xsl:attribute>

    </xsl:if>
  </xsl:template>

  <xsl:template name="foot.sep.rule">
    <xsl:param name="pageclass"/>
    <xsl:param name="sequence"/>
    <xsl:param name="gentext-key"/>

    <xsl:if test="$footer.rule != 0">
      <xsl:attribute name="border-top-width">4.0pt</xsl:attribute>
      <xsl:attribute name="border-top-style">solid</xsl:attribute>
      <xsl:attribute name="border-top-color">&shrgreen;</xsl:attribute>
      <xsl:attribute name="font-size">10</xsl:attribute>
    </xsl:if>
  </xsl:template>

  <xsl:attribute-set name="component.title.properties">
    <xsl:attribute name="font-weight">normal</xsl:attribute>
    <xsl:attribute name="color">&shrgreen;</xsl:attribute>
    <xsl:attribute name="start-indent">0mm</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="section.title.properties">
    <xsl:attribute name="start-indent">0mm</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="section.title.level1.properties">
    <xsl:attribute name="start-indent">0mm</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="section.title.level2.properties">
    <xsl:attribute name="start-indent">0mm</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="section.title.level3.properties">
    <xsl:attribute name="start-indent">0mm</xsl:attribute>
    <xsl:attribute name="font-style">normal</xsl:attribute>
    <xsl:attribute name="color">&shrgreen;</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="section.title.level4.properties">
    <xsl:attribute name="start-indent">0mm</xsl:attribute>
    <xsl:attribute name="font-style">normal</xsl:attribute>
  </xsl:attribute-set>


  <xsl:template name="user.pagemasters">
      <fo:simple-page-master master-name="shr-titlepage-first"
                             page-width="{$page.width}"
                             page-height="{$page.height}"
                             margin-top="0cm"
                             margin-bottom="0cm"
                             margin-left="0.5cm"
                             margin-right="0.5cm">
        <fo:region-body margin-bottom="0.5cm"
                        margin-top="0.8cm"
                        column-gap="{$column.gap.titlepage}"
                        column-count="{$column.count.titlepage}">
        </fo:region-body>
     </fo:simple-page-master>

      <fo:simple-page-master master-name="shr-titlepage-odd"
                             page-width="{$page.width}"
                             page-height="{$page.height}"
                             margin-top="1.5cm"
                             margin-bottom="2.5cm"
                             margin-left="2.5cm"
                             margin-right="2.0cm">
        <fo:region-body margin-bottom="{$body.margin.bottom}"
                        margin-top="{$body.margin.top}"
                        column-gap="{$column.gap.titlepage}"
                        column-count="{$column.count.titlepage}">
        </fo:region-body>
      </fo:simple-page-master>

      <fo:page-sequence-master master-name="shr-titlepage">
        <fo:repeatable-page-master-alternatives>
          <fo:conditional-page-master-reference master-reference="blank"
                                                blank-or-not-blank="blank"/>
          <fo:conditional-page-master-reference master-reference="shr-titlepage-first"
                                                page-position="first"/>
          <fo:conditional-page-master-reference master-reference="shr-titlepage-odd"
                                                odd-or-even="odd"/>
          <fo:conditional-page-master-reference
                                                odd-or-even="even">
            <xsl:attribute name="master-reference">
              <xsl:choose>
                <xsl:when test="$double.sided != 0">titlepage-even</xsl:when>
                <xsl:otherwise>shr-titlepage-odd</xsl:otherwise>
              </xsl:choose>
            </xsl:attribute>
          </fo:conditional-page-master-reference>
        </fo:repeatable-page-master-alternatives>
     </fo:page-sequence-master>
  </xsl:template>

  <xsl:template name="select.user.pagemaster">
    <xsl:param name="element"/>
    <xsl:param name="pageclass"/>
    <xsl:param name="default-pagemaster"/>

    <!-- Return my customized title page master name if for titlepage,
         otherwise return the default -->

    <xsl:choose>
      <xsl:when test="$default-pagemaster = 'titlepage'">
        <xsl:value-of select="'shr-titlepage'" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$default-pagemaster"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:attribute-set name="superscript.properties">
    <xsl:attribute name="font-size">60%</xsl:attribute>
    <xsl:attribute name="font-family">sans-serif</xsl:attribute>
  </xsl:attribute-set>

  <xsl:template name="toc.line">
    <xsl:param name="toc-context" select="NOTANODE"/>

    <xsl:variable name="id">
      <xsl:call-template name="object.id"/>
    </xsl:variable>

    <xsl:variable name="label">
      <xsl:choose>
        <xsl:when test="self::appendix">
          <xsl:call-template name="gentext">
            <xsl:with-param name="key">appendix</xsl:with-param>
          </xsl:call-template>
          <xsl:text> </xsl:text>
          <xsl:apply-templates select="." mode="label.markup"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates select="." mode="label.markup"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <fo:block xsl:use-attribute-sets="toc.line.properties" >
      <fo:table table-layout="fixed" width="100%+&bodyindent;" start-indent="0mm">
        <fo:table-column column-width="&bodyindent;"/> <!-- numbers -->
        <fo:table-column column-width="proportional-column-width(1)"/> <!-- header text -->
        <fo:table-body>
          <fo:table-row>
            <fo:table-cell width="&bodyindent;" padding-end="4mm">

              <fo:block text-align="right" text-align-last="right">
                <fo:basic-link internal-destination="{$id}">
                  <xsl:if test="$label != ''">
                    <xsl:copy-of select="$label"/>
                    <xsl:value-of select="$autotoc.label.separator"/>
                  </xsl:if>
                </fo:basic-link>
              </fo:block>
            </fo:table-cell>
            <fo:table-cell>
              <fo:block>
                <xsl:apply-templates select="." mode="titleabbrev.markup"/>
                <fo:leader leader-pattern="dots"
                           leader-pattern-width="3pt"
                           leader-alignment="reference-area"
                           keep-with-next.within-line="always"/>
                <xsl:text> </xsl:text>
                <fo:basic-link internal-destination="{$id}">
                 
                  <fo:page-number-citation ref-id="{$id}"/>
                </fo:basic-link>
              </fo:block>
            </fo:table-cell>
          </fo:table-row>
        </fo:table-body>
      </fo:table>
    </fo:block>
  </xsl:template>

  <xsl:attribute-set name="toc.line.properties">
    <xsl:attribute name="space-before">
      <xsl:choose>
          <xsl:when test="self::chapter | self::preface | self::appendix | self::glossary">12pt</xsl:when>
          <xsl:otherwise>0pt</xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>
    <xsl:attribute name="font-size">
      <xsl:choose>
          <xsl:when test="self::chapter | self::preface | self::appendix | self::glossary">12pt</xsl:when>
          <xsl:otherwise>10pt</xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>
    <xsl:attribute name="font-weight">
      <xsl:choose>
          <xsl:when test="self::section | self::sect1 | self::chapter | self::preface | self::appendix | self::glossary">bold</xsl:when>
          <xsl:otherwise>normal</xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>
  </xsl:attribute-set>

  <!-- Expand this template to add properties to any cell's block -->
  <xsl:template name="table.cell.block.properties">
      <xsl:variable name="tabstyle">
          <xsl:call-template name="tabstyle"/>
    </xsl:variable>

    <xsl:choose>
        <xsl:when test="$tabstyle='messagebox'">
            <xsl:attribute name="font-size">10pt</xsl:attribute>
        </xsl:when>
        <xsl:when test="$tabstyle='twocolumnlayout'">
        </xsl:when>
        <xsl:otherwise>
            <xsl:attribute name="font-size">8pt</xsl:attribute>
        </xsl:otherwise>
    </xsl:choose>

    <!-- highlight this entry? -->
    <xsl:if test="ancestor::thead or ancestor::tfoot">
         <xsl:attribute name="font-weight">bold</xsl:attribute>
    </xsl:if>
  </xsl:template>


  <xsl:attribute-set name="xref.properties">
      <xsl:attribute name="color">
              green
          </xsl:attribute>
  </xsl:attribute-set>



  <xsl:template match="varlistentry/term">
        <fo:inline font-weight="bold" font-style="italic"><xsl:apply-templates/>:</fo:inline>
          <xsl:choose>
              <xsl:when test="not(following-sibling::term)"/>
              <!-- do nothing -->
              <xsl:otherwise>
                   <!-- * if we have multiple terms in the same varlistentry, generate -->
                  <!-- * a separator (", " by default) and/or an additional line -->
                  <!-- * break after each one except the last -->
                  <fo:inline font-weight="bold" font-style="italic"><xsl:value-of select="$variablelist.term.separator"/></fo:inline>
                  <xsl:if test="not($variablelist.term.break.after = '0')">
                      <fo:block/>
                  </xsl:if>
              </xsl:otherwise>
          </xsl:choose>
  </xsl:template>

  <xsl:template match="trademark">
    <xsl:call-template name="inline.charseq"/>
        <xsl:choose>
          <xsl:when test="@class = 'copyright'
                          or @class = 'registered'">
            <fo:inline xsl:use-attribute-sets="superscript.properties">
              <xsl:choose>
                    <xsl:when test="$fop.extensions != 0">
                      <xsl:attribute name="vertical-align">super</xsl:attribute>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:attribute name="baseline-shift">super</xsl:attribute>
                    </xsl:otherwise>
                  </xsl:choose>

                <xsl:call-template name="dingbat">
                  <xsl:with-param name="dingbat" select="@class"/>
                </xsl:call-template>
            </fo:inline>

          </xsl:when>
          <xsl:when test="@class = 'service'">
            <xsl:call-template name="inline.superscriptseq">
              <xsl:with-param name="content" select="'SM'"/>
            </xsl:call-template>
          </xsl:when>
          <xsl:otherwise>
            <fo:inline xsl:use-attribute-sets="superscript.properties">
              <xsl:choose>
                    <xsl:when test="$fop.extensions != 0">
                      <xsl:attribute name="vertical-align">super</xsl:attribute>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:attribute name="baseline-shift">super</xsl:attribute>
                    </xsl:otherwise>
                  </xsl:choose>

              <xsl:call-template name="dingbat">
                <xsl:with-param name="dingbat" select="'trademark'"/>
              </xsl:call-template>
            </fo:inline>
          </xsl:otherwise>
        </xsl:choose>
  </xsl:template>


  <!-- ###### title page templates ###### -->
  <xsl:template match="edition" mode="titlepage.mode">
    <xsl:apply-templates mode="titlepage.mode"/>
  </xsl:template>

  <xsl:template name="book.titlepage.separator">
  </xsl:template>

  <xsl:template match="copyright" mode="titlepage.mode">
    <!--
    <xsl:call-template name="gentext">
      <xsl:with-param name="key" select="'Copyright'"/>
    </xsl:call-template>
    <xsl:call-template name="gentext.space"/>
    -->
  <fo:inline xsl:use-attribute-sets="superscript.properties">
    <xsl:choose>
        <xsl:when test="$fop.extensions != 0">
          <xsl:attribute name="vertical-align">super</xsl:attribute>
        </xsl:when>
        <xsl:otherwise>
          <xsl:attribute name="baseline-shift">super</xsl:attribute>
        </xsl:otherwise>
      </xsl:choose>
        <xsl:call-template name="dingbat">
          <xsl:with-param name="dingbat">copyright</xsl:with-param>
        </xsl:call-template>
  </fo:inline>
    <xsl:call-template name="gentext.space"/>
    <xsl:call-template name="copyright.years">
      <xsl:with-param name="years" select="year"/>
      <xsl:with-param name="print.ranges" select="$make.year.ranges"/>
      <xsl:with-param name="single.year.ranges"
                      select="$make.single.year.ranges"/>
    </xsl:call-template>
  <!--
    <xsl:call-template name="gentext.space"/>
    <xsl:apply-templates select="holder" mode="titlepage.mode"/>
    -->
  </xsl:template>

  <!-- ######## running headers ######## -->
  <xsl:param name="header.column.widths">1 0 1</xsl:param>


  <xsl:template name="header.content">
    <xsl:param name="pageclass" select="''"/>
    <xsl:param name="sequence" select="''"/>
    <xsl:param name="position" select="''"/>
    <xsl:param name="gentext-key" select="''"/>

    <fo:block>

      <!-- sequence can be odd, even, first, blank -->
      <!-- position can be left, center, right -->
      <xsl:choose>

      <xsl:when test="$pageclass = 'shr-titlepage'">
        <!-- nothing -->
      </xsl:when>

        <xsl:when test="$sequence = 'blank'">
          <!-- nothing -->
        </xsl:when>

      <!-- xsl:when test="$position='left'" -->
      <xsl:when test="$position='right'">
        <xsl:if test="$pageclass != 'shr-titlepage'">
<!--             <xsl:if test="$pageclass != 'lot' and $pageclass != 'shr-titlepage'">-->
              <!-- Same for odd, even, empty, and blank sequences -->
              <!-- <xsl:call-template name="draft.text"/> -->
              <!-- <xsl:apply-templates select="." mode="titleabbrev.markup"/> -->
                <fo:retrieve-marker retrieve-class-name="section.head.marker"
                                  retrieve-position="first-including-carryover"
                                    retrieve-boundary="page-sequence"/>
<!--              </xsl:if> -->
          </xsl:if>
      </xsl:when>

        <xsl:when test="($sequence='odd' or $sequence='even') and $position='center'">
        <xsl:if test="$pageclass != 'shr-titlepage'">
            <xsl:choose>
              <xsl:when test="ancestor::book and ($double.sided != 0)">
                <fo:retrieve-marker retrieve-class-name="section.head.marker"
                                    retrieve-position="first-including-carryover"
                                    retrieve-boundary="page-sequence"/>
              </xsl:when>
              <xsl:otherwise>
                  <!-- <xsl:apply-templates select="." mode="titleabbrev.markup"/> -->
              </xsl:otherwise>
            </xsl:choose>
          </xsl:if>
        </xsl:when>

        <xsl:when test="$position='center'">
          <!-- nothing for empty and blank sequences -->
        </xsl:when>

      <!-- xsl:when test="$position='right'" -->
      <xsl:when test="$position='left' and $pageclass!='shr-titlepage'">
        <xsl:if test="$pageclass != 'shr-titlepage'">
            <!-- Same for odd, even, empty, and blank sequences -->
              <!-- <xsl:call-template name="draft.text"/> -->
              <xsl:value-of select="ancestor-or-self::book/bookinfo/productname"/>
          </xsl:if>
     </xsl:when>

        <xsl:when test="$sequence = 'first'">
          <!-- nothing for first pages -->
        </xsl:when>

        <xsl:when test="$sequence = 'blank'">
          <!-- nothing for blank pages -->
        </xsl:when>
      </xsl:choose>
    </fo:block>
  </xsl:template>

  <!-- ######## running footers ######## -->
  <xsl:param name="footer.column.widths">1 0 1</xsl:param>

    <xsl:template name="footer.content">
      <xsl:param name="pageclass" select="''"/>
      <xsl:param name="sequence" select="''"/>
      <xsl:param name="position" select="''"/>
      <xsl:param name="gentext-key" select="''"/>

      <fo:block>
        <!-- pageclass can be front, body, back -->
        <!-- sequence can be odd, even, first, blank -->
        <!-- position can be left, center, right -->
        <xsl:choose>
          <!-- place pagenumber on every footer expect titelpages -->
          <xsl:when test="$double.sided != 0 and $position='center' and $pageclass != 'titlepage'">
            <fo:page-number/>
          </xsl:when>

          <!-- place document id on every footer expect titelpages -->

          <xsl:when test="$double.sided != 0 and $position='left' and $sequence = 'even'">
             <xsl:value-of select="ancestor-or-self::book/bookinfo/biblioid"/>
          </xsl:when>

          <xsl:when test="$double.sided != 0 and $position='right' and ($sequence = 'odd' or $sequence = 'first')">
             <xsl:value-of select="ancestor-or-self::book/bookinfo/biblioid"/>
          </xsl:when>

          <xsl:when test="$double.sided = 0 and $pageclass != 'shr-titlepage' and $position='right' ">
            <fo:page-number/>
          </xsl:when>
          <xsl:when test="$double.sided = 0 and $position='left' and $pageclass!='shr-titlepage'">
             Software Manual <xsl:value-of select="ancestor-or-self::book/bookinfo/biblioid"/>
          </xsl:when>

          <xsl:when test="$sequence='blank'">
            <xsl:choose>
              <xsl:when test="$double.sided != 0 and $position = 'left'">
                <fo:page-number/>
              </xsl:when>
              <xsl:when test="$double.sided = 0 and $position = 'right'">
                <fo:page-number/>
              </xsl:when>
              <xsl:otherwise>
                <!-- nop -->
              </xsl:otherwise>
            </xsl:choose>
          </xsl:when>


          <xsl:otherwise>
            <!-- nop -->
          </xsl:otherwise>
        </xsl:choose>
      </fo:block>
    </xsl:template>

  <!-- ==================================================================== -->
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

<!-- ==================================================================== -->
<!--
    This template is used, to render the headlines within a table.
-->
<xsl:template name="my.create.titletable">
  <xsl:param name="title"/>
  <!--divide numbers and text-->
  <xsl:variable name="my.section.numbers" select="substring-before($title,'&#160;')"/>
  <xsl:variable name="my.section.titletext" select="substring-after($title,'&#160;')"/>

  <!-- create the table with 2 columns-->
  <fo:table table-layout="fixed" width="100%">
     <!--use the available space in body text for the first column, so the
         second column is vertical aligned with the body text -->
    <fo:table-column column-width="&bodyindent;"/> <!-- numbers -->
    <fo:table-column column-width="proportional-column-width(1)"/> <!-- header text -->
    <fo:table-body>
      <fo:table-row>
        <xsl:choose>
          <!-- no split chracter found, so we think there are no numbers (like bridged header) -->
          <xsl:when test="$my.section.numbers=''">
            <fo:table-cell padding-end="2mm">
              <fo:block text-align="right"></fo:block> <!-- make an empty cell -->
            </fo:table-cell>
            <fo:table-cell>
              <fo:block><xsl:copy-of select="$title"/></fo:block> <!-- put the complete title here -->
            </fo:table-cell>
          </xsl:when>
          <xsl:otherwise>
            <fo:table-cell padding-end="2mm">
              <fo:block text-align="right"><xsl:copy-of select="$my.section.numbers"/>&#160;</fo:block> <!-- numbers -->
            </fo:table-cell>
            <fo:table-cell>
              <fo:block><xsl:copy-of select="$my.section.titletext"/></fo:block> <!-- title text -->
            </fo:table-cell>
          </xsl:otherwise>
        </xsl:choose>
      </fo:table-row>
    </fo:table-body>
  </fo:table>
</xsl:template>

<!-- ==================================================================== -->

<!-- this template was copied from docbook-xsl-1.75.2/fo/component.xsl
   changes: call the template my.create.titletable instead of copying
            the $title text directly for the otherwise choose.
-->
<xsl:template name="component.title">
  <xsl:param name="node" select="."/>
  <xsl:param name="pagewide" select="0"/>

  <xsl:variable name="id">
    <xsl:call-template name="object.id">
      <xsl:with-param name="object" select="$node"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="title">
    <xsl:apply-templates select="$node" mode="object.title.markup">
      <xsl:with-param name="allow-anchors" select="1"/>
    </xsl:apply-templates>
  </xsl:variable>

  <xsl:variable name="titleabbrev">
    <xsl:apply-templates select="$node" mode="titleabbrev.markup"/>
  </xsl:variable>

  <xsl:variable name="level">
    <xsl:choose>
      <xsl:when test="ancestor::section">
        <xsl:value-of select="count(ancestor::section)+1"/>
      </xsl:when>
      <xsl:when test="ancestor::sect5">6</xsl:when>
      <xsl:when test="ancestor::sect4">5</xsl:when>
      <xsl:when test="ancestor::sect3">4</xsl:when>
      <xsl:when test="ancestor::sect2">3</xsl:when>
      <xsl:when test="ancestor::sect1">2</xsl:when>
      <xsl:otherwise>1</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:if test="$passivetex.extensions != 0">
    <fotex:bookmark xmlns:fotex="http://www.tug.org/fotex"
                    fotex-bookmark-level="2"
                    fotex-bookmark-label="{$id}">
      <xsl:value-of select="$titleabbrev"/>
    </fotex:bookmark>
  </xsl:if>

  <fo:block xsl:use-attribute-sets="component.title.properties">
    <xsl:if test="$pagewide != 0">
      <!-- Doesn't work to use 'all' here since not a child of fo:flow -->
      <xsl:attribute name="span">inherit</xsl:attribute>
    </xsl:if>
    <xsl:attribute name="hyphenation-character">
      <xsl:call-template name="gentext">
        <xsl:with-param name="key" select="'hyphenation-character'"/>
      </xsl:call-template>
    </xsl:attribute>
    <xsl:attribute name="hyphenation-push-character-count">
      <xsl:call-template name="gentext">
        <xsl:with-param name="key" select="'hyphenation-push-character-count'"/>
      </xsl:call-template>
    </xsl:attribute>
    <xsl:attribute name="hyphenation-remain-character-count">
      <xsl:call-template name="gentext">
        <xsl:with-param name="key" select="'hyphenation-remain-character-count'"/>
      </xsl:call-template>
    </xsl:attribute>
    <xsl:if test="$axf.extensions != 0">
      <xsl:attribute name="axf:outline-level">
        <xsl:value-of select="count($node/ancestor::*)"/>
      </xsl:attribute>
      <xsl:attribute name="axf:outline-expand">false</xsl:attribute>
      <xsl:attribute name="axf:outline-title">
        <xsl:value-of select="normalize-space($title)"/>
      </xsl:attribute>
    </xsl:if>

    <!-- Let's handle the case where a component (bibliography, for example)
         occurs inside a section; will we need parameters for this?
         Danger Will Robinson: using section.title.level*.properties here
         runs the risk that someone will set something other than
         font-size there... -->
    <xsl:choose>
      <xsl:when test="$level=2">
        <fo:block xsl:use-attribute-sets="section.title.level2.properties">
          <xsl:copy-of select="$title"/>
        </fo:block>
      </xsl:when>
      <xsl:when test="$level=3">
        <fo:block xsl:use-attribute-sets="section.title.level3.properties">
          <xsl:copy-of select="$title"/>
        </fo:block>
      </xsl:when>
      <xsl:when test="$level=4">
        <fo:block xsl:use-attribute-sets="section.title.level4.properties">
          <xsl:copy-of select="$title"/>
        </fo:block>
      </xsl:when>
      <xsl:when test="$level=5">
        <fo:block xsl:use-attribute-sets="section.title.level5.properties">
          <xsl:copy-of select="$title"/>
        </fo:block>
      </xsl:when>
      <xsl:when test="$level=6">
        <fo:block xsl:use-attribute-sets="section.title.level6.properties">
          <xsl:copy-of select="$title"/>
        </fo:block>
      </xsl:when>
      <xsl:otherwise>
        <fo:block>
            <!-- not in a section: do nothing special -->
            <xsl:call-template name="my.create.titletable">
              <xsl:with-param name="title" select="$title"/>
          </xsl:call-template>
        </fo:block>
      </xsl:otherwise>
    </xsl:choose>
  </fo:block>
</xsl:template>

<!-- ==================================================================== -->

<!-- this template was copied from docbook-xsl-1.75.2/fo/sections.xsl
     changes: call the template my.create.titletable instead of copying
              the $title text directly for all levels
-->
<xsl:template name="section.heading">
  <xsl:param name="level" select="1"/>
  <xsl:param name="marker" select="1"/>
  <xsl:param name="title"/>
  <xsl:param name="marker.title"/>

  <fo:block xsl:use-attribute-sets="section.title.properties">
    <xsl:if test="$marker != 0">
      <fo:marker marker-class-name="section.head.marker">
        <xsl:copy-of select="$marker.title"/>
      </fo:marker>
    </xsl:if>

    <xsl:choose>
      <xsl:when test="$level=1">
        <fo:block xsl:use-attribute-sets="section.title.level1.properties">
          <xsl:call-template name="my.create.titletable">
            <xsl:with-param name="title" select="$title"/>
          </xsl:call-template>
        </fo:block>
      </xsl:when>
      <xsl:when test="$level=2">
        <fo:block xsl:use-attribute-sets="section.title.level2.properties">
          <xsl:call-template name="my.create.titletable">
            <xsl:with-param name="title" select="$title"/>
          </xsl:call-template>
        </fo:block>
      </xsl:when>
      <xsl:when test="$level=3">
        <fo:block xsl:use-attribute-sets="section.title.level3.properties">
          <xsl:call-template name="my.create.titletable">
            <xsl:with-param name="title" select="$title"/>
          </xsl:call-template>
        </fo:block>
      </xsl:when>
      <xsl:when test="$level=4">
        <fo:block xsl:use-attribute-sets="section.title.level4.properties">
          <xsl:call-template name="my.create.titletable">
            <xsl:with-param name="title" select="$title"/>
          </xsl:call-template>
        </fo:block>
      </xsl:when>
      <xsl:when test="$level=5">
        <fo:block xsl:use-attribute-sets="section.title.level5.properties">
          <xsl:call-template name="my.create.titletable">
            <xsl:with-param name="title" select="$title"/>
          </xsl:call-template>
        </fo:block>
      </xsl:when>
      <xsl:otherwise>
        <fo:block xsl:use-attribute-sets="section.title.level6.properties">
          <xsl:call-template name="my.create.titletable">
            <xsl:with-param name="title" select="$title"/>
          </xsl:call-template>
        </fo:block>
      </xsl:otherwise>
    </xsl:choose>
  </fo:block>
</xsl:template>

<!-- ==================================================================== -->

    <xsl:template match="processing-instruction('hard-pagebreak')">
       <fo:block break-after='page'/>
    </xsl:template>

    <xsl:template match="processing-instruction('linebreak')">
      <fo:block/>
    </xsl:template>
    <xsl:template match="processing-instruction('keep-block-together')">
       <fo:block keep-together.within-column="always">
          <xsl:apply-imports/>
       </fo:block>
    </xsl:template>

  <xsl:template match="guibutton">
      <fo:inline background-color="#EEEEEE">
              <xsl:call-template name="inline.boldseq"/>
      </fo:inline>
  </xsl:template>

<xsl:attribute-set name="admonition.title.properties">
  <!--<xsl:attribute name="font-size">14pt</xsl:attribute>-->
  <xsl:attribute name="font-weight">bold</xsl:attribute>
  <xsl:attribute name="hyphenate">false</xsl:attribute>
  <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
</xsl:attribute-set>

<xsl:template name="graphical.admonition">
  <xsl:param name="node" select="."/>

  <xsl:variable name="id">
    <xsl:call-template name="object.id"/>
  </xsl:variable>
  <xsl:variable name="graphic.width">
     <xsl:apply-templates select="." mode="admon.graphic.width"/>
  </xsl:variable>
  <xsl:variable name="border.color">
    <xsl:choose>
      <xsl:when test="local-name($node)='note'">blue</xsl:when>
      <xsl:when test="local-name($node)='warning'">orange</xsl:when>
      <xsl:when test="local-name($node)='caution'">yellow</xsl:when>
      <xsl:when test="local-name($node)='tip'">green</xsl:when>
      <xsl:when test="local-name($node)='important'">red</xsl:when>
      <xsl:otherwise>note</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <fo:block border-top="2pt solid {$border.color}"
            border-bottom="2pt solid {$border.color}"
            padding-top="4pt"
            padding-bottom="4pt"
            id="{$id}"
            xsl:use-attribute-sets="graphical.admonition.properties">
    <xsl:choose>
      <xsl:when test="local-name($node)='tip'">
        <fo:list-block provisional-distance-between-starts="34pt"
                        provisional-label-separation="18pt"
                        margin-left="36pt">
          <fo:list-item>
              <fo:list-item-label>
                <fo:block>
                  <fo:external-graphic width="auto" height="auto" >
                    <xsl:attribute name="src">
                      <xsl:call-template name="admon.graphic"/>
                    </xsl:attribute>
                  </fo:external-graphic>
                </fo:block>
              </fo:list-item-label>
              <fo:list-item-body start-indent="body-start()">
                <xsl:if test="$admon.textlabel != 0 or title or info/title">
                  <fo:block xsl:use-attribute-sets="admonition.title.properties">
                    <xsl:apply-templates select="." mode="object.title.markup">
                      <xsl:with-param name="allow-anchors" select="1"/>
                    </xsl:apply-templates>
                  </fo:block>
                </xsl:if>
                <fo:block xsl:use-attribute-sets="admonition.properties">
                  <xsl:apply-templates/>
                </fo:block>
              </fo:list-item-body>
          </fo:list-item>
        </fo:list-block>
      </xsl:when>
      <xsl:otherwise>
        <fo:block margin-left="36pt">
          <fo:external-graphic width="auto" height="auto" >
            <xsl:attribute name="src">
              <xsl:call-template name="admon.graphic"/>
            </xsl:attribute>
          </fo:external-graphic>

          <fo:block margin-left="34pt">
            <xsl:if test="$admon.textlabel != 0 or title or info/title">
              <fo:block xsl:use-attribute-sets="admonition.title.properties">
                <xsl:apply-templates select="." mode="object.title.markup">
                  <xsl:with-param name="allow-anchors" select="1"/>
                </xsl:apply-templates>
              </fo:block>
            </xsl:if>
            <fo:block xsl:use-attribute-sets="admonition.properties">
              <xsl:apply-templates/>
            </fo:block>
          </fo:block>
        </fo:block>
      </xsl:otherwise>
    </xsl:choose>
  </fo:block>
</xsl:template>





<!-- xref --> 
<xsl:template match="xref" name="xref">
  <xsl:param name="xhref" select="@xlink:href"/>
  <!-- is the @xlink:href a local idref link? -->
  <xsl:param name="xlink.idref">
    <xsl:if test="starts-with($xhref,'#')
                  and (not(contains($xhref,'&#40;'))
                  or starts-with($xhref, '#xpointer&#40;id&#40;'))">
      <xsl:call-template name="xpointer.idref">
        <xsl:with-param name="xpointer" select="$xhref"/>
      </xsl:call-template>
   </xsl:if>
  </xsl:param>
  <xsl:param name="xlink.targets" select="key('id',$xlink.idref)"/>
  <xsl:param name="linkend.targets" select="key('id',@linkend)"/>
  <xsl:param name="target" select="($xlink.targets | $linkend.targets)[1]"/>
  <xsl:param name="refelem" select="local-name($target)"/>

  <xsl:variable name="xrefstyle">
    <xsl:choose>
      <xsl:when test="@role and not(@xrefstyle) 
                      and $use.role.as.xrefstyle != 0">
        <xsl:value-of select="@role"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="@xrefstyle"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="content">
    <fo:inline xsl:use-attribute-sets="xref.properties">
      <xsl:choose>
        <xsl:when test="@endterm">
          <xsl:variable name="etargets" select="key('id',@endterm)"/>
          <xsl:variable name="etarget" select="$etargets[1]"/>
          <xsl:choose>
            <xsl:when test="count($etarget) = 0">
              <xsl:message>
                <xsl:value-of select="count($etargets)"/>
                <xsl:text>Endterm points to nonexistent ID: </xsl:text>
                <xsl:value-of select="@endterm"/>
              </xsl:message>
              <xsl:text>???</xsl:text>
            </xsl:when>
            <xsl:otherwise>
<!--              <xsl:apply-templates select="$etarget" mode="endterm"/> -->
<!-- use @endterm to avoid usage of extra spaces before and after term -->
               <xsl:apply-templates select="@endterm" mode="endterm"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:when>
  
        <xsl:when test="$target/@xreflabel">
          <xsl:call-template name="xref.xreflabel">
            <xsl:with-param name="target" select="$target"/>
          </xsl:call-template>
        </xsl:when>
  
        <xsl:when test="$target">
          <xsl:if test="not(parent::citation)">
            <xsl:apply-templates select="$target" mode="xref-to-prefix"/>
          </xsl:if>
  
          <xsl:apply-templates select="$target" mode="xref-to">
            <xsl:with-param name="referrer" select="."/>
            <xsl:with-param name="xrefstyle" select="$xrefstyle"/>
          </xsl:apply-templates>
  
          <xsl:if test="not(parent::citation)">
            <xsl:apply-templates select="$target" mode="xref-to-suffix"/>
          </xsl:if>
        </xsl:when>
        <xsl:otherwise>
          <xsl:message>
            <xsl:text>ERROR: xref linking to </xsl:text>
            <xsl:value-of select="@linkend|@xlink:href"/>
            <xsl:text> has no generated link text.</xsl:text>
          </xsl:message>
          <xsl:text>???</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </fo:inline>
  </xsl:variable>

  <!-- Convert it into an active link -->
  <xsl:call-template name="simple.xlink">
    <xsl:with-param name="content" select="$content"/>
  </xsl:call-template>

  <!-- Add standard page reference? -->
  <xsl:choose>
    <xsl:when test="not($target)">
      <!-- page numbers only for local targets -->
    </xsl:when>
    <xsl:when test="starts-with(normalize-space($xrefstyle), 'select:') 
                  and contains($xrefstyle, 'nopage')">
      <!-- negative xrefstyle in instance turns it off -->
    </xsl:when>
    <!-- positive xrefstyle already handles it -->
    <xsl:when test="not(starts-with(normalize-space($xrefstyle), 'select:') 
                  and (contains($xrefstyle, 'page')
                       or contains($xrefstyle, 'Page')))
                  and ( $insert.xref.page.number = 'yes' 
                     or $insert.xref.page.number = '1')">
      <xsl:apply-templates select="$target" mode="page.citation">
        <xsl:with-param name="id" select="$target/@id|$target/@xml:id"/>
      </xsl:apply-templates>
    </xsl:when>
  </xsl:choose>
</xsl:template>

</xsl:stylesheet>
