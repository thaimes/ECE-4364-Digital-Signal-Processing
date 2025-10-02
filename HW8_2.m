clc
close all

%% Shared by all
N_fft = 8192;
x = randn(1, 8192);             % Generate white noise
xlong = randn(1, 10 * N_fft);   % Longer white noise for C
Fs = 8000;                      % Sampling Frequency



%% Kaiser
% A.

Fpass = 1000;                   % Passband Frequency
Fstop = 1500;                   % Stopband Frequency
Dpass = 0.057501127785;         % Passband Ripple
Dstop = 0.01;                   % Stopband Attenuation
flag  = 'scale';                % Sampling Flag

% Calculate the order from the parameters using KAISERORD.
[N,Wn,BETA,TYPE] = kaiserord([Fpass Fstop]/(Fs/2), [1 0], [Dstop Dpass]);

% Calculate the coefficients using the FIR1 function.
b_kai  = fir1(N, Wn, TYPE, kaiser(N+1, BETA), flag);

[Hk,f]=freqz(b_kai,1,N_fft,Fs);

% Plot frequency and impulse response
figure;
subplot(2,1,1);
plot(f, 20*log10(abs(Hk)));
title("Frequency Response of Kaiser");
xlabel("Frequency (Hz)");
ylabel("Magnitude (dB)");

subplot(2,1,2);
stem(b_kai);
title("Impulse Response of Kaiser");
xlabel("time");
ylabel("Amplitude");

% B.
y_kaiser = filter(b_kai,1,x);

Xk = fft(x, N_fft);
Yk = fft(y_kaiser, N_fft);

f_axis = linspace(0, Fs, N_fft);


figure;
subplot(2,1,1);
plot(f_axis, 20*log10(fftshift(abs(Xk))));
title("White Noise (Unfiltered)");
xlabel("Frequency (Hz)");
ylabel("Magnitude (dB)");

subplot(2,1,2);
plot(f_axis, 20*log10(fftshift(abs(Yk))));
title("Kaiser Filter on White Noise");
xlabel("Frequency (Hz)");
ylabel("Magnitude (dB)");

% C.
ylong_kaiser = filter(b_kai, 1, xlong);
PSD = zeros(10, N_fft);

for i = 1:10
    block = ylong_kaiser((i-1)*N_fft + 1 : i*N_fft);
    blocky = fft(block, N_fft);
    PSD(i, :) = abs(blocky).^2;
end

PSD_avg = mean(PSD, 1);

figure;
plot(f_axis, 10*log10(fftshift(PSD_avg)))
title("Averaged PSD of Kaiser")
xlabel("Frequency (Hz)")
ylabel("Power Spectral Density (dB)")


%% Equiripple

% A. 
Fpass = 1000;            % Passband Frequency
Fstop = 1500;            % Stopband Frequency
Dpass = 0.057501127785;  % Passband Ripple
Dstop = 0.01;            % Stopband Attenuation
dens  = 20;              % Density Factor

% Calculate the order from the parameters using FIRPMORD.
[N, Fo, Ao, W] = firpmord([Fpass, Fstop]/(Fs/2), [1 0], [Dpass, Dstop]);

% Calculate the coefficients using the FIRPM function.
b_equi  = firpm(N, Fo, Ao, W, {dens});

[He,f]=freqz(b_equi,1,N_fft,Fs);

% Plot frequency and impulse response
figure;
subplot(2,1,1);
plot(f, 20*log10(abs(He)));
title("Frequency Response of Equiripple");
xlabel("Frequency (Hz)");
ylabel("Magnitude (dB)");

subplot(2,1,2);
stem(b_equi);
title("Impulse Response of Equiripple");
xlabel("n");
ylabel("Amplitude");

% B.
y_equip = filter(b_equi,1,x);

Xe = fft(x, N_fft);
Ye = fft(y_equip, N_fft);

f_axis = linspace(0, Fs, N_fft);


