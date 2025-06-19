#############################################################################
# This macro library supports WeBWorK problems from the PreTeXt project named
# Active Calculus
#############################################################################


# Return a string containing the latex-image-preamble contents.
# To be used by LaTeXImage objects as in:
# $image->addToPreamble(latexImagePreamble())

sub latexImagePreamble {
return <<'END_LATEX_IMAGE_PREAMBLE'
\usepackage{pgfplots}
\definecolor{blue}{HTML}{0000FF}
\definecolor{darkgreen}{HTML}{008000}
\definecolor{amber}{HTML}{c7502a}

\colorlet{firstcolor}{blue}
\colorlet{secondcolor}{darkgreen}
\colorlet{thirdcolor}{orange}

\pgfplotsset{firstcurve/.style      = {color=firstcolor,  mark=none, line width=1pt, solid, ultra thick}}
\pgfplotsset{secondcurve/.style     = {color=secondcolor, mark=none, line width=1pt, solid, ultra thick}}
\pgfplotsset{thirdcurve/.style     = {color=thirdcolor, mark=none, line width=1pt, solid, ultra thick}}

\pgfplotscreateplotcyclelist{acplotstyles}{%
  firstcurve\\%
  secondcurve\\%
  thirdcurve\\%
}

\pgfplotsset{every axis/.append style={
  axis lines=middle,
  grid = both,
  cycle list name=acplotstyles,
}}

\pgfplotsset{soliddot/.style        = {fill=amber,  mark=*, only marks}}
\pgfplotsset{hollowdot/.style       = {mark=*, only marks}}

\pgfplotsset{guideline/.style       = {color=gray, mark=none, line width=1pt, -}}
\tikzset{guideline/.style           = {color=gray, mark=none, line width=1pt, -}}

END_LATEX_IMAGE_PREAMBLE
}
