function S = decayS(tensorDir, bval, bvec)
%This function is to model tensorstick diffusion model.
%Usage: S = DECAYS(tensorDir, bval, bvec)
%
%Input: 
%  tensorDir - an orthogonal matrix, each column represented a diffusion
%  direction
%  bval - load('*.bval')
%  bvec - load('*.bvec'
%
%Shaofeng Duan
%Institute of High Energy Physics
%2016-10-25

b = max(bval);
d1 = 1.49*10^(-3); % the unit is mm^2*s^-1
d2 = 0.72*10^(-3);
n  = tensorDir(:, 1);
n2 = tensorDir(:, 2);
n3 = tensorDir(:, 3);

bmat = bval_bvec_to_matrix(bval, bvec, [2 1 3], [-1, 1, 1]);

D = d1*(n*n') + d2*(n2*n2') + d2*(n3*n3');
[dxx, dxy, dxz, dyy, dyz, dzz] = Matrix2DT(D);
S1 = cellfun(@(x) exp(-b*d1*(dot(n, x))^2), num2cell(bvec, 1));
S2 = cellfun(@(x) exp(-1*dot([dxx, dxy, dxz, dyy, dyz, dzz], x)), num2cell(bmat, 2));

S = 0.59*S1(:) + 0.41*S2(:);

