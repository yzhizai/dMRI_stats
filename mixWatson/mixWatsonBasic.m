function [eigM1, eigM2, eigM3] = mixWatsonBasic(dyadsM, n1, n2)
%Input:
%  dyadsM - a 4D matrix with 4th dim with size of 3*(n1 + n2)
%output:
%  eigM1 - the first samples' eigenvalue
%  eigM2 - the second samples' eigenvalue
%  eigM3 - the sum samples' eigenvalue
[xdim, ydim, zdim, ~] = size(dyadsM);
dyadsM_5D = reshape(dyadsM, xdim, ydim, zdim, 3, []);
dyads1 = dyadsM_5D(:, :, :, :, 1:n1);
dyads2 = dyadsM_5D(:, :, :, :, (end-n2 + 1):end);

eigM1 = zeros(xdim, ydim, zdim);
eigM2 = zeros(xdim, ydim, zdim);
eigM3 = zeros(xdim, ydim, zdim);

for aa = 1:zdim
    for bb = 1:ydim
        for cc = 1:xdim
            sigVox1 = reshape(dyads1(cc, bb, aa, :, :), 3, n1);
            S_sig1 = 1/n1*(sigVox1*sigVox1');
            eigM1(cc, bb, aa) = max(eig(S_sig1));
            
            sigVox2 = reshape(dyads2(cc, bb, aa, :, :), 3, n2);
            S_sig2 = 1/n2*(sigVox2*sigVox2');
            eigM2(cc, bb, aa) = max(eig(S_sig2));
            
            sigVox3 = reshape(dyadsM_5D(cc, bb, aa, :, :), 3, []);
            S_sig3 = 1/(n1 + n2)*(sigVox3*sigVox3');
            eigM3(cc, bb, aa) = max(eig(S_sig3));
        end
    end
end