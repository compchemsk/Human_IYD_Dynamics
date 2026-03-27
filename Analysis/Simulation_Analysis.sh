echo "
parm Substrate-Bound-dry.parm7
trajin Substrate-Bound-dry.nc 
trajout Substrate-Bound-dry.dcd dcd
trajout Substrate-Bound-dry.xtc xtc
run
quit " > cpptraj-2.in
cpptraj cpptraj-2.in

echo "
parm Substrate-Bound-dry.parm7
trajin Substrate-Bound-dry.nc 1 1 1
strip :WAT,Na+,Cl-
trajout first-frame-dry.pdb pdb include_ep
run 
quit " > cpptraj-3.in
cpptraj cpptraj-3.in


echo "
parm Substrate-Bound-dry.parm7 
trajin Substrate-Bound-dry.nc
radgyr :1-440&!(@H=) out RoG-Substrate-Bound-dry.agr mass nomax time 0.05
run
quit " > cpptraj-4.in
cpptraj cpptraj-4.in

rm cpptraj-2.in cpptraj-1.in cpptraj-3.in cpptraj-4.in

dcd=Substrate-Bound-dry.dcd
pdb=first-frame-dry.pdb
wordom=wordom_0.22-rc2.x86-64

$wordom -ia rmsd --TITLE full  --SELE "/*/@(1-220|221-440)/CA" --FIT "/*/*/CA" -imol $pdb -itrj $dcd > rmsd-Substrate-Bound-dry-protein.dat
$wordom -ia rmsd --TITLE chna  --SELE "/*/@(1-220)/CA" --FIT "/*/*/CA" -imol $pdb -itrj $dcd > rmsd-Substrate-Bound-dry-chainA.dat
$wordom -ia rmsd --TITLE chnb  --SELE "/*/@(221-440)/CA" --FIT "/*/*/CA" -imol $pdb -itrj $dcd > rmsd-Substrate-Bound-dry-chainB.dat

$wordom -ia rmsd --TITLE lig1  --SELE "/*/@(441)/!(H*)" --FIT "/*/@(1-220|221-440)/CA" -imol $pdb -itrj $dcd > FMNH-A-Substrate-Bound-dry.dat
$wordom -ia rmsd --TITLE lig2  --SELE "/*/@(442)/!(H*)" --FIT "/*/@(1-220|221-440)/CA" -imol $pdb -itrj $dcd > IYR-A-Substrate-Bound-dry.dat
$wordom -ia rmsd --TITLE lig3  --SELE "/*/@(443)/!(H*)" --FIT "/*/@(1-220|221-440)/CA" -imol $pdb -itrj $dcd > FMNH-B-Substrate-Bound-dry.dat
$wordom -ia rmsd --TITLE lig4  --SELE "/*/@(444)/!(H*)" --FIT "/*/@(1-220|221-440)/CA" -imol $pdb -itrj $dcd > IYR-B-Substrate-Bound-dry.dat

$wordom -ia rmsd --TITLE H1A --SELE "/*/@(12-29)/CA" --FIT "/*/@(1-220|221-440)/CA" -imol $pdb -itrj $dcd > H1A-Substrate-Bound-dry.dat
$wordom -ia rmsd --TITLE H2A  --SELE "/*/@(42-54)/CA" --FIT "/*/@(1-220|221-440)/CA" -imol $pdb -itrj $dcd > H2A-Substrate-Bound-dry.dat
$wordom -ia rmsd --TITLE H3A  --SELE "/*/@(59-62)/CA" --FIT "/*/@(1-220|221-440)/CA" -imol $pdb -itrj $dcd > H3A-Substrate-Bound-dry.dat
$wordom -ia rmsd --TITLE H4A  --SELE "/*/@(73-93)/CA" --FIT "/*/@(1-220|221-440)/CA" -imol $pdb -itrj $dcd > H4A-Substrate-Bound-dry.dat
$wordom -ia rmsd --TITLE H5A  --SELE "/*/@(97-107)/CA" --FIT "/*/@(1-220|221-440)/CA" -imol $pdb -itrj $dcd > H5A-Substrate-Bound-dry.dat
$wordom -ia rmsd --TITLE H6A  --SELE "/*/@(114-118)/CA" --FIT "/*/@(1-220|221-440)/CA" -imol $pdb -itrj $dcd > H6A-Substrate-Bound-dry.dat
$wordom -ia rmsd --TITLE H7A  --SELE "/*/@(143-161)/CA" --FIT "/*/@(1-220|221-440)/CA" -imol $pdb -itrj $dcd > H7A-Substrate-Bound-dry.dat
$wordom -ia rmsd --TITLE H8A  --SELE "/*/@(173-181)/CA" --FIT "/*/@(1-220|221-440)/CA" -imol $pdb -itrj $dcd > H8A-Substrate-Bound-dry.dat

