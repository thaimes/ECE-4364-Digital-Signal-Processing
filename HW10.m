% Thomas Haimes
% Homework 10
% 4/26/25

clc
close all

%% Question 1
%% Shared Information
Fs = 8000;  % Sampling Frequency

Fpass = 1000;        % Passband Frequency
Fstop = 1500;        % Stopband Frequency
Apass = 1;           % Passband Ripple (dB)
Astop = 40;          % Stopband Attenuation (dB)

%% Butterworth Filter Information
match = 'stopband';  % Band to match exactly

% Construct an FDESIGN object and call its BUTTER method.
b_butter  = fdesign.lowpass(Fpass, Fstop, Apass, Astop, Fs);
Hbutter = design(b_butter, 'butter', 'MatchExactly', match);
% Get the transfer function values.
[b1, a1] = tf(Hbutter);
% Convert to a singleton filter.
Hbutter = dfilt.df2(b1, a1);

%% Chebyshev I Filter Information
match = 'passband';  % Band to match exactly

% Construct an FDESIGN object and call its CHEBY1 method.
b_chev1  = fdesign.lowpass(Fpass, Fstop, Apass, Astop, Fs);
Hchev1 = design(b_chev1, 'cheby1', 'MatchExactly', match);
% Get the transfer function values.
[b2, a2] = tf(Hchev1);
Hchev1 = dfilt.df2(b2, a2);

%% Chebyshev II Filter Information
match = 'stopband';  % Band to match exactly

% Construct an FDESIGN object and call its CHEBY2 method.
b_chev2  = fdesign.lowpass(Fpass, Fstop, Apass, Astop, Fs);
Hchev2 = design(b_chev2, 'cheby2', 'MatchExactly', match);
% Get the transfer function values.
[b3, a3] = tf(Hchev2);
Hchev2 = dfilt.df2(b3, a3);

%% Elliptic Filter Information
match = 'both';  % Band to match exactly

% Construct an FDESIGN object and call its ELLIP method.
b_elli  = fdesign.lowpass(Fpass, Fstop, Apass, Astop, Fs);
Helli = design(b_elli, 'ellip', 'MatchExactly', match);
% Get the transfer function values.
[b4, a4] = tf(Helli);
Helli = dfilt.df2(b4, a4);

%% Graphing
nfft = 1024;

% Compute freqz with output
[H_b, ~] = freqz(b1,a1,nfft, "whole");
[H_c1, ~] = freqz(b2, a2, nfft, "whole");
[H_c2, ~] = freqz(b3, a3, nfft, "whole");
[H_e, ~] = freqz(b4, a4, nfft, "whole");

% Shift over
H_b = fftshift(H_b);
H_c1 = fftshift(H_c1);
H_c2 = fftshift(H_c2);
H_e = fftshift(H_e);

% X-axis frequency vector (centered)
f = linspace(-Fs/2, Fs/2, nfft);

% % Plotting
% figure;
% 
% % Magnitude Response
% subplot(2,1,1);
% plot(f, 20*log10(abs(H_b)), 'b', 'DisplayName', 'Butterworth'); 
% hold on;
% plot(f, 20*log10(abs(H_c1)), 'r', 'DisplayName', 'Chebyshev I');
% plot(f, 20*log10(abs(H_c2)), 'g', 'DisplayName', 'Chebyshev II');
% plot(f, 20*log10(abs(H_e)),  'k', 'DisplayName', 'Elliptic');
% title('Magnitude Response');
% xlabel('Frequency (Hz)');
% ylabel('Magnitude (dB)');
% legend;
% grid on;
% xlim([-4000 4000]);
% %ylim([-800 100]); % shows a bit above and a bit below for better viewing
% 
% % Phase Response
% subplot(2,1,2);
% plot(f, unwrap(angle(H_b)), 'b', 'DisplayName', 'Butterworth'); 
% hold on;
% plot(f, unwrap(angle(H_c1)), 'r', 'DisplayName', 'Chebyshev I');
% plot(f, unwrap(angle(H_c2)), 'g', 'DisplayName', 'Chebyshev II');
% plot(f, unwrap(angle(H_e)),  'k', 'DisplayName', 'Elliptic');
% title('Phase Response');
% xlabel('Frequency (Hz)');
% ylabel('Phase (radians)');
% legend;
% grid on;
% xlim([-4000 4000]);

%% For Cheatsheet stuff
figure;

% Magnitude Response
subplot(2,2,1);
plot(f, 20*log10(abs(H_b))); 
title('Magnitude Response of Butterworth');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
subplot(2,2,2);
plot(f, 20*log10(abs(H_c1)));
title('Magnitude Response of Chebyshev I');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
subplot(2,2,3)
plot(f, 20*log10(abs(H_c2)));
title('Magnitude Response of Chebyshev II');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
subplot(2,2,4)
plot(f, 20*log10(abs(H_e)));
title('Magnitude Response of Elliptic');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
xlim([-4000 4000]);
%ylim([-800 100]); % shows a bit above and a bit below for better viewing

