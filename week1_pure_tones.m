% playing a pure tone NOTES
% Thomas Haimes
% Original Author: Tanja Karp

clear % Always start program with clear

% signal generation
Ts = 1/8000 % sampling period
Fs = 1/Ts;   % sampling frequency

% signal properties
t = 0:Ts:2-Ts; % duration of 2 seconds
f0 = 440       % frequency in Hz (A from tuning fork)
A = 0.9        % amplitude

% create signal
x = A*cos(2*pi*f0*t) 

% graph signal
figure(1) % forces graph to pop to front
plot(t,x) % plot(independent variable, dependent variable)
xlabel("time t[s]")
ylabel("x(t)")
grid on
xlim([0, 0.1])

% play signal
sound(x, Fs) % sound(name of vector, sampling frequency)

% create wav-file
audiowrite("signal_440Hz.wav", x, Fs)