$wordom -ia rmsd --TITLE loopIA  --SELE "/*/@(30-41)/CA" --FIT "/*/@(1-220|221-440)/CA" -imol $pdb -itrj $dcd > loopIA-Substrate-Bound-dry.dat
$wordom -ia rmsd --TITLE loopIIA  --SELE "/*/@(55-58)/CA" --FIT "/*/@(1-220|221-440)/CA" -imol $pdb -itrj $dcd > loopIIA-Substrate-Bound-dry.dat
$wordom -ia rmsd --TITLE loopIIIA  --SELE "/*/@(94-96)/CA" --FIT "/*/@(1-220|221-440)/CA" -imol $pdb -itrj $dcd > loopIIIA-Substrate-Bound-dry.dat
$wordom -ia rmsd --TITLE loopIVA  --SELE "/*/@(108-113)/CA" --FIT "/*/@(1-220|221-440)/CA" -imol $pdb -itrj $dcd > loopIVA-Substrate-Bound-dry.dat
$wordom -ia rmsd --TITLE loopVA  --SELE "/*/@(162-172)/CA" --FIT "/*/@(1-220|221-440)/CA" -imol $pdb -itrj $dcd > loopVA-Substrate-Bound-dry.dat
$wordom -ia rmsd --TITLE D_loopA  --SELE "/*/@(128-142)/CA" --FIT "/*/@(1-220|221-440)/CA" -imol $pdb -itrj $dcd > D_loopA-Substrate-Bound-dry.dat
$wordom -ia rmsd --TITLE SHEET1A  --SELE "/*/@(65-70)/CA" --FIT "/*/@(1-220|221-440)/CA" -imol $pdb -itrj $dcd > SHEET1A-Substrate-Bound-dry.dat
$wordom -ia rmsd --TITLE SHEET2A  --SELE "/*/@(120-127)/CA" --FIT "/*/@(1-220|221-440)/CA" -imol $pdb -itrj $dcd > SHEET2A-Substrate-Bound-dry.dat
$wordom -ia rmsd --TITLE SHEET3A  --SELE "/*/@(187-195)/CA" --FIT "/*/@(1-220|221-440)/CA" -imol $pdb -itrj $dcd > SHEET3A-Substrate-Bound-dry.dat


