# Human_IYD_Dynamics  

Human IYD is a flavoprotein located in the thyroid gland. Its structural and dynamic properties were investigated using extra-point charge force fields, molecular dynamics simulations, conceptual DFT, and QM-cluster calculations. All required inputs, outputs, and codes are provided in this repository.  

📌 **Citation:** https://doi.org/10.1021/acs.biochem.4c00639  
👤 **Author:** Soumyajit Karmakar  

---

## 🧬 Overview of the Enzymatic Cycle  

The enzymatic cycle consists of four distinct stages:  

1. Human IYD (hIYD) + FMN_hq + I-Tyr (Substrate Bound)  
2. hIYD + FMN_ox + Tyr (Product Bound)  
3. hIYD + FMN_ox (Apo Oxidized)  
4. hIYD + FMN_hq (Apo Reduced)  

Modelling I-Tyr requires a modified force field due to the anisotropic charge distribution of halogen atoms. This enables proper representation of halogen bonding via sigma-hole modeling, following the trend:  

> **I > Br > Cl (not observable for F)**  

---

## 📁 A. Model_EP Directory  

This folder contains inputs and scripts for modelling I-Tyr with extra-point charge (EP), enabling accurate incorporation of halogen bonding effects in classical MD simulations using the AMBER force field.  

### ⚙️ Steps to Generate Parameters (PDB ID: 4TTC)

Ensure Gaussian16, AmberTools, and Amber18 (or higher) are installed.  

```bash
g16 < I-Tyr-EP.com > I-Tyr-EP.log
antechamber -i I-Tyr-EP.log -fi gout -o I-Tyr-EP.mol2 -fo mol2 -c resp -nc -1 -m 1 -rn MIT
parmchk2 -i I-Tyr-EP.mol2 -f mol2 -o I-Tyr-EP.frcmod -a Y
tleap -s -f Parameter-I-Tyr.in
```

Refer to the Electronic Supporting Information of the cited paper for detailed EP parameters.  

---

## 🧪 B. Simulation Directory  

This folder provides input files for classical MD simulations, including:  
- Minimization  
- Heating  
- Equilibration  
- Production  

Different stages use position-based harmonic restraints on backbone atoms, ligand atoms (excluding hydrogens), and side chains.  

- **Equilibration:** NVT ensemble  
- **Production:** NPT ensemble  
- **Conditions:** 300 K temperature, 1 atm pressure  

### ➕ Ion Calculation  

```bash
perl ions-addition.pl salt_concentration_in_M volume_of_simulation_box_in_A^3
```

### 🧩 System Preparation  

```bash
tleap -s -f Protein-Ligand-System.in
```

### 🚀 Running Simulations (GPU-enabled)  

```bash
pmemd.cuda -O \
-i Production.in \
-o Production.out \
-p Protein-Ligand-Flavin.parm7 \
-c Equilibration.rst7 \
-ref Equilibration.rst7 \
-r Production.rst7 \
-x Production.nc \
-inf Production.mdinfo
```

---

## 📊 C. Analysis Directory  

This folder includes scripts for trajectory analysis using wordom, GROMACS tools, and cpptraj.  

### ▶️ Run Analysis  

```bash
chmod +x Simulation_Analysis.sh
./Simulation_Analysis.sh
```

This generates:  
- RMSD  
- RMSF  
- Radius of Gyration (RoG)  

Dry trajectories (without water and ions) are used to reduce computational time.  

---

### 📈 Principal Component Analysis (PCA)  

```bash
chmod +x PCA_Minimum.sh
./PCA_Minimum.sh
```

Generated files:  
- eigenval.xvg  
- eigenvec.trr  

Modify the script based on the number of significant PCs.  

```bash
python PC_Contribution.py
```

This produces `2dproj.xvg` (PC1 vs PC2).  

---

### 🌄 Free Energy Landscape Construction  

```bash
awk '!/^[@#]/ {
if(NR==1||$1<min1)min1=$1;
if(NR==1||$1>max1)max1=$1;
if(NR==1||$2<min2)min2=$2;
if(NR==1||$2>max2)max2=$2
}
END{
print "Col1 Min:",min1,"Max:",max1;
print "Col2 Min:",min2,"Max:",max2
}' 2dproj.xvg

gfortran 2D_Boltzman.f
./a.out > 2dproj-fes.dat
```

### 🎯 Extract Minimum Energy Frame  

```bash
read x y _ < <(sort -nk3 2dproj-fes.dat | head -1)

awk -v x="$x" -v y="$y" '!/^[@#]/ {
i++;
d=($1-x)^2+($2-y)^2;
if(i==1||d<min){min=d; frame=i}
}
END{print frame}' 2dproj.xvg
```

