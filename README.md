# active-calculus-single-mbx
Repository for a conversion of Active Calculus (single variable) to MathBook XML

Active Calculus is available from [scholarworks.gvsu.edu](http://scholarworks.gvsu.edu/books/10/). This project aims to convert Active Calculus 2016 edition to a version in [MathBook XML](mathbook.pugetsound.edu).

# quickstart instructions
1. Clone this repository.
2. Clone [MathBook XML](https://github.com/rbeezer/mathbook) and install its dependencies.
3. Copy `Makefile.paths.original` to `Makefile.paths`. Edit `Makefile.paths` as instructed within that file.
4. Execute `make html`, `make pdf`, or other things detailed in `Makefile`. Output will be produced in the `output` folder.