$wordom -ia rmsd --TITLE H1B  --SELE "/*/@(232-249)/CA" --FIT "/*/@(1-220|221-440)/CA" -imol $pdb -itrj $dcd > H1B-Substrate-Bound-dry.dat
$wordom -ia rmsd --TITLE H2B  --SELE "/*/@(262-274)/CA" --FIT "/*/@(1-220|221-440)/CA" -imol $pdb -itrj $dcd > H2B-Substrate-Bound-dry.dat
$wordom -ia rmsd --TITLE H3B  --SELE "/*/@(279-282)/CA" --FIT "/*/@(1-220|221-440)/CA" -imol $pdb -itrj $dcd > H3B-Substrate-Bound-dry.dat
$wordom -ia rmsd --TITLE H4B  --SELE "/*/@(293-313)/CA" --FIT "/*/@(1-220|221-440)/CA" -imol $pdb -itrj $dcd > H4B-Substrate-Bound-dry.dat
$wordom -ia rmsd --TITLE H5B  --SELE "/*/@(317-327)/CA" --FIT "/*/@(1-220|221-440)/CA" -imol $pdb -itrj $dcd > H5B-Substrate-Bound-dry.dat
$wordom -ia rmsd --TITLE H6B  --SELE "/*/@(334-338)/CA" --FIT "/*/@(1-220|221-440)/CA" -imol $pdb -itrj $dcd > H6B-Substrate-Bound-dry.dat
$wordom -ia rmsd --TITLE H7B  --SELE "/*/@(363-381)/CA" --FIT "/*/@(1-220|221-440)/CA" -imol $pdb -itrj $dcd > H7B-Substrate-Bound-dry.dat
$wordom -ia rmsd --TITLE H8B  --SELE "/*/@(393-401)/CA" --FIT "/*/@(1-220|221-440)/CA" -imol $pdb -itrj $dcd > H8B-Substrate-Bound-dry.dat
$wordom -ia rmsd --TITLE SHEET1B  --SELE "/*/@(285-290)/CA" --FIT "/*/@(1-220|221-440)/CA" -imol $pdb -itrj $dcd > SHEET1B-Substrate-Bound-dry.dat
$wordom -ia rmsd --TITLE SHEET2B  --SELE "/*/@(340-347)/CA" --FIT "/*/@(1-220|221-440)/CA" -imol $pdb -itrj $dcd > SHEET2B-Substrate-Bound-dry.dat
$wordom -ia rmsd --TITLE SHEET3B  --SELE "/*/@(407-415)/CA" --FIT "/*/@(1-220|221-440)/CA" -imol $pdb -itrj $dcd > SHEET3B-Substrate-Bound-dry.dat
$wordom -ia rmsd --TITLE loopIB  --SELE "/*/@(250-261)/CA" --FIT "/*/@(1-220|221-440)/CA" -imol $pdb -itrj $dcd > loopIB-Substrate-Bound-dry.dat
$wordom -ia rmsd --TITLE loopIIB  --SELE "/*/@(275-278)/CA" --FIT "/*/@(1-220|221-440)/CA" -imol $pdb -itrj $dcd > loopIIB-Substrate-Bound-dry.dat
$wordom -ia rmsd --TITLE loopIIIB  --SELE "/*/@(314-316)/CA" --FIT "/*/@(1-220|221-440)/CA" -imol $pdb -itrj $dcd > loopIIIB-Substrate-Bound-dry.dat
$wordom -ia rmsd --TITLE loopIVB  --SELE "/*/@(328-333)/CA" --FIT "/*/@(1-220|221-440)/CA" -imol $pdb -itrj $dcd > loopIVB-Substrate-Bound-dry.dat
$wordom -ia rmsd --TITLE loopVB  --SELE "/*/@(382-392)/CA" --FIT "/*/@(1-220|221-440)/CA" -imol $pdb -itrj $dcd > loopVB-Substrate-Bound-dry.dat
$wordom -ia rmsd --TITLE D_loopB  --SELE "/*/@(348-362)/CA" --FIT "/*/@(1-220|221-440)/CA" -imol $pdb -itrj $dcd > D_loopB-Substrate-Bound-dry.dat



sed 1d rmsd-Substrate-Bound-dry-protein.dat > rmsd-Substrate-Bound-dry-protein-dup.dat
awk '{print ($1*0.05),$2}' rmsd-Substrate-Bound-dry-protein-dup.dat > rmsd-Substrate-Bound-dry-protein.dat

sed 1d rmsd-Substrate-Bound-dry-chainA.dat > rmsd-Substrate-Bound-dry-chainA-dup.dat
awk '{print ($1*0.05),$2}' rmsd-Substrate-Bound-dry-chainA-dup.dat > rmsd-Substrate-Bound-dry-chainA.dat

