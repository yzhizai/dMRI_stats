function Fval = mixWatsonMainFunc(filenames1, filenames2, n1, n2)

total_dyads1 = [];
total_dyads2 = [];

%every file data was 4D format, firstly changed the direction along the
%z-axis. then caoncatenate the data with 4th dim.
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

[eigM1_1, eigM2_1, eigM3_1] = mixWatsonBasic(total_dyads1, n1, n2);
[eigM1_2, eigM2_2, eigM3_2] = mixWatsonBasic(total_dyads2, n1, n2);

f = @(x1, x2) (2 - (x1 + x2))/2;
s1 = f(eigM1_1, eigM1_2);
s2 = f(eigM2_1, eigM2_2);
s = f(eigM3_1, eigM3_2);

N = n1 + n2;
Fval = (N - 2)*(N*s - n1*s1 - n2*s2)./(n1*s1 + n2*s2);



