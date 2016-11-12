function Fval = mixWat_statPower(filenames1, filenames2)

n1 = 10;
n2 = 10;
total_dyads1 = [];
total_dyads2 = [];

rndIdx = unidrnd(1000, 10, 1);
[xx, yy, zz] = ind2sub([10, 10, 10], rndIdx);

for aa = 1:numel(filenames1)
    dyads = spm_read_vols(spm_vol(filenames1{aa}));
    dyads_z_sign = sign(dyads(:, :, :, 3));
    dyads = dyads.*repmat(dyads_z_sign, 1, 1, 1, 3); %reorient vec.
    for cc = 1:numel(rndIdx)
        temp = dyads(xx(cc), yy(cc), zz(cc), :);
        total_dyads1 = cat(4, total_dyads1, temp);
    end
end

for bb = 1:numel(filenames2)
    dyads = spm_read_vols(spm_vol(filenames2{bb}));
    dyads_z_sign = sign(dyads(:, :, :, 3));
    dyads = dyads.*repmat(dyads_z_sign, 1, 1, 1, 3); %reorient vec.
    for cc = 1:numel(rndIdx)
        temp = dyads(xx(cc), yy(cc), zz(cc), :);
        total_dyads2 = cat(4, total_dyads2, temp);
    end
end

[eigM1_1, eigM2_1, eigM3_1] = mixWatsonBasic(total_dyads1, n1, n2);
[eigM1_2, eigM2_2, eigM3_2] = mixWatsonBasic(total_dyads2, n1, n2);

f = @(x1, x2) (2 - (x1 + x2))/2;
s1 = f(eigM1_1, eigM1_2);
s2 = f(eigM2_1, eigM2_2);
s = f(eigM3_1, eigM3_2);

N = n1 + n2;
Fval = (N - 2)*(N*s - n1*s1 - n2*s2)./(n1*s1 + n2*s2);
