function Fval = mixWatsonMainFunc(filenames1, filenames2, n1, n2)

total_dyads1 = [];
total_dyads2 = [];

for aa = 1:numel(filenames1)
    dyads = spm_read_vols(spm_vol(filenames1{aa}));
    dyads_z_sign = sign(dyads(:, :, :, 3));
    dyads = dyads.*repmat(dyads_z_sign, 1, 1, 1, 3); %reorient vec.
    total_dyads1 = cat(4, total_dyads1, dyads);
end

for bb = 1:numel(filenames2)
    dyads = spm_read_vols(spm_vol(filenames2{bb}));
    dyads_z_sign = sign(dyads(:, :, :, 3));
    dyads = dyads.*repmat(dyads_z_sign, 1, 1, 1, 3); %reorient vec.
    total_dyads2 = cat(4, total_dyads2, dyads);
end

[eigM1_1, eigM2_1, eigM3_1] = mixWatson(total_dyads1, n1, n2);
[eigM1_2, eigM2_2, eigM3_2] = mixWatson(total_dyads2, n1, n2);

f = @(x1, x2) (2 - (x1 + x2))/2;
s1 = f(eigM1_1, eigM1_2);
s2 = f(eigM2_1, eigM2_2);
s = f(eigM3_1, eigM3_2);

N = n1 + n2;
Fval = (N - 2)*(N*s - n1*s1 - n2*s2)./(n1*s1 + n2*s2);

function [eigM1, eigM2, eigM3] = mixWatson(dyadsM, n1, n2)
[xdim, ydim, zdim, ~] = size(dyadsM);
dyadsM_5D = reshape(dyadsM, xdim, ydim, zdim, 3, []);
dyads1 = dyadsM_5D(:, :, :, :, 1:n1);
dyads2 = dyadsM_5D(:, :, :, :, (end-n2 + 1):end);

eigM1 = zeros(xdim, ydim, zdim);
eigM2 = zeros(xdim, ydim, zdim);

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

