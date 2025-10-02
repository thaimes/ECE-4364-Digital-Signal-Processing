clear

N = 10000;
n = 0:N-1;

% white noise
xn = 0.1*randn(1, N);

% sinusoid
xc = 0.1*cos(pi/4*n);

figure(1)
subplot(211)
stem(n, xn+xc)

% calculate FFT
Xn = fft(xn+xc);

subplot(212)
stem(0:N-1, abs(Xn).^2)