### 📉 Plotting  

```bash
python 2D_plot.py
```

---

## 💡 D. Free_Energy Directory (MM-PBSA)  

Used for binding free energy calculations of ligands.  

Entropy corrections via quasi-harmonic approximation are excluded due to uncertainty.  

### ▶️ Run Calculation  

```bash
MPBSA.py -O \
-i mmpbsa_input.in \
-o mmpbsa-flavin.dat \
-sp solvated-complex.parm7 \
-cp complex.parm7 \
-rp receptor.parm7 \
-lp flavin.parm7 \
-y Production.nc > flavin.log
```

### 📌 Extract Results  

```bash
grep 'DELTA TOTAL' mmpbsa-flavin.dat | awk '{print $3, $4}'
```

### 🔁 Replica Averaging  

```bash
for np in {1..10}
do
cat path_to_replica/replica-${np}/mmpbsa-flavin-${np}/mmpbsa-flavin-${np}.dat | tail -5 | head -1 >> flavin.dat
done

awk '{
sum2+=$3;
sum3+=$4;
count++
}
END {
print "Col2 avg:", sum2/count;
print "Col3 avg:", sum3/count
}' flavin.dat
```

### 🧬 Residue Contribution  

```bash
chmod +x residue-decomp.sh
./residue-decomp.sh
```

---

## 🔗 E. Halogen Bonding Analysis  

Performed using NCI and AIM methods via Multiwfn.  

```bash
formchk NCI_input.chk
path_to_Multiwfn/Multiwfn NCI_input.fchk < NCI_input.txt
path_to_Multiwfn/Multiwfn NCI_input.fchk < AIM_input.txt
```

### 🎨 Visualization  

```bash
vmd -e RDGfill.vmd
vmd -e AIM.vmd
```

---

## 🤖 F. AlphaFold2-Model Directory  

Used to model the full hIYD enzyme including all domains.  

Run in Google Colab:  
https://colab.research.google.com/  

### 🧾 Input Sequence for Dimer  

```text
SGEPRTRAEARPWVDEDLKDSSDLHQAEEDADEWQESEENVEHIPFSHNHYPEKEMVKRSQEFYELLNKRRSVRFISNEQVPMEVIDNVIRTAGTAPSGAHTEPWTFVVVKDPDVKHKIRKIIEEEEEINYMKRMGHRWVTDLKKLRTNWIKEYLDTAPILILIFKQVHGFAANGKKKVHYYNEISVSIACGILLAALQNAGLVTVTTTPLNCGPRLRVLLGRPAHEKLLMLLPVGYPSKEATVPDLKRKPLDQIMVTVHHHHHH:SGEPRTRAEARPWVDEDLKDSSDLHQAEEDADEWQESEENVEHIPFSHNHYPEKEMVKRSQEFYELLNKRRSVRFISNEQVPMEVIDNVIRTAGTAPSGAHTEPWTFVVVKDPDVKHKIRKIIEEEEEINYMKRMGHRWVTDLKKLRTNWIKEYLDTAPILILIFKQVHGFAANGKKKVHYYNEISVSIACGILLAALQNAGLVTVTTTPLNCGPRLRVLLGRPAHEKLLMLLPVGYPSKEATVPDLKRKPLDQIMVTVHHHHHH
```

---

## ⚛️ G. QM Directory (Proton Transfer Study)  

Used to analyze re- vs si-face proton transfer using QM-cluster and NBO analysis.  

After running:  
- Files `.31` to `.41` are generated  

Then:  
- Open `.31` in Multiwfn (basis info)  
- Load `.37` for NBO analysis  

---

## 🔬 H. Ab-initio Calculations (ORCA + Multiwfn)  

Performed using DLPNO-CCSD(T)/DEF2-SVP.  

### 📄 Generate .wfn File  

```bash
orca_2mkl basename -molden
Multiwfn basename.molden
100
```

---

## 🔄 Restarting Gaussian Calculations  

### Optimization Restart  

**Way 1:**
```bash
%oldchk=reface-enzyme-env.chk
%chk=reface-enzyme-env-restart1.chk
#p opt(readopt) b3lyp/def2tzvp nosymm scf=xqc empiricaldispersion=gd3 geom=check guess=read
```

**Way 2:**  
Save last geometry and restart manually.  

---

### Single Point Restart  

```bash
%rwf=myfile.rwf
%nosave
%chk=myfile.chk

Title Card

# restart
rest of input
```

---

## ✅ Final Note  

Thank you. Hope this work helps you.  

Please ensure proper citation of all relevant software tools, including:  
- GROMACS  
- ORCA  
- Multiwfn  
- AMBER  