figure;
subplot(2,1,1);
plot(f_axis, 20*log10(fftshift(abs(Xe))));
title("White Noise (Unfiltered)");
xlabel("Frequency (Hz)");
ylabel("Magnitude (dB)");

subplot(2,1,2);
plot(f_axis, 20*log10(fftshift(abs(Ye))));
title("Equiripple Filter on White Noise");
xlabel("Frequency (Hz)");
ylabel("Magnitude (dB)");

% C.
ylong_equip = filter(b_equi, 1, xlong);
PSD = zeros(10, N_fft);

for i = 1:10
    block = ylong_equip((i-1)*N_fft + 1 : i*N_fft);
    blocky = fft(block, N_fft);
    PSD(i, :) = abs(blocky).^2;
end

PSD_avg = mean(PSD, 1);

figure;
plot(f_axis, 10*log10(fftshift(PSD_avg)))
title("Averaged PSD of Equiripple")
xlabel("Frequency (Hz)")
ylabel("Power Spectral Density (dB)")

%% Least Squares

% A.
N     = 30;    % Order
Fpass = 1000;  % Passband Frequency
Fstop = 1500;  % Stopband Frequency
Wpass = 1;     % Passband Weight
Wstop = 10;    % Stopband Weight

% Calculate the coefficients using the FIRLS function.
b_lq  = firls(N, [0 Fpass Fstop Fs/2]/(Fs/2), [1 1 0 0], [Wpass Wstop]);

[Hl,f]=freqz(b_lq,1,N_fft,Fs);

% Plot frequency and impulse response
figure;
subplot(2,1,1);
plot(f, 20*log10(abs(Hl)));
title("Frequency Response of Least Squares");
xlabel("Frequency (Hz)");
ylabel("Magnitude (dB)");

subplot(2,1,2);
stem(b_lq);
title("Impulse Response of Least Squares");
xlabel("n");
ylabel("Amplitude");

% B.
y_lq = filter(b_lq,1,x);

Xl = fft(x, N_fft);
Yl = fft(y_lq, N_fft);

f_axis = linspace(0, Fs, N_fft);


figure;
subplot(2,1,1);
plot(f_axis, 20*log10(fftshift(abs(Xl))));
title("White Noise (Unfiltered)");
xlabel("Frequency (Hz)");
ylabel("Magnitude (dB)");

subplot(2,1,2);
plot(f_axis, 20*log10(fftshift(abs(Yl))));
title("Least Squares Filter on White Noise");
xlabel("Frequency (Hz)");
ylabel("Magnitude (dB)");

% C.
ylong_lq = filter(b_lq, 1, xlong);
PSD = zeros(10, N_fft);

for i = 1:10
    block = ylong_lq((i-1)*N_fft + 1 : i*N_fft);
    blocky = fft(block, N_fft);
    PSD(i, :) = abs(blocky).^2;
end

PSD_avg = mean(PSD, 1);

figure;
plot(f_axis, 10*log10(fftshift(PSD_avg)))
title("Averaged PSD of Least Squares")
xlabel("Frequency (Hz)")
ylabel("Power Spectral Density (dB)")

%% High Pass Filter

% Highpass Kaiser using frequency shift on Lowpass Kaiser
n = 0:length(b_kai)-1;
h_high = b_kai .* ((-1).^n);

H_fft = fft(h_high, N_fft);
H_fft = fftshift(H_fft);
f = linspace(-Fs/2, Fs/2, N_fft);


figure
subplot(2,1,1)
plot(f, 20*log10(abs(H_fft)))
xlabel("Frequency (Hz)")
ylabel("Magnitude (dB)")
title("Frequency Resposne of Highpass Kaiser")
xlim([-4000 4000])

subplot(2,1,2)
stem(h_high)
xlabel("n");
ylabel("Amplitude")
title("Impulse Response of Highpass Kaiser")

