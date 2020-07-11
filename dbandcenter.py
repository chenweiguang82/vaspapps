from pymatgen.io.vasp.outputs import Vasprun
from pymatgen.electronic_structure.core import Spin, Orbital, OrbitalType
from scipy import integrate
import numpy as np
import sys
def dbandcenter(dos):
    intdos=integrate.trapz(dos[:,1],dos[:,0])
    intedos=integrate.trapz(dos[:,1]*dos[:,0],dos[:,0])
    return intedos/intdos

def intervalpos(arr, min, max):
    pos_max = arr<=max
    pos_min = arr>=min
    pos = pos_max & pos_min
    return np.where(pos == True)

vasprun= Vasprun(sys.argv[2])
cdos=vasprun.complete_dos
el_dos=cdos.get_element_spd_dos(sys.argv[1])

#s1dos=cdos.get_site_spd_dos(cdos.structure.sites[0])
energy=cdos.energies-cdos.efermi
pos = intervalpos(energy,min(energy), max(energy))
#pos = intervalpos(energy,min(energy), 0)
ddos_up=el_dos[OrbitalType.d].densities[Spin.up]
ddos_up=np.c_[cdos.energies-cdos.efermi,ddos_up]
print("%-10.4f" % dbandcenter(ddos_up[pos]),end='')
if vasprun.is_spin:
    ddos_down=el_dos[OrbitalType.d].densities[Spin.down]
    ddos_down=np.c_[cdos.energies-cdos.efermi,ddos_down]
    print("%-10.4f" % dbandcenter(ddos_down[pos]),end='')

print("")
