clear
close all

%% Question 1 (on paper for now)


%% Question 2 
B = 1;
A = [1, 1.3, -0.09, -0.405];



[r,p,k] = residuez(B, A)


%% Question 3

% A on paper

% B
alpha = 0.8;
k = 10;

% H(z) = (1 - alpha) / (1 - alpha*z^(-k))
B = [1 - alpha];   
A = zeros(1, k + 1);       
A(1) = 1;
A(end) = -alpha;

% Pole-zero plot
figure
zplane(B, A)
title("Pole-Zero Plot for H(z) with \alpha = 0.8, k = 10")

% C
% Code sampled from lecture notes
h = impz(B,A);
figure(2)
stem(h)

figure(3)
freqz(B,A)
freqz(B,A,2048,'whole')
[H,w]=freqz(B,A,2048,'whole');