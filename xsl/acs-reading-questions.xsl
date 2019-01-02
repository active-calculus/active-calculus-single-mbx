<?xml version='1.0'?>

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
    <!ENTITY % entities SYSTEM "../xsl/entities.ent">
    %entities;
]>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

    <xsl:import href="../xsl/pretext-solution-manual-latex.xsl" />
    <!-- Assumes next file can be found in mathbook/user, so it must be copied there -->
    <xsl:import href="acs-common.xsl" />
    <xsl:param name="latex.sides" select="'one'" />
    <!-- Superfluous frontmatter for a digital ancillaries -->
    <!-- So we don't bother and kill first two pages   -->
    <xsl:template match="*" mode="half-title" />
    <xsl:template match="*" mode="ad-card" />

    
<!-- The 20 possible switches default to "yes" if not set,     -->
<!-- but we try to address only the the things that ACS actually has -->
<xsl:param name="exercise.divisional.statement" select="'no'" />
<xsl:param name="exercise.divisional.hint" select="'no'" />
<xsl:param name="exercise.divisional.answer" select="'no'" />
<xsl:param name="exercise.divisional.solution" select="'no'" />

<xsl:param name="exercise.reading.statement" select="'yes'" />
<xsl:param name="exercise.reading.hint" select="'no'" />
<xsl:param name="exercise.reading.answer" select="'no'" />
<xsl:param name="exercise.reading.solution" select="'no'" />

<xsl:param name="project.statement" select="'no'" />
<xsl:param name="project.hint" select="'no'" />
<xsl:param name="project.answer" select="'no'" />
<xsl:param name="project.solution" select="'no'" />


<!-- Set the headers and footers for the book -->
<xsl:template match="book" mode="titleps-headings">
    <xsl:text>{\sethead {}{}{\textsl{\sectiontitle}}&#xa;</xsl:text>
    <xsl:text>\setfoot{}{\thepage}{}}&#xa;</xsl:text>
</xsl:template>


<!-- Use page size that matches the main text PDf -->
<xsl:param name="latex.geometry" select="'letterpaper,tmargin=.5in,bmargin=.3in,hmargin=.75in,includeheadfoot,lmargin=1in'" />

<xsl:param name="latex.preamble.late">
    <xsl:value-of select="$latex.preamble.late.common" />
</xsl:param>


</xsl:stylesheet>
