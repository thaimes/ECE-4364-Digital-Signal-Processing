% H(z) = B(z)/A(z) with B(z) and A(z) being polynomials in z^-1

B = [1, -2.05, 1];
A = [1, 1.8, 1.06, 0.45, 0.2025];

% graphing pole-zero plot
zplane(B,A)

% partial fraction expansion
% Make sure row vectors are NOT column vectors
% k is empty because numerator polynomial is higher degree than demoninator
% polynomial (order 2 on the top order 3 on bottom)
[r, p, k] = residuez(B,A)