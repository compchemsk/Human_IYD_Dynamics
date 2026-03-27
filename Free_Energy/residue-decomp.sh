grep -A999999 "DELTAS" FINAL_DECOMP_MMPBSA.dat > DELTAS.dat
sed -i '1,4d' DELTAS.dat
sed -i 's/,/ /g' DELTAS.dat
head -n -5 DELTAS.dat > temp && mv temp DELTAS.dat
echo 'import pandas as pd
import matplotlib.pyplot as plt

# Load the file (adjust filename accordingly)
filename = "DELTAS.dat"

# Since the file has no column names, define them manually
colnames = [
    "Residue", "Residue_ID", "Internal_Avg", "Internal_Std", "Internal_SEM", "Internal_Avg2", "Internal_Std2", "Internal_SEM2",
    "vdw_Avg", "vdw_Std", "vdw_SEM",
    "elec_Avg", "elec_Std", "elec_SEM",
    "pol_Avg", "pol_Std", "pol_SEM",
    "nonpol_Avg", "nonpol_Std", "nonpol_SEM",
    "total_Avg", "total_Std", "total_SEM"
]

# Read file (no headers, so assign manually)
df = pd.read_csv(filename, names=colnames, delim_whitespace=True)

# Ensure Residue_ID is numeric
df["Residue_ID"] = pd.to_numeric(df["Residue_ID"], errors="coerce")
df = df.dropna(subset=["Residue_ID"])
df["Residue_ID"] = df["Residue_ID"].astype(int)

# Adjust labels using Residue (name) and Residue_ID
labels = []
for res, rid in zip(df["Residue"].astype(str), df["Residue_ID"]):
    if 1 <= rid <= 220:
        labels.append(res + str(rid + 70))
    elif 221 <= rid <= 440:
        labels.append(res + str(rid - 150) + "*")
    else:
        labels.append(res + str(rid))

df["Label"] = labels

# Sort residues by total energy (Avg.), pick top 10 most negative
sorted_df = df.sort_values(by="total_Avg").head(10)

# Select values
van_der_waals = sorted_df["vdw_Avg"].values
electrostatic = sorted_df["elec_Avg"].values
polar_solv = sorted_df["pol_Avg"].values

# Plot grouped bar chart
x = range(len(sorted_df))
width = 0.25

plt.figure(figsize=(12,6))
plt.bar([i - width for i in x], van_der_waals, width, color="black", label="van der Waals")
plt.bar(x, electrostatic, width, color="red", label="Electrostatic")
plt.bar([i + width for i in x], polar_solv, width, color="green", label="Polar Solvation")

plt.xticks(x, sorted_df["Label"], rotation=45, fontsize=22)
plt.yticks(fontsize=22)
plt.xlabel("Residues", fontsize=24, fontweight="bold")
plt.ylabel("Energy (kcal/mol)", fontsize=24, fontweight="bold")
plt.ylim(-100,100)
plt.legend(frameon=False,fontsize=18)
plt.tight_layout()
plt.show()
' > mmpbsa-plot.py
python mmpbsa-plot.py
