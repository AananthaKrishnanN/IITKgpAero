#include <iostream>
#include <cmath>
#include <fstream>
#include <vector>
#include <iomanip>

using namespace std;

const double GAMMA = 1.4;
const double PI = acos(-1.0);

double deg2rad(double degrees) { return degrees * (PI / 180.0); }
double rad2deg(double radians) { return radians * (180.0 / PI); }

// Calculate Deflection Angle (Theta)
double calculate_theta(double M1, double beta_rad) {
    if (abs(beta_rad - (PI / 2.0)) < 1e-6) return 0.0;
    
    double cot_beta = cos(beta_rad) / sin(beta_rad);
    
    double num = (M1 * M1 * pow(sin(beta_rad), 2)) - 1.0;
    double den = (M1 * M1 * (GAMMA + cos(2.0 * beta_rad))) + 2.0;

    return atan(2.0 * cot_beta * (num / den));
}

// Calculate Downstream Mach Number (M2)
double calculate_M2(double M1, double beta_rad, double theta_rad) {
    double Mn1 = M1 * sin(beta_rad);
    double Mn1_sq = Mn1 * Mn1;

    double num = 1.0 + ((GAMMA - 1.0) / 2.0) * Mn1_sq;
    double den = GAMMA * Mn1_sq - ((GAMMA - 1.0) / 2.0);

    if (den <= 0.0 || (num / den) < 0.0) return 0.0;

    double Mn2 = sqrt(num / den);
    double denom = sin(beta_rad - theta_rad);

    if (abs(denom) < 1e-6) return 0.0;
    return Mn2 / denom;
}

// Generate CSV
void generate_csv() {
    ofstream file("theta_beta_mach.csv");
    file << "M1,Beta_deg,Theta_deg,M2\n";

    vector<double> mach_numbers = {1.1, 1.2, 1.3, 1.4, 1.5, 1.6, 1.7, 1.8, 1.9, 2.0, 2.3, 2.5, 2.8, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 10.0, 15.0};

    for (double M1 : mach_numbers) {
        double mu_deg = rad2deg(asin(1.0 / M1));

        for (double beta_deg = mu_deg; beta_deg <= 90.0; beta_deg += 0.5) {
            double beta_rad = deg2rad(beta_deg);

            double theta_rad = calculate_theta(M1, beta_rad);
            double theta_deg = rad2deg(theta_rad);

            if (theta_deg < 0.0) theta_deg = 0.0;

            double M2 = calculate_M2(M1, beta_rad, theta_rad);

            file << fixed << setprecision(4)
                 << M1 << "," << beta_deg << "," << theta_deg << "," << M2 << "\n";
        }
    }
    file.close();
    cout << "'theta_beta_mach.csv' has been generated." << endl;
}

int main() {
    generate_csv();
    return 0;
}