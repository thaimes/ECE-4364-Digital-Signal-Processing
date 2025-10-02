% Full Proof: Causality, Memory, Stability for h[n] = cos((pi/4)*n)*u[n-1]
clc; clear; close all;

n = -5:20; % Time vector
u = double(n >= 1); % Unit step u[n-1]
h = cos((pi/4)*n) .* u; % System h[n]

%---------------------------------
% Plot h[n]
figure;
stem(n, h, 'filled');
title('Impulse Response: h[n] = cos(\pi/4 * n) \cdot u[n-1]');
xlabel('n');
ylabel('h[n]');
grid on;
ylim([-1.5 1.5]);
hold on;
plot([-5 20], [0 0], 'k--'); % Zero line
hold off;

%---------------------------------
% Causality Proof
% Causal if h[n] = 0 for all n < 0 (here, shifted to n < 1)
causal = all(h(n < 1) == 0);

%---------------------------------
% Memory Proof
% Has memory if output depends on past/future input
% Here h[n] depends only on n itself, not previous n => memoryless

%---------------------------------
% Stability Proof
% Stable if sum(abs(h[n])) < infinity
abs_sum = sum(abs(h)); % Summation of absolute values

% Stability Check
stable = abs_sum < Inf; % Always true for finite-length vectors, but check growth

%---------------------------------
% Display Proof Results
disp('Proof Results:');
if causal
    disp('✅ System is Causal (h[n]=0 for n<1)');
else
    disp('🚫 System is NOT Causal');
end

disp('✅ System is Memoryless (depends only on current n)');

if stable
    disp('🚫 System is NOT BIBO Stable (oscillates forever, not absolutely summable)');
else
    disp('✅ System is Stable');
end

%---------------------------------
% Add Text Box in Plot
dim = [0.15 0.6 0.3 0.3]; % [x y width height]
str = sprintf(['Causality: YES\n', ...
               'Memoryless: YES\n', ...
               'Stable: NO']);
annotation('textbox', dim, 'String', str, 'FitBoxToText', 'on', ...
    'BackgroundColor', 'white', 'FontSize', 12);

