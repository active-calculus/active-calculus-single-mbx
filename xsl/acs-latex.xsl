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

<!-- ACS customizations for all LaTeX runs -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<!-- Assumes current file is in mathbook/user, so it must be copied there -->
<xsl:import href="../xsl/mathbook-latex.xsl" />
<!-- Assumes next file can be found in mathbook/user, so it must be copied there -->
<!--<xsl:import href="acs-common.xsl" />-->

<!-- List Chapters and Sections in printed Table of Contents -->
<xsl:param name="toc.level" select="'2'" />


<!-- Exercises have hint (sporadically), answer, and solution -->
<!-- Hint can be displayed where born, but otherwise suppress -->
<xsl:param name="exercise.divisional.hint" select="'yes'" />
<xsl:param name="exercise.divisional.answer" select="'no'" />
<xsl:param name="exercise.divisional.solution" select="'no'" />

<!-- activity is a project-like, so we need to set those stringparams -->
<!-- to control hints, answers, and solutions -->
<xsl:param name="project.hint" select="'no'" />
<xsl:param name="project.answer" select="'no'" />
<xsl:param name="project.solution" select="'no'" />

<!-- LaTeX formatting commands we can inject here without incident -->

<xsl:param name="latex.geometry" select="'paperwidth=7.44in,paperheight=9.69in,tmargin=.5in,bmargin=.3in,hmargin=.75in,bindingoffset=.4in,includeheadfoot '" />

<xsl:param name="latex.preamble.early">
       <xsl:text>%% Customized to load Palatino fonts&#xa;</xsl:text>
   <xsl:text>\usepackage[T1]{fontenc}&#xa;</xsl:text>
   <xsl:text>\renewcommand{\rmdefault}{zpltlf} %Roman font for use in math mode&#xa;</xsl:text>
   <xsl:text>\usepackage[scaled=.85]{beramono}% used only by \mathtt&#xa;</xsl:text>
   <xsl:text>\usepackage[type1]{cabin}%used only by \mathsf&#xa;</xsl:text>
   <xsl:text>\usepackage{amsmath,amssymb,amsthm}%load before newpxmath&#xa;</xsl:text>
   <xsl:text>\usepackage[varg,cmintegrals,bigdelims,varbb]{newpxmath}&#xa;</xsl:text>
   <xsl:text>\usepackage[scr=rsfso]{mathalfa}&#xa;</xsl:text>
   <xsl:text>\usepackage{bm} %load after all math to give access to bold math&#xa;</xsl:text>
   <xsl:text>% Now load the otf text fonts using fontspec--wont affect math&#xa;</xsl:text>
   <xsl:text>\usepackage[no-math]{fontspec}&#xa;</xsl:text>
   <xsl:text>\setmainfont{TeXGyrePagellaX}&#xa;</xsl:text>
   <xsl:text>\defaultfontfeatures{Ligatures=TeX,Scale=1,Mapping=tex-text}&#xa;</xsl:text>
   <xsl:text>\linespread{1.02}&#xa;</xsl:text>
