clear

h = [1, -1]*4/3;

n = 0:100;
x = 5 + 4*cos(pi/4*n);

y = conv(h,x);

figure(1)
subplot(211)
stem(n, x)
subplot(212)
stem(n, y(1:length(n)))
