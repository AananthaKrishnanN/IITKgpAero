% theta_beta_mach_plotter.m
clear; clc; close all;

%% 1. Read the Data
disp('Loading CSV data...');
data = readtable('theta_beta_mach.csv');
mach_numbers = unique(data.M1);
num_lines = length(mach_numbers);

%% 2. Setup the Figure & Colors
figure('Name', 'Theta-Beta-Mach Curves', 'Color', 'white', 'Position', [100, 100, 800, 600]);
hold on; grid on; grid minor; box on;

color_start = [1.00, 0.70, 0.10]; 
color_end   = [0.55, 0.15, 0.00]; 
colors = [linspace(color_start(1), color_end(1), num_lines)', ...
          linspace(color_start(2), color_end(2), num_lines)', ...
          linspace(color_start(3), color_end(3), num_lines)'];

%% 3. Plot Curves and Find Loci
theta_max_arr = zeros(1, num_lines);
beta_max_arr  = zeros(1, num_lines);
theta_sonic_arr = [];
beta_sonic_arr  = [];

for i = 1:num_lines
    M = mach_numbers(i);
    idx = (data.M1 == M);
    
    theta = data.Theta_deg(idx);
    beta  = data.Beta_deg(idx);
    M2    = data.M2(idx);
    
    % Plot the main orange gradient curve
    plot(theta, beta, 'LineWidth', 2.5, 'Color', colors(i,:), 'HandleVisibility', 'off');
    
    % --- Theta Max ---
    [t_max, max_idx] = max(theta);
    theta_max_arr(i) = t_max;
    beta_max_arr(i)  = beta(max_idx);
    
    % --- M2 = 1 ---
    [M2_unique, uniq_idx] = unique(M2);
    beta_unique = beta(uniq_idx);
    
    if length(M2_unique) >= 2 && min(M2_unique) <= 1.0 && max(M2_unique) >= 1.0
        b_sonic = interp1(M2_unique, beta_unique, 1.0, 'linear');
        t_sonic = interp1(beta, theta, b_sonic, 'linear');
        
        theta_sonic_arr(end+1) = t_sonic;
        beta_sonic_arr(end+1)  = b_sonic;
    end
end
%% 4. Plot the Boundary Locus Lines
plot(theta_max_arr, beta_max_arr, '--g', 'LineWidth', 2.5, 'DisplayName', '\theta_{max} Locus (Detachment Boundary)');

plot(theta_sonic_arr, beta_sonic_arr, '--r', 'LineWidth', 2.5, 'DisplayName', 'M_2 = 1 Locus (Sonic Boundary)');

%% 5. Formatting and Labels
ax = gca;
ax.XColor = 'k';
ax.YColor = 'k';

title('Oblique Shock Wave \theta-\beta-M Relation', 'FontSize', 14, 'FontWeight', 'bold', 'Color', 'k');
xlabel('Deflection Angle, \theta (Degrees)', 'FontSize', 12, 'FontWeight', 'bold', 'Color', 'k');
ylabel('Shock Angle, \beta (Degrees)', 'FontSize', 12, 'FontWeight', 'bold', 'Color', 'k');

xlim([0 50]); 
ylim([0 90]);

lgd = legend('Location', 'northwest', 'FontSize', 11);

yline(90, ':k', 'Normal Shock (\beta = 90^\circ)', 'LabelHorizontalAlignment', 'center', 'HandleVisibility', 'off');

hold off;
disp('Plot generated successfully.');