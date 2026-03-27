# Human_IYD_Dynamics
Human IYD is a flavoprotein in the thyroid gland. Its dynamics were investigated using extra-point charge force fields, molecular dynamics simulations, conceptual DFT, and QM-cluster calculations. All inputs, outputs, and codes are provided. Cite: https://doi.org/10.1021/acs.biochem.4c00639
<br>
Author: Soumyajit Karmakar
<br>
The enzymatic cycle contains 4 stages:

1. Human IYD (hIYD) + FMN_hq + I-Tyr (Substrate Bound)
2. hIYD + FMN_ox + Tyr (Product Bound)
3. hIYD + FMN_ox (Apo Oxidized)
4. hIYD + FMN_hq (Apo Reduced) 
<br>
Modelling I-Tyr will require a modified force field due to anisotropic charge distribution of halogen atoms which can help them to promote halogen bonding, with the trend: I > Br > Cl (not observable for F)
<br>
<br>
<br>
A. The folder "Model_EP" will provide inputs and codes for modelling I-Tyr with extra-point charge (EP) to incorporate halogen bonding effects (via modelling sigma hole) within classical MD simulation setup using AMBER force field.
<br>
<br>
To generate parameters for MD simulation using I-Tyr (obtained from crystal structure, PDB ID: 4TTC), Go to the Model_EP directory, and proceed as mentioned below (Make sure to have gaussian16, AmberTools, and Amber18 or higher version):

g16 < I-Tyr-EP.com > I-Tyr-EP.log
<br>
antechamber -i I-Tyr-EP.log -fi gout -o I-Tyr-EP.mol2 -fo mol2 -c resp -nc -1 -m 1 -rn MIT 
<br>
parmchk2 -i I-Tyr-EP.mol2 -f mol2 -o I-Tyr-EP.frcmod -a Y
<br>
Please check the Electronic Supporting Information of the above paper for detailed force field parameters for the extra-point charge.
<br>
tleap -s -f Parameter-I-Tyr.in
<br>
<br>
<br>
B. The folder "Simulation" provides general input files to run classical MD simulations. The simulations include: minimization, heating, equilibration, and production run. Minimization, heating, and equilibration simulations are performed at multiple stages using position-based harmonic restraints on backbone/non-hydrogen ligand atoms/side chains, etc. At equilibration step, NVT ensemble is used while at production stage, NPT ensemble is used. Simulation temperature and pressure are kept fixed at 300 K and 1 atm. During simulation, to calculate number of univalent positive and negative ions to be added, use the script "ions-addition.pl" (a perl script), using the below command:

<br>
<br>  
perl ions-addition.pl salt_concentration_in_M volume_of_simulation_box_in_A^3
<br>
To prepare full protein-ligand system at this stage:
<br>
tleap -s -f Protein-Ligand-System.in
<br>
<br>
<br>
To run simulations, the following command can be used (if GPUs are available):
<br>
pmemd.cuda -O -i Production.in -o Production.out -p Protein-Ligand-Flavin.parm7 -c Equilibration.rst7 -ref Equilibration.rst7 -r Production.rst7 -x Production.nc -inf Production.mdinfo, the parameter file for the full Substrate Bound system is provided in the "Simulation" directory.
<br>
<br>
<br>
B. The folder "Analysis" contains files for analysis of MD simulation trajectories which used wordom, GROMACS tools, cpptraj, which are freely available for academic use.
<br>
chmod +x Simulation_Analysis.sh
<br>

./Simulation_Analysis.sh
<br>
<br>
<br>
This may take few minutes based on the length of the trajectory used. This will generate all files containing root-mean-squre deviation (RMSD), root-mean-square fluctuation (RMSF), and radius of gyration (RoG) for different parts of the proteins. It is noteworthy that here dry trajectories (No water and ions) are used during analysis to reduce the analysis time. 
<br>
<br>

For studying the essential dynamics of the protein at each stage of the enzymatic cycle, principal component analysis (PCA) was performed using the GROMACS PCA tools. The basin corresponding to the minimum free energy was used to extract the structure, representing the most probable conformation of the protein at that temperature during the molecular dynamics simulation. For this purpose, the "PCA_Minimum.sh" code can be used.
<br>

During PCA analysis, first run the code "PCA_Minimum.sh" using the following lines:
<br>
<br>
chmod +x PCA_Minimum.sh
<br>

./PCA_Minimum.sh

After this, eigenval.xvg and eigenvec.trr files are created which contain information about eigenvalues and eigenvectors. Manually inspect, how many PCs will be required to inspect the essential dynamics of the protein and modify the "PCA_Minimum.sh" code accordingly and rerun it. Run the python code "PC_Contribution.py" to inspect the contribution of each principal component.

python PC_Contribution.py

<br>


