<?xml version='1.0'?>
<!-- **********************************************************************-->
<!-- Copyright 2012-2017                                                   -->
<!-- Matthew Boelkins                                                      -->
<!--                                                                       -->
<!-- This file is part of Active Calculus.                                 -->
<!--                                                                       -->
<!-- Permission is granted to copy, distribute and/or modify this document -->
<!-- under the terms of the Creative Commons BY-NC-SA license.  The work   -->
<!-- may be used for free by any party so long as attribution is given to  -->
<!-- the author(s), the work and its derivatives are used in the spirit of -->
<!-- "share and share alike"; no party may sell this work or any of its    -->
<!-- derivatives for profit.  All trademarks are the registered marks of   -->
<!-- their respective owners.                                              -->
<!-- **********************************************************************-->

<!-- ACS customizations for all LaTeX runs -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<!-- Assumes current file is in mathbook/user, so it must be copied there -->
<xsl:import href="../xsl/mathbook-latex.xsl" />
<!-- Assumes next file can be found in mathbook/user, so it must be copied there -->
<!--<xsl:import href="acs-common.xsl" />-->

<!-- List Chapters and Sections in printed Table of Contents -->
<xsl:param name="toc.level" select="'2'" />


<!-- Exercises have hint (sporadically), answer, and solution -->
<!-- Put answers in backmatter -->
<xsl:param name="exercise.text.statement" select="'yes'" />
<xsl:param name="exercise.text.hint" select="'yes'" />
<xsl:param name="exercise.text.answer" select="'no'" />
<xsl:param name="exercise.text.solution" select="'no'" />
<xsl:param name="exercise.backmatter.statement" select="'no'" />
<xsl:param name="exercise.backmatter.hint" select="'no'" />
<xsl:param name="exercise.backmatter.answer" select="'yes'" />
<xsl:param name="exercise.backmatter.solution" select="'no'" />

<!-- activity is a project-like, so we need to set those stringparams -->
<!-- to control hints, answers, and solutions -->
<xsl:param name="project.text.hint" select="'no'" />
<xsl:param name="project.text.answer" select="'no'" />
<xsl:param name="project.text.solution" select="'no'" />


<!-- ############################# -->
<!-- WeBWorK Problems from Servers -->
<!-- ############################# -->
<!-- This is an attempt to override what comes from PTX by default -->
    
<!-- @source, in an otherwise empty "webwork" element,     -->
<!-- indicates the problem lives on a server.  HTML        -->
<!-- output has no problem with that (it is easier than    -->
<!-- locally authored).  For LaTeX, the  mbx  script       -->
<!-- fetches a LaTeX rendering and associated image files. -->
<!-- Here, we just provide a light wrapper, and drop an    -->
<!-- include, since the basename for the filenames has     -->
<!-- been managed by the  mbx  script to be predictable.   -->
<xsl:template match="webwork[@source]">
    <!-- directory of server LaTeX must be specified -->
    <xsl:if test="$webwork.server.latex = ''">
        <xsl:message terminate="yes">MBX:ERROR   For LaTeX versions of WeBWorK problems on a server, the mbx script will collect the LaTeX source and then this conversion must specify the location through the "webwork.server.latex" command line stringparam.  Quitting...</xsl:message>
    </xsl:if>
    <xsl:variable name="xml-filename">
        <!-- assumes path has trailing slash -->
        <xsl:value-of select="$webwork.server.latex" />
        <xsl:apply-templates select="." mode="internal-id" />
        <xsl:text>.xml</xsl:text>
    </xsl:variable>
    <xsl:variable name="server-tex" select="document($xml-filename)/webwork-tex" />
    <!-- An enclosing exercise may introduce/connect the server-version problem. -->
    <!-- Then formatting is OK.  Otherwise we need a faux sentence instead.      -->
<!--    <xsl:text>\mbox{}\\ % hack to move box after heading&#xa;</xsl:text> -->
    <xsl:apply-templates select="introduction" /> <!-- before boxed problem -->
<!--    <xsl:text>\begin{mdframed}&#xa;</xsl:text>-->
    <xsl:text>{</xsl:text> <!-- prophylactic wrapper -->
<!--    <xsl:text>\marginnote{\tiny \includegraphics[width=0.25in]{images/webwork-logo.png}}</xsl:text>-->
    <!-- mbx script collects problem preamble, but we do not use it here -->
    <!-- process in the order server produces them, may be several -->
    <xsl:apply-templates select="$server-tex/statement|$server-tex/solution|$server-tex/hint" />
    <xsl:text>}</xsl:text>
<!--    <xsl:text>\par\vspace*{2ex}%&#xa;</xsl:text> -->
<!--    <xsl:text>{\tiny\ttfamily\noindent\url{</xsl:text> -->
<!--    <xsl:value-of select="@source" /> -->
<!--    <xsl:text>}\\</xsl:text>-->
    <!-- seed will round-trip through mbx script, default -->
    <!-- is hard-coded there.  It comes back as an        -->
    <!-- attribute of the overall "webwork-tex" element   -->
<!--    <xsl:text>Seed: </xsl:text> -->
<!--    <xsl:value-of select="$server-tex/@seed" /> -->
<!--    <xsl:text>\hfill</xsl:text> -->
<!--    <xsl:text>}</xsl:text> --> <!-- end: \tiny\ttfamily -->
<!--    <xsl:text>\end{mdframed}&#xa;</xsl:text>-->
    <xsl:apply-templates select="conclusion" /> <!-- after boxed problem -->
</xsl:template>

</xsl:stylesheet>
