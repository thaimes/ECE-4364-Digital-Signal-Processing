clear;
clc;
close all;

%% Continuous-Time Fourier Transform (FT)
% Example: Rectangular Pulse (Time-Limited Signal)

t = -5:0.01:5;
t1 = -25:0.01:25;
x = double(abs(t) <= 0.5).*1; % Rectangular pulse of width 1 centered at 0
x1 = double(abs(t1) <= 0.5).*1;

% Compute Fourier Transform using numerical integration
omega = linspace(-25, 25, 1000);
X = zeros(size(omega));
for k = 1:length(omega)
    X(k) = trapz(t, x .* exp(-1j*omega(k)*t));
end

figure(1);
plot(t, x, 'b', 'LineWidth', 1.2);
title('Rectangular Pulse in the Time Domain of Width 1');
xlabel('t');
ylabel('Amplitude');
grid on;

figure(2);
plot(omega, X, 'r', 'LineWidth', 1.2);
title('Fourier Transform (Magnitude Response) of Rectangular Pulse');
xlabel('\omega');
ylabel('X(\omega)');
grid on;

figure(3);
plot(omega, angle(X), 'r', 'LineWidth', 1.2);
title('Fourier Transform (Phase Response) of Rectangular Pulse');
xlabel('\omega');
ylabel('X(\omega)');
grid on;

figure(4);
plot(omega, X, 'r', 'LineWidth', 1.2);
hold on;
plot(t1, x1, 'b', 'LineWidth', 1.2);
hold off;
title('Fourier Transform of Rectangular Pulse');
legend('"Continuous" Time Fourier Transform', 'Original Rectangular Pulse');
xlabel('\omega');
ylabel('|X(\omega)|');
grid on;


%% Fourier Series (FS)
% Example: 0 to 1 Square Wave Approximation using Odd Harmonics

T = 2*pi;
t = linspace(-T, T, 1000);

x = 0.5 * (square(t) + 1); % Original square wave in [0, 1]

N = 10; % Number of harmonics
x_FS = 0.5 * ones(size(t));  % Start with DC term (a0 = 0.5)

% Build the Fourier series approximation (sine terms only)
for k = 1:N
    n = 2*k - 1;
    bn = (2 / (pi * n));  % Correct for 0-1 square wave
    x_FS = x_FS + bn * sin(n * t);
end

figure(4);
plot(t, x, 'b', 'LineWidth', 1.2);
title('0 to 1 Square Wave');
xlabel('t'); 
ylabel('x(t)');
grid on;
axis padded;

figure(5);
plot(t, x_FS, 'r', 'LineWidth', 1.2);
title(['Fourier Series Approx. of 0 to 1 Square Wave (N = ' num2str(N) ' terms)']);
xlabel('\Omega'); 
ylabel('X(\Omega)');
grid on;

figure(6);
plot(t, x_FS, 'r', 'LineWidth', 1.2);
hold on;
plot(t, x, 'b', 'LineWidth', 1.2);
hold off;
title(['Fourier Series Approx. of 0–1 Square Wave (N = ' num2str(N) ' terms)']);
legend( 'Fourier Series Approximation', 'Original Square Wave');
xlabel('t or \Omega'); 
ylabel('x(t) or X(t)');
grid on;
axis padded;


%% Discrete-Time Fourier Transform (DTFT)
% Example: Finite-length signal


% Creates the chirp sound sequence that exists over t and starts at 200 Hz
% and ends at 1200 Hz at t_f = 1 s
chirp_seq = chirp(t,f_0, t_f, f_f);

% Computes the DTFT of the various partitions with zero padding
seq_DTFT = fft(chirp_seq); % FFT with zero padding
phase = angle(seq_DTFT);
phase(abs(seq_DTFT) < 1) = 0;

% Computes a new normalized angular frequency axis 
x_axis = linspace(-pi, pi, length(seq_DTFT));

% Plots each of the graphs for each "sum limits"
figure(7);
subplot(3, 1, 2);
plot(x_axis, abs(seq_DTFT), 'b', 'LineWidth', 1.2);
ylabel('|X(\omega)|')
xlabel('Normalized Angular Frequency (\omega) (rads/sample)')
title("Magnitude Response for the Chirp Signal");
grid on;

subplot(3, 1, 3);
plot(x_axis, phase, 'b', 'LineWidth', 1.2);
ylabel('∠X(\omega) (Phase in radians)');
xlabel('Normalized Angular Frequency (\omega) (rads/sample)')
title("Phase Response for the Chirp Signal");
grid on;




%% Discrete Fourier Transform (DFT)
% Example: Same signal as DTFT, now sampled in frequency

x = [1 2 3 4 3 2 1];
N = length(x);
X = fft(x); % DFT using FFT

k = 0:N-1;
omega_k = 2*pi*k/N;

figure(8);
stem(omega_k, abs(X));
title('DFT Magnitude Spectrum');
xlabel('\omega_k');
ylabel('|X[k]|');
grid on;