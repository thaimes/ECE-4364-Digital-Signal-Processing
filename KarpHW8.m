close all
clc

x1 = [2, -1, 3, -2]  % starts at n = -1
x2 = [-1, -4, 1, -2] % starts at n = -3

y = conv(x1, x2)

ny = -4:-4+length(y)-1
stem(ny, y)

y = ifft(fft(x1,8).*fft(x2,8))

n1 = -1:2;
omega = -pi:pi/1000:pi;
X1 = zeros(size(omega))

for n = 1:length(n1)
    X1 = X1+x1(n)*exp(-1j*n1(n)*omega);
end

figure(2)
subplot(211)
plot(omega, abs(X1))

subplot(212)
plot(omega, angle(X1))