sed 1d rmsd-Substrate-Bound-dry-chainB.dat > rmsd-Substrate-Bound-dry-chainB-dup.dat
awk '{print ($1*0.05),$2}' rmsd-Substrate-Bound-dry-chainB-dup.dat > rmsd-Substrate-Bound-dry-chainB.dat

sed 1d FMNH-A-Substrate-Bound-dry.dat > FMNH-A-Substrate-Bound-dry-dup.dat
awk '{print ($1*0.05),$2}' FMNH-A-Substrate-Bound-dry-dup.dat > FMNH-A-Substrate-Bound-dry.dat

sed 1d IYR-A-Substrate-Bound-dry.dat > IYR-A-Substrate-Bound-dry-dup.dat
awk '{print ($1*0.05),$2}' IYR-A-Substrate-Bound-dry-dup.dat > IYR-A-Substrate-Bound-dry.dat

sed 1d FMNH-B-Substrate-Bound-dry.dat > FMNH-B-Substrate-Bound-dry-dup.dat
awk '{print ($1*0.05),$2}' FMNH-B-Substrate-Bound-dry-dup.dat > FMNH-B-Substrate-Bound-dry.dat

sed 1d IYR-B-Substrate-Bound-dry.dat > IYR-B-Substrate-Bound-dry-dup.dat
awk '{print ($1*0.05),$2}' IYR-B-Substrate-Bound-dry-dup.dat > IYR-B-Substrate-Bound-dry.dat

sed 1d H1A-Substrate-Bound-dry.dat > H1A-Substrate-Bound-dry-dup.dat
awk '{print ($1*0.05),$2}' H1A-Substrate-Bound-dry-dup.dat > H1A-Substrate-Bound-dry.dat

sed 1d H2A-Substrate-Bound-dry.dat > H2A-Substrate-Bound-dry-dup.dat
awk '{print ($1*0.05),$2}' H2A-Substrate-Bound-dry-dup.dat > H2A-Substrate-Bound-dry.dat

sed 1d H3A-Substrate-Bound-dry.dat > H3A-Substrate-Bound-dry-dup.dat
awk '{print ($1*0.05),$2}' H3A-Substrate-Bound-dry-dup.dat > H3A-Substrate-Bound-dry.dat

sed 1d H4A-Substrate-Bound-dry.dat > H4A-Substrate-Bound-dry-dup.dat
awk '{print ($1*0.05),$2}' H4A-Substrate-Bound-dry-dup.dat > H4A-Substrate-Bound-dry.dat

sed 1d H5A-Substrate-Bound-dry.dat > H5A-Substrate-Bound-dry-dup.dat
awk '{print ($1*0.05),$2}' H5A-Substrate-Bound-dry-dup.dat > H5A-Substrate-Bound-dry.dat

sed 1d H6A-Substrate-Bound-dry.dat > H6A-Substrate-Bound-dry-dup.dat
awk '{print ($1*0.05),$2}' H6A-Substrate-Bound-dry-dup.dat > H6A-Substrate-Bound-dry.dat

sed 1d H7A-Substrate-Bound-dry.dat > H7A-Substrate-Bound-dry-dup.dat
awk '{print ($1*0.05),$2}' H7A-Substrate-Bound-dry-dup.dat > H7A-Substrate-Bound-dry.dat

sed 1d H8A-Substrate-Bound-dry.dat > H8A-Substrate-Bound-dry-dup.dat
awk '{print ($1*0.05),$2}' H8A-Substrate-Bound-dry-dup.dat > H8A-Substrate-Bound-dry.dat

sed 1d loopIA-Substrate-Bound-dry.dat > loopIA-Substrate-Bound-dry-dup.dat
awk '{print ($1*0.05),$2}' loopIA-Substrate-Bound-dry-dup.dat > loopIA-Substrate-Bound-dry.dat

sed 1d loopIIA-Substrate-Bound-dry.dat > loopIIA-Substrate-Bound-dry-dup.dat
awk '{print ($1*0.05),$2}' loopIIA-Substrate-Bound-dry-dup.dat > loopIIA-Substrate-Bound-dry.dat

