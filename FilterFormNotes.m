clear;
clc;
close all;

%             1 + 2z^-1 + 1z^-2
%   H(z) = -----------------------
%           1 + 0.1z^-1 + 0.25z^-2

x = randn(1,100);
B = [1 2 1]
A = [1 0.1 -0.25]

% pole zero plot
figure
zplane(B,A)

% frequency response
figure
freqz(B,A,1024, "whole")

%% Direct Form I:
yd1(1) = B(1)*x(1);
yd1(2) = B(1)*x(2)+B(2)*x(1) - A(2)*yd1(1);

for n = 3:length(x)
    yd1(n) = B(1)*x(n) + B(2)*x(n-1) + B(3)*x(n-2) - A(2)*yd1(n-1) - A(3)*yd1(n-2);
end

%% Direct Form II:
w(1) = x(1);
yd2(1) = B(1)*w(1);

w(2) = x(2) - A(2)*w(1);
yd2(2) = B(1)*w(2) + B(2)*w(1);

for n = 3:length(x)
    w(n) = x(n) - A(2)*w(n-1) - A(3)*w(n-2); % Calculate signal in the middle
    yd2(n) = B(1)*w(n) + B(2)*w(n-1) + B(3)*w(n-2); % Calculate output with signal in the middle & its previous values
end

%% Direct Form II, more efficient

wn_2 = 0;
wn_1 = 0;

for n = 1:length(x)
    wn = x(n) - A(2)*wn_1 - A(3)*wn_2;
    y(n) = B(1)*wn + B(2)*wn_1 + B(3)*wn_2;

    wn_2 = wn_1;
    wn_1 = wn;
end

%% graph different outputs
figure
plot(yd1)
hold on
plot(yd2)
plot(y)
hold off
title("comparison of implementations")
xlabel("n")
ylabel("y[n]")
legend("direct form 1", "direct form 2", "efficient direct form")