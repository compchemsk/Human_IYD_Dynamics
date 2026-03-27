#module load apps/gromacs/2020/cpu
gmx covar -s first-frame-dry.pdb -f Substrate-Bound-dry.xtc #Choose Backbone in the input section
gmx anaeig -s first-frame-dry.pdb -f Substrate-Bound-dry.xtc -2d -first 1 -last 2 #Choose Backbone in the input section
#Here, the first 1 and last 2 mean, we consider 2 principal components to project our simulation data. Modify it as per necessary of the system.