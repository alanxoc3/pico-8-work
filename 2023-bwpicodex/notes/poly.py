import numpy as np
import sys

# Sample points
points = []
for v in sys.argv[1:]:
  points.append((float(v.split(",")[0]), float(v.split(",")[1])))

x = [z[0] for z in points]
y = [z[1] for z in points]

# Find polynomial coefficients
coefficients = np.polyfit(x, y, len(points)-1)
for c in coefficients:
  print(f"{c:.2f}")
print(coefficients)

# Create the polynomial function
# -- polynomial_function = np.poly1d(coefficients)
