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

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<!-- Next paths assume current file has been copied to mathbook/user -->
<xsl:import href="../xsl/pretext-solution-manual-latex.xsl" />
<xsl:import href="acs-common.xsl" />
<xsl:param name="toc.level" select="'3'" />

<xsl:output method="text" />

<xsl:param name="latex.print" select="'no'" />

<!-- These switches will control what we include -->
<xsl:param name="exercise.divisional.statement" select="'yes'" />
<xsl:param name="exercise.divisional.hint" select="'no'" />
<xsl:param name="exercise.divisional.answer" select="'no'" />
<xsl:param name="exercise.divisional.solution" select="'yes'" />

<xsl:param name="exercise.reading.statement" select="'no'" />
<xsl:param name="exercise.reading.hint" select="'no'" />
<xsl:param name="exercise.reading.answer" select="'no'" />
<xsl:param name="exercise.reading.solution" select="'no'" />

<!-- Preview activities and activities are project-like. -->
<xsl:param name="project.statement" select="'yes'" />
<xsl:param name="project.hint" select="'no'" />
<xsl:param name="project.answer" select="'no'" />
<xsl:param name="project.solution" select="'yes'" />

<!-- Superfluous frontmatter for a solution manual -->
<!-- So we don't bother and kill first two pages   -->
<xsl:template match="*" mode="half-title" />
<xsl:template match="*" mode="ad-card" />

<!-- Use letter paper and leave one-inch margins all around -->
<xsl:param name="latex.geometry" select="'letterpaper,tmargin=.5in,bmargin=.3in,hmargin=.75in,includeheadfoot '" />

<xsl:param name="latex.preamble.late">
    <xsl:value-of select="$latex.preamble.late.common" />
</xsl:param>

<!-- This suppresses subsection headings in the backmatter answers -->
<!-- It had to be developed by clobbering part of the template from -->
<!-- upstream PreTeXt. If something goes wrong with backmatter answer -->
<!-- formatting, this is the most likely culprit. -->
<!-- This lives here rather than in acs-common.xsl because we want to see -->
<!-- where exercises start in the solutions manual. -->
<xsl:template match="subsection" mode="division-in-solutions">
    <xsl:param name="scope" />
    <xsl:param name="b-has-heading"/>
    <xsl:param name="content" />
    <!-- Usually we create an automatic heading,  -->
    <!-- but not at the root division -->
    <xsl:if test="$b-has-heading">
        <xsl:variable name="font-size">
            <xsl:choose>
                <!-- backmatter placement gets appendix like chapter -->
                <xsl:when test="$scope/self::book">
                    <xsl:text>\Large</xsl:text>
                </xsl:when>
                <!-- backmatter placement gets appendix like section -->
                <xsl:when test="$scope/self::article">
                    <xsl:text>\large</xsl:text>
                </xsl:when>
                <!-- divisional placement is one level less -->
                <xsl:when test="$scope/self::chapter">
                    <xsl:text>\Large</xsl:text>
                </xsl:when>
                <xsl:when test="$scope/self::section">
                    <xsl:text>\large</xsl:text>
                </xsl:when>
                <xsl:when test="$scope/self::subsection">
                    <xsl:text>\normalsize</xsl:text>
                </xsl:when>
                <xsl:when test="$scope/self::subsubsection">
                    <xsl:text>\normalsize</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:message>PTX:BUG:     "solutions" division title does not have a font size</xsl:message>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <!-- Does the current division get a number at birth? -->
        <xsl:variable name="is-structured">
            <xsl:apply-templates select="parent::*" mode="is-structured-division"/>
        </xsl:variable>
        <xsl:variable name="b-is-structured" select="$is-structured = 'true'"/>
    </xsl:if>
    <xsl:copy-of select="$content" />
</xsl:template>


</xsl:stylesheet>

