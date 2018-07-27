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
<xsl:import href="../xsl/mathbook-latex.xsl" />
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
    <xsl:text>% CC icon at bottom of first page of chapter &#xa;</xsl:text>
    <xsl:text>%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%&#xa;</xsl:text>
    <xsl:text>\usepackage[automark]{scrlayer-scrpage}&#xa;</xsl:text>
    <xsl:text>\deftripstyle{ccfooter}&#xa;</xsl:text>
    <xsl:text>  {}&#xa;</xsl:text>
    <xsl:text>  {}&#xa;</xsl:text>
    <xsl:text>  {}&#xa;</xsl:text>
    <xsl:text>  {}&#xa;</xsl:text>
    <xsl:text>  {}&#xa;</xsl:text>
    <xsl:text>  {\includegraphics[height=1pc]{images/CClicense.pdf}}&#xa;</xsl:text>
    <xsl:text>\renewcommand{\chapterpagestyle}{ccfooter}&#xa;</xsl:text>
    <xsl:text>&#xa;</xsl:text>
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
    <xsl:text>%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%&#xa;</xsl:text>
    <xsl:text>% Basic paragraph parameters &#xa;</xsl:text>
    <xsl:text>%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%&#xa;</xsl:text>
    <xsl:text>\setlength{\parindent}{0mm}&#xa;</xsl:text>
    <xsl:text>\setlength{\parskip}{0.5pc}&#xa;</xsl:text>
    <xsl:text>%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%&#xa;</xsl:text>
    <xsl:text>% Greg's L &#xa;</xsl:text>
    <xsl:text>%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%&#xa;</xsl:text>
    <xsl:text>%% Package for breakable highlight boxes &#xa;</xsl:text>
    <xsl:text>\usepackage[framemethod=tikz]{mdframed}&#xa;</xsl:text>
    <xsl:text>\newtheorem{mdactivity}[cpjt]{Activity}&#xa;</xsl:text>
    <xsl:text>\newtheorem{mdexploration}[cpjt]{Preview Activity}&#xa;</xsl:text>
    <xsl:text>\renewenvironment{activity}[1][]% &#xa;</xsl:text>
    <xsl:text>  {\begin{mdframed}[linecolor=ActiveBlue,topline=false, &#xa;</xsl:text>
    <xsl:text>    rightline=false, &#xa;</xsl:text>
    <xsl:text>    bottomline=false, &#xa;</xsl:text>
    <xsl:text>    linewidth=3pt, &#xa;</xsl:text>
    <xsl:text>    innerleftmargin=15pt, &#xa;</xsl:text>
    <xsl:text>    innerrightmargin=0pt, &#xa;</xsl:text>
    <xsl:text>    skipabove=\baselineskip, &#xa;</xsl:text>
    <xsl:text>    skipabove=1.2\baselineskip,]\begin{mdactivity}[#1]}&#xa;</xsl:text>
    <xsl:text>  {\end{mdactivity}\end{mdframed}}&#xa;</xsl:text>
    <xsl:text>\renewenvironment{exploration}[1][]% &#xa;</xsl:text>
    <xsl:text>  {\begin{mdframed}[linecolor=ActiveBlue,topline=false, &#xa;</xsl:text>
    <xsl:text>    rightline=false, &#xa;</xsl:text>
    <xsl:text>    bottomline=false, &#xa;</xsl:text>
    <xsl:text>    linewidth=3pt, &#xa;</xsl:text>
    <xsl:text>    innerleftmargin=15pt, &#xa;</xsl:text>
    <xsl:text>    innerrightmargin=0pt, &#xa;</xsl:text>
    <xsl:text>    skipabove=\baselineskip, &#xa;</xsl:text>
    <xsl:text>   skipabove=1.2\baselineskip,]\begin{mdexploration}[#1]}&#xa;</xsl:text>
    <xsl:text>  {\end{mdexploration}\end{mdframed}}&#xa;</xsl:text>
    <xsl:text>%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%&#xa;</xsl:text>
    <xsl:text>% In print, trying to reduce color use &#xa;</xsl:text>
    <xsl:text>%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%&#xa;</xsl:text>
    <xsl:text>\hypersetup{colorlinks=true,linkcolor=black,citecolor=black,</xsl:text>
    <xsl:text>filecolor=black,urlcolor=black}&#xa;</xsl:text>
</xsl:param>

<!-- Put a WeBWorK icon in the margin next to WeBWorK exercises -->
<xsl:template match="exercise/webwork-reps/static/statement">
    <xsl:text>\marginnote{\hspace*{-10ex}\tiny \includegraphics[width=0.25in]{images/webwork-logo.png}}</xsl:text>
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
