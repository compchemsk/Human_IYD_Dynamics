import numpy as np

eigenvalues = []

with open("eigenval.xvg", "r") as f:
    for line in f:
        if line.startswith("#") or line.startswith("@"):
            continue
        parts = line.split()
        if len(parts) == 2:
            eigenvalues.append(float(parts[1]))

# Convert to numpy array
eigenvalues = np.array(eigenvalues)

# Total variance
total = np.sum(eigenvalues)

# Percentage contribution
percent = (eigenvalues / total) * 100

# Cumulative contribution
cumulative = np.cumsum(percent)

# Print results
print(f"{'PC':<5}{'Eigenvalue':<15}{'% Contribution':<20}{'Cumulative %'}")
for i, (eig, p, c) in enumerate(zip(eigenvalues, percent, cumulative), start=1):
    print(f"{i:<5}{eig:<15.6f}{p:<20.2f}{c:.2f}")