% Thomas Haimes
% Homework 6
% 03/10/25

clear
close all

% Give me the audio file
[y, Fs] = audioread("twinkle1.wav");
t = (0:length(y) - 1) / Fs; % time vector


% Show me the graph
% plot(t, y);
% xlabel("Time (s)");
% ylabel("Amplitude");
% title("twinkle1.wav");

% B.

% TIME SPACES FOUND IN AUDACITY

% Find note 2
t2s = 0.349;                % Start time
t2e = 0.652;                % End time

idx2s = round(t2s * Fs);    % Start time index
idx2e = round(t2e * Fs);    % End time index

note2 = y(idx2s:idx2e);     % Extracted note 2

% Find note 4
t4s = 1.04;                 % Start time
t4e = 1.34;                 % End time

idx4s = round(t4s * Fs);    % Start time index
idx4e = round(t4e * Fs);    % End time index

note4 = y(idx4s:idx4e);     % Extracted note 4

% Find note 8
t8s = 2.75;                 % Start time
t8e = 3.04;                 % End time

idx8s = round(t8s * Fs);    % Start time index
idx8e = round(t8e * Fs);    % End time index

note8 = y(idx8s:idx8e);     % Extracted note 8

% Plots

% figure;
% subplot(3,1,1)
% plot(t(idx2s:idx2e), note2);  
% xlabel("Time (s)");
% ylabel("Amplitude");
% title("Note 2");
% 
% subplot(3,1,2)
% plot(t(idx4s:idx4e), note4);  
% xlabel("Time (s)");
% ylabel("Amplitude");
% title("Note 4");
% 
% subplot(3,1,3)
% plot(t(idx8s:idx8e), note8);  
% xlabel("Time (s)");
% ylabel("Amplitude");
% title("Note 8");

% C.
N = 16384;
k = 1:N;

% FFT
Y2 = fftshift(fft(note2, N));
Y4 = fftshift(fft(note4, N));
Y8 = fftshift(fft(note8, N));

% Frequency axis
f = (0:N-1)*(Fs/N);

% figure;
% subplot(3,1,1)
% plot(f, abs(Y2));
% xlabel("Frequency (Hz)");
% ylabel("Magnitude");
% title("Note 2 FFT");
% 
% subplot(3,1,2)
% plot(f, abs(Y4));
% xlabel("Frequency (Hz)");
% ylabel("Magnitude");
% title("Note 4 FFT");
% 
% subplot(3,1,3)
% plot(f, abs(Y8));
% xlabel("Frequency (Hz)");
% ylabel("Magnitude");
% title("Note 8 FFT");

% D.

% Find peaks
[~, locs2] = findpeaks(abs(Y2(N/2:end)), "MinPeakHeight", 0.1*max(abs(Y2)));
[~, locs4] = findpeaks(abs(Y4(N/2:end)), "MinPeakHeight", 0.1*max(abs(Y4)));
[~, locs8] = findpeaks(abs(Y8(N/2:end)), "MinPeakHeight", 0.1*max(abs(Y8)));


% Find fundamental frequencies
fun2 = f(locs2(1));
fun4 = f(locs4(1));
fun8 = f(locs8(1));

% Find harmonics
% --> frequency values

harm2 = f(locs2(2:end));
harm4 = f(locs4(2:end));
harm8 = f(locs8(2:end));

% Display stuff
disp("Note 2 Fundamental Frequency: " + fun2 + " Hz");
disp("Note 2 Harmonics:");
disp(harm2);

disp("Note 4 Fundamental Frequency: " + fun4 + " Hz");
disp("Note 4 Harmonics:");
disp(harm4);

disp("Note 8 Fundamental Frequency: " + fun8 + " Hz");
disp("Note 8 Harmonics:");
disp(harm8);

% E.
% Chose Notes 2 and 3 because Note 2 data already gathered
% TIMES AQUIRED FROM AUDACITY 

t2s = 0.349;  % Start of Note 2
t3e = 1;      % End of Note 3

idxs = round(t2s * Fs);
idxe = round(t3e * Fs);
section = y(idxs:idxe);
timesec = t(idxs:idxe);

Y23 = fftshift(fft(section, N));

