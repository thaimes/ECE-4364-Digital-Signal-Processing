% Thomas Haimes
% 2/16/25
% Homework 4

clear 
close all 


% PART B 
Fs = 8000;           % Sampling frequency
t = 0:1/Fs:1-1/Fs;   % Time vector
f0 = 200;            % Initial frequency
f1 = 1200;           % Final frequency

omega = linspace(-pi, pi, Fs);
omega2 = linspace(-pi, pi, Fs/2);

y = chirp(t, f0, 1, f1, "linear"); % Chirp function

%audiowrite("discrete_chrip.wav", y, Fs); % WAV file creation


% Graphs
figure;
subplot(2,1,1)
plot(t, abs(y));
xlabel("Time (s)");
ylabel("Magnitude");
title("Magnitude of Chirp");

subplot(2,1,2)
plot(t, angle(y));
xlabel("Time (s)");
ylabel("Phase");
title("Phase of Chirp");

% PART C

N = length(y);
Y = fft(y);                % FFT
f = (-N/2:N/2-1)*(Fs/N);   % Frequency axis

figure;

subplot(2,1,1);
plot(f, abs(fftshift(Y)));
%xlim([200 1200]);
xlabel("Frequency (Hz)");
ylabel("Magnitude");
title("Magnitude of Chirp Signal");

subplot(2,1,2);
plot(f, angle(fftshift(Y)));
%xlim([200 1200]);
xlabel("Frequency (Hz)");
ylabel("Phase");
title("Phase of Chirp Signal");

figure;

subplot(2,1,1);
plot(omega, abs(fftshift(Y)));
%xlim([200 1200]);
xlabel("\omega");
ylabel("Magnitude");
title("Magnitude of Chirp Signal");

subplot(2,1,2);
plot(omega, angle(fftshift(Y)));
%xlim([200 1200]);
xlabel("\omega");
ylabel("Phase");
title("Phase of Chirp Signal");
% DTFT AT DIFFERENT SEGMENTS

y1 = y(1:4000);        % First 0.5 seconds
y2 = y(2001:6000); % Middle 0.5 seconds
y3 = y(4001:8000);       % Last 0.5 seconds

% FFT

Y1 = fft(y1);
Y2 = fft(y2);
Y3 = fft(y3);

f1 = (-length(Y1)/2:length(Y1)/2-1)*(Fs/length(Y1));
f2 = (-length(Y2)/2:length(Y2)/2-1)*(Fs/length(Y2));
f3 = (-length(Y3)/2:length(Y3)/2-1)*(Fs/length(Y3));

% Plots

figure;

subplot(3,1,1);
plot(omega2, abs(fftshift(Y1)));
%xlim([200 1200]);
xlabel("\omega");
ylabel("Magnitude");
title("Magnitude of First 0.5 Seconds");

subplot(3,1,2);
plot(omega2, abs(fftshift(Y2)));
%xlim([200 1200]);
xlabel("\omega");
ylabel("Magnitude");
title("Magnitude of Middle 0.5 Seconds");

subplot(3,1,3);
plot(omega2, abs(fftshift(Y3)));
%xlim([200 1200]);
xlabel("\omega");
ylabel("Magnitude");
title("Magnitude of Last 0.5 Seconds");

figure;

subplot(3,1,1);
plot(omega2, angle(fftshift(Y1)));
%xlim([200 1200]);
xlabel("\omega");
ylabel("Phase");
title("Phase of First 0.5 Seconds");

subplot(3,1,2);
plot(omega2, angle(fftshift(Y2)));
%xlim([200 1200]);
xlabel("\omega");
ylabel("Phase");
title("Phase of Middle 0.5 Seconds");

subplot(3,1,3);
plot(omega2, angle(fftshift(Y3)));
%xlim([200 1200]);
xlabel("\omega");
ylabel("Phase");
title("Phase of Last 0.5 Seconds");

% PART D

figure;

subplot(3,1,1);
plot(f1, abs(fftshift(Y1)));
%xlim([200 1200]);
xlabel("Frequency (Hz)");
ylabel("Magnitude");
title("Magnitude of First 0.5 Seconds");

subplot(3,1,2);
plot(f2, abs(fftshift(Y2)));
%xlim([200 1200]);
xlabel("Frequency (Hz)");
ylabel("Magnitude");
title("Magnitude of Middle 0.5 Seconds");

subplot(3,1,3);
plot(f3, abs(fftshift(Y3)));
%xlim([200 1200]);
xlabel("Frequency (Hz)");
ylabel("Magnitude");
title("Magnitude of Last 0.5 Seconds");

figure;

subplot(3,1,1);
plot(f1, angle(fftshift(Y1)));
%xlim([200 1200]);
xlabel("Frequency (Hz)");
ylabel("Phase");
title("Phase of First 0.5 Seconds");

subplot(3,1,2);
plot(f2, angle(fftshift(Y2)));
%xlim([200 1200]);
xlabel("Frequency (Hz)");
ylabel("Phase");
title("Phase of Middle 0.5 Seconds");

subplot(3,1,3);
plot(f3, angle(fftshift(Y3)));
%xlim([200 1200]);
xlabel("Frequency (Hz)");
ylabel("Phase");
title("Phase of Last 0.5 Seconds");
% Physical Frequency
% fHz = (Fs/N) * (-N/2:N/2-1);
% 
% figure;
% 
% subplot(4,1,1);
% plot(fHz, abs(fftshift(Y)));
% %xlim([200 1200]);
% xlabel("Frequency (Hz)");
% ylabel("Magnitude");
% title("Magnitude of Chirp Signal");
% 
% subplot(4,1,2);
% plot(fHz, angle(fftshift(Y)));
% %xlim([200 1200]);
% xlabel("Frequency (Hz)");
% ylabel("Phase");
% title("Phase of Chirp Signal");

% PART E
% Frequency Shift

fshift = 300;
yshift = y .* exp(1j*2*pi*fshift*t);

% FFT
Yshift = fft(yshift);

% Graph
figure;

subplot(2,1,1)
plot(f, abs(fftshift(Y)));
hold on;
plot(f, abs(fftshift(Yshift)));
%xlim([200 1200]);
xlabel("Frequency (Hz)");
ylabel("Magnitude");
title("Original vs Shifted Magnitude");
hold off;



subplot(2,1,2)
plot(f, angle(fftshift(Y)));
hold on;
plot(f, angle(fftshift(Yshift)));
%xlim([500 1500]);
xlabel("Frequency (Hz)");
ylabel("Y Shifted");
title("Original vs Shifted Phase");
hold off;


