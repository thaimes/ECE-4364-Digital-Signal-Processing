% Thomas Haimes
% Homework 3 Question 4b
% 2/8/25

clear

% Signal Properties
Ts = 1/100;
Omega = -pi:pi/10000:pi;

n1 = -10:10;
n2 = -100:100;
n3 = -1000:1000;

% Calculate S(Omega#) for n# = [-10,10]
%                            = [-100, 100]
%                            = [-1000, 1000]
S_Omega1 = zeros(size(Omega));
for k = 1:length(n1)
    S_Omega1 = S_Omega1 + exp(-1i *n1(k) * Ts * Omega);
end

S_Omega2 = zeros(size(Omega));
for k = 1:length(n2)
    S_Omega2 = S_Omega2 + exp(-1i *n2(k) * Ts * Omega);
end

S_Omega3 = zeros(size(Omega));
for k = 1:length(n3)
    S_Omega3 = S_Omega3 + exp(-1i *n3(k) * Ts * Omega);
end

% Plots

figure;
subplot(311);
plot(Omega, abs(S_Omega1));
title("S(\Omega) w/ n1 = [-10, 10]");
xlabel("\Omega");
ylabel("Magnitude of S(\Omega)");
xlim([-pi pi]);
ylim([0, max(abs(S_Omega1)) * 1.1]);
grid on;

subplot(312);
plot(Omega, abs(S_Omega2));
title("S(\Omega) w/ n2 = [-100, 100]");
xlabel("\Omega");
ylabel("Magnitude of S(\Omega)");
xlim([-pi pi]);
grid on;

subplot(313);
plot(Omega, abs(S_Omega3));
title("S(\Omega) w/ n2 = [-1000, 1000]");
xlabel("\Omega");
ylabel("Magnitude of S(\Omega)");
xlim([-pi pi]);
grid on;