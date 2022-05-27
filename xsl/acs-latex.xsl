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
    <!ENTITY % entities SYSTEM "../xsl/entities.ent">
    %entities;
]>

<!-- ACS customizations for producing the main book -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<!-- Assumes current file is in mathbook/user, so it must be copied there -->
<xsl:import href="../xsl/pretext-latex.xsl"
	    pretext-href="pretext-latex.xsl" />
<!-- Assumes next file can be found in mathbook/user, so it must be copied there -->
<xsl:import href="acs-common.xsl" />

<!-- Exercises have hint (sporadically), answer, and solution -->
<!-- Hint can be displayed where born, but otherwise suppress -->
<!-- These configurations live here because workbook and solutions manual need -->
<!-- different settings. -->
<xsl:param name="exercise.divisional.hint" select="'yes'" />
<xsl:param name="exercise.divisional.answer" select="'no'" />
<xsl:param name="exercise.divisional.solution" select="'no'" />

<!-- activity is a project-like, so we need to set those stringparams -->
<!-- to control hints, answers, and solutions -->
<xsl:param name="project.hint" select="'no'" />
<xsl:param name="project.answer" select="'no'" />
<xsl:param name="project.solution" select="'no'" />

<!-- LaTeX formatting commands we can inject here without incident -->
<!-- Different products have different page sizes, so this stays here -->
<xsl:param name="latex.geometry" select="'paperwidth=7.44in,paperheight=9.69in,tmargin=.5in,bmargin=.3in,hmargin=.75in,bindingoffset=.4in,includeheadfoot,marginparsep=6ex '" />

<xsl:param name="latex.preamble.late.main">
    <xsl:text>%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%&#xa;</xsl:text>
    <xsl:text>% Start sections on new page, just not the first one &#xa;</xsl:text>
    <xsl:text>%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%&#xa;</xsl:text>
    <xsl:text>\let\oldsection\section &#xa;</xsl:text>
    <xsl:text>\renewcommand\section{\znewpage\oldsection}&#xa;</xsl:text>
    <xsl:text>&#xa;</xsl:text>
    <xsl:text>\let\oldchapter\chapter &#xa;</xsl:text>
    <xsl:text>\renewcommand\chapter{\clearpage\gdef\znewpage{</xsl:text>
    <xsl:text>\global\let\znewpage\clearpage}\oldchapter}&#xa;</xsl:text>
    <xsl:text>&#xa;</xsl:text>
    <xsl:text>\global\let\znewpage\clearpage &#xa;</xsl:text>
</xsl:param>

<xsl:param name="latex.preamble.late">
    <xsl:value-of select="$latex.preamble.late.common" />
    <xsl:value-of select="$latex.preamble.late.main" />
</xsl:param>

<!-- Put a WeBWorK icon in the margin next to WeBWorK exercises -->
<xsl:template match="exercise/webwork-reps/static/statement">
    <xsl:text>\marginnote{\hspace*{-10ex}\tiny \includegraphics[width=0.25in]{external/images/webwork-logo.png}}</xsl:text>
    <xsl:apply-imports />
</xsl:template>

<!-- We don't want to start each section's answers on a new page in the backmatter -->
<!-- This applies only to the answers in the backmatter of the main book -->
<xsl:template match="backmatter">
    <xsl:text>\renewcommand\section{\oldsection}</xsl:text>
    <xsl:apply-imports />
</xsl:template>

<!-- This suppresses subsection headings in the backmatter answers -->
<!-- It had to be developed by clobbering part of the template from -->
<!-- upstream PreTeXt. If something goes wrong with backmatter answer -->
<!-- formatting, this is the most likely culprit. -->
<!-- This lives here rather than in acs-common.xsl because we want to see -->
<!-- where exercises start in the solutions manual. -->
<xsl:template match="subsection|exercises" mode="division-in-solutions">
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
