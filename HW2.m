% Homework 2
% Thomas Haimes
% 2/1/25

% Always start program with clear
clear 

% Signal Generation
Fs1 = 22050; % Sampling Frequency
Ts1 = 1/Fs1; % Sampling Period
Ts2 = 2*Ts1;

% Signal Properties
%t = 0:Ts1:5-Ts1;                                        % Duration of 5sec
t = 0:Ts2:5-Ts2;
f0 = [1000, 2000, 3000, 4000, 5000, 6000, 7000, 8000];  % Array of frequencies
wav = [1, 2, 3, 4, 5, 6, 7, 8]                          % Array for wav generation
omega = [];                                             % Empty array for omega 

% For loop for .wav file generation
for i = 1:length(f0)
    x = cos(2*pi*f0(i)*t); 
    %name = sprintf("%dkHz.wav", wav(i));
    name = sprintf("%dkHz Low Sample.wav", wav(i));
    audiowrite(name, x, Fs1);
    %omega(i) = 2*pi*f0(i)*Ts1;

end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% COMMENTS & SOURCES

% https://www.mathworks.com/help/matlab/matlab_prog/formatting-strings.html