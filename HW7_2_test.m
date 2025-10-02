clc
close all
clear

n = -3:1:3;

x1=[0,0,-2,1,-2,0,0];
x2=[0,0,-2,1,0,0,0];
x3=[0,0,0,1,1,0,0];

y1=[0,-1,3,3,0,1,0];
y2=[0,-1,1,-3,0,-1,0];
y3=[2,1,-3,0,2,0,0];

figure
subplot(3,2,1)
stem(n, x1)
xlabel("n")
title("x1[n]")

subplot(3,2,3)
stem(n, x2)
xlabel("n")
title("x2[n]")

subplot(3,2,5)
stem(n, x3)
xlabel("n")
title("x3[n]")

subplot(3,2,2)
stem(n, y1)
xlabel("n")
title("y1[n]")

subplot(3,2,4)
stem(n, y2)
xlabel("n")
title("y2[n]")

subplot(3,2,6)
stem(n, y3)
xlabel("n")
title("y3[n]")

x4 = ((x1-x2)+2*x3)/2;
y4 = ((y1-y2)+2*x3)/2;

figure
subplot(2,2,1)
stem(n, x4)
xlabel("n")
title("x4[n]")

subplot(2,2,2)
stem(n, y4)
xlabel("n")
title("y4[n]")

