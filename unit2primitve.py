from pymatgen.core.structure import Structure
import sys

struct=Structure.from_file(sys.argv[1])
from pymatgen.symmetry.analyzer import SpacegroupAnalyzer
sg=SpacegroupAnalyzer(struct)
sg.find_primitive()
pc=sg.find_primitive()
pc.to(filename='POSCAR_primitivecell')
