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

<!-- ACS common customizations used in all LaTeX productions -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<!-- List Chapters and Sections in printed Table of Contents -->
<xsl:param name="toc.level" select="'2'" />

<!-- Set font size and two-sided mode -->
<xsl:param name="latex.font.size" select="'10pt'" />
<xsl:param name="latex.sides" select="'two'" />

<!-- Font configuration should be consistent -->
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

<xsl:param name="latex.preamble.late.common">
    <xsl:text>%% Used to get WeBWorK logo into margin next to WW exercises&#xa;</xsl:text>
    <xsl:text>\usepackage{marginnote}&#xa;</xsl:text>

    <xsl:text>%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%&#xa;</xsl:text>
    <xsl:text>% CC icon at bottom of first page of each chapter &#xa;</xsl:text>
    <xsl:text>%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%&#xa;</xsl:text>
    <xsl:text>\newpagestyle{chapopen}{&#xa;</xsl:text>
    <xsl:text>\sethead[][][] % even&#xa;</xsl:text>
    <xsl:text>{}{}{} % odd&#xa;</xsl:text>
    <xsl:text>\setfoot[\includegraphics[height=1pc]{images/CC-BY-SA-license.pdf}][][]&#xa;</xsl:text>
<xsl:text>{}{}{\includegraphics[height=1pc]{images/CC-BY-SA-license.pdf}}}&#xa;</xsl:text>
    <xsl:text>\assignpagestyle{\chapter}{chapopen}&#xa;</xsl:text>

    <xsl:text>%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%&#xa;</xsl:text>
    <xsl:text>% Modified from Mitch Keller's chapter handling &#xa;</xsl:text>
    <xsl:text>%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%&#xa;</xsl:text>
    <xsl:text>%%% This is from common&#xa;</xsl:text>
    <xsl:text>\definecolor{ActiveBlue}{cmyk}{1, 0.5, 0, 0.35}&#xa;</xsl:text>
    <xsl:text>\colorlet{chaptercolor}{ActiveBlue}&#xa;</xsl:text>
    <xsl:text>%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%&#xa;</xsl:text>
    <xsl:text>% Basic paragraph parameters &#xa;</xsl:text>
    <xsl:text>%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%&#xa;</xsl:text>
    <xsl:text>\setlength{\parindent}{0mm}&#xa;</xsl:text>
    <xsl:text>\setlength{\parskip}{0.5pc}&#xa;</xsl:text>
    <xsl:text>%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%&#xa;</xsl:text>
    <xsl:text>% In print, trying to reduce color use &#xa;</xsl:text>
    <xsl:text>%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%&#xa;</xsl:text>
    <xsl:text>\hypersetup{colorlinks=true,linkcolor=black,citecolor=black,</xsl:text>
    <xsl:text>filecolor=black,urlcolor=black}&#xa;</xsl:text>
</xsl:param>

<!-- Set the headers and footers for the book -->
<xsl:template match="book" mode="titleps-headings">
    <xsl:text>{\sethead[\textsl{\ifthechapter{\chaptertitlename{} </xsl:text>
    <xsl:text>\thechapter }{} \chaptertitle}][][]&#xa;</xsl:text>
    <xsl:text>{}{}{\textsl{\thesection{} \sectiontitle}}&#xa;</xsl:text>
    <xsl:text>\setfoot[\thepage][][]&#xa;</xsl:text>
    <xsl:text>{}{}{\thepage}}&#xa;</xsl:text>
</xsl:template>

