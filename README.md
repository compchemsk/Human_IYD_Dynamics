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
C. The folder "Analysis" contains files for analysis of MD simulation trajectories which used wordom, GROMACS tools, cpptraj, which are freely available for academic use.
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
This will generate a file 2dproj.xvg (considering only 2 PCs contribute significantly to the overall dynamics) where PC1 vs PC2 data is written. Now, we will construct a free energy landscape along PC1 vs PC2 using "2D_Boltzman.f" file. Replace the maximum and minimum values of both columns in the fortran file. Collect the data of maximum and minimum values PC1 and PC2 from the 2dproj.xvg file using the commands:

awk '!/^[@#]/ {if(NR==1||$1<min1)min1=$1; if(NR==1||$1>max1)max1=$1; if(NR==1||$2<min2)min2=$2; if(NR==1||$2>max2)max2=$2} END{print "Col1 Min:",min1,"Max:",max1; print "Col2 Min:",min2,"Max:",max2}' 2dproj.xvg

<br>
gfortran 2D_Boltzman.f
./a.out > 2dproj-fes.dat

<br>
The frame number corresponding to the structure closest to the minimum free energy basin can be obtained using the following command:
<br>
<br>


read x y _ < <(sort -nk3 2dproj-fes.dat | head -1); awk -v x="$x" -v y="$y" '!/^[@#]/ {i++; d=($1-x)^2+($2-y)^2; if(i==1||d<min){min=d; frame=i}} END{print frame}' 2dproj.xvg

<br>
<br>



To plot the free energy landscape along PC1 and PC2 use the python code "2D_plot.py".

<br>
<br>
<br>
<br>
<br>

D. The protein contains different ligands at different stages of the enzymatic cycle. To calculate the binding free energy of different ligands, Molecular Mechanics Poission-Boltzmann Surface Area (MM-PBSA) method was employed. The input files for MM-PBSA and corresponding codes for finding residue-wise decomposition of the free energy can be found in the Free_Energy directory. It is noteworthy that entropy corrections using quasi-harmonic approximations are not included since they are known to incorporate unwanted uncertainty in the free energy values (please refer to the above paper).  

<br>
<br>

To run the MM-PBSA calculation:

<br>
MPBSA.py -O -i mmpbsa_input.in -o mmpbsa-flavin.dat -sp solvated-complex.parm7 -cp complex.parm7 -rp receptor.parm7 -lp flavin.parm7 -y Production.nc > flavin.log

<br>

To print the free energy values and corresponding standard deviation:

<br>

grep 'DELTA TOTAL' mmpbsa-flavin.dat | awk '{print$3,$4}'


<br>

Often it is mentioned that single MM-PBSA calculation does not give well-converged result. Hence, multiple replicas must be simulated and final result should be an average of all the replicas. To do this, perform many short MM-PBSA calculations stating from the minimum free energy structure. Then:

<br>
<br>
for np in {1..10}
<br>
do
<br>
cat path_to_replica/replica-${np}/mmpbsa-flavin-${np}/mmpbsa-flavin-${np}.dat | tail -5 | head -1 >> flavin.dat
<br>
done
<br>
awk '{sum2+=$3; sum3+=$4; count++} END {print "Col2 avg:", sum2/count; print "Col3 avg:", sum3/count}' flavin.dat

<br>
<br>
Now, to identify the top 10 residues which contribute significantly to the binding can be directly plotted using the residue-decomp.sh script.

<br>
<br>
chmod +x residue-decomp.sh
<br>
./residue-decomp.sh
<br>

It will create a nice plot showing electrostatic, van der Walls, and polar solvation contribution of residues of protein to the binding of ligand.

<br>
<br>
<br>
<br>

E. To identify if there is halogen bonding in the active site of the enzyme, non-covalent interaction (NCI) analysis was performed. For NCI and atom-in-molecules (AIM) analyses, the inputs are provided in Halogen_Bonding directory. Multiwfn, a tool for wave function analysis was used in this case.

