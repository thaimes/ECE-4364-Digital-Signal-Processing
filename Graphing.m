% Graphing
% Thomas Haimes
% 2/1/25

clear

n = [-10:0.25:10];
% y = 5*cos(pi*(n/2)-(pi/2)); 
% stem(n,y);

%y = 3*cos((5*n) + (pi/6));
%y = 2.*exp(imag((n/6)-pi));
%y = cos(n/8) .* cos((n*pi)/8);
y = cos((pi*n)/2) - sin((pi*n)/8) + 3*cos(((pi*n)/4)+(pi/3));

stem(n,y);