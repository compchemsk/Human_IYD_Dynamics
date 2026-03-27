import numpy as np 
import pandas as pd 
import matplotlib.pyplot as plt
import matplotlib.ticker as ticker
import math 
from matplotlib import rcParams
rcParams.update({'figure.autolayout': True})
rcParams.update({'font.size': 15})


x, y, z = np.genfromtxt(r'2dproj-fes.dat', unpack=True)

plt.figure(1)
tt = plt.tricontourf(x,y,z, cmap="jet")

#ticks = [0.0, -1.0, -2.0, -3.0, -4.0, -5.0]
#cbar = plt.colorbar(tt, ticks=ticks)
#cbar.ax.set_yticklabels([f'{tick}' for tick in ticks])

plt.xlabel(r'PC1 (Angstrom)',fontweight='bold',fontsize=18.0)
plt.ylabel(r'PC2 (Angstrom)',fontweight='bold',fontsize=18.0)
plt.xticks(fontsize=14)
plt.yticks(fontsize=14)
plt.autoscale()
plt.colorbar()
#plt.xlim(100,180)
#plt.ylim(100,180)
plt.savefig("PC1-vs-PC2.png")
plt.show()