sed 1d loopIIIA-Substrate-Bound-dry.dat > loopIIIA-Substrate-Bound-dry-dup.dat
awk '{print ($1*0.05),$2}' loopIIIA-Substrate-Bound-dry-dup.dat > loopIIIA-Substrate-Bound-dry.dat

sed 1d loopIVA-Substrate-Bound-dry.dat > loopIVA-Substrate-Bound-dry-dup.dat
awk '{print ($1*0.05),$2}' loopIVA-Substrate-Bound-dry-dup.dat > loopIVA-Substrate-Bound-dry.dat

sed 1d loopVA-Substrate-Bound-dry.dat > loopVA-Substrate-Bound-dry-dup.dat
awk '{print ($1*0.05),$2}' loopVA-Substrate-Bound-dry-dup.dat > loopVA-Substrate-Bound-dry.dat

sed 1d D_loopA-Substrate-Bound-dry.dat > D_loopA-Substrate-Bound-dry-dup.dat
awk '{print ($1*0.05),$2}' D_loopA-Substrate-Bound-dry-dup.dat > D_loopA-Substrate-Bound-dry.dat

sed 1d SHEET1A-Substrate-Bound-dry.dat > SHEET1A-Substrate-Bound-dry-dup.dat
awk '{print ($1*0.05),$2}' SHEET1A-Substrate-Bound-dry-dup.dat > SHEET1A-Substrate-Bound-dry.dat

sed 1d SHEET2A-Substrate-Bound-dry.dat > SHEET2A-Substrate-Bound-dry-dup.dat
awk '{print ($1*0.05),$2}' SHEET2A-Substrate-Bound-dry-dup.dat > SHEET2A-Substrate-Bound-dry.dat

sed 1d SHEET3A-Substrate-Bound-dry.dat > SHEET3A-Substrate-Bound-dry-dup.dat
awk '{print ($1*0.05),$2}' SHEET3A-Substrate-Bound-dry-dup.dat > SHEET3A-Substrate-Bound-dry.dat

sed 1d H1B-Substrate-Bound-dry.dat > H1B-Substrate-Bound-dry-dup.dat
awk '{print ($1*0.05),$2}' H1B-Substrate-Bound-dry-dup.dat > H1B-Substrate-Bound-dry.dat

sed 1d H2B-Substrate-Bound-dry.dat > H2B-Substrate-Bound-dry-dup.dat
awk '{print ($1*0.05),$2}' H2B-Substrate-Bound-dry-dup.dat > H2B-Substrate-Bound-dry.dat

sed 1d H3B-Substrate-Bound-dry.dat > H3B-Substrate-Bound-dry-dup.dat
awk '{print ($1*0.05),$2}' H3B-Substrate-Bound-dry-dup.dat > H3B-Substrate-Bound-dry.dat

sed 1d H4B-Substrate-Bound-dry.dat > H4B-Substrate-Bound-dry-dup.dat
awk '{print ($1*0.05),$2}' H4B-Substrate-Bound-dry-dup.dat > H4B-Substrate-Bound-dry.dat

sed 1d H5B-Substrate-Bound-dry.dat > H5B-Substrate-Bound-dry-dup.dat
awk '{print ($1*0.05),$2}' H5B-Substrate-Bound-dry-dup.dat > H5B-Substrate-Bound-dry.dat

sed 1d H6B-Substrate-Bound-dry.dat > H6B-Substrate-Bound-dry-dup.dat
awk '{print ($1*0.05),$2}' H6B-Substrate-Bound-dry-dup.dat > H6B-Substrate-Bound-dry.dat

sed 1d H7B-Substrate-Bound-dry.dat > H7B-Substrate-Bound-dry-dup.dat
awk '{print ($1*0.05),$2}' H7B-Substrate-Bound-dry-dup.dat > H7B-Substrate-Bound-dry.dat

