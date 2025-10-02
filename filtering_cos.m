clear

Fs = 8000;

f0 = 400;
f1 = 1000;

t = 0:1/Fs:2;

x = cos(2*pi*f0*t) + cos(2*pi*f1*t+pi/3);

figure(1)
plot(t,x)
xlabel("time")

% filter impulse response import
load LP_kaiser.mat

% All frequency values are in Hz.
N    = 50;       % Order
Fc   = 700;      % Cutoff Frequency
flag = 'scale';  % Sampling Flag
Beta = 5;        % Window Parameter

% Create the window vector for the design algorithm.
win = kaiser(N+1, Beta);

% Calculate the coefficients using the FIR1 function.
h  = fir1(N, Fc/(Fs/2), 'low', win, flag);

y = conv(h, x)

hold on
plot(t, y(1:length(t)))
hold off