<br>
formchk NCI_input.chk
<br>
path_to_Multiwfn/Multiwfn NCI_input.fchk < NCI_input.txt
<br>
path_to_Multiwfn/Multiwfn NCI_input.fchk < AIM_input.txt
<br>
<br>

For visualization, we can use visual molecular dynamics (vmd) with the following commands:
<br>
vmd -e RDGfill.vmd
<br>
vmd -e AIM.vmd



<br>
<br>
<br>

F. The NADPH-mediated flavin reduction step is one of the obscure step of the full enzymatic cycle. The full hIYD enzyme with its N-terminal membrane-bound domain, intermediate domain, and C-terminal domain was modelled using AlphaFold2. The input ColabFold python file, output pdb, docking input files, and simulation input files (where restraint was applied on the N-terminal domain) are provided in AlphaFold2-Model directory. 

<br>

To run the AlphaFold2.py file, upload it into google colab (https://colab.research.google.com/), then input the protein sequence and then run. For dimer, like hIYD, the sequence should be given as: 
<br>
<br>

SGEPRTRAEARPWVDEDLKDSSDLHQAEEDADEWQESEENVEHIPFSHNHYPEKEMVKRSQEFYELLNKRRSVRFISNEQVPMEVIDNVIRTAGTAPSGAHTEPWTFVVVKDPDVKHKIRKIIEEEEEINYMKRMGHRWVTDLKKLRTNWIKEYLDTAPILILIFKQVHGFAANGKKKVHYYNEISVSIACGILLAALQNAGLVTVTTTPLNCGPRLRVLLGRPAHEKLLMLLPVGYPSKEATVPDLKRKPLDQIMVTVHHHHHH:SGEPRTRAEARPWVDEDLKDSSDLHQAEEDADEWQESEENVEHIPFSHNHYPEKEMVKRSQEFYELLNKRRSVRFISNEQVPMEVIDNVIRTAGTAPSGAHTEPWTFVVVKDPDVKHKIRKIIEEEEEINYMKRMGHRWVTDLKKLRTNWIKEYLDTAPILILIFKQVHGFAANGKKKVHYYNEISVSIACGILLAALQNAGLVTVTTTPLNCGPRLRVLLGRPAHEKLLMLLPVGYPSKEATVPDLKRKPLDQIMVTVHHHHHH

<br>
<br>
<br>

G. To understand the proton source, at the onset of reductive dehalogentaion (the catalytic step), we performed re- vs si-face proton transfer. We use QM-cluster calculations and NBO analysis. The input files are given in the QM directory. After a successful run of the NBO-plot.com jobfile, files with .31 to .41 extensions will be generated. Now, boot Multiwfn and open the .31 file for basis information and then input .37 for NBO analysis.

<br>
<br>
<br>

H. The ab-initio calculations using DLPNO-CCSD(T)/DEF2-SVP were performed using ORCA for the active site of hIYD enzyme. Then Fukui function analysis was also performed using Multiwfn. The input file was provided in Ab-initio directory. For Fukui function analysis, N.wfn, N+1.wfn, and N-1.wfn files were created by addition and removal of one electron, respectively, to the original system (N electrons). 

<br>
How to create a .wfn file after calculation using ORCA?
<br>
orca_2mkl basename (filename without extension) -molden
<br>
Multiwfn basename.molden
<br>
100
<br>
select option to output wfn file.


<br>
<br>

To restart a gaussian optimization calculation:
<br>
1. Way1:
<br>
%oldchk=reface-enzyme-env.chk
<br>
%chk=reface-enzyme-env-restart1.chk
<br>
#p opt(readopt) b3lyp/def2tzvp nosymm scf=xqc empiricaldispersion=gd3 geom=check guess=read


<br>
<br>

2. Way2: Save last geometry and run the job from there again.

<br>
<br>
<br>

To restart a single point calculation job in gaussian:
<br>
%rwf=myfile.rwf
<br>
%nosave
<br>
%chk=myfile.chk

<br>
Title Card

<br>
# restart
<br>
rest of input

Thank you. Hope this work helps you.