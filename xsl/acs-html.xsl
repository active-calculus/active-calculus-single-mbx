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

<!-- ACS customizations for HTML runs -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<!-- Assumes current file is in mathbook/user, so it must be copied there -->
<xsl:import href="../xsl/mathbook-html.xsl" />
<!-- Assumes next file can be found in mathbook/user, so it must be copied there -->
<!--<xsl:import href="acs-common.xsl" />-->

<!-- List Chapters and Sections in sidebar Table of Contents -->
<xsl:param name="toc.level" select="'2'" />

<!-- Examples and inline exercises are knowlized by default -->
<!-- We disable this behavior  -->
<xsl:param name="html.knowl.example" select="'no'" />
<xsl:param name="html.knowl.exercise.inline" select="'no'" />

<!-- Exercises have hint (sporadically), answer, and solution -->
<xsl:param name="exercise.divisional.statement" select="'yes'" />
<xsl:param name="exercise.divisional.hint" select="'yes'" />
<xsl:param name="exercise.divisional.answer" select="'no'" />
<xsl:param name="exercise.divisional.solution" select="'no'" />

<!-- activity is a project-like, so we need to set those stringparams -->
<!-- to control hints, answers, and solutions -->
<xsl:param name="project.statement" select="'yes'" />
<xsl:param name="project.hint" select="'no'" />
<xsl:param name="project.answer" select="'no'" />
<xsl:param name="project.solution" select="'no'" />

<!-- Specify the color scheme to use for HTML -->
<xsl:param name="debug.colors" select="'blue_grey'" />

<!-- Specify options for WeBWorK exercises -->
<xsl:param name="webwork.divisional.static" select="'no'" />
<xsl:param name="html.knowl.exercise.sectional" select="'no'" />

<!-- Specify Google Custom Search -->
<xsl:param name="html.google-search" select="'015103900096539427448:ngwuia10qci'" />

<!-- Kill answers to WeBWorK exercises -->
<xsl:template match="exercise[webwork-reps]" mode="solutions">
</xsl:template>

</xsl:stylesheet>
