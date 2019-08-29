# WeBWorK definition files

In this folder you will find the definition files for all the webwork problems in the 2018 (Updated Edition) of Active Calculus. For newer versions, you can use the python code found in `webwork_scraper.py`. This script uses the [Beautiful Soup](https://www.crummy.com/software/BeautifulSoup/bs4/doc/) package. 

The code skips Section 4.4 as those problems are hard coded into the book. Hence the definition file for Section 4.4 was written manually. Also, Sections 2.2 and 3.3 do not have webwork problems, so there are not definition files. These are items to keep in mind for use with later versions of Active Calculus. 

## How to use the files

The following outlines a method to use these files.
1. Upload the `AC-WeBWorK-2018-Updated-Ed.tgz` file to your course using the `File Manager`. 
2. Go to the `Hmwk Sets Editor` and select the `Import` tab.
3. Find the section to import from the `Import from where?` scroll menu. 
4. Fill in the rest of the form as desired and click `Take Action` (do not use spaces in your set name). 

This will create a homework set (see your `Homework Sets`) that contains the webwork problems from the book. It can then be modified as desired. 
