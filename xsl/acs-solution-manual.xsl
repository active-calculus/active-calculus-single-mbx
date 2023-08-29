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

<xsl:import href="./core/pretext-solution-manual-latex.xsl" />
<xsl:import href="acs-common.xsl" />
<xsl:variable name="title-separator" select="'\\[0.25\baselineskip]'"/>

<xsl:output method="text" />

<!-- Superfluous frontmatter for a solution manual -->
<!-- So we don't bother and kill first two pages   -->
<xsl:template match="*" mode="half-title" />
<xsl:template match="*" mode="ad-card" />

<xsl:template match="exercise[@exercise-interactive='webwork-reps']" mode="solutions-generator"> </xsl:template>
<xsl:template match="exercise[@exercise-interactive='webwork-reps']" mode="solutions"> </xsl:template>
<!-- Use letter paper and leave one-inch margins all around -->
<xsl:param name="latex.geometry" select="'letterpaper,tmargin=.5in,bmargin=.3in,hmargin=.75in,includeheadfoot '" />

<xsl:param name="latex.preamble.late">
  <xsl:text>% These override what PreTeXt supplies by default. The only addition&#xa;</xsl:text>
  <xsl:text>% is the after clause. If things start looking odd, look earlier in&#xa;</xsl:text>
  <xsl:text>% the LaTeX file to see how PreTeXt has redefined these three styles&#xa;</xsl:text>
  <xsl:text>% and update latex.preamble.late&#xa;</xsl:text>
  <xsl:text>\tcbset{ divisionsolutionstyle/.style={bwminimalstyle,&#xa;</xsl:text>
  <xsl:text>runintitlestyle, exercisespacingstyle, after title={\space},&#xa;</xsl:text>
  <xsl:text>breakable, parbox=false, after={\clearpage} } }&#xa;</xsl:text>
  <xsl:text>\tcbset{ explorationsolutionstyle/.style={bwminimalstyle,&#xa;</xsl:text>
  <xsl:text>runintitlestyle, exercisespacingstyle, after
  title={\space},&#xa;</xsl:text>
  <xsl:text>breakable, parbox=false ,after={\clearpage}} }&#xa;</xsl:text>
  <xsl:text>\tcbset{ activitysolutionstyle/.style={bwminimalstyle,&#xa;</xsl:text>
  <xsl:text>runintitlestyle, exercisespacingstyle, after title={\space},&#xa;</xsl:text>
  <xsl:text>breakable, parbox=false, after={\clearpage}} }&#xa;</xsl:text>

  <xsl:value-of select="$latex.preamble.late.common" />
</xsl:param>

</xsl:stylesheet>
