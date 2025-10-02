clc
close all

n = -3:3;                         % Full range for all (except c)
nconv = -6:6;                     % Full range for convolution

nc = -3:6;                        % C has different range
ncconv = -6:12;                   % Better to do this way

ne = -1:1;
neconv = -2:2;
neconv2 = -4:4;

%% Vectors for convolution
% n = [-3, -2, -1, 0, 1, 2, 3];

xa1 = [0, 0, 0, 2, 3, -2, -3];    % 2 is n = 0
xa2 = [0, 0, -10, 0, -5, 0, 0];   % 0 is n = 0

xb1 = [0, 0, 2, -1, 3, -2, 0];    % -1 is n = 0
xb2 = [-1, -4, 1, -2, 0, 0, 0];   % -2 is n = 0

xc1 = [0, 0, 0, 0, 0, 3, 2, 1, 2, 3];
xc2 = [2, 3, -2, 1, 0, 0, 0, 0, 0, 0];

xd1 = [5, 0, 0, -2, 8, 0, 0];
xd2 = [0, -1, 1, 3, 3, -2, 3];

% E has triple convolution

% E vectors first half
xe11 = [1, 0, 0];
xe12 = [0, 1, -1];

% E vectors second half
xe21 = [0, 1, -1];
xe22 = [1, -1, 0];

%% Convolution Occurs Here
ya = conv(xa1, xa2);
yb = conv(xb1, xb2);
yc = conv(xc1, xc2);
yd = conv(xd1, xd2);

% E convolves 3 times

% E convolution first half
ye1 = conv(xe11, xe12);

% E convolution second half
ye2 = conv(xe21, xe22);

% E full convolution
yef = conv(ye1, ye2); % this might blow up


% Debug display to see if results are as expected
disp("x1: ");
disp(ye1);
disp("x2: ");
disp(ye2);
disp("Convolution result: ");
disp(yef);
disp("Index range: ");
disp(neconv2);

%% Plots for A
figure;
subplot(3,1,1);
stem(n,xa1);
title("xa1[n]");
xlabel("n");

subplot(3,1,2);
stem(n,xa2);
title("xa2[n]");
xlabel("n");

subplot(3,1,3);
stem(nconv,ya);
title("Convolution of xa1 and xa2");
xlabel("n");

%% Plots for B
figure;
subplot(3,1,1);
stem(n,xb1);
title("xb1[n]");
xlabel("n");

subplot(3,1,2);
stem(n,xb2);
title("xb2[n]");
xlabel("n");

subplot(3,1,3);
stem(nconv,yb);
title("Convolution of xb1 and xb2");
xlabel("n");
%% Plots for C
figure;
subplot(3,1,1);
stem(nc,xc1);
title("xc1[n]");
xlabel("n");

subplot(3,1,2);
stem(nc,xc2);
title("xc2[n]");
xlabel("n");

subplot(3,1,3);
stem(ncconv,yc);
title("Convolution of xc1 and xc2");
xlabel("n");
%% Plots for D
figure;
subplot(3,1,1);
stem(n,xd1);
title("xd1[n]");
xlabel("n");

subplot(3,1,2);
stem(n,xd2);
title("xd2[n]");
xlabel("n");

subplot(3,1,3);
stem(nconv,yd);
title("Convolution of xd1 and xd2");
xlabel("n");
%% Plots for E

% First Convolution
figure;
subplot(3,1,1);
stem(ne,xe11);
title("xe11[n]");
xlabel("n");

subplot(3,1,2);
stem(ne,xe12);
title("xe12[n]");
xlabel("n");

subplot(3,1,3);
stem(neconv,ye1);
title("Convolution of xe11 and xe12");
xlabel("n");

% Second Convolution
figure;
subplot(3,1,1);
stem(ne,xe21);
title("xe21[n]");
xlabel("n");

subplot(3,1,2);
stem(ne,xe22);
title("xe22[n]");
xlabel("n");

subplot(3,1,3);
stem(neconv,ye2);
title("Convolution of xe21 and xe22");
xlabel("n");

% Full Convolution

figure;
subplot(3,1,1);
stem(neconv,ye1);
title("ye1[n]");
xlabel("n");

subplot(3,1,2);
stem(neconv,ye2);
title("ye2[n]");
xlabel("n");

subplot(3,1,3);
stem(neconv2,yef);
title("Full Convolution of ye");
xlabel("n");

%% B. Proof of Convolution via DTFT

% VARIABLES USED
% xd1, xd2, yd, n

% n = -3:3;                         % Full range for all (except c)
% nconv = -6:6;                     % Full range for convolution
% 
% xd1 = [5, 0, 0, -2, 8, 0, 0];
% xd2 = [0, -1, 1, 3, 3, -2, 3];
% 
% yd = conv(xd1, xd2);

omega = -pi:pi/10000:pi;

X1 = zeros(size(omega));
X2 = zeros(size(omega));
Y  = zeros(size(omega));

for nn = 1:length(n)
    X1 = X1 + xd1(nn) * exp(-1i * n(nn) * omega);
end

for nn = 1:length(n)
    X2 = X2 + xd2(nn) * exp(-1i * n(nn) * omega);
end

for nn = 1:length(nconv)
    Y = Y + yd(nn) * exp(-1i * nconv(nn) * omega);
end

X1_X2 = X1 .* X2;

%% Figures sampled from MATLAB notes on BB
figure
subplot(311)
stem(n,xd1)
xlabel('n')
ylabel('x_1[n]')
title('unit sample sequence')

subplot(312)
plot(omega,abs(X1))
xlabel('\omega')
ylabel('|X_1(e^{j\omega})|')

subplot(313)
plot(omega,angle(X1))
xlabel('\omega')
ylabel('\angle X_1(e^{j\omega}) [rad]')

figure
subplot(311)
stem(n,xd2)
xlabel('n')
ylabel('x_2[n]')
title('unit sample sequence')

subplot(312)
plot(omega,abs(X2))
xlabel('\omega')
ylabel('|X_2(e^{j\omega})|')

subplot(313)
plot(omega,angle(X2))
xlabel('\omega')
ylabel('\angle X_2(e^{j\omega}) [rad]')

% Graphs for X1 * X2
figure

subplot(211)
plot(omega,abs(X1_X2))
xlabel('\omega')
ylabel('|(X_1 \cdot X_2)(e^{j\omega})|')

subplot(212)
plot(omega,angle(X1_X2))
xlabel('\omega')
ylabel('\angle (X_1 \cdot X_2)(e^{j\omega}) [rad]')


% Convolution Result in frequency domain

figure
subplot(311)
stem(nconv,yd)
xlabel('n')
ylabel('Y[n]')
title('unit sample sequence')

subplot(312)
plot(omega,abs(Y))
xlabel('\omega')
ylabel('|Y(e^{j\omega})|')

subplot(313)
plot(omega,angle(Y))
xlabel('\omega')
ylabel('\angle Y(e^{j\omega}) [rad]')