figure
% Phase Response
subplot(2,2,1)
plot(f, unwrap(angle(H_b))); 
title('Phase Response of Butterworth');
xlabel('Frequency (Hz)');
ylabel('Phase (radians)');
subplot(2,2,2)
plot(f, unwrap(angle(H_c1)));
title('Phase Response of Chebyshev I');
xlabel('Frequency (Hz)');
ylabel('Phase (radians)');
subplot(2,2,3)
plot(f, unwrap(angle(H_c2)));
title('Phase Response of Chebyshev II');
xlabel('Frequency (Hz)');
ylabel('Phase (radians)');
subplot(2,2,4)
plot(f, unwrap(angle(H_e)));
title('Phase Response of Elliptic');
xlabel('Frequency (Hz)');
ylabel('Phase (radians)');
xlim([-4000 4000]);

%% Pole zero stuff
figure;
subplot(2,2,1);
zplane(Hbutter);
title('Butterworth');

subplot(2,2,2);
zplane(Hchev1);
title('Chebyshev I');

subplot(2,2,3);
zplane(Hchev2);
title('Chebyshev II');

subplot(2,2,4);
zplane(Helli);
title('Elliptic');

%% White noise
% Average psd of white noise
xlong = randn(1, 10*nfft);   % Longer white noise longer to fit
X = fft(xlong, nfft);

figure;
plot(f, 20*log10(fftshift(abs(X))));
title("White Noise (Unfiltered)");
xlabel("Frequency (Hz)");
ylabel("Magnitude (dB)");

ylong_b = filter(Hbutter, xlong);
PSD = zeros(10, nfft);

for i = 1:10
    block = ylong_b((i-1)*nfft + 1 : i*nfft);
    blocky = fft(block, nfft);
    PSD(i, :) = abs(blocky).^2;
end

PSD_avg = mean(PSD, 1);

figure;
subplot(2,2,1);
plot(f, 10*log10(fftshift(PSD_avg)))
title("Averaged PSD of Butterworth")
xlabel("Frequency (Hz)")
ylabel("Power Spectral Density (dB)")

% Chebyshev I
ylong_c1 = filter(Hchev1, xlong);
PSD = zeros(10, nfft);

for i = 1:10
    block = ylong_b((i-1)*nfft + 1 : i*nfft);
    blocky = fft(block, nfft);
    PSD(i, :) = abs(blocky).^2;
end

PSD_avg = mean(PSD, 1);

subplot(2,2,2);
plot(f, 10*log10(fftshift(PSD_avg)))
title("Averaged PSD of Chebyshev I")
xlabel("Frequency (Hz)")
ylabel("Power Spectral Density (dB)")

% Chebyshev II
ylong_c2 = filter(Hchev2, xlong);
PSD = zeros(10, nfft);

for i = 1:10
    block = ylong_b((i-1)*nfft + 1 : i*nfft);
    blocky = fft(block, nfft);
    PSD(i, :) = abs(blocky).^2;
end

PSD_avg = mean(PSD, 1);

subplot(2,2,3);
plot(f, 10*log10(fftshift(PSD_avg)))
title("Averaged PSD of Chebyshev II")
xlabel("Frequency (Hz)")
ylabel("Power Spectral Density (dB)")

% Elliptic
ylong_e = filter(Helli, xlong);
PSD = zeros(10, nfft);

for i = 1:10
    block = ylong_b((i-1)*nfft + 1 : i*nfft);
    blocky = fft(block, nfft);
    PSD(i, :) = abs(blocky).^2;
end

PSD_avg = mean(PSD, 1);

subplot(2,2,4);
plot(f, 10*log10(fftshift(PSD_avg)))
title("Averaged PSD of Elliptic")
xlabel("Frequency (Hz)")
ylabel("Power Spectral Density (dB)")

%% Question 2
[x, fs] = audioread('noisy1.wav');

% Finding what frequency needs to be filtered out using FFT
N = length(x);
X = abs(fft(x));
f = (0:N-1)*(fs/N);

figure
plot(f, X)
xlim([0 fs/2])
xlabel("Frequency (Hz)")
title("FFT of unfiltered signal")
% Spike @ 1kHz means that's what we must filter out..

% Filter design to notch out 1kHz
f0 = 1000;                           % Frequency to get cut out
r = 0.95;                            % Good value for accurate notching
theta = 2*pi*f0/fs;                  % Angular frequency

% Placing poles & zeroes via calculation
b = [1, -2*cos(theta), 1];           % Zeros on unit circle
a = [1, -2*r*cos(theta), r^2];       % Poles inside unit circle

% Apply filter
y = filter(b, a, x);
y = y / max(abs(y));  

% Save .wav after filtering
audiowrite('quiet1.wav', y, fs);

% FFT after filtering (to verify its gone)
N = length(y);
Y = abs(fft(y));
f = (0:N-1)*(fs/N);

figure;
plot(f, Y);
xlim([0 fs/2]);
xlabel("Frequency (Hz)");
title("FFT of filtered signal");

% Pole zero plot for visualization
figure;
zplane(b, a);
title("Pole-Zero Plot of Notch Filter");

% Frequency Response

figure;
freqz(b, a, "whole");
title("Frequency Response of Notch Filter");


%figure;

% For listening (1kHz is gone :D)
% sound(y, fs) 

% Tea in thin china has a sweet taste...


%% Sources
% https://dsp.stackexchange.com/questions/26688/analytically-designing-a-notch-filter-for-specified-frequency-50-hz