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
<xsl:import href="../xsl/mathbook-latex.xsl" />
<!--<xsl:import href="acs-common.xsl" />-->
<xsl:param name="toc.level" select="'3'" />

<xsl:output method="text" />

<!-- These switches will control what we include -->
<xsl:param name="exercise.text.statement" select="'yes'" />
<xsl:param name="exercise.divisional.hint" select="'no'" />
<xsl:param name="exercise.divisional.answer" select="'no'" />
<xsl:param name="exercise.divisional.solution" select="'yes'" />


<!-- Preview activities and activities are project-like. -->
<xsl:param name="project.text.statement" select="'yes'" />
<xsl:param name="project.text.hint" select="'no'" />
<xsl:param name="project.text.answer" select="'no'" />
<xsl:param name="project.text.solution" select="'yes'" />

<!-- Superfluous frontmatter for a solution manual -->
<!-- So we don't bother and kill first two pages   -->
<xsl:template match="*" mode="half-title" />
<xsl:template match="*" mode="ad-card" />

<!-- Chapters: default presentation, we have them all, so numbers OK     -->
<!-- Sections and Equivalents: kill them, except for specific ones below -->
<!-- Killing introduction here kills preview activities from output -->
<xsl:template match="introduction|conclusion|references|objectives|appendix|index" />

<!-- Kill solutions to WeBWorK exercises -->
<xsl:template match="exercise[webwork]">
</xsl:template>

<!-- As a subset of full content, we can't            -->
<!-- trust LaTeX's auto-numbering to coincide         -->
<!-- with the sections of the full book               -->
<!-- Thus we need to redo the whole exercises section -->
<!-- With \section* we do not get ToC entries, but    -->
<!-- we could purposely add them if we wished         -->
<xsl:template match="exercises">

    <xsl:text>\section*{\arabic{chapter}.\arabic{section}</xsl:text>
    <xsl:apply-templates select="." mode="number" />
    <xsl:text>\quad </xsl:text>
    <xsl:apply-templates select="." mode="title-full" />
    <xsl:text>}&#xa;</xsl:text>
    <xsl:text>\addcontentsline{toc}{subsection}{Exercises}&#xa;</xsl:text>
    <xsl:apply-templates />
    <!-- Insert a page break so that each section's exercises start on a -->
    <!-- new page. This is mainly insurance for when a more compact version -->
    <!-- without a page break after each exercise's solution is being produced. -->
    <xsl:text>\clearpage&#xA;&#xA;</xsl:text>
</xsl:template>

<!-- As a subset of full content, we can't         -->
<!-- point to much of the content with hyperlinks  -->
<!-- We do have the full context as we process, so -->
<!-- we can get numbers for cross-references and   -->
<!-- hard code them into the LaTeX                 -->
<!-- This override obliterates autonaming support  -->
<xsl:template match="*" mode="ref-id">
    <xsl:apply-templates select="." mode="number" />
</xsl:template>

<!-- We do the expedient thing and *hard-code* the number    -->
<!-- of each item cross-referenced from within the solutions -->
<!-- manual, so the cropss-refernce text matches with HTML   -->
<!-- output and LaTeX output for the entire book.            -->
<!-- Since the output LaTeX file is a subset of the content, -->
<!-- there will not be a \label for many \ref, and worse, if -->
<!-- there is a \label then a \ref to it will be wrong.      -->
<xsl:template match="*" mode="xref-number">
  <xsl:apply-templates select="." mode="number" />
</xsl:template>

<!-- As a subset of the full content, the auto-numbering of          -->
<!-- a figure or table included in the solution manual will          -->
<!-- be incorrect, so we have to supply the MBX number               -->
<!-- NB: this may not work for figures or tables within a sidebyside -->
<xsl:template match="table/caption|figure/caption">
    <xsl:choose>
      <xsl:when test="ancestor::sidebyside and ancestor::table and not(ancestor::sidebyside/caption)">
            <xsl:text>\captionof*{table}{\textbf{</xsl:text>
      </xsl:when>
      <xsl:when test="ancestor::sidebyside and ancestor::figure and not(ancestor::sidebyside/caption)">
            <xsl:text>\captionof*{figure}{\textbf{</xsl:text>
      </xsl:when>
      <xsl:otherwise>
          <xsl:text>\caption*{\textbf{</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:apply-templates select=".." mode="type-name" />
    <xsl:text> </xsl:text>
    <xsl:apply-templates select=".." mode="number" />
    <xsl:if test="not(. = '')">
        <xsl:text>: </xsl:text>
    </xsl:if>
    <xsl:text>}</xsl:text>
    <xsl:apply-templates />
    <xsl:text>}&#xa;</xsl:text>
</xsl:template>

<!-- If we do not include statements, then we kill -->
<!-- introductions and conclusions for exercise    -->
<!-- sections and exercise groups                  -->
<xsl:template match="exercises/introduction|exercises/conclusion|exercisegroup/introduction|exercisegroup/conclusion">
    <xsl:choose>
        <xsl:when test="$exercise.text.statement='yes'">
            <xsl:apply-imports />
        </xsl:when>
        <xsl:otherwise></xsl:otherwise>
    </xsl:choose>
</xsl:template>

<!-- Let's attempt to start a new page after each activity and PA -->
<xsl:template match="activity|exploration">
    <xsl:apply-imports />
    <xsl:text>\clearpage&#xA;&#xA;</xsl:text>
</xsl:template>

<!-- Let's attempt to start a new page after each exercise -->
<xsl:template match="exercise">
    <xsl:apply-imports />
    <xsl:text>\clearpage&#xA;&#xA;</xsl:text>
</xsl:template>


<!-- Only process activity within subsection -->
<!-- This could match="introduction|subsection" and then -->
<!-- select="exploration|activity" if preview activities were to be included -->
<xsl:template match="subsection">
    <xsl:apply-templates select="activity" />
</xsl:template>
</xsl:stylesheet>

