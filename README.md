# active-calculus-single-mbx
Repository for a conversion of Active Calculus (single variable) to MathBook XML

Active Calculus is available from [scholarworks.gvsu.edu](http://scholarworks.gvsu.edu/books/10/). This project aims to convert Active Calculus 2016 edition to a version in [MathBook XML](mathbook.pugetsound.edu).

# quickstart instructions
1. Clone this repository.
1. Install the [PreTeXt-CLI](https://pypi.org/project/pretextbook/)
1. Execute `pretext generate` to prepare the WeBWorK problems. (This
   step needs to be done any time you change a WeBWorK problem.)
1. Then execute `pretext build html`, `pretext view html`, `pretext build pdf`, `pretext
   build latex`or other things you can find in `project.ptx`, such as
   `pretext build workbook14`.
