# active-calculus-single-mbx
Repository for a conversion of Active Calculus (single variable) to MathBook XML

Active Calculus is available from [scholarworks.gvsu.edu](http://scholarworks.gvsu.edu/books/10/). This project aims to convert Active Calculus 2016 edition to a version in [MathBook XML](mathbook.pugetsound.edu).

# quickstart instructions
1. Clone this repository (from @mitchkeller). The branch you want is
   `WW-PAs-CS`, so switch to that branch.
1. Get a special branch of PreTeXt. This has some commits that are in the pipeline, but may evolve before merging into the official repo.
```cd ~/pretext
git remote add jordan https://github.com/Alex-Jordan/mathbook
git fetch jordan active-calculus
git checkout -b active-calculus --track jordan/active-calculus```
If you use a directory other than `~/pretext` here for this, update
paths below.
1. Make WeBWorK representations. Once @Alex-Jordan's branch is merged,
that can be done with the CLI (`pretext generate -t
runestone-safranski webwork`), but for now, you need 
`~/pretext/pretext/pretext -p publication/publication_runestone.ptx -c
webwork source/main.ptx` (Replace `~/pretext/pretext/pretext` with
path to the `pretext` script.)
1. Build the HTML. `~/pretext/pretext/pretext -p
   publication/publication_runestone.ptx -c all -f html -d output/runestone-safranski/
   source/main.ptx` Change `output/runestone-safranski` to whereever you want the output
   to go and change `~/pretext/pretext/pretext` to path to the
   `pretext` script. With Alex's code merged, this can be done using
   the CLI via `pretext build runestone-safranski`.
