clear
close all

fs = 50; % Sampling frequency
t = 0:1/fs:10; % Time vector from 0 to 10 seconds
f0 = 10; % Initial frequency in Hz
f1 = 110; % Final frequency in Hz
x = chirp(t, f0, max(t), f1, "linear"); % Chirp signal

% Define STFT parameters
win = hamming(100, 'periodic'); % Corrected hamming window
overlap = 98; % Overlap length
nfft = 128; % FFT length

% Compute and plot STFT
stft(x, fs, 'Window', win, 'OverlapLength', overlap, 'FFTLength', nfft);

% Label axes
xlabel("Time (s)");
ylabel("Frequency (Hz)");
title("Short-Time Fourier Transform of Chirp Signal");
colorbar; % Show colorbar for better visualization
