<?xml version="1.0" encoding="UTF-8" ?>
<!-- **********************************************************************-->
<!-- Copyright 2012-2024                                                   -->
<!-- Matthew Boelkins                                                      -->
<!--                                                                       -->
<!-- This file is part of Active Calculus.                                 -->
<!--                                                                       -->
<!-- Permission is granted to copy, distribute and/or modify this document -->
<!-- under the terms of the Creative Commons BY-SA license.  The work      -->
<!-- may be used for free by any party so long as attribution is given to  -->
<!-- the author(s), the work and its derivatives are used in the spirit of -->
<!-- "share and share alike".  All trademarks are the registered marks of  -->
<!-- their respective owners.                                              -->
<!-- **********************************************************************-->

<xsl:stylesheet 
version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="xml" encoding="UTF-8" indent="yes"/>
<xsl:strip-space elements="*"/>

<!-- Copy everything -->
<xsl:template match="@*|node()">
 <xsl:copy>
  <xsl:apply-templates select="@*|node()"/>
 </xsl:copy>
</xsl:template>

<!-- Target specific things -->

<!-- Wrap activity and exploration (Preview Activity) in a worksheet. -->
<!-- Add label based on @xml:id so get sensible file names in HTML. -->
<xsl:template match="activity|exploration">
  <worksheet>
    <xsl:attribute name="label">ws-<xsl:value-of select="@xml:id" /> </xsl:attribute>
    <xsl:element name="{name(  )}">
      <xsl:apply-templates select="@*|node()"/>
    </xsl:element>
  </worksheet>
</xsl:template>

<!-- When we have a statement that contains a p containing an ol -->
<!-- we replace the statement iwth an introduction -->
<xsl:template match="statement[p/ol]">
  <introduction>
    <xsl:apply-templates select="@*|node()"/>
  </introduction>
  <xsl:apply-templates select="p/ol" mode="tasks"/>
</xsl:template>

<xsl:template match="statement/p/ol" mode="tasks">
  <xsl:call-template name="build-task">
    <xsl:with-param name="statement-ol" select="./li" />
    <xsl:with-param name="hint-ol" select="../../../hint/p/ol/li" />
    <xsl:with-param name="answer-ol" select="../../../answer/p/ol/li" />
    <xsl:with-param name="solution-ol" select="../../../solution/p/ol/li" />
    <xsl:with-param name="id" select="../../../@xml:id" />
    <xsl:with-param name="counter">0</xsl:with-param>
  </xsl:call-template>
</xsl:template>

<!-- These are all being consumed by the build-task named template -->
<xsl:template match="hint[p/ol]|answer[p/ol]|solution[p/ol]" />
<xsl:template match="statement/p/ol" />

<xsl:template name="build-task">
  <xsl:param name="statement-ol" />
  <xsl:param name="hint-ol" />
  <xsl:param name="answer-ol" />
  <xsl:param name="solution-ol" />
  <xsl:param name="id" />
  <xsl:param name="counter" />
  <xsl:choose>
    <xsl:when test="not($statement-ol)" />
    <xsl:otherwise>
      <task workspace="3cm">
        <xsl:attribute name="xml:id"><xsl:value-of select="$id" />-task-<xsl:value-of select="$counter" /></xsl:attribute>
        <statement>
          <xsl:apply-templates select="$statement-ol[1]/p"/>
        </statement>
        <hint>
          <xsl:apply-templates select="$hint-ol[1]/p"/>
        </hint>
        <answer>
          <xsl:apply-templates select="$answer-ol[1]/p"/>
        </answer>
        <solution>
          <xsl:apply-templates select="$solution-ol[1]/p"/>
        </solution>
      </task>
      <xsl:call-template name="build-task">
        <xsl:with-param name="statement-ol" select="$statement-ol[position() > 1]" />
        <xsl:with-param name="hint-ol" select="$hint-ol[position() > 1]" />
        <xsl:with-param name="answer-ol" select="$answer-ol[position() > 1]" />
        <xsl:with-param name="solution-ol" select="$solution-ol[position() > 1]" />
        <xsl:with-param name="id" select="$id" />
        <xsl:with-param name="counter" select="1+$counter"/>
      </xsl:call-template>
    </xsl:otherwise>
  </xsl:choose>  
</xsl:template>

<!-- Clobber the permids -->
<xsl:template match="@permid"></xsl:template>

</xsl:stylesheet>