% Highpass Kaiser using Filter Designer GUI
Fstop = 2500;            % Stopband Frequency
Fpass = 3000;            % Passband Frequency
Dstop = 0.01;            % Stopband Attenuation
Dpass = 0.057501127785;  % Passband Ripple
flag  = 'scale';         % Sampling Flag

% Calculate the order from the parameters using KAISERORD.
[N,Wn,BETA,TYPE] = kaiserord([Fstop Fpass]/(Fs/2), [0 1], [Dpass Dstop]);

% Calculate the coefficients using the FIR1 function.
bh_kai  = fir1(N, Wn, TYPE, kaiser(N+1, BETA), flag);

H_fft = fft(bh_kai, N_fft);
H_fft = fftshift(H_fft);
f = linspace(-Fs/2, Fs/2, N_fft);


% Plot frequency and impulse response
figure
subplot(2,1,1)
plot(f, 20*log10(abs(H_fft)))
title("Frequency Response of Highpass Kaiser (GUI)")
xlabel("Frequency (Hz)")
ylabel("Magnitude (dB)")
xlim([-4000 4000]);

subplot(2,1,2)
stem(bh_kai)
title("Impulse Response of Highpass Kaiser (GUI)")
xlabel("n")
ylabel("Amplitude")

%% Band Pass Filter

% Bandpass Kaiser using frequency shift on Lowpass Kaiser
n = 0:length(b_kai)-1;
fcent = 2000;
h_band = 2 * b_kai .* cos(2*pi*fcent/Fs * n);

H_fft = fft(h_band, N_fft);
H_fft = fftshift(H_fft);
f = linspace(-Fs/2, Fs/2, N_fft);


figure
subplot(2,1,1)
plot(f, 20*log10(abs(H_fft)))
xlabel("Frequency (Hz)")
ylabel("Magnitude (dB)")
title("Frequency Resposne of Bandpass Kaiser")
xlim([-4000 4000])

subplot(2,1,2)
stem(h_band)
xlabel("n");
ylabel("Amplitude")
title("Impulse Response of Bandpass Kaiser")

% Bandpass Kaiser using Filter Designer GUI
Fstop1 = 500;             % First Stopband Frequency
Fpass1 = 1000;            % First Passband Frequency
Fpass2 = 3000;            % Second Passband Frequency
Fstop2 = 3500;            % Second Stopband Frequency
Dstop1 = 0.001;           % First Stopband Attenuation
Dpass  = 0.057501127785;  % Passband Ripple
Dstop2 = 0.0001;          % Second Stopband Attenuation
flag   = 'scale';         % Sampling Flag

% Calculate the order from the parameters using KAISERORD.
[N,Wn,BETA,TYPE] = kaiserord([Fstop1 Fpass1 Fpass2 Fstop2]/(Fs/2), [0 ...
                             1 0], [Dstop1 Dpass Dstop2]);

% Calculate the coefficients using the FIR1 function.
bband_kai  = fir1(N, Wn, TYPE, kaiser(N+1, BETA), flag);

H_fft = fft(bband_kai, N_fft);
H_fft = fftshift(H_fft);
f = linspace(-Fs/2, Fs/2, N_fft);


% Plot frequency and impulse response
figure
subplot(2,1,1)
plot(f, 20*log10(abs(H_fft)))
title("Frequency Response of Bandpass Kaiser (GUI)")
xlabel("Frequency (Hz)")
ylabel("Magnitude (dB)")
xlim([-4000 4000]);

subplot(2,1,2)
stem(bband_kai)
title("Impulse Response of Bandpass Kaiser (GUI)")
xlabel("n")
ylabel("Amplitude")

%% COMMENTS & RESOURCES

% Frequency Response Info:
% https://www.mathworks.com/help/signal/ug/frequency-response.html
% There's probably a button in the GUI but I couldn't find it :(
% Update 4/7/25 I found the button but I already made the graphs :D