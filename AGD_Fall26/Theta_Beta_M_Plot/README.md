# Oblique Shock Theta-Beta-Mach Solver

This project contains a numerical solver and MATLAB plotting tool to generate $\theta-\beta-M$ oblique shock curves for compressible flow ($\gamma = 1.4$). 

## Files Included
* `theta_beta_m_relation.cpp`: Core C++ script that calculates the analytical shock relations and exports the data.
* `theta_beta_mach.csv`: The generated dataset containing $M_1$, $\beta$, $\theta$, and $M_2$ values for upstream Mach numbers ranging from 1.1 to 15.0.
* `theta_beta_m_2.m`: MATLAB script that reads the CSV data to plot the constant-Mach contours, including the detachment boundary ($\theta_{max}$) and the sonic boundary ($M_2 = 1$).

## How to Run
1. **Generate Data:** Compile and execute the C++ file from your terminal:
   ```bash
   g++ theta_beta_m_relation.cpp -o solver
   ./solver

## RESULT:
![alt text](<Theta-Beta-Mach Curves-1.png>)

The plot visualizes the standard oblique shock wave relations for compressible flow. It charts the shock angle ($\beta$) on the y-axis against the flow deflection angle ($\theta$) on the x-axis across a range of upstream Mach numbers. 

Key features highlighted in the plot include:
* **Detachment Boundary ($\theta_{max}$ Locus):** Represented by the green dashed line, this indicates the maximum possible deflection angle for an attached shock at a given Mach number.
* **Sonic Boundary ($M_2 = 1$ Locus):** Represented by the red dashed line, this denotes where the downstream flow reaches exactly Mach 1, separating the strong shock and weak shock solutions.