<!-- Style titles -->
<xsl:template name="titlesec-section-style">
    <!-- Only the formatting of chapter titles was changed -->
    <xsl:text>\titleformat{\chapter}[display]&#xa;</xsl:text>
    <xsl:text>{\raggedleft\normalfont\color{chaptercolor}\Large}{</xsl:text>
    <xsl:text>\MakeUppercase{\divisionnameptx}\space</xsl:text>
    <xsl:text>\rlap{\enskip\resizebox{!}{0.95cm}{\thechapter} \rule{15cm}{0.95cm}</xsl:text>
    <xsl:text>}}{10pt}{\normalfont\Huge\itshape#1}&#xa;</xsl:text>
    <xsl:text>[{\Large\authorsptx}]&#xa;</xsl:text>
    <xsl:text>\titleformat{name=\chapter,numberless}[display]&#xa;</xsl:text>
    <xsl:text>{\raggedleft\normalfont\color{chaptercolor}\Huge\itshape}{}{0pt}{#1}&#xa;</xsl:text>
    <xsl:text>[{\Large\authorsptx}]&#xa;</xsl:text>
    <xsl:text>\titlespacing*{\chapter}{0pt}{30pt}{20pt}&#xa;</xsl:text>

    <!-- Everything in this template below here is stock PTX as of 2018-12-17 -->
    <xsl:text>\titleformat{\section}[block]&#xa;</xsl:text>
<xsl:text>{\normalfont\Large\bfseries}{\thesection\space\titleptx}{1em}{}&#xa;</xsl:text>
    <xsl:text>[{\large\authorsptx}]&#xa;</xsl:text>
    <xsl:text>\titleformat{name=\section,numberless}[block]&#xa;</xsl:text>
    <xsl:text>{\normalfont\Large\bfseries}{}{0pt}{#1}&#xa;</xsl:text>
    <xsl:text>[{\large\authorsptx}]&#xa;</xsl:text>
    <xsl:text>\titlespacing*{\section}{0pt}{3.5ex plus 1ex minus .2ex}{2.3ex plus .2ex}&#xa;</xsl:text>
    <xsl:text>\titleformat{\subsection}[block]&#xa;</xsl:text>
    <xsl:text>{\normalfont\large\bfseries}{\thesubsection\space\titleptx}{1em}{}&#xa;</xsl:text>
    <xsl:text>[{\normalsize\authorsptx}]&#xa;</xsl:text>
    <xsl:text>\titleformat{name=\subsection,numberless}[block]&#xa;</xsl:text>
    <xsl:text>{\normalfont\large\bfseries}{}{0pt}{#1}&#xa;</xsl:text>
    <xsl:text>[{\normalsize\authorsptx}]&#xa;</xsl:text>
    <xsl:text>\titlespacing*{\subsection}{0pt}{3.25ex plus 1ex minus .2ex}{1.5ex plus .2ex}&#xa;</xsl:text>
    <xsl:text>\titleformat{\subsubsection}[block]&#xa;</xsl:text>
    <xsl:text>{\normalfont\normalsize\bfseries}{\thesubsubsection\space\titleptx}{1em}{}&#xa;</xsl:text>
    <xsl:text>[{\small\authorsptx}]&#xa;</xsl:text>
    <xsl:text>\titleformat{name=\subsubsection,numberless}[block]&#xa;</xsl:text>
    <xsl:text>{\normalfont\normalsize\bfseries}{}{0pt}{#1}&#xa;</xsl:text>
    <xsl:text>[{\normalsize\authorsptx}]&#xa;</xsl:text>
    <xsl:text>\titlespacing*{\subsubsection}{0pt}{3.25ex plus 1ex minus .2ex}{1.5ex plus .2ex}&#xa;</xsl:text>
</xsl:template>

<!-- Blue vertical rule next to Activity and Preview Activity -->
<xsl:template match="&PROJECT-LIKE;" mode="tcb-style">
    <xsl:text>enhanced,frame hidden,interior hidden, sharp corners,&#xa;</xsl:text>
    <xsl:text>boxrule=0pt,borderline west={3pt}{0pt}{ActiveBlue}, &#xa;</xsl:text>
    <xsl:text>runintitlestyle, blockspacingstyle, after title={.\space}, &#xa;</xsl:text>
    <xsl:text>colback=white,&#xa;</xsl:text>
    <xsl:text>coltitle=black,</xsl:text>
</xsl:template>


<xsl:template match="&DEFINITION-LIKE;" mode="tcb-style">
    <xsl:text>bwminimalstyle, runintitlestyle, blockspacingstyle, after title={\space}, </xsl:text>
</xsl:template>

<xsl:template match="&EXAMPLE-LIKE;" mode="tcb-style">
    <xsl:text>bwminimalstyle, runintitlestyle, blockspacingstyle, after title={\space}, </xsl:text>
</xsl:template>


<!-- Restore horizontal rules around Motivating Questions -->
<!-- This is fixing a bug in PreTeXt and can be removed when it's fixed -->
<xsl:template match="objectives" mode="tcb-style">
    <xsl:text>enhanced,frame hidden,interior hidden,sharp corners,&#xa;</xsl:text>
    <xsl:text>blockspacingstyle,boxrule=0pt,left=0pt,right=0pt,&#xa;</xsl:text>
    <xsl:text>fonttitle=\large\bfseries,&#xa;</xsl:text>
    <xsl:text>borderline north={0.1ex}{0pt}{black},&#xa;</xsl:text>
    <xsl:text>toptitle=0.5ex,top=2ex, bottom=0.5ex, &#xa;</xsl:text>
    <xsl:text>borderline south={0.1ex}{0pt}{black},coltitle=black,</xsl:text>
</xsl:template>

<!-- Add some styling to assemblage. This was roughly the PreTeXt default -->
<!-- in summer 2018 when the 2018 edition was produced. -->
<!-- The only change made here is to use ActiveBlue instead of the default blue. -->
<xsl:template match="assemblage" mode="tcb-style">
    <xsl:text>skin=enhanced, arc=2ex, &#xa;</xsl:text>
    <xsl:text>colback=ActiveBlue!5,colframe=ActiveBlue!75!black, &#xa;</xsl:text>
    <xsl:text>colbacktitle=ActiveBlue!20, coltitle=black, &#xa;</xsl:text>
    <xsl:text>boxed title style={sharp corners, frame hidden}, &#xa;</xsl:text>
    <xsl:text>fonttitle=\bfseries, attach boxed title to top &#xa;</xsl:text>
    <xsl:text>left={xshift=4mm,yshift=-3mm}, top=3mm,&#xa;</xsl:text>
</xsl:template>

<!-- Kill answers to WeBWorK exercises -->
<xsl:template match="exercise[webwork-reps]" mode="solutions">
</xsl:template>

<!-- This suppresses subsection headings in the backmatter answers -->
<!-- It had to be developed by clobbering part of the template from -->
<!-- upstream PreTeXt. If something goes wrong with backmatter answer -->
<!-- formatting, this is the most likely culprit. -->
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
