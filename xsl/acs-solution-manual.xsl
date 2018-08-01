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
<xsl:param name="exercise.divisional.hint" select="'no'" />
<xsl:param name="exercise.divisional.answer" select="'no'" />
<xsl:param name="exercise.divisional.solution" select="'yes'" />


<!-- Preview activities and activities are project-like. -->
<xsl:param name="project.text.hint" select="'no'" />
<xsl:param name="project.text.answer" select="'no'" />
<xsl:param name="project.text.solution" select="'yes'" />

<!-- Superfluous frontmatter for a solution manual -->
<!-- So we don't bother and kill first two pages   -->
<xsl:template match="*" mode="half-title" />
<xsl:template match="*" mode="ad-card" />

<!-- Chapters: default presentation, we have them all, so numbers OK     -->
<!-- Sections and Equivalents: kill them, except for specific ones below -->
<xsl:template match="conclusion|references|objectives|appendix|index|solutions" />

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

    <xsl:text>\section*{</xsl:text>
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
<!-- Also need to remove the template for introduction below -->
<xsl:template match="subsection">
    <xsl:apply-templates select="activity" />
</xsl:template>

<!-- We can't just kill introductions, since if we do, it messes up the -->
<!-- numbering. Instead, we increment the cpjt counter every time we see -->
<!-- an exploration (Preview Activity). If you want to include Preview Activities -->
<!-- just remove the template that matches exploration. -->
<xsl:template match="introduction">
    <xsl:apply-templates select="exploration" />
</xsl:template>
<xsl:template match="exploration">
    <xsl:text>\stepcounter{cpjt}&#xa;</xsl:text>
</xsl:template>    

<!-- Configure font with latex.preamble.early -->
<xsl:param name="latex.preamble.early">
    <xsl:text>%% Customized to load Palatino fonts&#xa;</xsl:text>
    <xsl:text>\usepackage[T1]{fontenc}&#xa;</xsl:text>
    <xsl:text>%Roman font for use in math mode&#xa;</xsl:text>
    <xsl:text>\renewcommand{\rmdefault}{zpltlf}&#xa;</xsl:text>
    <xsl:text>% used only by \mathtt&#xa;</xsl:text>
    <xsl:text>\usepackage[scaled=.85]{beramono}&#xa;</xsl:text>
    <xsl:text>%used only by \mathsf&#xa;</xsl:text>
    <xsl:text>\usepackage[type1]{cabin}&#xa;</xsl:text>
    <xsl:text>%load before newpxmath&#xa;</xsl:text>
    <xsl:text>\usepackage{amsmath,amssymb,amsthm}&#xa;</xsl:text>
    <xsl:text>\usepackage[varg,cmintegrals,bigdelims,varbb]{newpxmath}</xsl:text>
    <xsl:text>&#xa;</xsl:text>
    <xsl:text>\usepackage[scr=rsfso]{mathalfa}&#xa;</xsl:text>
    <xsl:text>%load after all math to give access to bold math&#xa;</xsl:text>
    <xsl:text>\usepackage{bm} &#xa;</xsl:text>
    <xsl:text>% Now load the otf text fonts using fontspec--</xsl:text>
    <xsl:text>wont affect math&#xa;</xsl:text>
    <xsl:text>\usepackage[no-math]{fontspec}&#xa;</xsl:text>
    <xsl:text>\setmainfont{TeXGyrePagellaX}&#xa;</xsl:text>
    <xsl:text>\defaultfontfeatures{Ligatures=TeX,Scale=1,Mapping=tex-text}</xsl:text>
    <xsl:text>&#xa;</xsl:text>
    <xsl:text>\linespread{1.02}&#xa;</xsl:text>
</xsl:param>

<!-- Use letter paper and leave one-inch margins all around -->
<xsl:param name="latex.geometry" select="'letterpaper,tmargin=.5in,bmargin=.3in,hmargin=.75in,includeheadfoot '" />

<!-- Format headers to match the text PDF -->
<xsl:param name="latex.preamble.late">
    <xsl:text>%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%&#xa;</xsl:text>
    <xsl:text>% Modified from Mitch Keller's chapter handling &#xa;</xsl:text>
    <xsl:text>%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%&#xa;</xsl:text>
    <xsl:text>\definecolor{ActiveBlue}{cmyk}{1, 0.5, 0, 0.35}&#xa;</xsl:text>
    <xsl:text>\colorlet{chaptercolor}{ActiveBlue}&#xa;</xsl:text>
    <xsl:text>\setkomafont{chapter}{\normalfont\color{chaptercolor}</xsl:text>
    <xsl:text>\Huge\itshape}&#xa;</xsl:text>
    <xsl:text>\setkomafont{chapterprefix}{\normalfont\Large}&#xa;</xsl:text>
    <xsl:text>\renewcommand*{\raggedchapter}{\raggedleft}&#xa;</xsl:text>
    <xsl:text>\renewcommand*{\chapterformat}{\MakeUppercase</xsl:text>
    <xsl:text>{\chapappifchapterprefix{}}&#xa;</xsl:text>
    <xsl:text>\rlap{\enskip\resizebox{!}{1.2cm}{\thechapter} </xsl:text>
    <xsl:text>\rule{15cm}{1.2cm} }}&#xa;</xsl:text>
    <xsl:text>\RedeclareSectionCommand[beforeskip=30pt,</xsl:text>
    <xsl:text>afterskip=20pt]{chapter}&#xa;</xsl:text>
    <xsl:text>\renewcommand*\chapterheadmidvskip{\par\nobreak</xsl:text>
    <xsl:text>\vspace{10pt}}&#xa;</xsl:text>
    <xsl:text>\setkomafont{captionlabel}{}&#xa;</xsl:text>
    <xsl:text>\setkomafont{caption}{}&#xa;</xsl:text>
    <xsl:text>\setcapindent{0em}&#xa;</xsl:text>
    <xsl:text>\addtokomafont{disposition}{\rmfamily\bfseries}&#xa;</xsl:text>
    <xsl:text>\addtokomafont{descriptionlabel}{\rmfamily\bfseries}&#xa;</xsl:text>
    <xsl:text>%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%&#xa;</xsl:text>
    <xsl:text>% CC icon at bottom of first page of each chapter &#xa;</xsl:text>
    <xsl:text>%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%&#xa;</xsl:text>
    <xsl:text>\usepackage[automark]{scrlayer-scrpage}&#xa;</xsl:text>
    <xsl:text>\deftripstyle{ccfooter}&#xa;</xsl:text>
    <xsl:text>  {}&#xa;</xsl:text>
    <xsl:text>  {}&#xa;</xsl:text>
    <xsl:text>  {}&#xa;</xsl:text>
    <xsl:text>  {}&#xa;</xsl:text>
    <xsl:text>  {}&#xa;</xsl:text>
    <xsl:text>  {\includegraphics[height=1pc]{images/CC-BY-SA-license.pdf}}&#xa;</xsl:text>
    <xsl:text>\renewcommand{\chapterpagestyle}{ccfooter}&#xa;</xsl:text>
    <xsl:text>&#xa;</xsl:text>
    <xsl:text>%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%&#xa;</xsl:text>
    <xsl:text>% Basic paragraph parameters &#xa;</xsl:text>
    <xsl:text>%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%&#xa;</xsl:text>
    <xsl:text>\setlength{\parindent}{0mm}&#xa;</xsl:text>
    <xsl:text>\setlength{\parskip}{0.5pc}&#xa;</xsl:text>
    <xsl:text>%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%&#xa;</xsl:text>
    <xsl:text>% In print, trying to reduce color use &#xa;</xsl:text>
    <xsl:text>%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%&#xa;</xsl:text>
    <xsl:text>\hypersetup{colorlinks=true,linkcolor=black,citecolor=black,</xsl:text>
    <xsl:text>filecolor=black,urlcolor=black}&#xa;</xsl:text>
</xsl:param>

</xsl:stylesheet>

