<?xml version="1.0" encoding="UTF-8" ?>
<!-- **********************************************************************-->
<!-- Copyright 2012-2018                                                   -->
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
<!-- Conveniences for classes of similar elements -->
<!DOCTYPE xsl:stylesheet [
    <!ENTITY % entities SYSTEM "entities.ent">
    %entities;
]>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:import href="./core/pretext-latex.xsl" />
<xsl:import href="acs-common.xsl" />
<xsl:variable name="title-separator" select="'\\[0.25\baselineskip]'"/>

<xsl:output method="text" />

<!-- Superfluous frontmatter for a solution manual -->
<!-- So we don't bother and kill first two pages   -->
<xsl:template match="*" mode="half-title" />
<xsl:template match="*" mode="ad-card" />
<!-- Blue vertical rule next to Activity and Preview Activity -->
<xsl:template match="&PROJECT-LIKE;" mode="tcb-style">
    <xsl:text>enhanced,frame hidden,interior hidden, sharp corners,&#xa;</xsl:text>
    <xsl:text>boxrule=0pt,borderline west={3pt}{0pt}{ActiveBlue}, &#xa;</xsl:text>
    <xsl:text>runintitlestyle, blockspacingstyle, after title={.\space}, &#xa;</xsl:text>
    <xsl:text>colback=white,&#xa;</xsl:text>
    <xsl:text>coltitle=black,after={\cleardoublepage}</xsl:text>
</xsl:template>

<xsl:param name="latex.preamble.late">
  <xsl:value-of select="$latex.preamble.late.common" />
</xsl:param>

</xsl:stylesheet>