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
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
>

<xsl:output method="xml" encoding="UTF-8" indent="yes"/>
<xsl:strip-space elements="*"/>

<!-- Copy everything -->
<xsl:template match="@*|node()">
 <xsl:copy>
  <xsl:apply-templates select="@*|node()"/>
 </xsl:copy>
</xsl:template>

<!-- Target specific things -->

<!-- Upgrade exploration to have a statement -->
<xsl:template match="exploration[not(statement)]">
  <exploration>
    <xsl:attribute name="xml:id"><xsl:value-of select="@xml:id" /></xsl:attribute>
    <statement>
        <xsl:apply-templates select="@*[not(local-name( )='id')]|node()"/>
    </statement>
  </exploration>    
</xsl:template>


<!-- Clobber the permids -->
<xsl:template match="@permid"></xsl:template>

</xsl:stylesheet>