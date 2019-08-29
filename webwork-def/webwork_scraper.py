from os import listdir
from os.path import isfile, join
from bs4 import BeautifulSoup

ez_path = "../src/exercises"
files = [f for f in listdir(ez_path) if isfile(join(ez_path, f))]
files.sort()

set_files = []
for file in files:
    set_file = file.replace('ez', 'set')
    set_file = set_file.replace('.xml', '.def')
    set_files.append(set_file)

num_sections = len(files)

preamble = """# we include open/close/etc dates because they seem to be required
openDate = 11/7/30 at 8:00 AM
dueDate = 11/7/30 at 1:00 PM
answerDate = 11/7/30 at 6:00 PM
#
problemList="""

for num in range(num_sections):
    f = open(join(ez_path, files[num]),'r')
    file_contents = f.read()
    soup = BeautifulSoup(file_contents, 'html.parser')
    
    ww_paths = soup.findAll('webwork')
#     print(ww_paths)
    g = open(set_files[num], 'a')
    g.write(preamble+'\n')
    for ww_path in ww_paths:
        if set_files[num] != 'set-4-4.def':
            g.write(ww_path['source']+'\n')
    g.close()
    f.close() 

print(files[num],set_files[num])