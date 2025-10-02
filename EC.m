% Clear and reset
clear
clc
close all


n = -20:20;
x = cos(pi * n / 10);   % Finite-length cosine

figure
stem(n, x)
title('Finite Length Cosine Sequence')
xlabel('n')
ylabel('x[n]')
grid on

N = 256;
X = fft(x, N);
omega = linspace(-pi, pi, N);

figure
subplot(2,2,[1,2])
plot(omega, X)
title("FFT of Cosine Sequence")
xlabel("\omega")
ylabel("X[k]")
grid on

subplot(2,2,3)
plot(omega, abs(X))
title('Magnitude of FFT')
xlabel('\omega')
ylabel('|X[k]|')
grid on

subplot(2,2,4)
plot(omega, angle(X))
title("Phase of FFT")
xlabel('\omega')
ylabel('∠X[k]')
grid on