sed 1d H8B-Substrate-Bound-dry.dat > H8B-Substrate-Bound-dry-dup.dat
awk '{print ($1*0.05),$2}' H8B-Substrate-Bound-dry-dup.dat > H8B-Substrate-Bound-dry.dat

sed 1d SHEET1B-Substrate-Bound-dry.dat > SHEET1B-Substrate-Bound-dry-dup.dat
awk '{print ($1*0.05),$2}' SHEET1B-Substrate-Bound-dry-dup.dat > SHEET1B-Substrate-Bound-dry.dat

sed 1d SHEET2B-Substrate-Bound-dry.dat > SHEET2B-Substrate-Bound-dry-dup.dat
awk '{print ($1*0.05),$2}' SHEET2B-Substrate-Bound-dry-dup.dat > SHEET2B-Substrate-Bound-dry.dat

sed 1d SHEET3B-Substrate-Bound-dry.dat > SHEET3B-Substrate-Bound-dry-dup.dat
awk '{print ($1*0.05),$2}' SHEET3B-Substrate-Bound-dry-dup.dat > SHEET3B-Substrate-Bound-dry.dat

sed 1d loopIB-Substrate-Bound-dry.dat > loopIB-Substrate-Bound-dry-dup.dat
awk '{print ($1*0.05),$2}' loopIB-Substrate-Bound-dry-dup.dat > loopIB-Substrate-Bound-dry.dat

sed 1d loopIIB-Substrate-Bound-dry.dat > loopIIB-Substrate-Bound-dry-dup.dat
awk '{print ($1*0.05),$2}' loopIIB-Substrate-Bound-dry-dup.dat > loopIIB-Substrate-Bound-dry.dat

sed 1d loopIIIB-Substrate-Bound-dry.dat > loopIIIB-Substrate-Bound-dry-dup.dat
awk '{print ($1*0.05),$2}' loopIIIB-Substrate-Bound-dry-dup.dat > loopIIIB-Substrate-Bound-dry.da

sed 1d loopIVB-Substrate-Bound-dry.dat > loopIVB-Substrate-Bound-dry-dup.dat
awk '{print ($1*0.05),$2}' loopIVB-Substrate-Bound-dry-dup.dat > loopIVB-Substrate-Bound-dry.dat

sed 1d loopVB-Substrate-Bound-dry.dat > loopVB-Substrate-Bound-dry-dup.dat
awk '{print ($1*0.05),$2}' loopVB-Substrate-Bound-dry-dup.dat > loopVB-Substrate-Bound-dry.dat

sed 1d D_loopB-Substrate-Bound-dry.dat > D_loopB-Substrate-Bound-dry-dup.dat
awk '{print ($1*0.05),$2}' D_loopB-Substrate-Bound-dry-dup.dat > D_loopB-Substrate-Bound-dry.dat




#module load apps/gromacs/2020/cpu
grep -v 'EP' first-frame-dry.pdb > first-frame-dry-new.pdb
gmx_mpi rmsf -f Substrate-Bound-dry.xtc -s first-frame-dry-new.pdb -o BB-Substrate-Bound-dry-rmsf.xvg -res

gawk 'NR>=18 && NR<=237' BB-Substrate-Bound-dry-rmsf.xvg > BB-Substrate-Bound-dry-chainA-rmsf.dat
gawk 'NR>=238 && NR<=457' BB-Substrate-Bound-dry-rmsf.xvg > BB-Substrate-Bound-dry-chainB-rmsf.dat

paste BB-Substrate-Bound-dry-chainA-rmsf.dat BB-Substrate-Bound-dry-rmsf.dat > BB-Substrate-Bound-dry-rmsf.dat

rm  Substrate-Bound-dry.xtc BB-Substrate-Bound-dry-chainA-rmsf.dat first-frame-dry-new.pdb BB-Substrate-Bound-dry-chainB-rmsf.dat BB-Substrate-Bound-dry-rmsf.xvg *-dup.dat
rm *-dup.dat
rm '#BB-4ttc-FMNH-IYR-rmsf.xvg.1#'