% figure;
% subplot(2,1,1);
% plot(timesec, section);
% xlabel("Time (s)");
% ylabel("Amplitude");
% title("Notes 2 and 3");
% 
% subplot(2,1,2);
% plot(f, abs(Y23) / max(abs(Y23)));
% xlabel("Frequency (Hz)");
% ylabel("Magnitude");
% title("FFT Notes 2 and 3");

% F.
 win_size = 256;
 overlap = 128;
 nfft = 512;

 % figure;
 % spectrogram(section, win_size, overlap, nfft, Fs, "yaxis"); % y axis flips 
 % title("Short-Time Fourier Transform")

 plot(f, angle(Y23));
 xlabel("Frequency (Hz)");
 ylabel("Phase");
 title("Phase of Notes 2 and 3");



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Question 2

% Load signal
load("test_signal.mat");
fs = 500;                   % Sampling frequency
N = 2500;
Tolerance = 400;

t = 0:1/fs:5-1/fs;          % 5 seconds
f = (-N/2:N/2-1)*(fs/N);



% A.

% FFT to find frequencies
SFFT = fftshift(fft(test_signal));

[~, loc] = findpeaks(abs(SFFT), "MinPeakHeight", 400);

found = f(loc);


% B.

% figure;
% subplot(2,1,1);
% plot(abs(SFFT).^2);
% xlabel("Frequency (Hz)");
% ylabel("Magnitude");
% title("FFT w/ Magnitude");
% grid on;
% 
% subplot(2,1,2)
% plot(t, test_signal);
% xlabel("Time (s)");
% ylabel("Amplitude");

% Help from Alejandro
SFFT(abs(SFFT) < Tolerance) = 0;
frq = [100, 105, 200, 210];
phase = [0.0191118, -0.0175716, -0.102692, -0.137863];

% figure;
% subplot(2,1,1);
% plot(f, abs(SFFT));
% xlabel("Frequency (Hz)");
% ylabel("Amplitude");
% title("FFT w/ Magnitude");
% 
% subplot(2,1,2);
% plot(f, angle(SFFT));
% xlabel("Frequency (Hz)")
% ylabel("Phase)");
% title("FFT w/ Phase");

window_size = 256;
overlap = 200;
nfft = 512;

% Graphs

% for f0 = frq
%     filtered = bandpass(test_signal, [f0-2, f0+2], fs);
%     figure;
%     subplot(2,1,1);
%     plot(t, filtered);
%     title(["Filtered Signal at ", num2str(f0), " Hz"]);
%     xlabel("Time (s)");
%     ylabel("Amplitude");
% 
%     subplot(2,1,2);
%     spectrogram(filtered, window_size, overlap, nfft, fs, "yaxis");
%     title("STFT of Test Signal");
%     colorbar;
% end

[S, F, T, P] = spectrogram(test_signal, window_size, overlap, nfft, fs);
for i = 1:length(frq)
    f0 = frq(i);

    % 

    [~, idx] = min(abs(F - f0));

    % Power @ Freq / Time
    power = P(idx, :);

    % Threshold
    threshold = 0.5 * max(power);
    atidx = find(power > threshold);

    % idx to time
    start = min(T(atidx));
    stop = max(T(atidx));

    fprintf("Frequency %.1f Hz starts at %.2fs and ends at %.2fs\n", f0, start, stop);
end

% C.
amplitudes = [0, 0, 0, 0];

for i = 1:length(frq)
    f0 = frq(i);

    % Bandpass filter around f0
    filtered = bandpass(test_signal, [f0-2, f0+2], fs);

    % Peak to peak amplitude
    amp = max(abs(filtered))*2;


    amplitudes(i) = amp;

    % DO NOT FORGET %F 
    fprintf("Amplitude for %.1f Hz = %.2f\n", f0, amp);

end

% D.
% Let's try to get this signal back
% zeros not zeroEs >:(
reconstructed = zeros(size(t));

for i = 1:length(frq)
    f0 = frq(i);
    A0 = amplitudes(i);
    phi = angle(SFFT(loc(i)));
    reconstructed = reconstructed + A0 * cos(2 * pi * f0 * t + phi);
end

% figure;
% plot(t, test_signal, "r", t, reconstructed, "b");
% legend("Original Signal", "Reconstructed Signal");
% title("Original vs Reconstructed");