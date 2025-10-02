% Thomas Haimes
% Homework 11
% 5/3/25

clc
close all

% A.
load("HW11.mat", "SOS", "G")  % Import .mat file so coefficients come too

% B.
Fs = 8000;
nfft = 2048;
f = linspace(-Fs/2, Fs/2, nfft);


%% 4 second-order sections

% SOS 1
b1 = SOS(1, 1:3) * G(1);
a1 = SOS(1, 4:6);
[H1, ~] = freqz(b1, a1, nfft, "whole");
H1 = fftshift(H1);

% SOS 2
b2 = SOS(2, 1:3) * G(2);
a2 = SOS(2, 4:6);
[H2, ~] = freqz(b2, a2, nfft, "whole");
H2 = fftshift(H2);

% SOS 3
b3 = SOS(3, 1:3) * G(3);
a3 = SOS(3, 4:6);
[H3, ~] = freqz(b3, a3, nfft, "whole");
H3 = fftshift(H3);

% SOS 4
b4 = SOS(4, 1:3) * G(4);
a4 = SOS(4, 4:6);
[H4, ~] = freqz(b4, a4, nfft, "whole");
H4 = fftshift(H4);

% Plotting all 4 SOS frequency responses
figure

% Magnitude
subplot(4,2,1)
plot(f, 20*log10(abs(H1)))
title('Magnitude - SOS 1')
xlabel('Frequency (Hz)')
ylabel('Magnitude (dB)')
grid on

subplot(4,2,3)
plot(f, 20*log10(abs(H2)))
title('Magnitude - SOS 2')
xlabel('Frequency (Hz)')
ylabel('Magnitude (dB)')
grid on

subplot(4,2,5)
plot(f, 20*log10(abs(H3)))
title('Magnitude - SOS 3')
xlabel('Frequency (Hz)')
ylabel('Magnitude (dB)')
grid on

subplot(4,2,7)
plot(f, 20*log10(abs(H4)))
title('Magnitude - SOS 4')
xlabel('Frequency (Hz)')
ylabel('Magnitude (dB)')
grid on

% Phase
subplot(4,2,2)
plot(f, unwrap(angle(H1)))
title('Phase - SOS 1')
xlabel('Frequency (Hz)')
ylabel('Phase (rads)')
grid on

subplot(4,2,4)
plot(f, unwrap(angle(H2)))
title('Phase - SOS 2')
xlabel('Frequency (Hz)')
ylabel('Phase (rads)')
grid on

subplot(4,2,6)
plot(f, unwrap(angle(H3)))
title('Phase - SOS 3')
xlabel('Frequency (Hz)')
ylabel('Phase (rads)')
grid on

subplot(4,2,8)
plot(f, unwrap(angle(H4)))
title('Phase - SOS 4')
xlabel('Frequency (Hz)')
ylabel('Phase (rads)')
grid on

% Frequency response of whole signal
H_total = H1 .* H2 .* H3 .* H4; % Multiply SOS responses for full signal

figure
subplot(2,1,1)
plot(f, 20*log10(abs(H_total)))
title('Overall Magnitude Response')
xlabel('Frequency (Hz)')
ylabel('Magnitude (dB)')
grid on

subplot(2,1,2)
plot(f, unwrap(angle(H_total)))
title('Overall Phase Response')
xlabel('Frequency (Hz)')
ylabel('Phase (radians)')
grid on

%% C.

% Creating chirp signal
% Fs still 8000
t = 0:1/Fs:3.5;         % 3.5 second time vector
f0 = 10;                % Starting frequnecy
f1 = 3500;              % Ending frequency

y = chirp(t, f0, 3.5, f1, 'linear');

% Filtering chirp signal
% Can also be done using sosfilt() and SOS
% Instead here I cascade the filter thru the SOS matrix
x1 = filter(b1, a1, y);  % Apply SOS 1
x2 = filter(b2, a2, x1);  % Apply SOS 2
x3 = filter(b3, a3, x2);  % Apply SOS 3
x4 = filter(b4, a4, x3);  % Apply SOS 4

% PSD of filtered chirp
% nfft still 2048
X = fftshift(fft(x, nfft));
% f still same

% PSD stuff
psd = abs(X).^2;

figure
plot(f, 10*log10(psd))
title('Power Spectral Density of Filtered Chirp Signal')
xlabel('Frequency (Hz)')
ylabel('Power (dB)')
grid on

%% D.

%% E.

%% F.

%% G.

%% H.

%% I.