</xsl:param>
<xsl:param name="latex.preamble.late">
    <xsl:text>%% Used to get WeBWorK logo into margin next to WW exercises&#xa;</xsl:text>
    <xsl:text>\usepackage{marginnote}&#xa;</xsl:text>
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
    <xsl:text>\rlap{\enskip\resizebox{!}{0.95cm}{\thechapter} </xsl:text>
    <xsl:text>\rule{15cm}{0.95cm} }}&#xa;</xsl:text>
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
    <xsl:text>  {\includegraphics[height=1pc]{images/CC-BY-SA-license.pdf}}&#xa;</xsl:text>
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
    <xsl:text>\usepackage[framemethod=tikz]{mdframed}&#xa;</xsl:text>
    <xsl:text>\RenewDocumentEnvironment{exploration}{o}&#xa;</xsl:text>
    <xsl:text>  {\IfValueTF{#1}{\begin{mdframed}[linecolor=ActiveBlue,topline=false, &#xa;</xsl:text>
    <xsl:text>    rightline=false, &#xa;</xsl:text>
    <xsl:text>    bottomline=false, &#xa;</xsl:text>
    <xsl:text>    linewidth=3pt, &#xa;</xsl:text>
    <xsl:text>    innerleftmargin=15pt, &#xa;</xsl:text>
    <xsl:text>    innerrightmargin=0pt, &#xa;</xsl:text>
    <xsl:text>    skipabove=\baselineskip,&#xa;</xsl:text>
    <xsl:text> skipabove=1.2\baselineskip,]\begin{explorationtitle}[#1]}&#xa;</xsl:text>
    <xsl:text>{\begin{mdframed}[linecolor=ActiveBlue,topline=false, &#xa;</xsl:text>
    <xsl:text>    rightline=false, &#xa;</xsl:text>
    <xsl:text>    bottomline=false, &#xa;</xsl:text>
    <xsl:text>    linewidth=3pt, &#xa;</xsl:text>
    <xsl:text>    innerleftmargin=15pt, &#xa;</xsl:text>
    <xsl:text>    innerrightmargin=0pt, &#xa;</xsl:text>
    <xsl:text>    skipabove=\baselineskip, &#xa;</xsl:text>
    <xsl:text>    skipabove=1.2\baselineskip,]\begin{explorationnotitle}}}&#xa;</xsl:text>
    <xsl:text>    {\IfValueTF{#1}{\end{explorationtitle}\end{mdframed}}&#xa;</xsl:text>
    <xsl:text>    {\end{explorationnotitle}\end{mdframed}}}&#xa;</xsl:text>
    <xsl:text>\RenewDocumentEnvironment{activity}{o}&#xa;</xsl:text>
    <xsl:text>  {\IfValueTF{#1}{\begin{mdframed}[linecolor=ActiveBlue,topline=false, &#xa;</xsl:text>
    <xsl:text>    rightline=false, &#xa;</xsl:text>
    <xsl:text>    bottomline=false, &#xa;</xsl:text>
    <xsl:text>    linewidth=3pt, &#xa;</xsl:text>
    <xsl:text>    innerleftmargin=15pt, &#xa;</xsl:text>
    <xsl:text>    innerrightmargin=0pt, &#xa;</xsl:text>
    <xsl:text>    skipabove=\baselineskip, &#xa;</xsl:text>
    <xsl:text> skipabove=1.2\baselineskip,]\begin{activitytitle}[#1]}&#xa;</xsl:text>
    <xsl:text>    {\begin{mdframed}[linecolor=ActiveBlue,topline=false, &#xa;</xsl:text>
    <xsl:text>    rightline=false, &#xa;</xsl:text>
    <xsl:text>    bottomline=false, &#xa;</xsl:text>
    <xsl:text>    linewidth=3pt, &#xa;</xsl:text>
    <xsl:text>    innerleftmargin=15pt, &#xa;</xsl:text>
    <xsl:text>    innerrightmargin=0pt, &#xa;</xsl:text>
    <xsl:text>    skipabove=\baselineskip, &#xa;</xsl:text>
    <xsl:text>    skipabove=1.2\baselineskip,]\begin{activitynotitle}}}&#xa;</xsl:text>
    <xsl:text>  {\IfValueTF{#1}{\end{activitytitle}\end{mdframed}}&#xa;</xsl:text>
    <xsl:text>    {\end{activitynotitle}\end{mdframed}}}&#xa;</xsl:text>
    <xsl:text>%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%&#xa;</xsl:text>
    <xsl:text>% In print, trying to reduce color use &#xa;</xsl:text>
    <xsl:text>%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%&#xa;</xsl:text>
    <xsl:text>\hypersetup{colorlinks=true,linkcolor=black,citecolor=black,</xsl:text>
    <xsl:text>filecolor=black,urlcolor=black}&#xa;</xsl:text>
</xsl:param>

<xsl:template match="exercise[webwork-reps]">
    <xsl:text>\marginnote{\tiny \includegraphics[width=0.25in]{images/webwork-logo.png}}</xsl:text>
    <xsl:apply-imports />
</xsl:template>

<!-- We don't want to start each section's answers on a new page in the backmatter -->
<xsl:template match="backmatter">
    <xsl:text>\renewcommand\section{\oldsection}</xsl:text>
    <xsl:apply-imports />
</xsl:template>
</xsl:stylesheet>
