% Homework 1
% Thomas Haimes
% 1/24/25

% Always start program with clear
clear 

% Signal generation
Ts = 1/8000              % Sampling period
Fs = 1/Ts                % Sampling frequency

% Signal properties
pause = 0.35                  % Pause duration
note = 2                      % Full note duration
h = 0:Ts:(note/2)-pause-Ts;   % Half note duration
q = 0:Ts:(note/4)-pause-Ts;   % Quarter note duration

p = 0:Ts:pause-Ts;       % duration of pause real pause
o4 = 1;                  % o4 = 1 for Octave 4 || o4 = 0 for Octave 5
amp = 0.9                % amplitude

% Frequencies
if (o4 == 1) 
% Octave 4 notes
    A = 440
    C = 261.1
    D = 293.7
    E = 329.6
    F = 349.2
    G = 392
else 
% Octave 5 notes
    A = 880
    C = 523.3
    D = 587.3
    E = 659.3
    F = 698.5
    G = 784
end
% TEST VALUES
testmeasure = [C, C, G, G];
testdur = {q, q, q, q};

line1 = [C, C, G, G, A, A, G, F, F, E, E, D, D, C];
line2 = [G, G, F, F, E, E, D, G, G, F, F, E, E, D];
line3 = [C, C, G, G, A, A, G, F, F, E, E, D, D, C];
dur   = {q, q, q, q, q, q, h, q, q, q, q, q, q, h};
% Entire song follows the same beat pattern 
% Only need to plug in notes to each duration and play 3 times
song = [line1, line2, line3];
realdur = [dur, dur, dur]; % 3x14 matrix

% h = half note duration
% q = quarter note duration
% amp*cos(2*pi*freq*duration)

x = [] % Empty array to populate the sound file

% for loop to apply note duration 

% UNCOMMENT TO HEAR TEST MEASURE
% for i=1:length(testmeasure)
%     % Assign current duration for calculation
%     curdur = testdur{i};
%     % Signal creation
%     x = [x, amp*cos(2*pi*testmeasure(i)*curdur), zeros(1, length(p))];
%     % zeros adds pause in between each note
% end

% COMMENT OUT IF TRYING TO HEAR TEST MEASURE
for i=1:length(song)
    % Assign current duration for calculation
    curdur = realdur{i};
    % Signal creation
    x = [x, amp*cos(2*pi*song(i)*curdur), zeros(1, length(p))];
    % zeros adds pause in between each note
end

% Graph creation
% time = (0:length(x)-1)/Fs;
% figure(1)
% plot(time, x)
% xlabel("time t[s]")
% ylabel("x(t)")
% title(["Full Song"])
% grid on
% xlim([0, 25])

% Song creation
sound(x, Fs) % Play entire x array at frequency Fs

% Create wav-file
%audiowrite("Test_Measure.wav", x, Fs)
%audiowrite("Test_clip.wav", x, Fs)
%audiowrite("Octave4_Speed1.wav", x, Fs)
%audiowrite("Octave4_Speed2.wav", x, Fs)
%audiowrite("Octave5_Speed1.wav", x, Fs)
%audiowrite("Octave5_Speed2.wav", x, Fs)

% File Size Calculation
O4S1 = dir('Octave4_Speed1.wav')
O4S2 = dir('Octave4_Speed2.wav')
O5S1 = dir('Octave5_Speed1.wav')

size1 = O4S1.bytes
size2 = O4S2.bytes
size3 = O5S1.bytes

% Test clipping
%[x, Fs] = audioread("Test_clip.wav")
% 
% time = (0:length(x)-1)/Fs;
% figure(2)
% plot(time, x)
% xlabel("time t[s]")
% ylabel("x(t)")
% title(["Clipping"])
% grid on
% xlim([0, 2.5])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% COMMENTS & SOURCES

% MUSIC FREQUENCIES
% https://www.seventhstring.com/resources/notefrequencies.html

% ARRAY INSPIRATION
% https://users.rowan.edu/~shreek/networks1/music.html

% THROUGHOUT FILE
% MATLAB notes from Blackboard
% Microsoft Copilot assisted w/ FOR loop syntax

% FILE SIZE CALCULATION
% https://www.mathworks.com/matlabcentral/answers/315359-how-can-i-know-the-size-of-the-file
